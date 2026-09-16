// Pi extension entry point: wraps `moon ide <command>` and `moon
// check/test/fmt/info` as discrete tools so the model gets compiler-aware
// navigation instead of falling back to grep/zip on MoonBit source. Place
// this file in `.pi/extensions/moon-ide.ts` (project-local) or
// `~/.pi/agent/extensions/moon-ide.ts` (global).
//
// Design notes:
// - One tool per CLI intent (peek-def, find-references, hover, outline,
//   rename, analyze, doc, check, test, fmt-info) rather than one tool with
//   a `command` enum. Each intent has a different useful parameter shape
//   and separate tools give the model clearer selection signal and let
//   each `description` teach the model when to reach for it.
// - `rename` defaults to a dry run (no --apply). The model must explicitly
//   set apply: true to rewrite files, and we still show the computed edits
//   either way so it's an informed decision, not a blind flag flip.
// - Output is truncated defensively; `moon ide` results are generally small,
//   but doc/workspace-symbols searches on broad queries can be large.
// - The `moon` binary is checked (`moon version`) once at extension load.
//   All `moon_*` tools below are registered ONLY if that check succeeds —
//   an LLM given a `moon_peek_def` tool that always fails with "command not
//   found" is worse than not having the tool at all, since it'll keep
//   retrying or misdiagnose the failure as a code problem. The always-
//   registered `moon-doctor` command lets a human re-check reachability
//   (e.g. after fixing PATH) without needing to know that's what's wrong.
// - All tool execute handlers receive the full Pi signature and pass
//   `ctx.cwd` into subprocesses so they run in the session's working
//   directory (critical for multi-root / non-module contexts).
// - AbortSignal is honoured: if the model/user cancels a tool call, the
//   underlying `moon` process is killed via the signal option on execFile.
//
// Module layout:
//   moonbit.ts        — this entry: toolchain gate, moon-doctor, registration
//   shared.ts         — output shaping (truncate/toContent) + `moon ide` runner
//   bash-redirect.ts  — bash → moon_* tool redirection table
//   diagnostics.ts    — `moon check` NDJSON parsing + ownership partitioning
//   ide-tools.ts      — peek-def / find-references / hover / outline /
//                       rename / analyze / doc
//   check-tool.ts     — moon_check (with dependency filtering)
//   test-tools.ts     — moon_test / moon_fmt_info
//   doctor.ts         — `moon version` reachability probe
//   moonexec.ts       — generic `moon` subprocess runner

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";
import { checkMoonAvailable } from "./doctor";
import { findBashRedirect, redirectMessage } from "./bash-redirect";
import { FAILURE_FLAG } from "./shared";
import { registerCheckTool } from "./check-tool";
import { registerIdeTools } from "./ide-tools";
import { registerTestTools } from "./test-tools";
import { registerErrorTools } from "./error-tool";

