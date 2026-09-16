// Shared output-shaping helpers and the `moon ide` runner used by the ide
// tools. Everything here is presentation-level: run a subcommand, parse
// JSON when present, and shape a tool result with defensive truncation.

import { Type } from "typebox";
import { runMoon } from "./moonexec";

export const MAX_OUTPUT_CHARS = 20_000;
// `moon ide <subcommand>` runs a project check under the hood, so give it a
// generous-but-bounded timeout; the caller's AbortSignal still wins.
export const TIMEOUT_MS = 30_000;

export interface MoonIdeResult {
  ok: boolean;
  json: unknown | null;
  raw: string;
  stderr: string;
  aborted?: boolean;
}

function shapeMoonIdeResult(args: string[], r: Awaited<ReturnType<typeof runMoon>>): MoonIdeResult {
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
}

// Runs `moon ide <args>` and best-effort parses stdout as JSON. Subcommands
// that don't support --json return plain text — the json field is null then
// and toContent falls back to the raw text.

export async function runMoonIde(
  args: string[],
  cwd?: string,
  signal?: AbortSignal,
): Promise<MoonIdeResult> {
  return shapeMoonIdeResult(
    args,
    await runMoon(["ide", ...args], { cwd, signal, timeout: TIMEOUT_MS }),
  );
}

export function truncate(s: string): string {
  if (s.length <= MAX_OUTPUT_CHARS) return s;
  return (
    s.slice(0, MAX_OUTPUT_CHARS) +
    `\n... [truncated ${s.length - MAX_OUTPUT_CHARS} chars]`
  );
}

// Marker set on tool results whose outcome should be presented to the model
// as an error (failing tests, check errors, failed steps) without losing the
// summarized content. Translated into isError by the tool_result hook in
// moonbit.ts.
//
// Why not isError on the execute() return? The installed pi runtime's
// AgentToolResult has no isError field: returning a normal result is never
// presented as an error, and throwing would replace the summarized content
// with the raw exception text. The tool_result event is the supported seam
// for overriding the error flag on the outgoing tool-result message.
export const FAILURE_FLAG = "flagsDiagnosticFailure";

export function failureFlagged(details: Record<string, unknown>): Record<string, unknown> {
  return { ...details, [FAILURE_FLAG]: true };
}

export function abortedContent() {
  return {
    content: [{ type: "text" as const, text: "Cancelled." }],
    details: failureFlagged({ ok: false, aborted: true }),
  };
}

export function toContent(result: MoonIdeResult) {
  if (result.aborted) return abortedContent();
  const body = result.json
    ? JSON.stringify(result.json, null, 2)
    : result.raw || "(no stdout)";
  const failed = !result.ok;
  const text = failed
    ? truncate(`moon ide failed.\nstdout: ${body}\nstderr: ${result.stderr}`)
    : truncate(body);
  return {
    content: [{ type: "text" as const, text }],
    details: failed
      ? failureFlagged({ ok: result.ok, stderr: result.stderr })
      : { ok: result.ok, stderr: result.stderr },
  };
}

// --loc accepts path[:line[:col]]; keep it a single free-form string so
// callers can pass whichever precision they have (file only, file:line,
// or file:line:col) without us guessing.
export const LocParam = Type.Optional(
  Type.String({
    description:
      "Source location as path[:line[:col]], 1-based, e.g. './main.mbt:8:7'. Required for hover; optional elsewhere as a disambiguation hint when the symbol name alone is ambiguous.",
  }),
);
