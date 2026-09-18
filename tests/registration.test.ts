import { describe, expect, test, beforeAll } from "bun:test";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { FAILURE_FLAG, truncate } from "../extensions/shared.ts";
import moonbitExtension, { registerMoonTools } from "../extensions/moonbit.ts";

const tools = new Map<string, any>();
const commands = new Map<string, any>();
const listeners = new Map<string, (event: any, ctx?: any) => any>();

function makeStubPi() {
    return {
        registerTool: (tool: any) => tools.set(tool.name, tool),
        registerCommand: (name: string, spec: any) => commands.set(name, spec),
        on: (event: string, handler: (event: any, ctx?: any) => any) => listeners.set(event, handler),
    };
}

beforeAll(async () => {
    // Load the full extension (doctor command + tool suite) through the real
    // default export; registration runs the `moon version` reachability check,
    // which must pass for the integration tests below anyway.
    await moonbitExtension(makeStubPi() as any);
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

    test("before_agent_start loads the MoonBit tooling guide from disk", async () => {
        const handler = listeners.get("before_agent_start");
        expect(handler).toBeDefined();

        // The handler reads ./AGENTS.md relative to the process CWD at event
        // time, so run it against a temp dir with sentinel content to prove
        // the guide is actually read from disk (not a hard-coded string).
        const tmp = fs.mkdtempSync(path.join(os.tmpdir(), "moonbit-guide-"));
        const sentinel = "# MoonBit tooling guide (test sentinel)\nUse moon_check liberally.";
        fs.writeFileSync(path.join(tmp, "AGENTS.md"), sentinel);
        const prevCwd = process.cwd();
        process.chdir(tmp);
        try {
            const result = await handler?.({}, { cwd: tmp });
            expect(result?.message?.customType).toBe("pi-moonbit-guide");
            expect(result?.message?.display).toBe(true);
            expect(result?.message?.content).toBe(sentinel);
        } finally {
            process.chdir(prevCwd);
            fs.rmSync(tmp, { recursive: true, force: true });
        }

        // Missing AGENTS.md surfaces the read failure instead of a fake guide.
        const missing = fs.mkdtempSync(path.join(os.tmpdir(), "moonbit-guide-"));
        process.chdir(missing);
        try {
            await expect(handler?.({}, { cwd: missing })).rejects.toThrow();
        } finally {
            process.chdir(prevCwd);
            fs.rmSync(missing, { recursive: true, force: true });
        }
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