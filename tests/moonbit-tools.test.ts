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
// The fixtures mirror the sample project (medconf_api): an `S3Config`
// struct with a doc comment (peek-def/hover/find-references), a cross-
// package reference from `ok/`, an unused import warning (code 29), and
// passing/failing tests for the moon_test paths. Because `moon test -p`
// builds the whole module, the deliberate type error (code 4021,
// `strconv.parse_int` — same as the sample project) lives in a separate
// module, tests/fixtures/moon-broken, so it can't poison the passing
// moon_test runs.
//
// NOTE: `moon ide peek-def`, `find-references` and `hover` accept --json;
// `outline`, `doc`, `analyze` and `rename` do not (moon 0.1.20260904), so
// those tools return plain text. The rename/apply test runs in a throwaway
// copy of the fixture so the committed fixture is never rewritten.

import { describe, expect, test, beforeAll } from "bun:test";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import moonbitExtension, { registerMoonTools } from "../extensions/moonbit.ts";
import { BASH_REDIRECTS, findBashRedirect } from "../extensions/bash-redirect.ts";
import {
  dependencyOrigin,
  findModuleRoot,
  hiddenDepSummary,
  isDependencyPath,
  parseCheckOutput,
  partitionDiagnostics,
  type CheckDiagnostic,
} from "../extensions/diagnostics.ts";
import { FAILURE_FLAG, truncate } from "../extensions/shared.ts";

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
  return await tool.execute("test-call-id", params, undefined, undefined, ctx);
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

describe("findBashRedirect", () => {
  test("every configured redirect matches its canonical command", () => {
    for (const r of BASH_REDIRECTS) {
      // derive the canonical command from the regex itself (strip the
      // command-position anchors and expand the whitespace class)
      const sample = r.match.source
        .replace(/[\^\$]|\\b/g, "")
        .replace(/\\s\+/g, " ");
      expect(findBashRedirect(sample)).toBeDefined();
    }
  });

  test("matches chained commands at command positions", () => {
    expect(findBashRedirect("cd /tmp && moon test -p ok")?.tool).toBe("moon_test");
    expect(findBashRedirect("moon fmt && moon info")?.tool).toBe("moon_fmt_info");
    expect(findBashRedirect("$(moon check) | head")?.tool).toBe("moon_check");
  });

  test("does not match mentions inside quoted arguments", () => {
    // the case that motivated the fix: a command whose argument text merely
    // mentions a moon subcommand must pass through to bash
    expect(findBashRedirect("perl -e 's/.../moon ide hover/' README.md")).toBeUndefined();
    expect(findBashRedirect('echo "moon test"')).toBeUndefined();
    expect(findBashRedirect("grep 'moon check' notes.md")).toBeUndefined();
  });

  test("does not match mentions at non-command positions", () => {
    expect(findBashRedirect("echo use the moon check tool")).toBeUndefined();
  });

  test("maps the moon subcommands the tools wrap", () => {
    expect(findBashRedirect("moon check --output-json -p foo")?.tool).toBe("moon_check");
    expect(findBashRedirect("moon test -p foo --target wasm-gc")?.tool).toBe("moon_test");
    expect(findBashRedirect("moon fmt && moon info")?.tool).toBe("moon_fmt_info");
    expect(findBashRedirect("moon ide peek-def foo --json")?.tool).toBe("moon_peek_def");
    expect(findBashRedirect("moon ide rename old new --loc x.mbt")?.tool).toBe("moon_rename");
  });

  test("does not match non-moon or glued commands", () => {
    expect(findBashRedirect("ls -la")).toBeUndefined();
    expect(findBashRedirect("mooncheck")).toBeUndefined();
    expect(findBashRedirect("cat moon/check.txt")).toBeUndefined();
    expect(findBashRedirect("moon build")).toBeUndefined();
  });
});

// ---------------------------------------------------------------------------
// Registration surface
// ---------------------------------------------------------------------------

