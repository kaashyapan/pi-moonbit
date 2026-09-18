// Tests for the tools registered by extensions/moonbit.ts (the pi MoonBit
// extension). Strategy:
//
// 1. Unit tests for the pure helpers (parseCheckOutput, truncate,
//    findBashRedirect) using NDJSON and diagnostics captured from real
//    `moon check --output-json` runs.
// 2. Integration tests that load the real extension into a stub
//    ExtensionAPI and execute the actual tool handlers against the
//    fixture MoonBit module in tests/fixtures/moon-sample.
//

import { describe, expect, test, beforeAll } from "bun:test";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import moonbitExtension from "../extensions/moonbit.ts";
import {
  dependencyOrigin,
  hiddenDepSummary,
  isDependencyPath,
  parseCheckOutput,
  partitionDiagnostics,
  type CheckDiagnostic,
} from "../extensions/diagnostics.ts";
import {
  FAILURE_FLAG,
  moonModDir,
  truncate,
} from "../extensions/shared.ts";

// ---------------------------------------------------------------------------
// Harness: stub ExtensionAPI that captures registrations
// ---------------------------------------------------------------------------

const FIXTURE_DIR = path.resolve(import.meta.dir, "../fixtures/moon-sample");
const BROKEN_DIR = path.resolve(import.meta.dir, "../fixtures/moon-broken");
// module root inside the moon.work fixture (app is the owned module;
// dep-noisy/dep-broken are workspace-sibling dependencies)
const WS_APP_DIR = path.resolve(import.meta.dir, "../fixtures/moon-workspace/app");
const TYPES_MBT = path.join(FIXTURE_DIR, "types", "types.mbt");

const tools = new Map<string, any>();
const commands = new Map<string, any>();
const listeners = new Map<string, (event: any) => any>();

function makeStubPi() {
  return {
    registerTool: (tool: any) => tools.set(tool.name, tool),
    registerCommand: (name: string, spec: any) => commands.set(name, spec),
    on: (event: string, handler: (event: any) => any) => listeners.set(event, handler),
  };
}

async function execute(
  name: string,
  params: Record<string, unknown>,
  ctx: { cwd?: string } = {},
) {
  const tool = tools.get(name);
  if (!tool) throw new Error(`tool ${name} not registered`);
  // Simulate the model: moon_mod_filepath is required on every tool except
  // moon_explain_error and must be the absolute path of the module's moon.mod.
  const fullParams = {
    moon_mod_filepath: path.join(ctx.cwd ?? process.cwd(), "moon.mod"),
    ...params,
  };
  return await tool.execute("test-call-id", fullParams, undefined, undefined, ctx);
}

beforeAll(async () => {
  // Load the full extension (doctor command + tool suite) through the real
  // default export; registration runs the `moon version` reachability check,
  // which must pass for the integration tests below anyway.
  await moonbitExtension(makeStubPi() as any);
});

// ---------------------------------------------------------------------------
// Pure helpers
// ---------------------------------------------------------------------------

// One real NDJSON line captured via `moon check --output-json` on the
// fixture's broken package (same error as the sample project's
// cmd/main/handlers.mbt).
const REAL_ERROR_LINE =
  '{"$message_type":"diagnostic","level":"error","error_code":4021,' +
  '"path":"/tmp/moon-sample/broken/broken.mbt","loc":"3:9-3:27",' +
  '"message":"Value parse_int not found in package `strconv`.",' +
  '"context":"2 |pub fn parse_page(raw : String) -> Int {\\n3 |  match @strconv.parse_int(raw) {"}';

const REAL_WARNING_LINE =
  '{"$message_type":"diagnostic","level":"warning","error_code":29,' +
  '"path":"/tmp/moon-sample/types/moon.pkg","loc":"4:3-4:26",' +
  '"message":"Warning (unused_package): Unused package \'moonbitlang/core/json\'",' +
  '"context":"3 |import {\\n4 |  \\"moonbitlang/core/json\\","}';

