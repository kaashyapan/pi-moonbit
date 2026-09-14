---
name: pi-extensions
description: How to write, structure, and install TypeScript extensions for the Pi coding-agent harness (@earendil-works/pi-coding-agent) — custom tools, commands, shortcuts, and event hooks. Use this whenever the user wants to build a Pi extension, wrap a CLI or API as a Pi tool, add a slash command or keyboard shortcut to Pi, intercept/guard tool calls (e.g. blocking dangerous bash commands), or asks "how do I extend Pi" / "can you bootstrap a Pi extension for X" — even if they just describe wanting Pi to do something new rather than naming "extension" explicitly.
---

# Writing Pi Extensions

Pi (`@earendil-works/pi-coding-agent`) is a minimal terminal coding-agent
harness: four built-in tools (read, write, edit, bash) plus a small system
prompt. Everything else — new tools, slash commands, shortcuts, event hooks,
custom TUI — is added via TypeScript extensions. This skill covers how to
write one well, not just how to make one run.

## When to reach for an extension vs. leaving something as bash

Don't default to building an extension just because a CLI exists. An
extension earns its cost when at least one of these is true:

- **Structured output matters.** A CLI already emits JSON/NDJSON that the
  model would otherwise have to re-parse from raw text on every call.
- **There's a wrong default to structurally prevent.** E.g. the CLI's own
  docs say "prefer semantic navigation over grep" but nothing stops the
  model from grepping anyway — a tool that *only* exposes the semantic path
  is a much stronger nudge than a sentence in a skill doc.
- **The operation is destructive or stateful** and benefits from an
  enforced dry-run/confirm step (rename, delete, deploy).
- **The underlying tool isn't request/response shaped** (a persistent LSP
  session, a long-running dev server with hot reload) — bash's spawn-and-
  wait model doesn't compose well with that regardless of wrapping.

Skip the extension (leave it as bash + a skill doc describing correct
invocation/sequencing) when the command is simple, stateless, and already
returns something a model can read directly — `git status`, `npm install`,
formatters, one-shot doctor/diagnostic commands.

## Anatomy of an extension

```ts
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";

export default function (pi: ExtensionAPI) {
  // register tools, commands, shortcuts, event hooks here
}
```

- The default export is a factory function receiving `ExtensionAPI`. It can
  be `async` — Pi awaits it before startup continues, which matters if you
  need one-time init (e.g. fetching a remote model list) before other
  registration calls.
- Extensions load via `jiti`, so plain TypeScript works with no build step.
- npm dependencies work: put a `package.json` next to the extension (or in
  a parent directory), `npm install`, and imports from `node_modules/`
  resolve automatically. Node built-ins (`node:fs`, `node:path`, etc.) are
  always available.
- For distributed Pi packages (installed via `pi install`), runtime deps
  must be in `dependencies`, not `devDependencies` — installs default to
  `npm install --omit=dev`.

### Install locations

- `.pi/extensions/` — project-local, not shared unless committed.
- `~/.pi/agent/extensions/` — global, applies to every project.
- Inside a Pi Package (npm or git) — shareable via `pi install`.

Restart Pi (or run `/restart`) after adding or editing an extension file.

## Registering a tool

```ts
pi.registerTool({
  name: "greet",
  label: "Greeting",
  description: "Generate a greeting",
  parameters: Type.Object({
    name: Type.String({ description: "Name to greet" }),
  }),
  async execute(toolCallId, params, signal, onUpdate, ctx) {
    return {
      content: [{ type: "text", text: `Hello, ${params.name}!` }],
      details: {},
    };
  },
});
```

Notes:

- Parameters use `typebox`'s `Type.*`. Use `Type.StringEnum` (not a plain
  string union) for enum-like string parameters — required for Google API
  compatibility.
- `execute` receives `(toolCallId, params, signal, onUpdate, ctx)`. `signal`
  is an `AbortSignal` for cancellation; `onUpdate` lets you stream partial
  progress; `ctx` gives you `ctx.ui` (see below).
- Return `{ content, details, isError? }`. `details` is arbitrary JSON kept
  alongside the result — useful for stateful tools (see the TODO-list
  pattern below), since it survives session branching.
- Set `isError: true` when the *result* represents a failure the model
  should treat as "fix this" (a compile error, a failed precondition) —
  distinct from the tool call itself throwing.
- `renderCall` / `renderResult` can customize how a tool call/result looks
  in the TUI; if omitted, a default `Box` rendering is used. Set
  `renderShell: "self"` if the tool needs to fully own its framing (e.g. a
  large preview that must stay visually stable).

### The SDK form: `defineTool`

For embedding Pi programmatically (not as a `.pi/extensions/` file), use
`defineTool` and pass tools directly to a session:

```ts
import { Type } from "typebox";
import { createAgentSession, defineTool } from "@earendil-works/pi-coding-agent";

const myTool = defineTool({
  name: "my_tool",
  label: "My Tool",
  description: "Does something useful",
  parameters: Type.Object({ input: Type.String({ description: "Input value" }) }),
  execute: async (_toolCallId, params) => ({
    content: [{ type: "text", text: `Result: ${params.input}` }],
    details: {},
  }),
});

const { session } = await createAgentSession({ customTools: [myTool] });
```

