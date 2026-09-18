// Tests for the moon_check tool and its diagnostic helpers.
//
// The extension is compiled to JavaScript by `moon build`, and the compiled
// module exposes only `default_main` — the extension factory. So these tests
// load the built bundle, install it into a stub ExtensionAPI, and exercise the
// registered tool through its public surface, exactly as pi does.
//
// The diagnostic parsing, level counting, and ownership partitioning are
// exercised against fixtures under tests/fixtures/: a warning-only module, a
// module with a type error, and a moon.work workspace where the dependencies
// carry the diagnostics.

import { describe, expect, test, beforeAll } from "bun:test";
import path from "node:path";
import extensionDefault from "../extensions/index.js";
import { realExec } from "./helpers";

const FAILURE_FLAG = "flagsDiagnosticFailure";

const FIXTURE_DIR = path.resolve(import.meta.dir, "fixtures/moon-sample");
const BROKEN_DIR = path.resolve(import.meta.dir, "fixtures/moon-broken");
// module root inside the moon.work fixture (app is the owned module;
// dep-noisy/dep-broken are workspace-sibling dependencies)
const WS_APP_DIR = path.resolve(
  import.meta.dir,
  "fixtures/moon-workspace/app",
);
const WS_DIR = path.dirname(WS_APP_DIR);
// dependency paths used by the stubbed-runner tests; real paths so the
// ownership partitioning resolves them as siblings of WS_APP_DIR
const DEP_NOISY_PKG = path.join(WS_DIR, "dep-noisy", "lib", "moon.pkg");
const DEP_BROKEN_MBT = path.join(
  WS_DIR,
  "dep-broken",
  "broken",
  "broken.mbt",
);

const tools = new Map<string, any>();
let execCalls: string[][] = [];
let execResult: (args: string[]) => any;

function makeStubPi() {
  return {
    registerTool: (tool: any) => tools.set(tool.name, tool),
    registerCommand: () => {},
    on: () => {},
    exec: async (_command: string, args: string[]) => {
      execCalls.push([...args]);
      return execResult(args);
    },
  };
}

function loadExtension() {
  return (extensionDefault as any)(makeStubPi());
}

async function execute(
  params: Record<string, unknown>,
  signal?: AbortSignal,
) {
  const tool = tools.get("moon_check");
  if (!tool) throw new Error("tool moon_check not registered");
  return await tool.execute("test-call-id", params, signal, undefined, {});
}

// Loads the extension with a real subprocess runner so the fixtures are
// checked by the installed `moon` binary.
async function loadReal() {
  const realTools = new Map<string, any>();
  const pi = {
    registerTool: (tool: any) => realTools.set(tool.name, tool),
    registerCommand: () => {},
    on: () => {},
    exec: realExec,
  };
  await (extensionDefault as any)(pi);
  return realTools.get("moon_check");
}

beforeAll(async () => {
  execResult = () => ({
    stdout: "moon 0.1.20260904 (test)\n",
    stderr: "",
    code: 0,
    killed: false,
  });
  await loadExtension();
});

describe("moon_check registration", () => {
  test("is registered when the toolchain is reachable", () => {
    expect(tools.has("moon_check")).toBe(true);
    expect(tools.get("moon_check").name).toBe("moon_check");
  });

  test("declares a required moon_mod_filepath plus optional target/package/includeDeps", () => {
    const tool = tools.get("moon_check");
    expect(tool.parameters.type).toBe("object");
    expect(Object.keys(tool.parameters.properties).sort()).toEqual([
      "includeDeps",
      "moon_mod_filepath",
      "package",
      "target",
    ]);
    expect(tool.parameters.required).toEqual(["moon_mod_filepath"]);
    // prompt guidance must survive as a real array, not a boxed Option
    expect(Array.isArray(tool.promptGuidelines)).toBe(true);
  });
});

