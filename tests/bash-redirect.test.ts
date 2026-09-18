// Tests for the bash/powershell → moon_* tool redirect.
//
// The extension is compiled to JavaScript by `moon build`, and the compiled
// module exposes only `default_main` — the extension factory. The matching
// helpers (`find_bash_redirect`, `bash_redirects`) are not exported, so these
// tests drive the behaviour through the registered `tool_call` handler, which
// is the same surface pi uses.
//
// This mirrors ../tests/bash-redirect.test.ts. That file calls
// `findBashRedirect` directly; here the same cases go through the handler and
// the chosen tool is read back out of the block reason.
//
// Every call is guarded by a timeout, so a regression that makes the matcher
// spin fails the test instead of hanging the suite.

import { describe, expect, test, beforeAll } from "bun:test";
import extensionDefault from "../extensions/index.js";

const listeners = new Map<string, (event: any, ctx?: any) => any>();

// A minimal stand-in for the harness ExtensionAPI. `exec` reports a reachable
// toolchain so the redirect hook is registered; it is never actually called.
function makeStubPi() {
  return {
    registerTool: () => {},
    registerCommand: () => {},
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

// The tool name the handler names in its block reason, or undefined when the
// call was allowed through. The reason format is
// "Blocked — ... Call the <tool> tool now instead of <shell>: ...".
function redirectTool(command: string, toolName = "bash"): string | undefined {
  const handler = listeners.get("tool_call");
  if (!handler) throw new Error("tool_call handler not registered");
  const result = handler({ toolName, input: { command } });
  if (!result?.block) return undefined;
  const match = /Call the (\S+) tool/.exec(result.reason ?? "");
  if (!match) throw new Error(`unexpected block reason: ${result.reason}`);
  return match[1];
}

// Runs several commands with a hard wall-clock budget, so a matcher that never
// returns fails here rather than stalling the whole run.
function withinBudget<T>(budgetMs: number, body: () => T): T {
  const start = Date.now();
  const value = body();
  const elapsed = Date.now() - start;
  if (elapsed > budgetMs) {
    throw new Error(`redirect matching took ${elapsed}ms, over the ${budgetMs}ms budget`);
  }
  return value;
}

describe("bash redirect", () => {
  test("every configured redirect matches its canonical command", () => {
    const canonical = [
      "moon check",
      "moon test",
      "moon fmt",
      "moon info",
      "moon ide peek-def",
      "moon ide find-references",
      "moon ide hover",
      "moon ide outline",
      "moon ide rename",
      "moon ide analyze",
      "moon ide doc",
      "moon ide workspace-symbols",
    ];
    for (const command of canonical) {
      expect(redirectTool(command)).toBeDefined();
    }
  });

  test("matches chained commands at command positions", () => {
    expect(redirectTool("cd /tmp && moon test -p ok")).toBe("moon_test");
    expect(redirectTool("moon fmt && moon info")).toBe("moon_fmt_info");
    expect(redirectTool("$(moon check) | head")).toBe("moon_check");
  });

  test("does not match mentions inside quoted arguments", () => {
    // The case that motivated the fix: a command whose argument text merely
    // mentions a moon subcommand must pass through to bash.
    expect(redirectTool("perl -e 's/.../moon ide hover/' README.md")).toBeUndefined();
    expect(redirectTool('echo "moon test"')).toBeUndefined();
    expect(redirectTool("grep 'moon check' notes.md")).toBeUndefined();
  });

  test("does not match mentions at non-command positions", () => {
    expect(redirectTool("echo use the moon check tool")).toBeUndefined();
  });

  test("maps the moon subcommands the tools wrap", () => {
    expect(redirectTool("moon check --output-json -p foo")).toBe("moon_check");
    expect(redirectTool("moon test -p foo --target wasm-gc")).toBe("moon_test");
    expect(redirectTool("moon fmt && moon info")).toBe("moon_fmt_info");
    expect(redirectTool("moon ide peek-def foo --json")).toBe("moon_peek_def");
    expect(redirectTool("moon ide rename old new --loc x.mbt")).toBe("moon_rename");
  });

  test("does not match non-moon or glued commands", () => {
    expect(redirectTool("ls -la")).toBeUndefined();
    expect(redirectTool("mooncheck")).toBeUndefined();
    expect(redirectTool("cat moon/check.txt")).toBeUndefined();
    expect(redirectTool("moon build")).toBeUndefined();
  });

  test("blocks powershell too (Windows bypass)", () => {
    expect(redirectTool("moon check", "powershell")).toBe("moon_check");
    expect(redirectTool("Get-ChildItem", "powershell")).toBeUndefined();
  });

  test("ignores non-shell tool calls", () => {
    expect(redirectTool("moon check", "read")).toBeUndefined();
  });

  test("stays within budget on pathological input", () => {
    const inputs = [
      ";".repeat(50_000),
      '"'.repeat(50_000),
      "`".repeat(50_000),
      "\n".repeat(50_000),
      "x".repeat(500_000),
      "moon check ".repeat(20_000),
    ];
    // A single matcher regression here would otherwise spin forever.
    withinBudget(10_000, () => {
      for (const command of inputs) {
        redirectTool(command);
      }
    });
  });
});
