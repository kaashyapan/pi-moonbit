// Tests for the moon_test and moon_fmt_info tools.
//
// The extension is compiled to JavaScript by `moon build`, and the compiled
// module exposes only `default_main` — the extension factory. So these tests
// load the built bundle, install it into a stub ExtensionAPI, and exercise the
// registered tools through their public surface, exactly as pi does.
//
// Behaviour tests replace `exec` with a stub; the integration tests run
// against the fixtures under tests/fixtures/ with the real `moon` binary.

import { describe, expect, test, beforeAll } from "bun:test";
import path from "node:path";
import extensionDefault from "../extensions/index.js";
import { realExec } from "./helpers";

const FAILURE_FLAG = "flagsDiagnosticFailure";

const FIXTURE_DIR = path.resolve(import.meta.dir, "fixtures/moon-sample");
const BROKEN_DIR = path.resolve(import.meta.dir, "fixtures/moon-broken");

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
  name: string,
  params: Record<string, unknown>,
  signal?: AbortSignal,
) {
  const tool = tools.get(name);
  if (!tool) throw new Error(`tool ${name} not registered`);
  return await tool.execute("test-call-id", params, signal, undefined, {});
}

// Loads the extension with a real subprocess runner so the fixtures are
// exercised by the installed `moon` binary.
async function loadReal() {
  const realTools = new Map<string, any>();
  const pi = {
    registerTool: (tool: any) => realTools.set(tool.name, tool),
    registerCommand: () => {},
    on: () => {},
    exec: realExec,
  };
  await (extensionDefault as any)(pi);
  return realTools;
}

const okStdout = { stdout: "moon 0.1.20260904 (test)\n", stderr: "", code: 0, killed: false };

beforeAll(async () => {
  execResult = () => okStdout;
  await loadExtension();
});

describe("test tool registration", () => {
  test("registers moon_test and moon_fmt_info", () => {
    expect(tools.has("moon_test")).toBe(true);
    expect(tools.has("moon_fmt_info")).toBe(true);
    expect(tools.get("moon_test").name).toBe("moon_test");
    expect(tools.get("moon_fmt_info").name).toBe("moon_fmt_info");
  });

  test("declares the expected parameter schemas", () => {
    const testTool = tools.get("moon_test");
    expect(Object.keys(testTool.parameters.properties).sort()).toEqual([
      "moon_mod_filepath",
      "package",
      "target",
      "update",
    ]);
    expect(testTool.parameters.required).toEqual(["moon_mod_filepath"]);

    const fmtTool = tools.get("moon_fmt_info");
    expect(Object.keys(fmtTool.parameters.properties).sort()).toEqual([
      "moon_mod_filepath",
      "package",
    ]);
    expect(fmtTool.parameters.required).toEqual(["moon_mod_filepath"]);
  });
});