describe("moon_check behaviour (stubbed runner)", () => {
  test("defaults to the wasm-gc target and passes it through", async () => {
    execCalls = [];
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "", stderr: "", code: 0, killed: false };
    await loadExtension();
    await execute({ moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod") });

    const checkCall = execCalls.find((args) => args.includes("check"));
    expect(checkCall).toContain("--target");
    expect(checkCall).toContain("wasm-gc");
    expect(checkCall).toContain("--output-json");
  });

  test("passes an explicit target and package scope", async () => {
    execCalls = [];
    await loadExtension();
    await execute({
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
      target: "js",
      package: "types",
    });
    const checkCall = execCalls.find((args) => args.includes("check"));
    expect(checkCall).toContain("js");
    expect(checkCall).toContain("-p");
    expect(checkCall).toContain("types");
  });

  test("counts errors, warnings, and other levels from NDJSON", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : {
            stdout: [
              JSON.stringify({
                $message_type: "diagnostic",
                level: "error",
                error_code: 4021,
                path: path.join(FIXTURE_DIR, "types", "a.mbt"),
                loc: "3:9-3:27",
                message: "Value parse_int not found.",
              }),
              JSON.stringify({
                $message_type: "diagnostic",
                level: "warning",
                error_code: 29,
                path: path.join(FIXTURE_DIR, "types", "moon.pkg"),
                loc: "4:3-4:26",
                message: "Unused package",
              }),
              JSON.stringify({
                $message_type: "diagnostic",
                level: "info",
                path: path.join(FIXTURE_DIR, "types", "b.mbt"),
                message: "note",
              }),
            ].join("\n"),
            stderr: "",
            code: 1,
            killed: false,
          };
    await loadExtension();
    const res = await execute({
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
      target: "js",
    });

    expect(res.details.errorCount).toBe(1);
    expect(res.details.warningCount).toBe(1);
    expect(res.details.hasErrors).toBe(true);
    expect(res.details[FAILURE_FLAG]).toBe(true);
    const text = res.content[0].text;
    expect(text).toContain("1 error(s), 1 warning(s)");
    expect(text).toContain("[error 4021]");
    expect(text).toContain("[warning 29]");
    expect(text).toContain("Value parse_int not found.");
  });

  test("a clean run reports no errors or warnings", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "", stderr: "", code: 0, killed: false };
    await loadExtension();
    const res = await execute({
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    expect(res.details.errorCount).toBe(0);
    expect(res.details.warningCount).toBe(0);
    expect(res.details[FAILURE_FLAG]).toBeUndefined();
    expect(res.content[0].text).toContain("No errors or warnings.");
  });

  test("hides dependency warnings behind a count and always shows dependency errors", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : {
            stdout: [
              JSON.stringify({
                $message_type: "diagnostic",
                level: "error",
                error_code: 4021,
                path: DEP_BROKEN_MBT,
                message: "Value parse_int not found.",
              }),
              JSON.stringify({
                $message_type: "diagnostic",
                level: "warning",
                error_code: 29,
                path: DEP_NOISY_PKG,
                message: "Unused package",
              }),
            ].join("\n"),
            stderr: "",
            code: 1,
            killed: false,
          };
    await loadExtension();
    const res = await execute({
      moon_mod_filepath: path.join(WS_APP_DIR, "moon.mod"),
      target: "js",
    });
    expect(res.details.depErrorCount).toBe(1);
    expect(res.details.depWarningCount).toBe(1);
    const text = res.content[0].text;
    expect(text).toContain("[dependency error 4021]");
    expect(text).toContain("1 dependency warning(s) hidden (dep-noisy: 1).");
    // hidden dependency warnings are not listed
    expect(text).not.toContain("[dependency warning");
  });

  test("includeDeps:true lists the previously hidden dependency warnings", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : {
            stdout: JSON.stringify({
              $message_type: "diagnostic",
              level: "warning",
              error_code: 29,
              path: DEP_NOISY_PKG,
              message: "Unused package",
            }),
            stderr: "",
            code: 0,
            killed: false,
          };
    await loadExtension();
    const res = await execute({
      moon_mod_filepath: path.join(WS_APP_DIR, "moon.mod"),
      target: "js",
      includeDeps: true,
    });
    expect(res.details.includeDeps).toBe(true);
    const text = res.content[0].text;
    expect(text).toContain("[dependency warning 29]");
    expect(text).not.toContain("hidden (");
  });
  test("keeps unparseable lines instead of dropping them", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : {
            stdout: 'not json at all\n{"$message_type":"progress"}',
            stderr: "",
            code: 0,
            killed: false,
          };
    await loadExtension();
    const res = await execute({
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    const text = res.content[0].text;
    expect(text).toContain("2 unparsed line(s)");
    expect(text).toContain("not json at all");
    expect(text).toContain('{"$message_type":"progress"}');
  });

  test("reports a timeout as a failure", async () => {
    execResult = (args) =>
      args.includes("version")
        ? { stdout: "moon x\n", stderr: "", code: 0, killed: false }
        : { stdout: "", stderr: "", code: 1, killed: true };
    await loadExtension();
    const res = await execute({
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.details.timedOut).toBe(true);
    expect(res.content[0].text).toContain("timed out");
  });

  test("an already-aborted signal cancels the call", async () => {
    execResult = () => ({
      stdout: "should not run",
      stderr: "",
      code: 0,
      killed: false,
    });
    await loadExtension();
    const controller = new AbortController();
    controller.abort();
    const res = await execute(
      { moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod") },
      controller.signal,
    );
    expect(res.content[0].text).toBe("Cancelled.");
    expect(res.details.aborted).toBe(true);
  });

  test("an invalid moon_mod_filepath returns an actionable failure", async () => {
    await loadExtension();
    const res = await execute({ moon_mod_filepath: "/definitely/not/here/moon.mod" });
    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.details.ok).toBe(false);
    const text = res.content[0].text;
    expect(text).toContain("Invalid moon_mod_filepath");
    expect(text).toContain("nonexistent");
  });
});

