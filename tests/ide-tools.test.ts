// Tests for the tools registered by extensions/moonbit.ts (the pi MoonBit
// extension). Strategy:
//
// 1. Integration tests that load the real extension into a stub
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
import { FAILURE_FLAG, truncate } from "../extensions/shared.ts";

// ---------------------------------------------------------------------------
// Harness: stub ExtensionAPI that captures registrations
// ---------------------------------------------------------------------------

const FIXTURE_DIR = path.resolve(import.meta.dir, "../fixtures/moon-sample");
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
