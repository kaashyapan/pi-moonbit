// Tests for the moon_explain_error tool (extensions/error-tool.ts). The tool
// is a pure lookup against ERROR_MESSAGES — no moon subprocess involved — so
// these run against a stub ExtensionAPI with the real extension loaded.

import { describe, expect, test, beforeAll } from "bun:test";
import moonbitExtension from "../extensions/moonbit.ts";
import { FAILURE_FLAG } from "../extensions/shared.ts";

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

async function execute(params: Record<string, unknown>) {
  const tool = tools.get("moon_explain_error");
  if (!tool) throw new Error("tool moon_explain_error not registered");
  return await tool.execute("test-call-id", params, undefined, undefined, {});
}

beforeAll(async () => {
  await moonbitExtension(makeStubPi() as any);
});

describe("moon_explain_error tool", () => {
  test("is registered by the extension", () => {
    expect(tools.has("moon_explain_error")).toBe(true);
  });

  test("returns the explanation for a known code", async () => {
    const res = await execute({ error_code: 1 });
    expect(res.content[0].text).toStartWith("# E0001")
    expect(res.details).toEqual({ ok: true, error_code: 1 });
    expect(res.details[FAILURE_FLAG]).toBeUndefined();
  });

  test("flags an unknown code as a failure with a helpful message", async () => {
    const res = await execute({ error_code: 999999 });
    expect(res.details[FAILURE_FLAG]).toBe(true);
    expect(res.details.ok).toBe(false);
    expect(res.details.error_code).toBe(999999);
    expect(res.content[0].text).toContain("999999");
    expect(res.content[0].text).toContain("not found");
  });
});