describe("moon_check against the real toolchain", () => {
  test(
    "warning-only module reports the warning without the failure flag",
    async () => {
      const tool = await loadReal();
      const res = await tool.execute(
        "id",
        { moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"), target: "js" },
        undefined,
        undefined,
        {},
      );
      expect(res.details.ok).toBe(true);
      expect(res.details.target).toBe("js");
      expect(res.details.errorCount).toBe(0);
      expect(res.details.warningCount).toBe(1);
      expect(res.details.hasErrors).toBe(false);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      const text = res.content[0].text;
      expect(text).toContain("0 error(s), 1 warning(s)");
      expect(text).toContain("[warning 29]");
      expect(text).toContain("Unused package 'moonbitlang/core/json'");
    },
    120_000,
  );

  test(
    "type error is reported as an error with the failure flag",
    async () => {
      const tool = await loadReal();
      const res = await tool.execute(
        "id",
        { moon_mod_filepath: path.join(BROKEN_DIR, "moon.mod"), target: "js" },
        undefined,
        undefined,
        {},
      );
      expect(res.details.errorCount).toBe(1);
      expect(res.details.hasErrors).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBe(true);
      const text = res.content[0].text;
      expect(text).toContain("[error 4021]");
      expect(text).toContain("broken/broken.mbt");
      expect(text).toContain("Value parse_int not found in package `strconv`.");
    },
    120_000,
  );

  test(
    "package scope limits the report",
    async () => {
      const tool = await loadReal();
      const res = await tool.execute(
        "id",
        {
          moon_mod_filepath: path.join(BROKEN_DIR, "moon.mod"),
          target: "js",
          package: "extra",
        },
        undefined,
        undefined,
        {},
      );
      expect(res.details.errorCount).toBe(0);
      expect(res.details.warningCount).toBe(0);
      expect(res.content[0].text).toContain("No errors or warnings.");
    },
    120_000,
  );

  test(
    "moon.work workspace: dependency warnings hidden, dependency errors shown",
    async () => {
      const tool = await loadReal();
      const res = await tool.execute(
        "id",
        { moon_mod_filepath: path.join(WS_APP_DIR, "moon.mod"), target: "js" },
        undefined,
        undefined,
        {},
      );
      expect(res.details.ok).toBe(true);
      // the dependency error breaks the build, so the failure flag is set
      expect(res.details[FAILURE_FLAG]).toBe(true);
      expect(res.details.errorCount).toBe(1);
      expect(res.details.warningCount).toBe(0);
      expect(res.details.depErrorCount).toBe(1);
      expect(res.details.depWarningCount).toBe(1);
      expect(res.details.includeDeps).toBe(false);
      const text = res.content[0].text;
      expect(text).toContain("1 error(s), 1 warning(s).");
      expect(text).toContain("1 dependency warning(s) hidden (dep-noisy: 1).");
      expect(text).toContain("[dependency error 4021]");
      // hidden dependency warnings are not listed
      expect(text).not.toContain("dep-noisy/lib/moon.pkg");
    },
    120_000,
  );

  test(
    "includeDeps:true lists the dependency warnings in the workspace",
    async () => {
      const tool = await loadReal();
      const res = await tool.execute(
        "id",
        {
          moon_mod_filepath: path.join(WS_APP_DIR, "moon.mod"),
          target: "js",
          includeDeps: true,
        },
        undefined,
        undefined,
        {},
      );
      expect(res.details.includeDeps).toBe(true);
      const text = res.content[0].text;
      expect(text).toContain("[dependency warning 29]");
      expect(text).toContain("dep-noisy/lib/moon.pkg");
      expect(text).not.toContain("hidden (");
    },
    120_000,
  );

  test(
    "runs against moon_mod_filepath even when the session cwd is elsewhere",
    async () => {
      const tool = await loadReal();
      const res = await tool.execute(
        "id",
        { moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"), target: "js" },
        undefined,
        undefined,
        { cwd: path.dirname(FIXTURE_DIR) },
      );
      expect(res.details.ok).toBe(true);
      expect(res.details.warningCount).toBe(1);
      expect(res.content[0].text).toContain("Unused package 'moonbitlang/core/json'");
    },
    120_000,
  );
});