describe("moon_test behaviour (stubbed runner)", () => {
  test("defaults to wasm-gc and builds the expected argv", async () => {
    execCalls = [];
    execResult = (args) =>
      args.includes("version")
        ? okStdout
        : { stdout: "", stderr: "", code: 0, killed: false };
    await loadExtension();
    await execute("moon_test", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    const call = execCalls.find((args) => args.includes("test"));
    expect(call).toEqual([
      "-C",
      FIXTURE_DIR,
      "test",
      "--target",
      "wasm-gc",
    ]);
  });

  test("passes target, package, and update through", async () => {
    execCalls = [];
    await loadExtension();
    await execute("moon_test", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
      target: "js",
      package: "ok",
      update: true,
    });
    const call = execCalls.find((args) => args.includes("test"));
    expect(call).toEqual([
      "-C",
      FIXTURE_DIR,
      "test",
      "--target",
      "js",
      "-p",
      "ok",
      "--update",
    ]);
  });

  test("omits --update when not requested", async () => {
    execCalls = [];
    await loadExtension();
    await execute("moon_test", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
      target: "js",
    });
    const call = execCalls.find((args) => args.includes("test"));
    expect(call).not.toContain("--update");
  });

  test("passing tests report success without the failure flag", async () => {
    execResult = (args) =>
      args.includes("version")
        ? okStdout
        : {
            stdout: "Total tests: 2, passed: 2, failed: 0.\n",
            stderr: "",
            code: 0,
            killed: false,
          };
    await loadExtension();
    const res = await execute("moon_test", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
      target: "js",
    });
    expect(res.details.ok).toBe(true);
    expect(res.details.target).toBe("js");
    expect(res.details.exitCode).toBe(0);
    expect(res.details[FAILURE_FLAG]).toBeUndefined();
    expect(res.content[0].text).toContain("Tests passed.");
  });

  test("failing tests are flagged as an error but are not a spawn failure", async () => {
    execResult = (args) =>
      args.includes("version")
        ? okStdout
        : {
            stdout: "Total tests: 2, passed: 1, failed: 1.\n",
            stderr: "",
            code: 2,
            killed: false,
          };
    await loadExtension();
    const res = await execute("moon_test", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
      target: "js",
    });
    expect(res.details.ok).toBe(false);
    expect(res.details.exitCode).toBe(2);
    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.content[0].text).toContain("Tests failed (exit 2).");
  });

  test("reports a timeout as a failure", async () => {
    execResult = (args) =>
      args.includes("version")
        ? okStdout
        : { stdout: "", stderr: "", code: 1, killed: true };
    await loadExtension();
    const res = await execute("moon_test", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    expect(res.details.timedOut).toBe(true);
    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.content[0].text).toContain("moon test timed out");
  });

  test("an already-aborted signal cancels the call", async () => {
    execResult = () => okStdout;
    await loadExtension();
    const controller = new AbortController();
    controller.abort();
    const res = await execute(
      "moon_test",
      { moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod") },
      controller.signal,
    );
    expect(res.content[0].text).toBe("Cancelled.");
    expect(res.details.aborted).toBe(true);
  });

  test("an invalid moon_mod_filepath returns an actionable failure", async () => {
    await loadExtension();
    const res = await execute("moon_test", {
      moon_mod_filepath: "/definitely/not/here/moon.mod",
    });
    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.content[0].text).toContain("Invalid moon_mod_filepath");
  });
});