export default async function (pi: ExtensionAPI) {
  // Translate the tools' FAILURE_FLAG markers into isError on the outgoing
  // tool-result message. execute() return values have no isError field in
  // the current pi runtime (AgentToolResult lacks it) — this hook is the
  // supported seam for flagging failures while keeping the summarized
  // content. Registered unconditionally: before the tools exist it matches
  // nothing, and after /reload brings them online it's already in place.
  pi.on("tool_result", (event) => {
    const details = event.details as Record<string, unknown> | undefined;
    if (!details || details[FAILURE_FLAG] !== true) return;
    return {
      details: { ...details, [FAILURE_FLAG]: undefined },
      isError: true,
    };
  });

  const startupCheck = await checkMoonAvailable();

  pi.on("before_agent_start", async (event, ctx) => {
    const moonToolingGuide = `
## MoonBit tooling

This project has dedicated tools for most common operation.
SHOULD use these tools for working with moonbit files.
SHOULD AVOID 'bash'.

| Call this tool         | Tool function / Why run this              | When                                     |
| ---------------------- | ----------------------------------------- | ---------------------------------------- |
| 'moon_check'           | Static analysis for MoonBit source        | After every source edit, before          |
|                        | — type and syntax                         | Before 'moon_test'.                      |
| 'moon_test'            | Run MoonBit tests for the current         | After moon_check is clean.               |
|                        | module or a scoped package                |                                          |
| 'moon_fmt_info'        | Formats source in place, generates        | Before handing off a change              |
|                        | public interface (.mbti) files.           |                                          |
| 'moon_peek_def'        | Resolve a MoonBit symbol’s definition     | To resolve a symbol’s definition         |
|                        | with source.                              |                                          |
|                        | Dont run grep, sed and bash for this.     |                                          |
| 'moon_find_references' | Find all usages of a MoonBit symbol       | When you need every call                 |
|                        | across dependents. Dont run grep,         | site of a symbol.                        |
|                        | sed and bash for this.                    |                                          |
| 'moon_type_info'       | Type inference and documentation for      | When you need type info of a semantic    |
|                        | token at given location. Do not           | token                                    |
|                        | guess from source code.                   |                                          |
| 'moon_outline'         | Summarize the structure (types,           | When you want a summary of types and     |
|                        | functions, etc.) of a MoonBit file or     | functions in a package or file           |
|                        | package. Do not grep or read a file       |                                          |
| 'moon_rename'          | Compute semantic rename edits for a       | When you need sed and bash to rename     |
|                        | MoonBit symbol across the workspace       | variables. This understands scope and    |
|                        | Use this instead of reading full file     | shadowing                                |
|                        | and edit and string replace               |                                          |
| 'moon_analyze'         | Report public API usage counts for        | When you need the call sites to          |
|                        | a package. Used this instead of           | estimate usage                           |
|                        | 'grep', 'sed', 'bash'                     |                                          |
| 'moon_doc'             | Search exported APIs and documentation    | Call this before using an API you're     |
|                        | across the workspace and its dependencies | not certain of the current signature.    |
|                        |                                           | or usage. When you need the description  |
|                        |                                           | of a package. e.g '@json'                |
| 'moon_explain_error'   | Explains a compiler error code            | Need detailed information about an error |
|                        |                                           | code.                                    |

### Standard workflow

1. Edit source files '.mbt'.
2. 'moon_check' — fix any errors before moving on.
3. 'moon_test' — fix any errors before moving on.
4. 'moon_fmt_info'.

### Rules, not suggestions

- Never use 'grep'/'cat'/'sed' on '.mbt' files to find a definition, find references, infer a
  type, or perform a rename — the tools above are compiler-resolved and will be more accurate.
- If a 'moon_check' error code's message alone isn't enough to know the fix, call
  'moon_explain_error' with that code before guessing.
- moon_peek_def / moon_find_references / moon_type_info / moon_outline / moon_rename /
  moon_analyze / moon_doc SHOULD be used for navigation; don't grep or sed .mbt files for these.
- If '/moon-doctor' reports the toolchain isn't reachable, say so — don't try to work around it
  by shelling out to 'moon' directly.
`.trim();

    return {
      message: {
        customType: "pi-moonbit-guide",
        content: moonToolingGuide,
        display: true,
      },
    };
  });
  // Always registered, regardless of toolchain state, so a human can
  // diagnose *why* the moon_* tools are missing (or confirm they're live)
  // without needing to know in advance that this extension gates on PATH.
  pi.registerCommand("moon-doctor", {
    description:
      "MoonBit doctor: Check whether the MoonBit toolchain (`moon`) is reachable on PATH and whether moon-ide/moon-check tools are active",
    handler: async (_args, ctx) => {
      const result = await checkMoonAvailable(ctx.cwd);
      if (result.available) {
        const toolsLive = startupCheck.available;
        ctx.ui.notify(
          `moon is reachable — ${result.version}. ` +
          (toolsLive
            ? "MoonBit tools (moon_peek_def, moon_check, moon_test, etc.) are active."
            : "MoonBit tools were NOT registered at startup (moon wasn't reachable then). Run /reload to pick them up now."),
          "info",
        );
      } else {
        ctx.ui.notify(
          `moon is not reachable: ${result.error}. Install the MoonBit toolchain or fix PATH, then run /moon-doctor again (or /reload) once fixed. MoonBit tools are not registered.`,
          "error",
        );
      }
    },
  });

  if (!startupCheck.available) {
    // Do not register any moon_* tools when the toolchain isn't functional —
    // an always-failing tool is worse than no tool. Use /moon-doctor to
    // re-check after fixing PATH, then /reload to register them.
    return;
  }

  registerMoonTools(pi);
}

// Registers the moon_* tool suite plus the bash→tool redirect hook. Exported
// (rather than inlined in the default export) so tests can install the real
// tools into a stub ExtensionAPI and execute their handlers directly.
export function registerMoonTools(pi: ExtensionAPI) {
  // Hard-block bash calls that duplicate a registered moon_* tool. Fires
  // before the bash tool executes; returning { block: true, reason } stops
  // it and surfaces `reason` to the model in place of a result, so it
  // self-corrects to the named tool on the next turn instead of getting a
  // normal (successful) bash result that reinforces the bash habit.
  pi.on("tool_call", (event) => {
    if (isToolCallEventType("bash", event)) {
      const redirect = findBashRedirect(event.input.command ?? "");
      if (!redirect) return;
      return {
        block: true,
        reason: redirectMessage("bash", redirect),
      };
    }
    // Windows: the model can route moon subcommands through powershell to
    // bypass the bash redirect. Same block, same reason.
    if (isToolCallEventType("powershell", event)) {
      const redirect = findBashRedirect(event.input.command ?? "");
      if (!redirect) return;
      return {
        block: true,
        reason: redirectMessage("powershell", redirect),
      };
    }
  });

  registerIdeTools(pi);
  registerCheckTool(pi);
  registerTestTools(pi);
  registerErrorTools(pi);
}
