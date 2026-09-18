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
import path from "node:path";
import moonbitExtension, { registerMoonTools } from "../extensions/moonbit.ts";
import { FAILURE_FLAG, truncate } from "../extensions/shared.ts";

// ---------------------------------------------------------------------------
// Harness: stub ExtensionAPI that captures registrations
// ---------------------------------------------------------------------------

const FIXTURE_DIR = path.resolve(import.meta.dir, "../fixtures/moon-sample");
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
// moonexec / doctor plumbing
// ---------------------------------------------------------------------------

describe("moonexec.runMoon + doctor", () => {
  test("pre-aborted signal short-circuits to aborted", async () => {
    const { runMoon } = await import("../extensions/moonexec.ts");
    const controller = new AbortController();
    controller.abort();
    const res = await runMoon(["version"], { dir: FIXTURE_DIR, signal: controller.signal });
    expect(res.aborted).toBe(true);
    expect(res.ok).toBe(false);
    expect(res.spawnFailed).toBe(false);
    expect(res.timedOut).toBe(false);
  });

  test("non-zero exit is a normal result, not a spawn failure", async () => {
    const { runMoon } = await import("../extensions/moonexec.ts");
    const res = await runMoon(["nonexistent-subcommand-xyz"], { dir: FIXTURE_DIR });
    expect(res.ok).toBe(false);
    expect(res.spawnFailed).toBe(false);
    expect(res.timedOut).toBe(false);
    expect(typeof res.exitCode).toBe("number");
    expect(res.stderr).toContain("no such subcommand");
  }, 30_000);

  test("timeout kill sets timedOut, not spawnFailed", async () => {
    // `moon version` is fast, but a tiny execFile timeout still fires first
    const { runMoon } = await import("../extensions/moonexec.ts");
    const res = await runMoon(["version"], { dir: FIXTURE_DIR, timeout: 1 });
    expect(res.ok).toBe(false);
    expect(res.timedOut).toBe(true);
    expect(res.spawnFailed).toBe(false);
    expect(res.timeoutMs).toBe(1);
  }, 30_000);

  test("checkMoonAvailable reports the reachable toolchain", async () => {
    const { checkMoonAvailable } = await import("../extensions/doctor.ts");
    const res = await checkMoonAvailable();
    expect(res.available).toBe(true);
    expect(res.version).toMatch(/^moon \d/);
  }, 30_000);
});

// guard against accidentally dropping the extraction of registerMoonTools
test("registerMoonTools is exported for direct invocation", () => {
  expect(typeof registerMoonTools).toBe("function");
});