describe("registration", () => {
  test("registers every moon tool and the doctor command", () => {
    const expected = [
      "moon_peek_def",
      "moon_find_references",
      "moon_type_info",
      "moon_outline",
      "moon_rename",
      "moon_analyze",
      "moon_doc",
      "moon_check",
      "moon_test",
      "moon_fmt_info",
    ];
    for (const name of expected) {
      expect(tools.has(name)).toBe(true);
      expect(tools.get(name).name).toBe(name);
    }
    expect(commands.has("moon-doctor")).toBe(true);
  });

  test("tool_call listener blocks bash duplicates and names the tool to use", () => {
    const handler = listeners.get("tool_call");
    expect(handler).toBeDefined();

    const blocked = handler?.({ toolName: "bash", input: { command: "moon test -p ok" } });
    expect(blocked).toEqual({
      block: true,
      reason: expect.stringContaining("moon_test"),
    });

    // unrelated bash and non-bash tool calls pass through untouched
    expect(handler?.({ toolName: "bash", input: { command: "ls -la" } })).toBeUndefined();
    expect(handler?.({ toolName: "read", input: { path: "x.mbt" } })).toBeUndefined();
  });

  test("tool_call listener also blocks powershell duplicates (Windows bypass)", () => {
    const handler = listeners.get("tool_call");
    const blocked = handler?.({ toolName: "powershell", input: { command: "moon check" } });
    expect(blocked).toEqual({
      block: true,
      reason: expect.stringContaining("moon_check"),
    });
    expect(handler?.({ toolName: "powershell", input: { command: "Get-ChildItem" } })).toBeUndefined();
  });

  test("tool_result listener flags FAILURE_FLAG results as errors and strips the marker", () => {
    const handler = listeners.get("tool_result");
    expect(handler).toBeDefined();

    const flagged = handler?.({
      type: "tool_result",
      toolName: "moon_check",
      toolCallId: "x",
      input: {},
      content: [{ type: "text", text: "1 error(s)" }],
      details: { ok: true, hasErrors: true, [FAILURE_FLAG]: true },
      isError: false,
    });
    expect(flagged?.isError).toBe(true);
    expect(flagged?.details?.[FAILURE_FLAG]).toBeUndefined();
    // unrelated results pass through untouched
    expect(
      handler?.({ type: "tool_result", toolName: "moon_check", details: { ok: true } }),
    ).toBeUndefined();
  });
});

// ---------------------------------------------------------------------------
// moon_check (integration, real moon against the fixture module)
// ---------------------------------------------------------------------------