Same shape as `registerTool`; `defineTool` just gives you a standalone
tool object instead of registering it against a live `ExtensionAPI`.

## Design patterns worth following

These come from wrapping real CLIs as Pi tools (e.g. a MoonBit `moon ide` /
`moon check` wrapper) — lessons that generalize to any CLI-wrapping tool.

**One tool per intent, not one tool with a `command` enum.** If the
underlying CLI has several subcommands with genuinely different useful
parameters (a rename needs two names + an apply flag; a doc search just
needs a query string), give each its own `registerTool` call. This lets
each tool's `description` teach the model precisely when to reach for it,
and avoids the model constructing a `command` + free-form `args` string
that bypasses per-parameter validation.

**Always return something on failure — don't throw.** Wrap the underlying
process call so that a failure (non-zero exit, unparseable output) still
returns `{ content: [...], isError: true }` describing what happened,
rather than letting an exception surface as an opaque tool-call error. The
model can often recover from "here's the stderr" but not from nothing.

**Distinguish "the tool ran and reported a problem" from "the tool failed
to run."** A linter/checker exiting non-zero because it found errors is a
*normal result*, not a spawn failure — don't conflate the two. Only treat
actual spawn failures (binary missing from PATH, timeout) as an execution
error; surface expected-but-bad outcomes (compile errors, lint failures)
via `isError: true` on an otherwise successful tool call, with the
diagnostic detail in `content`.

**Gate destructive/stateful operations behind an explicit flag, default to
dry-run.** For rename/delete/apply-style operations, make the tool preview
the change by default and require an explicit `apply: true` (or similar)
parameter to actually mutate files — never default to "on." Label dry-run
output clearly so the model doesn't mistake a preview for a completed
action.

**Parse structured output defensively.** JSON and NDJSON (one JSON object
per line — common in compiler/linter `--output-json` flags) both show up
in the wild; check which one you're getting rather than assuming. Fall
back to raw text when a line/blob doesn't parse instead of dropping it.

**Truncate large output.** Compiler/search output on a broad query can be
large; cap it defensively (e.g. ~20k chars) with a clear "[truncated N
chars]" marker rather than flooding context.

**Use `details` for tool state that should survive session branching**,
not for anything the model needs to *see* — that belongs in `content`.

## Event hooks, commands, shortcuts

```ts
export default function (pi: ExtensionAPI) {
  // Intercept/guard tool calls
  pi.on("tool_call", async (event, ctx) => {
    if (event.toolName === "bash" && event.input.command?.includes("rm -rf")) {
      const ok = await ctx.ui.confirm("Dangerous!", "Allow rm -rf?");
      if (!ok) return { block: true, reason: "Blocked by user" };
    }
  });

  // Slash commands
  pi.registerCommand("hello", {
    description: "Say hello",
    handler: async (args, ctx) => {
      ctx.ui.notify("Hello!", "info");
    },
  });

  // Keyboard shortcuts
  pi.registerShortcut("ctrl+x", { /* ... */ });

  // Custom CLI flags
  pi.registerFlag("my-flag", { /* ... */ });
}
```

`ctx.ui` is available in both event handlers and tool `execute`:

- `ctx.ui.confirm(title, message)` — modal yes/no, returns a boolean.
- `ctx.ui.notify(message, level)` — transient notification.
- `ctx.ui.setStatus(key, text)` — footer status line.
- `ctx.ui.setWidget(key, lines)` — persistent widget above the editor.

`pi.on("tool_call", ...)` is the main guardrail mechanism — return
`{ block: true, reason }` to veto a call before it executes. Use this for
policy (blocking dangerous bash patterns, requiring confirmation for
specific tools) rather than trying to enforce policy from inside every
tool's own `execute`.

## Bootstrapping a new extension: checklist

1. Confirm it's worth an extension at all (see the decision guide above)
   rather than a skill doc + bash.
2. Identify the underlying CLI/API surface and how it reports success,
   failure, and structured output (JSON? NDJSON? plain text with an exit
   code?). This shapes the result-handling code more than anything else.
3. Decide tool granularity: one tool per subcommand/intent unless the
   surface is genuinely one operation.
4. Write `parameters` with real descriptions per field — these are what
   the model reads to decide how to call the tool, not just documentation.
5. Implement `execute` with defensive parsing, truncation, and the
   spawn-failure-vs-expected-failure distinction above.
6. For anything destructive, default to dry-run and require an explicit
   flag to apply.
7. Write a short README (or a comment block at the top of the extension
   file) explaining install location and *why* the tool boundaries were
   drawn the way they were — this is what a future reader needs to extend
   it correctly instead of re-deriving the same tradeoffs.
8. Place in `.pi/extensions/` to test locally before promoting to
   `~/.pi/agent/extensions/` or packaging for distribution.

## Reference material

- `docs/extensions.md` and `docs/sdk.md` in `earendil-works/pi` (repo:
  github.com/earendil-works/pi, path
  `packages/coding-agent/docs/`) — canonical API reference.
- `packages/coding-agent/examples/extensions/` in the same repo — worked
  examples including a permission-gate tool-call interceptor, a stateful
  TODO-list tool, and an SSH integration.
- These docs move; if something in this skill looks stale (a signature,
  an event name), fetch the current `docs/extensions.md` rather than
  trusting this file blindly.
