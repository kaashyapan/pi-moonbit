// Tests for the extension's registration surface and the `before_agent_start`
// prompt injection.
//
// The extension is compiled to JavaScript by `moon build`, and the compiled
// module exposes only `default_main` — the extension factory. So these tests
// load the built bundle, install it into a stub ExtensionAPI, and drive what
// it registers through the same public surface pi uses.
//
// This mirrors ../tests/registration.test.ts. The one difference follows from
// the MoonBit port itself: it loads the tooling guide from the directory
// holding the extension bundle rather than from the process cwd. The
// cwd-independence case below covers that.

import { describe, expect, test, beforeAll } from "bun:test";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import extensionDefault from "../extensions/index.js";

// The failure marker the tools set on results that should be presented as
// errors. Mirrors FAILURE_FLAG in the TypeScript shared.ts.
const FAILURE_FLAG = "flagsDiagnosticFailure";

const tools = new Map<string, any>();
const commands = new Map<string, any>();
const listeners = new Map<string, (event: any, ctx?: any) => any>();

// The guide is inlined in the compiled bundle rather than shipped as a data
// file, so the tests assert its content directly. The heading and the tool
// table are the parts the model relies on, so drift there is what matters.
const guideHeadings = [
  "## MoonBit tooling",
  "### Compiler driven development",
  "### Rules",
  "## Available bash commands",
];
const guideTools = [
  "moon_check",
  "moon_test",
  "moon_fmt_info",
  "moon_peek_def",
  "moon_find_references",
  "moon_type_info",
  "moon_outline",
  "moon_rename",
  "moon_analyze",
  "moon_doc",
  "moon_workspace_symbols",
  "moon_explain_error",
];

// A minimal stand-in for the harness ExtensionAPI. `exec` reports a reachable
// toolchain so the `moon_*` tools register without depending on the test
// machine having `moon` on PATH; everything else just captures registrations.
function makeStubPi() {
  return {
    registerTool: (tool: any) => tools.set(tool.name, tool),
    registerCommand: (name: string, spec: any) => commands.set(name, spec),
    on: (event: string, handler: (event: any, ctx?: any) => any) =>
      listeners.set(event, handler),
    exec: async () => ({
      stdout: "moon 0.1.20260904 (test)\n",
      stderr: "",
      code: 0,
      killed: false,
    }),
  };
}

beforeAll(async () => {
  await (extensionDefault as any)(makeStubPi());
});

// Runs `body` with the process cwd set to a fresh temp directory, then restores
// the cwd and removes the directory.
function withTempCwd(body: (tmp: string) => void) {
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), "moonbit-guide-"));
  const prevCwd = process.cwd();
  process.chdir(tmp);
  try {
    body(tmp);
  } finally {
    process.chdir(prevCwd);
    fs.rmSync(tmp, { recursive: true, force: true });
  }
}

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
      "moon_workspace_symbols",
      "moon_check",
      "moon_test",
      "moon_fmt_info",
      "moon_explain_error",
    ];
    for (const name of expected) {
      expect(tools.has(name)).toBe(true);
      expect(tools.get(name).name).toBe(name);
    }
    expect(commands.has("moon-doctor")).toBe(true);
    // The hook that turns the tools' failure marker into `isError`.
    expect(listeners.has("tool_result")).toBe(true);
  });
});

describe("tool_result", () => {
  test("flags FAILURE_FLAG results as errors and strips the marker", () => {
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

    // Unrelated results, and results whose marker is not the boolean `true`,
    // pass through untouched. The guard is a strict comparison, so a truthy
    // non-boolean must not flag the result.
    expect(handler?.({ type: "tool_result", toolName: "moon_check", details: { ok: true } })).toBeUndefined();
    expect(
      handler?.({ type: "tool_result", toolName: "moon_check", details: { [FAILURE_FLAG]: false } }),
    ).toBeUndefined();
    expect(
      handler?.({ type: "tool_result", toolName: "moon_check", details: { [FAILURE_FLAG]: "true" } }),
    ).toBeUndefined();
    expect(handler?.({ type: "tool_result", toolName: "moon_check", details: undefined })).toBeUndefined();
  });

  test("turns a real failed tool result into an error end-to-end", async () => {
    // A tool sets the marker on failure; the hook is what makes the model see
    // it as an error. An invalid moon_mod_filepath fails validation before any
    // subprocess runs, so this needs no toolchain.
    const tool = tools.get("moon_check");
    const res = await tool.execute(
      "id",
      { moon_mod_filepath: "/nonexistent/moon.mod", target: "js" },
      undefined,
      undefined,
      {},
    );
    expect(res.details[FAILURE_FLAG]).toBe(true);

    const hookResult = listeners.get("tool_result")?.({
      type: "tool_result",
      toolName: "moon_check",
      toolCallId: "id",
      input: {},
      content: res.content,
      details: res.details,
      isError: false,
    });
    expect(hookResult?.isError).toBe(true);
    expect(hookResult?.details?.[FAILURE_FLAG]).toBeUndefined();
  });
});

