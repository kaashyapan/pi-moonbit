import { describe, expect, test, beforeAll } from "bun:test";
import { FAILURE_FLAG, truncate } from "../extensions/shared.ts";
import path from "node:path";
import moonbitExtension, { registerMoonTools } from "../extensions/moonbit.ts";

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

beforeAll(async () => {
    // Load the full extension (doctor command + tool suite) through the real
    // default export; registration runs the `moon version` reachability check,
    // which must pass for the integration tests below anyway.
    await moonbitExtension(makeStubPi() as any);
});
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