describe("parseCheckOutput", () => {
  test("parses real diagnostic NDJSON lines", () => {
    const { diagnostics, unparsedLines } = parseCheckOutput(
      `${REAL_ERROR_LINE}\n${REAL_WARNING_LINE}\n`,
    );
    expect(diagnostics.length).toBe(2);
    expect(unparsedLines.length).toBe(0);

    const [err, warn] = diagnostics as CheckDiagnostic[];
    expect(err.level).toBe("error");
    expect(err.error_code).toBe(4021);
    expect(err.path).toBe("/tmp/moon-sample/broken/broken.mbt");
    expect(err.loc).toBe("3:9-3:27");
    expect(err.message).toContain("parse_int");

    expect(warn.level).toBe("warning");
    expect(warn.error_code).toBe(29);
    expect(warn.message).toContain("unused_package");
  });

  test("collects non-JSON and non-diagnostic lines as unparsed", () => {
    const { diagnostics, unparsedLines } = parseCheckOutput(
      `not json at all\n${REAL_ERROR_LINE}\n{"$message_type":"progress"}\n\n`,
    );
    expect(diagnostics.length).toBe(1);
    expect(unparsedLines).toEqual([
      "not json at all",
      '{"$message_type":"progress"}',
    ]);
  });

  test("empty stdout yields no diagnostics and no unparsed lines", () => {
    expect(parseCheckOutput("")).toEqual({ diagnostics: [], unparsedLines: [] });
    expect(parseCheckOutput("  \n \n")).toEqual({ diagnostics: [], unparsedLines: [] });
  });
});

describe("truncate", () => {
  test("leaves short output untouched", () => {
    const s = "x".repeat(100);
    expect(truncate(s)).toBe(s);
  });

  test("marks oversized output as truncated", () => {
    const s = "y".repeat(25_000);
    const out = truncate(s);
    expect(out.startsWith("y".repeat(20_000))).toBe(true);
    expect(out).toContain("... [truncated 5000 chars]");
  });
});

describe("moonModDir", () => {
  test("strips a trailing /moon.mod and resolves to an absolute dir", () => {
    expect(moonModDir("/home/me/proj/moon.mod")).toBe("/home/me/proj");
    expect(moonModDir("/home/me/proj/")).toBe("/home/me/proj");
    expect(moonModDir("/home/me/proj/MOON.MOD")).toBe("/home/me/proj");
    // tolerant of a bare directory too (model already stripped the filename)
    expect(moonModDir("/home/me/proj")).toBe("/home/me/proj");
  });

  test("rejects empty, blank, and relative inputs instead of silently resolving", () => {
    // empty/blank would otherwise become the session cwd — the wrong module
    expect(() => moonModDir("")).toThrow();
    expect(() => moonModDir("   ")).toThrow();
    expect(() => moonModDir(undefined as unknown as string)).toThrow();
    // relative paths would silently resolve against the extension process cwd
    expect(() => moonModDir("proj")).toThrow();
    expect(() => moonModDir("./proj")).toThrow();
    expect(() => moonModDir("./fixtures/moon-sample/moon.mod")).toThrow();
  });
});

describe("invalid moon_mod_filepath handling", () => {
  test(
    "moon_check returns an actionable failure result for a nonexistent path",
    async () => {
      const res = await execute(
        "moon_check",
        { moon_mod_filepath: "/definitely/not/here/moon.mod" },
        { cwd: "/tmp" },
      );
      expect(res.details[FAILURE_FLAG]).toBe(true);
      expect(res.details.ok).toBe(false);
      const text = res.content[0].text as string;
      expect(text).toContain("Invalid moon_mod_filepath");
      expect(text).toContain("nonexistent");
      expect(text).toContain("/definitely/not/here");
    },
    30_000,
  );

  test(
    "directory without a moon.mod says so explicitly (moon would mislead)",
    async () => {
      const nomod = fs.mkdtempSync(path.join(os.tmpdir(), "moon-nomod-"));
      try {
        const res = await execute(
          "moon_check",
          { moon_mod_filepath: path.join(nomod, "moon.mod") },
          { cwd: "/tmp" },
        );
        expect(res.details[FAILURE_FLAG]).toBe(true);
        expect(res.content[0].text).toContain("No moon.mod found");
      } finally {
        fs.rmSync(nomod, { recursive: true, force: true });
      }
    },
    30_000,
  );

  test(
    "an ide tool surfaces the same error instead of moon's misleading symbol output",
    async () => {
      const res = await execute(
        "moon_peek_def",
        { moon_mod_filepath: "/definitely/not/here/moon.mod", symbol: "S3Config" },
        { cwd: "/tmp" },
      );
      expect(res.details[FAILURE_FLAG]).toBe(true);
      // must NOT contain moon's "No symbols found" — that would read as a
      // legitimate "symbol doesn't exist" answer
      expect(res.content[0].text).toContain("Invalid moon_mod_filepath");
      expect(res.content[0].text).not.toContain("No symbols found");
    },
    30_000,
  );

  test("valid path still passes validation and reaches moon", async () => {
    const res = await execute("moon_check", {}, { cwd: FIXTURE_DIR });
    expect(res.details.ok).toBe(true);
    expect(res.details[FAILURE_FLAG]).toBeUndefined();
  }, 120_000);
});