describe("before_agent_start", () => {
  test("injects the inlined MoonBit tooling guide", async () => {
    const handler = listeners.get("before_agent_start");
    expect(handler).toBeDefined();

    const result = await handler?.({}, {});
    expect(result?.message?.customType).toBe("pi-moonbit-guide");
    expect(result?.message?.display).toBe(true);

    // The guide is a string literal in the bundle, so assert its shape: the
    // section headings and every tool it names. A truncated or reordered table
    // fails here rather than silently reaching the model.
    const content = result?.message?.content;
    expect(typeof content).toBe("string");
    for (const heading of guideHeadings) {
      expect(content).toContain(heading);
    }
    for (const tool of guideTools) {
      expect(content).toContain(tool);
    }
  });

  test("appends the enforcement rules to the system prompt", async () => {
    const handler = listeners.get("before_agent_start");
    expect(handler).toBeDefined();

    // The rules are appended so the harness keeps its own prompt (and the
    // project instructions pi loaded) and the rules are merely added.
    const base = "You are an expert coding assistant.";
    const result = await handler?.({ type: "before_agent_start", systemPrompt: base }, {});
    expect(typeof result?.systemPrompt).toBe("string");
    expect(result.systemPrompt.startsWith(base)).toBe(true);
    expect(result.systemPrompt).toContain("## MoonBit tooling (enforced)");
    // Spot-check the tool names, so the rules cannot silently lose a rule.
    for (const tool of ["moon_peek_def", "moon_find_references", "moon_type_info", "moon_outline"]) {
      expect(result.systemPrompt).toContain(tool);
    }
  });

  test("does not append the rules twice", async () => {
    const handler = listeners.get("before_agent_start");

    // The rules name their own section heading, so appending is idempotent: an
    // event whose system prompt already carries them (for example because
    // AGENTS.md was loaded into the project context) gets no second copy.
    const once = await handler?.({ type: "before_agent_start", systemPrompt: "base" }, {});
    const twice = await handler?.({
      type: "before_agent_start",
      systemPrompt: once.systemPrompt,
    });
    expect(twice?.systemPrompt).toBeUndefined();
  });

  test("leaves the system prompt alone when the event has none", async () => {
    const handler = listeners.get("before_agent_start");

    // Returning a system prompt here would replace the harness prompt with the
    // rules alone, dropping the project instructions. So nothing is returned.
    const result = handler?.({ type: "before_agent_start", prompt: "hi" }, {});
    expect(result?.systemPrompt).toBeUndefined();
    expect(result?.message?.customType).toBe("pi-moonbit-guide");
  });

  test("ignores files on disk, including AGENTS.md in the cwd", async () => {
    const handler = listeners.get("before_agent_start");
    expect(handler).toBeDefined();

    // The guide is inlined, so a decoy AGENTS.md in the process cwd must not
    // influence the result. This is what separates the port from the
    // TypeScript extension, which reads ./AGENTS.md at event time.
    const sentinel = "# MoonBit tooling guide (test sentinel)\nUse moon_check liberally.";
    let content = "";
    await withTempCwd(async (tmp) => {
      fs.writeFileSync(path.join(tmp, "AGENTS.md"), sentinel);
      const result = await handler?.({}, { cwd: tmp });
      content = result?.message?.content;
    });

    expect(content).not.toBe(sentinel);
    expect(content).toContain("## MoonBit tooling");
  });
});