describe("moon_fmt_info behaviour (stubbed runner)", () => {
  test("runs fmt module-wide then info, without -p by default", async () => {
    execCalls = [];
    execResult = (args) =>
      args.includes("version")
        ? okStdout
        : { stdout: "", stderr: "", code: 0, killed: false };
    await loadExtension();
    await execute("moon_fmt_info", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    const subcommands = execCalls
      .filter((args) => args[2] === "fmt" || args[2] === "info")
      .map((args) => args[2]);
    expect(subcommands).toEqual(["fmt", "info"]);
    const infoCall = execCalls.find((args) => args[2] === "info");
    expect(infoCall).toEqual(["-C", FIXTURE_DIR, "info"]);
  });

  test("scopes only moon info with the package argument", async () => {
    execCalls = [];
    await loadExtension();
    await execute("moon_fmt_info", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
      package: "types",
    });
    const fmtCall = execCalls.find((args) => args[2] === "fmt");
    const infoCall = execCalls.find((args) => args[2] === "info");
    // fmt always runs module-wide; only info takes the package scope
    expect(fmtCall).toEqual(["-C", FIXTURE_DIR, "fmt"]);
    expect(infoCall).toEqual(["-C", FIXTURE_DIR, "info", "-p", "types"]);
  });

  test("reports both sections on success", async () => {
    execResult = (args) =>
      args.includes("version")
        ? okStdout
        : { stdout: "done\n", stderr: "", code: 0, killed: false };
    await loadExtension();
    const res = await execute("moon_fmt_info", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    expect(res.details.ok).toBe(true);
    expect(res.details.fmtExit).toBe(0);
    expect(res.details.infoExit).toBe(0);
    expect(res.details[FAILURE_FLAG]).toBeUndefined();
    expect(res.content[0].text).toContain("## moon fmt (exit 0)");
    expect(res.content[0].text).toContain("## moon info (exit 0)");
  });

  test("skips moon info when fmt fails", async () => {
    execCalls = [];
    execResult = (args) => {
      if (args.includes("version")) return okStdout;
      if (args[2] === "fmt")
        return { stdout: "", stderr: "fmt boom", code: 1, killed: false };
      return { stdout: "", stderr: "", code: 0, killed: false };
    };
    await loadExtension();
    const res = await execute("moon_fmt_info", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    expect(res.details.ok).toBe(false);
    expect(res.details.step).toBe("fmt");
    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.content[0].text).toContain("skipping moon info");
    // info must not have run
    expect(execCalls.some((args) => args[2] === "info")).toBe(false);
  });

  test("reports an info failure while still surfacing both sections", async () => {
    execResult = (args) => {
      if (args.includes("version")) return okStdout;
      if (args[2] === "info")
        return { stdout: "", stderr: "info boom", code: 1, killed: false };
      return { stdout: "", stderr: "", code: 0, killed: false };
    };
    await loadExtension();
    const res = await execute("moon_fmt_info", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    expect(res.details.ok).toBe(false);
    expect(res.details.fmtExit).toBe(0);
    expect(res.details.infoExit).toBe(1);
    expect(res.details[FAILURE_FLAG]).toBe(true);
    const text = res.content[0].text;
    expect(text).toContain("## moon fmt (exit 0)");
    expect(text).toContain("## moon info (exit 1)");
  });

  test("reports a fmt timeout", async () => {
    execResult = (args) =>
      args.includes("version")
        ? okStdout
        : { stdout: "", stderr: "", code: 1, killed: true };
    await loadExtension();
    const res = await execute("moon_fmt_info", {
      moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
    });
    expect(res.details.step).toBe("fmt");
    expect(res.details.timedOut).toBe(true);
    expect(res.content[0].text).toContain("moon fmt timed out");
  });
});

describe("moon_test against the real toolchain", () => {
  test(
    "a passing package reports success",
    async () => {
      const realTools = await loadReal();
      const tool = realTools.get("moon_test");
      const res = await tool.execute(
        "id",
        {
          moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
          target: "js",
          package: "ok",
        },
        undefined,
        undefined,
        {},
      );
      expect(res.details.ok).toBe(true);
      expect(res.details.exitCode).toBe(0);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      const text = res.content[0].text;
      expect(text).toContain("Tests passed.");
      expect(text).toContain("passed: 1");
      expect(text).toContain("failed: 0");
    },
    180_000,
  );

  test(
    "a failing package sets the failure flag and surfaces the failing test",
    async () => {
      const realTools = await loadReal();
      const tool = realTools.get("moon_test");
      const res = await tool.execute(
        "id",
        {
          moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"),
          target: "js",
          package: "types",
        },
        undefined,
        undefined,
        {},
      );
      expect(res.details.ok).toBe(false);
      expect(res.details[FAILURE_FLAG]).toBe(true);
      const text = res.content[0].text;
      expect(text).toContain("Tests failed (exit ");
      expect(text).toContain("intentionally failing");
      expect(text).toContain("failed: 1");
    },
    180_000,
  );
});

describe("moon_fmt_info against the real toolchain", () => {
  test(
    "formats the module and regenerates interfaces, reporting success",
    async () => {
      const realTools = await loadReal();
      const tool = realTools.get("moon_fmt_info");
      const res = await tool.execute(
        "id",
        { moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod"), package: "ok" },
        undefined,
        undefined,
        {},
      );
      expect(res.details.ok).toBe(true);
      expect(res.details.fmtExit).toBe(0);
      expect(res.details.infoExit).toBe(0);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("## moon fmt (exit 0)");
      expect(res.content[0].text).toContain("## moon info (exit 0)");
    },
    180_000,
  );

  test(
    "a broken module: fmt succeeds, info fails, the failure is reported",
    async () => {
      const realTools = await loadReal();
      const tool = realTools.get("moon_fmt_info");
      const res = await tool.execute(
        "id",
        { moon_mod_filepath: path.join(BROKEN_DIR, "moon.mod") },
        undefined,
        undefined,
        {},
      );
      expect(res.details.ok).toBe(false);
      expect(res.details.fmtExit).toBe(0);
      expect(res.details[FAILURE_FLAG]).toBe(true);
      // both sections are surfaced even though info failed
      expect(res.content[0].text).toContain("## moon fmt (exit 0)");
      expect(res.content[0].text).toContain("## moon info");
    },
    180_000,
  );
});