// ---------------------------------------------------------------------------
// moon_check (integration, real moon against the fixture module)
// ---------------------------------------------------------------------------

describe("moon_check tool", () => {
  test(
    "runs against the moon_mod_filepath module even when session cwd is elsewhere",
    async () => {
      // moon -C <module dir> must redirect the run away from the session cwd.
      const res = await execute(
        "moon_check",
        { moon_mod_filepath: path.join(FIXTURE_DIR, "moon.mod") },
        { cwd: path.dirname(FIXTURE_DIR) },
      );
      expect(res.details.ok).toBe(true);
      expect(res.details.errorCount).toBe(0);
      expect(res.details.warningCount).toBe(1); // the moon-sample module's warning
      expect(res.content[0].text).toContain("Unused package 'moonbitlang/core/json'");
    },
    120_000,
  );

  test(
    "whole module: warning-only report is not an error",
    async () => {
      const res = await execute("moon_check", {}, { cwd: FIXTURE_DIR });
      // ok is true even with diagnostics; FAILURE_FLAG reflects error presence
      expect(res.details.ok).toBe(true);
      expect(res.details.target).toBe("wasm-gc"); // default target
      expect(res.details.errorCount).toBe(0);
      expect(res.details.warningCount).toBe(1);
      expect(res.details.hasErrors).toBe(false);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("0 error(s), 1 warning(s)");
      expect(res.content[0].text).toContain("[warning 29]");
      expect(res.content[0].text).toContain("Unused package 'moonbitlang/core/json'");
    },
    120_000,
  );

  test(
    "explicit target is passed through (js)",
    async () => {
      const res = await execute(
        "moon_check",
        { target: "js", package: "types" },
        { cwd: FIXTURE_DIR },
      );
      expect(res.details.ok).toBe(true);
      expect(res.details.target).toBe("js");
      expect(res.details.errorCount).toBe(0);
      expect(res.details.warningCount).toBe(1);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
    },
    120_000,
  );

  test(
    "broken module: reports the type error as an error",
    async () => {
      const res = await execute("moon_check", {}, { cwd: BROKEN_DIR });
      expect(res.details.ok).toBe(true);
      expect(res.details.errorCount).toBe(1);
      expect(res.details.warningCount).toBe(0);
      expect(res.details.hasErrors).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBe(true);
      expect(res.content[0].text).toContain("1 error(s), 0 warning(s)");
      expect(res.content[0].text).toContain("[error 4021]");
      expect(res.content[0].text).toContain("broken/broken.mbt");
      expect(res.content[0].text).toContain("Value parse_int not found in package `strconv`.");
    },
    120_000,
  );

  test(
    "scoped to the types package: warning only, not an error",
    async () => {
      const res = await execute("moon_check", { package: "types" }, { cwd: FIXTURE_DIR });
      expect(res.details.errorCount).toBe(0);
      expect(res.details.warningCount).toBe(1);
      expect(res.details.hasErrors).toBe(false);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("0 error(s), 1 warning(s)");
    },
    120_000,
  );

  test(
    "scoped check keeps dependency diagnostics (-p ok includes the types warning)",
    async () => {
      const res = await execute("moon_check", { package: "ok" }, { cwd: FIXTURE_DIR });
      // ok has no own issues, but moon check still reports the unused
      // import warning from its dependency `types` — observed behavior of
      // moon 0.1.20260904 that callers must expect.
      expect(res.details.errorCount).toBe(0);
      expect(res.details.warningCount).toBe(1);
      expect(res.details.hasErrors).toBe(false);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("0 error(s), 1 warning(s)");
      expect(res.content[0].text).toContain("types/moon.pkg");
    },
    120_000,
  );

  test(
    "scoped to a package with no issues and no issues upstream: clean report",
    async () => {
      const res = await execute("moon_check", { package: "extra" }, { cwd: BROKEN_DIR });
      expect(res.details.errorCount).toBe(0);
      expect(res.details.warningCount).toBe(0);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("No errors or warnings.");
    },
    120_000,
  );
});

