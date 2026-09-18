// Shared output-shaping helpers and the `moon ide` runner used by the ide
// tools. Everything here is presentation-level: run a subcommand, parse
// JSON when present, and shape a tool result with defensive truncation.

import path from "node:path";
import { existsSync, statSync } from "node:fs";
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
  dir: string,
  signal?: AbortSignal,
): Promise<MoonIdeResult> {
  if (typeof dir !== "string" || !dir.trim()) {
    throw new TypeError(
      "runMoonIde: dir is required — pass the module directory derived from the tool's moon_mod_filepath parameter.",
    );
  }
  return shapeMoonIdeResult(
    args,
    await runMoon(["ide", ...args], { dir, signal, timeout: TIMEOUT_MS }),
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

// Every tool except moon_explain_error requires the absolute path of the
// module's moon.mod file. It identifies WHICH MoonBit module to operate on
// (the model may be working in a multi-root workspace or outside any module),
// and is converted to a `moon -C <DIR>` working directory by moonModDir().
export const MoonModFilePathParam = Type.String({
  description:
    "Absolute path to the module's moon.mod file, e.g. '/home/me/proj/moon.mod'. " +
    "Identifies the MoonBit module this call operates on; all relative paths in other " +
    "parameters are resolved against its directory.",
});

// Converts the moon_mod_filepath parameter into the directory passed to
// `moon -C <DIR>`: strips a trailing '/moon.mod' and resolves to an absolute
// path. Accepts the bare directory too, so a model that already stripped the
// filename still works.
//
// Hard-required and validated rather than lenient: an empty/whitespace input
// would otherwise resolve to the session cwd (silently checking the WRONG
// module), and a relative path would depend on the process cwd. Both throw —
// a loud parameter error beats a silent wrong-module run.
//
// Existence is NOT checked here: this throws structured TypeErrors only, so
// callers can format a proper failed tool result. Whether the directory
// actually contains a moon.mod is verified by validateMoonModDir() in each
// tool's execute() — an invalid path there returns a failed tool result (not
// an exception), which the model can read and correct.
export function moonModDir(moonModFilePath: string): string {
  if (typeof moonModFilePath !== "string" || !moonModFilePath.trim()) {
    throw new TypeError(
      "moon_mod_filepath is required — pass the absolute path of the module's moon.mod file (e.g. '/home/me/proj/moon.mod').",
    );
  }
  const trimmed = moonModFilePath.trim();
  const stripped = trimmed.replace(/\/+moon\.mod$/i, "");
  const dir = path.resolve(stripped);
  if (!path.isAbsolute(trimmed)) {
    // Relative path: refuse rather than silently resolving against the
    // extension process's cwd.
    throw new TypeError(
      `moon_mod_filepath must be an absolute path; got '${moonModFilePath}'. Pass the absolute path of the module's moon.mod file.`,
    );
  }
  return dir;
}

// Verifies the directory derived from moon_mod_filepath actually is a MoonBit
// module (exists, is a directory, contains moon.mod). Returns a short reason
// string when invalid, undefined when valid.
//
// Why this check lives here and not in the runner: without it, moon produces
// misleading results — a nonexistent dir errors with a cryptic
// "failed to change directory", and worse, `moon ide` against a directory
// without a moon.mod reports "No symbols found matching 'X'", which a model
// can easily misread as "the symbol doesn't exist in my code". Catching it
// here turns both into a clear, actionable tool error.
export function invalidMoonModDirReason(dir: string): string | undefined {
  if (!existsSync(dir)) {
    return (
      `moon_mod_filepath points to a nonexistent location: ${dir}. ` +
      "Pass the absolute path of the module's moon.mod file (e.g. '/home/me/proj/moon.mod')."
    );
  }
  if (!statSync(dir).isDirectory()) {
    return (
      `moon_mod_filepath is not a directory: ${dir}. ` +
      "Pass the absolute path of the module's moon.mod file (e.g. '/home/me/proj/moon.mod')."
    );
  }
  if (!existsSync(path.join(dir, "moon.mod"))) {
    return (
      `No moon.mod found in ${dir}. ` +
      "moon_mod_filepath must be the absolute path of a MoonBit module's moon.mod file " +
      "(e.g. '/home/me/proj/moon.mod'), not a directory without one or a workspace subdir."
    );
  }
  return undefined;
}

// Builds the standard failed tool result for an invalid moon_mod_filepath.
// Returned instead of thrown so the model sees the reason and can self-correct
// (e.g. locate the real moon.mod) rather than the harness showing a stack.
export function invalidMoonModResult(moonModFilePath: string, reason: string) {
  const text =
    `Invalid moon_mod_filepath: '${moonModFilePath}'.\n${reason}\n` +
    "Fix the parameter and call this tool again. Do not guess a moon.mod path — " +
    "locate the module's moon.mod on disk first.";
  return {
    content: [{ type: "text" as const, text }],
    details: failureFlagged({
      ok: false,
      error: reason,
      moon_mod_filepath: moonModFilePath,
    }),
  };
}

// One-call resolve + validate for tool execute() bodies: derives the module
// dir and checks it is a real MoonBit module. Discriminated result: on
// failure the tool returns invalidMoonModResult(params.moon_mod_filepath,
// mod.error) so the model gets an actionable message.
export function validatedMoonModDir(
  moonModFilePath: string,
): { ok: true; dir: string } | { ok: false; error: string } {
  try {
    const dir = moonModDir(moonModFilePath);
    const reason = invalidMoonModDirReason(dir);
    return reason ? { ok: false, error: reason } : { ok: true, dir };
  } catch (e) {
    // moonModDir's TypeErrors (empty / relative path) surface through the
    // same channel so every tool handles one uniform failure shape.
    return { ok: false, error: e instanceof Error ? e.message : String(e) };
  }
}

// --loc accepts path[:line[:col]]; keep it a single free-form string so
// callers can pass whichever precision they have (file only, file:line,
// or file:line:col) without us guessing.
export const LocParam = Type.Optional(
  Type.String({
    description:
      "Source location as path[:line[:col]], 1-based, e.g. './main.mbt:8:7'. Required; optional elsewhere as a disambiguation hint when the symbol name alone is ambiguous.",
  }),
);
