// Tests for the tools registered by extensions/moonbit.ts (the pi MoonBit
// extension). Strategy:
//
// 1. Unit tests for the pure helpers (parseCheckOutput, truncate,
//    findBashRedirect) using NDJSON and diagnostics captured from real
//    `moon check --output-json` runs.
// 2. Integration tests that load the real extension into a stub
//    ExtensionAPI and execute the actual tool handlers against the
//    fixture MoonBit module in tests/fixtures/moon-sample.

import { describe, expect, test, beforeAll } from "bun:test";
import path from "node:path";
import moonbitExtension, { registerMoonTools } from "../extensions/moonbit.ts";

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