describe("moon_check tool", () => {
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
  test("findModuleRoot walks up to the nearest moon.mod", () => {
    expect(findModuleRoot(FIXTURE_DIR)).toBe(FIXTURE_DIR);
    expect(findModuleRoot(path.join(FIXTURE_DIR, "types"))).toBe(FIXTURE_DIR);
    expect(findModuleRoot(undefined)).toBeUndefined();
    expect(findModuleRoot("/nonexistent-root-for-tests/deep")).toBeUndefined();
  });

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

// ---------------------------------------------------------------------------
// moon_test (integration)
// ---------------------------------------------------------------------------

describe("moon_test tool", () => {
  test(
    "passing package reports success without the failure flag",
    async () => {
      const res = await execute("moon_test", { package: "ok" }, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(true);
      expect(res.details.target).toBe("wasm-gc"); // default target
      expect(res.details.exitCode).toBe(0);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("Tests passed.");
      expect(res.content[0].text).toContain("passed: 1");
      expect(res.content[0].text).toContain("failed: 0");
    },
    180_000,
  );

  test(
    "explicit target is passed through (js)",
    async () => {
      const res = await execute(
        "moon_test",
        { package: "ok", target: "js" },
        { cwd: FIXTURE_DIR },
      );
      expect(res.details.ok).toBe(true);
      expect(res.details.target).toBe("js");
      expect(res.details.exitCode).toBe(0);
      expect(res.content[0].text).toContain("Tests passed.");
    },
    180_000,
  );

  test(
    "failing package sets the failure flag and surfaces the failing test",
    async () => {
      const res = await execute("moon_test", { package: "types" }, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(false);
      expect(res.details[FAILURE_FLAG]).toBe(true);
      expect(res.content[0].text).toContain("Tests failed (exit ");
      expect(res.content[0].text).toContain("intentionally failing");
      expect(res.content[0].text).toContain("failed: 1");
    },
    180_000,
  );
});

// ---------------------------------------------------------------------------
// moon_peek_def / moon_type_info / moon_find_references (integration)
// ---------------------------------------------------------------------------

describe("moon_peek_def tool", () => {
  test(
    "resolves a symbol to its definition path and range",
    async () => {
      const res = await execute("moon_peek_def", { symbol: "S3Config" }, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      const json = JSON.parse(res.content[0].text);
      expect(json.length).toBe(1);
      expect(json[0].path).toBe(TYPES_MBT);
      expect(json[0].range).toBe("10:17-10:25");
    },
    120_000,
  );

  test(
    "unknown symbol surfaces moon's non-JSON failure instead of throwing",
    async () => {
      const res = await execute(
        "moon_peek_def",
        { symbol: "NoSuchSymbolAnywhere" },
        { cwd: FIXTURE_DIR },
      );
      expect(res.details[FAILURE_FLAG]).toBe(true);
      expect(res.content[0].text).toContain("moon ide failed.");
      expect(res.content[0].text).toContain("No symbols found matching 'NoSuchSymbolAnywhere'");
    },
    120_000,
  );
});

describe("moon_type_info tool", () => {
  test(
    "returns type + doc comment at the definition position",
    async () => {
      const res = await execute(
        "moon_type_info",
        { loc: `${TYPES_MBT}:10:17` },
        { cwd: FIXTURE_DIR },
      );
      expect(res.details.ok).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      const json = JSON.parse(res.content[0].text);
      expect(json.range).toBe("10:17-10:25");
      expect(json.contents[0]).toContain("struct S3Config");
      // the /// doc comment lines are included in the hover payload
      expect(json.contents[1]).toContain("Storage configuration");
    },
    120_000,
  );

  test(
    "position off a symbol fails gracefully",
    async () => {
      const res = await execute(
        "moon_type_info",
        { loc: `${TYPES_MBT}:10:1` },
        { cwd: FIXTURE_DIR },
      );
      expect(res.details[FAILURE_FLAG]).toBe(true);
      expect(res.content[0].text).toContain("moon ide failed.");
    },
    120_000,
  );
});

describe("moon_find_references tool", () => {
  test(
    "finds compiler-resolved references across packages",
    async () => {
      const res = await execute("moon_find_references", { symbol: "S3Config" }, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      const json = JSON.parse(res.content[0].text);
      const refs = json.map((r: any) => `${path.relative(FIXTURE_DIR, r.path)}@${r.range}`);
      // Ctx field + endpoint_url param + cross-package use in ok/ are stable
      // across moon versions. The definition site (types.mbt@10:17-10:25) is
      // NOT: newer moon builds (e.g. 0.1.20260915 on Linux) omit the
      // declaration site from find-references output — observed on CI. So
      // assert the usage sites exactly and the definition site conditionally.
      const defSite = refs.indexOf("types/types.mbt@10:17-10:25");
      if (defSite >= 0) refs.splice(defSite, 1);
      expect(refs).toEqual([
        "ok/ok.mbt@2:36-2:44",
        "types/types.mbt@19:8-19:16",
        "types/types.mbt@23:30-23:38",
      ]);
      // every returned entry must be one of the four known S3Config sites —
      // catches a moon version that also changes range shapes
      for (const r of refs) {
        expect([
          "ok/ok.mbt@2:36-2:44",
          "types/types.mbt@10:17-10:25",
          "types/types.mbt@19:8-19:16",
          "types/types.mbt@23:30-23:38",
        ]).toContain(r);
      }
    },
    120_000,
  );
});

// ---------------------------------------------------------------------------
// Tools whose underlying `moon ide` subcommands reject --json on
// moon 0.1.20260904. These pin the current (failing) behavior: the tool
// must not crash and must surface moon's stderr.
// ---------------------------------------------------------------------------

describe("moon_outline tool", () => {
  test(
    "returns declaration snippets with line numbers",
    async () => {
      const res = await execute("moon_outline", { path: "types" }, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("types.mbt:");
      expect(res.content[0].text).toContain("pub(all) struct S3Config {");
      expect(res.content[0].text).toContain("pub fn page_size");
    },
    120_000,
  );
});

describe("moon_doc tool", () => {
  test(
    "returns the exported API listing for a package query",
    async () => {
      const res = await execute("moon_doc", { query: "@json" }, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain('package "moonbitlang/core/json"');
      expect(res.content[0].text).toContain("to_json");
    },
    120_000,
  );
});

describe("moon_analyze tool", () => {
  test(
    "with no path, reports usage counts for all local packages",
    async () => {
      const res = await execute("moon_analyze", {}, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("kaashyapan/moon-sample/types");
      expect(res.content[0].text).toContain("usage: 1 (1 in test)");
    },
    120_000,
  );

  test(
    "scopes the report to the given package directory",
    async () => {
      const res = await execute("moon_analyze", { path: "./types" }, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text).toContain("page_size");
      expect(res.content[0].text).not.toContain("kaashyapan/moon-sample/ok");
    },
    120_000,
  );

  test(
    "rejects symbol names (the positional is a package dir)",
    async () => {
      const res = await execute("moon_analyze", { path: "S3Config" }, { cwd: FIXTURE_DIR });
      expect(res.details.ok).toBe(false);
      expect(res.details[FAILURE_FLAG]).toBe(true);
      expect(res.content[0].text).toContain("No such file or directory");
    },
    120_000,
  );
});

describe("moon_rename tool", () => {
  test(
    "dry run returns the patch list and writes nothing",
    async () => {
      const res = await execute(
        "moon_rename",
        { old_name: "S3Config", new_name: "S3Settings", loc: "types/types.mbt" },
        { cwd: FIXTURE_DIR },
      );
      expect(res.details.ok).toBe(true);
      expect(res.details[FAILURE_FLAG]).toBeUndefined();
      expect(res.content[0].text.startsWith("[DRY RUN")).toBe(true);
      expect(res.content[0].text).toContain("*** Begin Patch");
      expect(res.content[0].text).toContain("+pub(all) struct S3Settings {");
      // dry run must not have touched the committed fixture
      expect(fs.readFileSync(TYPES_MBT, "utf8")).toContain("pub(all) struct S3Config {");
    },
    120_000,
  );

  test(
    "apply rewrites files in a throwaway copy of the fixture",
    async () => {
      const tmp = fs.mkdtempSync(path.join(os.tmpdir(), "moon-rename-"));
      try {
        fs.cpSync(FIXTURE_DIR, tmp, { recursive: true });
        fs.rmSync(path.join(tmp, "_build"), { recursive: true, force: true });
        const res = await execute(
          "moon_rename",
          { old_name: "S3Config", new_name: "S3Settings", loc: "types/types.mbt", apply: true },
          { cwd: tmp },
        );
        expect(res.details.ok).toBe(true);
        expect(res.details[FAILURE_FLAG]).toBeUndefined();
        expect(res.content[0].text).toContain("Applied 4 edit(s) across 2 file(s).");
        // the rename spans both the definition and the cross-package usage
        expect(fs.readFileSync(path.join(tmp, "types", "types.mbt"), "utf8")).toContain(
          "pub(all) struct S3Settings {",
        );
        expect(fs.readFileSync(path.join(tmp, "ok", "ok.mbt"), "utf8")).toContain(
          "@types.S3Settings",
        );
        // no DRY RUN banner on a real apply
        expect(res.content[0].text.startsWith("[DRY RUN")).toBe(false);
      } finally {
        fs.rmSync(tmp, { recursive: true, force: true });
      }
    },
    180_000,
  );
});

// ---------------------------------------------------------------------------
// moon_fmt_info (integration; fixture is committed fmt-canonical)
// ---------------------------------------------------------------------------

describe("moon_fmt_info tool", () => {
  test(
    "formats the module and regenerates interfaces, reporting success",
    async () => {
      const res = await execute("moon_fmt_info", { package: "ok" }, { cwd: FIXTURE_DIR });
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
    "broken module: fmt succeeds, info fails, tool reports the failure",
    async () => {
      const res = await execute("moon_fmt_info", {}, { cwd: BROKEN_DIR });
      expect(res.details.ok).toBe(false);
      expect(res.details.fmtExit).toBe(0);
      expect(res.details[FAILURE_FLAG]).toBe(true);
      // both sections are surfaced even though info failed
      expect(res.content[0].text).toContain("## moon fmt (exit 0)");
      expect(res.content[0].text).toContain("## moon info");
    },
    180_000,
  );

  test("fixture survives a fmt round-trip unchanged", async () => {
    // run fmt via the same exec path the tool uses, then confirm no diff
    const { runMoon } = await import("../extensions/moonexec.ts");
    await runMoon(["fmt"], { cwd: FIXTURE_DIR });
    const proc = Bun.spawnSync(["git", "status", "--porcelain", "."], {
      cwd: FIXTURE_DIR,
    });
    // only an unstaged/staged *worktree modification* means fmt touched a
    // file (column 2 of porcelain = worktree status). Everything else —
    // staged renames, untracked _build/pkg.generated.mbti — is index/noise
    // irrelevant to this invariant.
    const dirty = proc.stdout
      .toString()
      .split("\n")
      .filter((l) => l.length > 3 && l[1] === "M");
    expect(dirty).toEqual([]);
  }, 180_000);
});

// ---------------------------------------------------------------------------
// moonexec / doctor plumbing
// ---------------------------------------------------------------------------

describe("moonexec.runMoon + doctor", () => {
  test("pre-aborted signal short-circuits to aborted", async () => {
    const { runMoon } = await import("../extensions/moonexec.ts");
    const controller = new AbortController();
    controller.abort();
    const res = await runMoon(["version"], { signal: controller.signal });
    expect(res.aborted).toBe(true);
    expect(res.ok).toBe(false);
    expect(res.spawnFailed).toBe(false);
    expect(res.timedOut).toBe(false);
  });

  test("non-zero exit is a normal result, not a spawn failure", async () => {
    const { runMoon } = await import("../extensions/moonexec.ts");
    const res = await runMoon(["nonexistent-subcommand-xyz"], { cwd: FIXTURE_DIR });
    expect(res.ok).toBe(false);
    expect(res.spawnFailed).toBe(false);
    expect(res.timedOut).toBe(false);
    expect(typeof res.exitCode).toBe("number");
    expect(res.stderr).toContain("no such subcommand");
  }, 30_000);

  test("timeout kill sets timedOut, not spawnFailed", async () => {
    // `moon version` is fast, but a tiny execFile timeout still fires first
    const { runMoon } = await import("../extensions/moonexec.ts");
    const res = await runMoon(["version"], { cwd: FIXTURE_DIR, timeout: 1 });
    expect(res.ok).toBe(false);
    expect(res.timedOut).toBe(true);
    expect(res.spawnFailed).toBe(false);
    expect(res.timeoutMs).toBe(1);
  }, 30_000);

  test("checkMoonAvailable reports the reachable toolchain", async () => {
    const { checkMoonAvailable } = await import("../extensions/doctor.ts");
    const res = await checkMoonAvailable(FIXTURE_DIR);
    expect(res.available).toBe(true);
    expect(res.version).toMatch(/^moon \d/);
  }, 30_000);
});

// guard against accidentally dropping the extraction of registerMoonTools
test("registerMoonTools is exported for direct invocation", () => {
  expect(typeof registerMoonTools).toBe("function");
});
