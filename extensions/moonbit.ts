// Pi extension: wraps `moon ide <command>` as discrete tools so the model
// gets compiler-aware navigation instead of falling back to grep/zip on
// MoonBit source. Place this file in `.pi/extensions/moon-ide.ts` (project-
// local) or `~/.pi/agent/extensions/moon-ide.ts` (global).
//
// Design notes:
// - One tool per CLI intent (peek-def, find-references, hover, outline,
//   rename, analyze, doc, workspace-symbols, check, test, fmt-info) rather
//   than one tool with a `command` enum. Each intent has a different useful
//   parameter shape and separate tools give the model clearer selection
//   signal and let each `description` teach the model when to reach for it.
// - Every tool always passes --json (where applicable) and parses it. If
//   parsing fails we still return the raw stdout/stderr rather than throwing,
//   so the model can see what actually happened (e.g. "not inside a MoonBit
//   module").
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

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execFile } from "node:child_process";
import { Type } from "typebox";
import { checkMoonAvailable } from "./doctor";
import { runMoon } from "./moonexec";

const MAX_OUTPUT_CHARS = 20_000;
const TIMEOUT_MS = 30_000;
const TEST_TIMEOUT_MS = 120_000;


interface MoonIdeResult {
  ok: boolean;
  json: unknown | null;
  raw: string;
  stderr: string;
  aborted?: boolean;
}

function runMoonIde(
  args: string[],
  cwd?: string,
  signal?: AbortSignal,
): Promise<MoonIdeResult> {
  return runMoon(["ide", ...args], { cwd, signal, timeout: TIMEOUT_MS }).then((r) => {
    if (r.aborted) {
      return { ok: false, json: null, raw: "", stderr: "", aborted: true };
    }
    let json: unknown | null = null;
    try {
      json = r.stdout.trim() ? JSON.parse(r.stdout) : null;
    } catch {
      json = null;
    }
    return {
      ok: r.ok && !r.spawnFailed,
      json,
      raw: r.stdout,
      stderr: r.stderr,
      aborted: false,
    };
  });
}

// --- moon check ---------------------------------------------------------
// Separate path: --output-json is NDJSON; non-zero exit is expected when
// there are diagnostics.

interface CheckDiagnostic {
  level?: string;
  error_code?: number;
  path?: string;
  loc?: string;
  message?: string;
  context?: string;
}

function runMoonCheck(
  args: string[],
  cwd?: string,
  signal?: AbortSignal,
): Promise<{
  spawnFailed: boolean;
  aborted: boolean;
  stdout: string;
  stderr: string;
  spawnMessage?: string;
}> {
  return runMoon(["check", "--output-json", ...args], { cwd, signal }).then((r) => ({
    spawnFailed: r.spawnFailed,
    aborted: r.aborted,
    stdout: r.stdout,
    stderr: r.stderr,
    spawnMessage: r.spawnMessage,
  }));
}

function parseCheckOutput(stdout: string): { diagnostics: CheckDiagnostic[]; unparsedLines: string[] } {
  const diagnostics: CheckDiagnostic[] = [];
  const unparsedLines: string[] = [];
  for (const line of stdout.split("\n")) {
    const trimmed = line.trim();
    if (!trimmed) continue;
    try {
      const obj = JSON.parse(trimmed);
      if (obj && obj.$message_type === "diagnostic") {
        diagnostics.push(obj as CheckDiagnostic);
      } else {
        unparsedLines.push(trimmed);
      }
    } catch {
      unparsedLines.push(trimmed);
    }
  }
  return { diagnostics, unparsedLines };
}

function truncate(s: string): string {
  if (s.length <= MAX_OUTPUT_CHARS) return s;
  return (
    s.slice(0, MAX_OUTPUT_CHARS) +
    `\n... [truncated ${s.length - MAX_OUTPUT_CHARS} chars]`
  );
}

function abortedContent() {
  return {
    content: [{ type: "text" as const, text: "Cancelled." }],
    details: { ok: false, aborted: true },
    isError: true,
  };
}

function toContent(result: MoonIdeResult) {
  if (result.aborted) return abortedContent();
  const body = result.json
    ? JSON.stringify(result.json, null, 2)
    : result.raw || "(no stdout)";
  const text = result.ok
    ? truncate(body)
    : truncate(`moon ide failed.\nstdout: ${body}\nstderr: ${result.stderr}`);
  return {
    content: [{ type: "text" as const, text }],
    details: { ok: result.ok, stderr: result.stderr },
    isError: !result.ok,
  };
}

