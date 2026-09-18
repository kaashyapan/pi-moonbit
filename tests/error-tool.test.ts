// Tests for the moon_explain_error tool.
//
// The extension is compiled to JavaScript by `moon build`, and the compiled
// module exposes only `default_main` — the extension factory. So these tests
// load the built bundle, install it into a stub ExtensionAPI, and exercise the
// registered tool through its public surface, exactly as pi does.
//
// The tool delegates to `moon explain --diagnostic <code>` through the shared
// runner, pinned to the OS temp directory. It needs no module context. Tests
// that assert real explanations therefore require `moon` on PATH; the
// behaviour-only tests replace `exec` with a stub.

import { describe, expect, test, beforeAll } from "bun:test";
import extensionDefault from "../extensions/index.js";
import { realExec } from "./helpers";

// The failure marker the tool sets on results that should be presented as
// errors. Mirrors FAILURE_FLAG in the TypeScript shared.ts.
const FAILURE_FLAG = "flagsDiagnosticFailure";

const tools = new Map<string, any>();
const commands = new Map<string, any>();
let execCalls: string[][] = [];
let execResult: (args: string[]) => any;

// A minimal stand-in for the harness ExtensionAPI. `exec` is the only action
// the extension uses; the rest just capture registrations.
function makeStubPi() {
  return {
    registerTool: (tool: any) => tools.set(tool.name, tool),
    registerCommand: (name: string, spec: any) => commands.set(name, spec),
    on: () => {},
    exec: async (_command: string, args: string[]) => {
      execCalls.push([...args]);
      return execResult(args);
    },
  };
}

// Version probe succeeds by default so the tool is registered.
function loadExtension() {
  return (extensionDefault as any)(makeStubPi());
}

async function execute(params: Record<string, unknown>, signal?: AbortSignal) {
  const tool = tools.get("moon_explain_error");
  if (!tool) throw new Error("tool moon_explain_error not registered");
  return await tool.execute("test-call-id", params, signal, undefined, {});
}

beforeAll(async () => {
  execResult = () => ({ stdout: "moon 0.1.20260904 (test)\n", stderr: "", code: 0, killed: false });
  await loadExtension();
});

describe("moon_explain_error registration", () => {
  test("is registered when the toolchain is reachable", () => {
    expect(tools.has("moon_explain_error")).toBe(true);
    const tool = tools.get("moon_explain_error");
    expect(tool.name).toBe("moon_explain_error");
    expect(tool.label).toBe("MoonBit: Explain error");
  });

  test("declares an integer error_code parameter and prompt guidance", () => {
    const tool = tools.get("moon_explain_error");
    // parameters is a JSON-schema object, not a MoonBit struct: it is handed
    // to the harness, which compiles and validates against it.
    expect(tool.parameters.type).toBe("object");
    expect(tool.parameters.properties.error_code.type).toBe("integer");
    expect(tool.parameters.required).toEqual(["error_code"]);
    // promptGuidelines must be a real array, not a boxed Option.
    expect(Array.isArray(tool.promptGuidelines)).toBe(true);
    expect(tool.promptGuidelines.length).toBeGreaterThan(0);
    expect(tool.promptSnippet).toContain("moon_explain_error");
  });

  test("is not registered when the toolchain probe fails", async () => {
    const isolated = new Map<string, any>();
    const pi = {
      registerTool: (tool: any) => isolated.set(tool.name, tool),
      registerCommand: () => {},
      on: () => {},
      exec: async () => ({ stdout: "", stderr: "`moon` is not on PATH", code: 1, killed: false }),
    };
    await (extensionDefault as any)(pi);
    expect(isolated.has("moon_explain_error")).toBe(false);
  });
});

describe("moon_explain_error behaviour (stubbed runner)", () => {
  test("runs moon -C <tmpdir> explain --diagnostic <code>", async () => {
    execCalls = [];
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "explanation body\n", stderr: "", code: 0, killed: false };
    await loadExtension();
    await execute({ error_code: 4021 });

    const explainCall = execCalls.find((args) => args.includes("explain"));
    expect(explainCall).toBeDefined();
    // "-C" always precedes the subcommand; the probe is pinned to tmpdir.
    expect(explainCall?.[0]).toBe("-C");
    expect(explainCall).toContain("explain");
    expect(explainCall).toContain("--diagnostic");
    expect(explainCall).toContain("4021");
  });

  test("returns the explanation as text content and ok details", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "  # E4021\n\nThe value identifier is unbound.\n", stderr: "", code: 0, killed: false };
    await loadExtension();
    const res = await execute({ error_code: 4021 });

    expect(res.content).toHaveLength(1);
    expect(res.content[0].type).toBe("text");
    expect(res.content[0].text).toStartWith("# E4021");
    expect(res.details.ok).toBe(true);
    expect(res.details.error_code).toBe(4021);
    expect(res.details[FAILURE_FLAG]).toBeUndefined();
  });

  test("falls back to stderr when stdout is empty", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "", stderr: "from-stderr\n", code: 0, killed: false };
    await loadExtension();
    const res = await execute({ error_code: 1 });
    expect(res.content[0].text).toBe("from-stderr");
    expect(res.details.ok).toBe(true);
  });

  test("flags an unknown code as a failure with guidance", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "", stderr: "no integrated diagnostic docs found for `999999`", code: 1, killed: false };
    await loadExtension();
    const res = await execute({ error_code: 999999 });

    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.details.ok).toBe(false);
    expect(res.details.error_code).toBe(999999);
    expect(res.details.exitCode).toBe(1);
    const text = res.content[0].text;
    expect(text).toContain("No explanation available");
    expect(text).toContain("999999");
    expect(text).toContain("no integrated diagnostic docs found");
    expect(text).toContain("Treat the moon_check diagnostic message");
  });

  test("reports a timeout as a failure", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "", stderr: "", code: 1, killed: true };
    await loadExtension();
    const res = await execute({ error_code: 4021 });

    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.details.timedOut).toBe(true);
    expect(res.content[0].text).toContain("timed out");
  });

  test("returns Cancelled for an already-aborted signal", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "should not run", stderr: "", code: 0, killed: false };
    await loadExtension();
    const controller = new AbortController();
    controller.abort();
    const res = await execute({ error_code: 4021 }, controller.signal);

    expect(res.content[0].text).toBe("Cancelled.");
    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.details.aborted).toBe(true);
  });

  test("truncates very long output", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "x".repeat(25000), stderr: "", code: 0, killed: false };
    await loadExtension();
    const res = await execute({ error_code: 1 });
    const text = res.content[0].text;
    expect(text.length).toBeLessThan(25000);
    expect(text).toContain("[truncated");
  });
});

describe("moon_explain_error against the real toolchain", () => {
  test(
    "returns the explanation for a known code",
    async () => {
      // Uses the real moon binary through the default runner path.
      const isolated = new Map<string, any>();
      const pi = {
        registerTool: (tool: any) => isolated.set(tool.name, tool),
        registerCommand: () => {},
        on: () => {},
        // No exec override: exercise the real toolchain path by delegating to
        // a real subprocess, the way the harness `exec` does.
        exec: realExec,
      };
      await (extensionDefault as any)(pi);
      const tool = isolated.get("moon_explain_error");
      expect(tool).toBeDefined();

      const res = await tool.execute("id", { error_code: 4021 }, undefined, undefined, {});
      expect(res.details.ok).toBe(true);
      expect(res.details.error_code).toBe(4021);
      expect(res.content[0].text).toStartWith("# E4021");
    },
    30_000,
  );
});