// ---------------------------------------------------------------------------
// dependency-vs-module partitioning (moon_check ownership filter)
// ---------------------------------------------------------------------------

describe("ownership partitioning helpers", () => {
  test("isDependencyPath: outside the module or under .mooncakes", () => {
    const root = "/ws/app";
    expect(isDependencyPath("/ws/app/src/lib.mbt", root)).toBe(false);
    expect(isDependencyPath("/ws/app/src/lib.mbt", root)).toBe(false);
    expect(isDependencyPath("/ws/dep-noisy/lib/lib.mbt", root)).toBe(true);
    expect(isDependencyPath("/ws/app/.mooncakes/bobz/crescent/lib.mbt", root)).toBe(true);
    // relative paths resolve against the module root
    expect(isDependencyPath("src/lib.mbt", root)).toBe(false);
    expect(isDependencyPath("../dep/lib.mbt", root)).toBe(true);
    // fail open without a module root
    expect(isDependencyPath("/ws/dep-noisy/lib/lib.mbt", undefined)).toBe(false);
  });

  test("dependencyOrigin: mooncakes user/pkg, else sibling dir name", () => {
    expect(dependencyOrigin("/ws/app/.mooncakes/bobz/crescent/lib/lib.mbt", "/ws/app")).toBe(
      "bobz/crescent",
    );
    expect(dependencyOrigin("/ws/dep-noisy/lib/lib.mbt", "/ws/app")).toBe("dep-noisy");
  });

  test("hiddenDepSummary groups by origin", () => {
    const diags: CheckDiagnostic[] = [
      { level: "warning", path: "/ws/dep-noisy/lib/moon.pkg" },
      { level: "warning", path: "/ws/dep-noisy/lib/moon.pkg" },
      { level: "warning", path: "/ws/app/.mooncakes/bobz/crescent/cookie.mbt" },
    ];
    expect(hiddenDepSummary(diags, "/ws/app")).toBe("dep-noisy: 2, bobz/crescent: 1");
  });

  test("partitionDiagnostics: diagnostics without a path stay in the module bucket", () => {
    const diags: CheckDiagnostic[] = [
      { level: "error", path: "/ws/app/src/lib.mbt" },
      { level: "warning", path: "/ws/dep-noisy/lib/moon.pkg" },
      { level: "error", message: "no location" },
    ];
    const { workspace, dependency } = partitionDiagnostics(diags, "/ws/app");
    expect(workspace.length).toBe(2);
    expect(dependency.length).toBe(1);
  });
});

describe("moon_check dependency filtering (moon.work workspace)", () => {
  test(
    "default: dependency warnings hidden behind a count, dependency errors always shown",
    async () => {
      const res = await execute("moon_check", {}, { cwd: WS_APP_DIR });
      expect(res.details[FAILURE_FLAG]).toBe(true); // the dependency error breaks the build
      expect(res.details.ok).toBe(true);
      expect(res.details.errorCount).toBe(1);
      expect(res.details.warningCount).toBe(0); // module itself is clean
      expect(res.details.depErrorCount).toBe(1);
      expect(res.details.depWarningCount).toBe(2);
      expect(res.details.includeDeps).toBe(false);
      const text = res.content[0].text;
      expect(text).toContain("1 error(s), 2 warning(s).");
      expect(text).toContain("2 dependency warning(s) hidden (dep-noisy: 2).");
      // dependency errors are listed, tagged as dependency
      expect(text).toContain("[dependency error 4021]");
      expect(text).toContain("dep-broken/broken/broken.mbt");
      // hidden dependency warnings are not listed
      expect(text).not.toContain("dep-noisy/lib/moon.pkg");
    },
    120_000,
  );

  test(
    "includeDeps: true lists the previously hidden dependency warnings",
    async () => {
      const res = await execute(
        "moon_check",
        { includeDeps: true },
        { cwd: WS_APP_DIR },
      );
      expect(res.details.includeDeps).toBe(true);
      expect(res.details.depWarningCount).toBe(2);
      const text = res.content[0].text;
      expect(text).toContain("[dependency warning 29]");
      expect(text).toContain("dep-noisy/lib/moon.pkg");
      expect(text).not.toContain("hidden (");
    },
    120_000,
  );
});