// --loc accepts path[:line[:col]]; keep it a single free-form string so
// callers can pass whichever precision they have (file only, file:line,
// or file:line:col) without us guessing.
const LocParam = Type.Optional(
  Type.String({
    description:
      "Source location as path[:line[:col]], 1-based, e.g. './main.mbt:8:7'. Required for hover; optional elsewhere as a disambiguation hint when the symbol name alone is ambiguous.",
  }),
);

export default async function (pi: ExtensionAPI) {
  const startupCheck = await checkMoonAvailable();

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

  pi.registerTool({
    name: "moon_peek_def",
    label: "MoonBit: Peek Definition",
    description:
      "MoonBit: Peek Definition - Resolve a MoonBit symbol's definition and show source context. Prefer this over grepping .mbt files for a declaration. Provide either `symbol` (e.g. 'Array::length', '@pkg.foo') or `loc`, or both to disambiguate.",
    parameters: Type.Object({
      symbol: Type.Optional(
        Type.String({
          description: "Symbol query, e.g. 'foo', '@pkg.foo', 'Type::member'.",
        }),
      ),
      loc: LocParam,
    }),
    promptGuidelines: ["Returns json response."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["peek-def", "--json"];
      if (params.symbol) args.splice(1, 0, params.symbol);
      if (params.loc) args.push("--loc", params.loc);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_find_references",
    label: "MoonBit: Find References",
    description:
      "MoonBit: Find References - Find all usages of a MoonBit symbol across dependents. Prefer this over grepping for a name — it's compiler-resolved, so it correctly follows type-directed dispatch that text search can't. Provide `symbol`. Note: current moon ide find-references does not yet support -loc.",
    parameters: Type.Object({
      symbol: Type.Optional(
        Type.String({ description: "Symbol query, e.g. 'println', '@pkg.foo'." }),
      ),
      loc: LocParam,
    }),
    promptGuidelines: ["Returns json response."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["find-references", "--json"];
      if (params.symbol) args.splice(1, 0, params.symbol);
      if (params.loc) args.push("--loc", params.loc);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_hover",
    label: "MoonBit: Hover Info",
    description:
      "MoonBit: Hover Info - Show the type and docs for whatever is at a source position. Requires `loc` with a line number.",
    parameters: Type.Object({
      loc: Type.String({
        description: "Source location, path:line[:col], 1-based. Line is required.",
      }),
      symbol: Type.Optional(
        Type.String({ description: "Optional symbol name to disambiguate at that position." }),
      ),
    }),
    promptGuidelines: ["Returns json response."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["hover", "--json", "--loc", params.loc];
      if (params.symbol) args.splice(1, 0, params.symbol);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_outline",
    label: "MoonBit: Outline",
    description:
      "MoonBit: Outline - Summarize the structure (types, functions, etc.) of a MoonBit file or package. Use this to orient in a file instead of reading it whole or grepping for declarations. Pass a file or directory path; omit to outline the current package.",
    parameters: Type.Object({
      path: Type.Optional(
        Type.String({
          description:
            "File or package/directory path (positional argument to `moon ide outline`). e.g. '.', './src/lib.mbt'. Omit to outline the current package.",
        }),
      ),
    }),
    promptGuidelines: ["Returns json response."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["outline", "--json"];
      if (params.path) args.push(params.path);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_rename",
    label: "MoonBit: Rename Symbol",
    description:
      "MoonBit: Rename Symbol - Compute semantic rename edits for a MoonBit symbol across the workspace. Defaults to a dry run (returns the edit set without writing). Set apply: true only after reviewing the dry-run output, since this rewrites files on disk.",
    parameters: Type.Object({
      old_name: Type.String({ description: "Current symbol name." }),
      new_name: Type.String({ description: "New symbol name." }),
      loc: Type.String({ description: "Location disambiguating which declaration to rename, path[:line]." }),
      apply: Type.Optional(
        Type.Boolean({ description: "If true, rewrite files. Defaults to false (dry run)." }),
      ),
    }),
    promptGuidelines: ["Returns json response."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["rename", params.old_name, params.new_name, "--loc", params.loc, "--json"];
      if (params.apply) args.push("--apply");
      const result = await runMoonIde(args, ctx?.cwd, signal);
      if (!params.apply && result.ok && !result.aborted) {
        result.raw =
          "[DRY RUN — no files written; call again with apply: true to rewrite]\n" + result.raw;
      }
      return toContent(result);
    },
  });

  pi.registerTool({
    name: "moon_analyze",
    label: "MoonBit: Analyze API Usage",
    description: "MoonBit: Analyze API Usage - Report public API usage counts for a symbol or the package.",
    parameters: Type.Object({
      symbol: Type.Optional(Type.String({ description: "Symbol query to scope the analysis." })),
    }),
    promptGuidelines: ["Returns json response."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["analyze", "--json"];
      if (params.symbol) args.splice(1, 0, params.symbol);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_doc",
    label: "MoonBit: Search Docs",
    description:
      "MoonBit: Search Docs - Search exported APIs and documentation across the workspace and its dependencies, e.g. `@json`. Prefer this over guessing API signatures from memory.",
    parameters: Type.Object({
      query: Type.String({ description: "Doc/API search query, e.g. '@json' or a function name." }),
    }),
    promptGuidelines: ["Returns json response."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      return toContent(await runMoonIde(["doc", params.query, "--json"], ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_check",
    label: "MoonBit: Check (static analysis)",
    description:
      "MoonBit: Check (static analysis) - Run moon_check to verify syntax and type correctness without building object files. Always run this after editing MoonBit source and before moon_test — it's much cheaper than a full build and catches errors early. Returns diagnostics grouped by level (error/warning) with counts, not raw NDJSON.",
    parameters: Type.Object({
      package: Type.Optional(
        Type.String({ description: "Limit the check to a specific package, passed as -p <package>." }),
      ),
    }),
    promptGuidelines: [`Follow this sequence`,
      "1. Edit source",
      "2. `moon_check --diagnostic - limit 1` (Check if there are errors)",
      "3. `moon_check` (cheap, catch type/syntax errors)",
      "4. `moon_test` (after check is clean)",
      "5. `moon_fmt_info` before handoff`",
      "The tool returns a json response."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = params.package ? ["-p", params.package] : [];
      const result = await runMoonCheck(args, ctx?.cwd, signal);

      if (result.aborted) return abortedContent();

      if (result.spawnFailed) {
        return {
          content: [
            {
              type: "text" as const,
              text: `Failed to run moon check: ${result.spawnMessage}\nstderr: ${result.stderr}`,
            },
          ],
          details: { ok: false },
          isError: true,
        };
      }

      const { diagnostics, unparsedLines } = parseCheckOutput(result.stdout);
      const errors = diagnostics.filter((d) => d.level === "error");
      const warnings = diagnostics.filter((d) => d.level === "warning");
      const other = diagnostics.filter((d) => d.level !== "error" && d.level !== "warning");

      const lines: string[] = [];
      if (diagnostics.length === 0 && unparsedLines.length === 0) {
        lines.push("No errors or warnings.");
      } else {
        lines.push(
          `${errors.length} error(s), ${warnings.length} warning(s)${other.length ? `, ${other.length} other` : ""
          }.`,
        );
        for (const d of [...errors, ...warnings, ...other]) {
          lines.push(
            `\n[${d.level ?? "?"}${d.error_code !== undefined ? ` ${d.error_code}` : ""}] ${d.path ?? "?"
            }${d.loc ? `:${d.loc}` : ""}\n${d.message ?? ""}${d.context ? `\n${d.context}` : ""}`,
          );
        }
      }
      if (unparsedLines.length) {
        lines.push(`\n[${unparsedLines.length} unparsed line(s) from moon check]`);
        lines.push(...unparsedLines.slice(0, 20));
      }
      if (result.stderr.trim()) {
        lines.push(`\nstderr: ${result.stderr.trim()}`);
      }

      return {
        content: [{ type: "text" as const, text: truncate(lines.join("\n")) }],
        details: {
          ok: true,
          errorCount: errors.length,
          warningCount: warnings.length,
          hasErrors: errors.length > 0,
        },
        isError: errors.length > 0,
      };
    },
  });

  // --- moon test ----------------------------------------------------------
  // Non-zero exit is normal (failed tests). Only spawn failure is isError
  // for execution; failed tests are still flagged via isError so the model
  // treats them as "fix this".

  pi.registerTool({
    name: "moon_test",
    label: "MoonBit: Test",
    description:
      "MoonBit: Test - Run `moon test` for the current module or a scoped package. Prefer moon_check first (cheaper).",
    parameters: Type.Object({
      package: Type.Optional(
        Type.String({ description: "Limit to a package (-p <package>)." }),
      ),
      target: Type.Optional(
        Type.String({
          description:
            "Backend target, e.g. 'wasm', 'js', 'native', 'llvm'. Passed as --target. Prefer wasm if the supported_target in moon.pkg allows.",
        }),
      ),
      update: Type.Optional(
        Type.Boolean({
          description:
            "If true, pass --update to refresh snapshot tests. Defaults to false — only set when intentionally updating snapshots.",
        }),
      ),
    }),
    promptGuidelines: [`Test should only be run for one target`,
      "Test should only be run against package in which files have been edited",
    ],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["test"];
      if (params.package) args.push("-p", params.package);
      if (params.target) args.push("--target", params.target);
      if (params.update) args.push("--update");

      const result = await runMoon(args, {
        cwd: ctx?.cwd,
        signal,
        timeout: TEST_TIMEOUT_MS,
      });

      if (result.aborted) return abortedContent();

      if (result.spawnFailed) {
        return {
          content: [
            {
              type: "text" as const,
              text: `Failed to run moon test: ${result.spawnMessage}\nstderr: ${result.stderr}`,
            },
          ],
          details: { ok: false },
          isError: true,
        };
      }

      const body = [
        result.ok ? "Tests passed." : `Tests failed (exit ${result.exitCode ?? "?"}).`,
        result.stdout.trim() ? `\n${result.stdout.trim()}` : "",
        result.stderr.trim() ? `\nstderr:\n${result.stderr.trim()}` : "",
      ]
        .filter(Boolean)
        .join("");

      return {
        content: [{ type: "text" as const, text: truncate(body) }],
        details: {
          ok: result.ok,
          exitCode: result.exitCode,
        },
        isError: !result.ok,
      };
    },
  });

  // --- moon fmt && moon info (handoff sequence) --------------------------
  // Agent guide: run fmt and info before handoff. Combined into one tool so
  // the model does the standard cleanup in a single call. fmt rewrites
  // source; info regenerates .mbti interface files (review their diff).

  pi.registerTool({
    name: "moon_fmt_info",
    label: "MoonBit: Format + Info",
    description:
      "MoonBit: Format - Formats source in place, then regenerates public interface (.mbti) files. Run this after edits are done and moon_check is clean, not mid-edit.",
    parameters: Type.Object({
      package: Type.Optional(
        Type.String({
          description: "Optional package scope for moon info (-p <package>). fmt always runs module-wide.",
        }),
      )
    }),
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const sections: string[] = [];

      // 1) moon fmt
      const fmt = await runMoon(["fmt"], { cwd: ctx?.cwd, signal });
      if (fmt.aborted) return abortedContent();
      if (fmt.spawnFailed) {
        return {
          content: [
            {
              type: "text" as const,
              text: `Failed to run moon fmt: ${fmt.spawnMessage}\nstderr: ${fmt.stderr}`,
            },
          ],
          details: { ok: false, step: "fmt" },
          isError: true,
        };
      }
      sections.push(
        `## moon fmt (exit ${fmt.exitCode ?? 0})`,
        fmt.stdout.trim() || "(no stdout)",
        fmt.stderr.trim() ? `stderr:\n${fmt.stderr.trim()}` : "",
      );

      if (!fmt.ok) {
        return {
          content: [
            {
              type: "text" as const,
              text: truncate(
                sections.filter(Boolean).join("\n") +
                "\n\nmoon fmt failed; skipping moon info.",
              ),
            },
          ],
          details: { ok: false, step: "fmt", exitCode: fmt.exitCode },
          isError: true,
        };
      }

      // 2) moon info
      const infoArgs = ["info"];
      if (params.package) infoArgs.push("-p", params.package);

      const info = await runMoon(infoArgs, { cwd: ctx?.cwd, signal });
      if (info.aborted) return abortedContent();
      if (info.spawnFailed) {
        return {
          content: [
            {
              type: "text" as const,
              text: truncate(
                sections.filter(Boolean).join("\n") +
                `\n\n## moon info\nFailed to run: ${info.spawnMessage}\nstderr: ${info.stderr}`,
              ),
            },
          ],
          details: { ok: false, step: "info" },
          isError: true,
        };
      }
      sections.push(
        `## moon info (exit ${info.exitCode ?? 0})`,
        info.stdout.trim() || "(no stdout)",
        info.stderr.trim() ? `stderr:\n${info.stderr.trim()}` : "",
      );

      const ok = info.ok;
      return {
        content: [
          {
            type: "text" as const,
            text: truncate(sections.filter(Boolean).join("\n")),
          },
        ],
        details: {
          ok,
          fmtExit: fmt.exitCode,
          infoExit: info.exitCode,
        },
        isError: !ok,
      };
    },
  });
}
