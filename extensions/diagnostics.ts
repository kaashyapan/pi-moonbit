// `moon check` diagnostics: NDJSON parsing and dependency-vs-module
// ownership partitioning.
//
// `moon check --output-json` emits one diagnostic object per line (NDJSON)
// and exits non-zero whenever there are diagnostics — that's normal, not a
// spawn failure. `moon check` reports diagnostics for the whole module AND
// its workspace siblings / mooncake dependencies. Warnings from code the
// model didn't write (crescent, dotenv, .mooncakes/...) are noise that
// drowns the signal and invites "fixes" in files the model should never
// touch, so moon_check partitions diagnostics by ownership and hides
// dependency *warnings* by default. Dependency *errors* are always shown:
// they break the build regardless of who owns the file.
// `includeDeps: true` on the moon_check tool is the escape hatch.

import { existsSync } from "node:fs";
import path from "node:path";
import { runMoon } from "./moonexec";

export interface CheckDiagnostic {
  level?: string;
  error_code?: number;
  path?: string;
  loc?: string;
  message?: string;
  context?: string;
}

export function runMoonCheck(
  args: string[],
  cwd?: string,
  signal?: AbortSignal,
): Promise<{
  spawnFailed: boolean;
  timedOut: boolean;
  aborted: boolean;
  stdout: string;
  stderr: string;
  spawnMessage?: string;
  timeoutMs: number;
}> {
  return runMoon(["check", "--output-json", ...args], { cwd, signal }).then((r) => ({
    spawnFailed: r.spawnFailed,
    timedOut: r.timedOut,
    aborted: r.aborted,
    stdout: r.stdout,
    stderr: r.stderr,
    spawnMessage: r.spawnMessage,
    timeoutMs: r.timeoutMs,
  }));
}

export function parseCheckOutput(stdout: string): { diagnostics: CheckDiagnostic[]; unparsedLines: string[] } {
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

// --- ownership partitioning ------------------------------------------------

const MOONCAKES_SEGMENT = "/.mooncakes/";

// Nearest ancestor (including cwd itself) containing a moon.mod file.
// That module root is the ownership boundary; everything outside it is a
// dependency — including moon.work sibling members (e.g. ../crescent),
// which the agent working in this module shouldn't edit even though the
// workspace links them. Returns undefined when no module root is found,
// in which case the caller fails open (nothing is hidden).
export function findModuleRoot(cwd?: string): string | undefined {
  if (!cwd) return undefined;
  let dir = path.resolve(cwd);
  for (;;) {
    if (existsSync(path.join(dir, "moon.mod"))) return dir;
    const parent = path.dirname(dir);
    if (parent === dir) return undefined;
    dir = parent;
  }
}

export function isDependencyPath(filePath: string, moduleRoot?: string): boolean {
  if (filePath.includes(MOONCAKES_SEGMENT)) return true;
  if (!moduleRoot) return false; // fail open: show everything
  const abs = path.isAbsolute(filePath) ? filePath : path.resolve(moduleRoot, filePath);
  return !(abs === moduleRoot || abs.startsWith(moduleRoot + path.sep));
}

// Short origin label for a dependency diagnostic, for the hidden-summary
// line: "bobzhang/crescent" for mooncakes, the sibling module/dir name
// otherwise (resolved against the module root's parent, which is where
// moon.work sibling members live).
export function dependencyOrigin(filePath: string, moduleRoot?: string): string {
  const idx = filePath.indexOf(MOONCAKES_SEGMENT);
  if (idx >= 0) {
    return filePath
      .slice(idx + MOONCAKES_SEGMENT.length)
      .split("/")
      .slice(0, 2)
      .join("/");
  }
  const base = moduleRoot ? path.dirname(moduleRoot) : path.dirname(filePath);
  const rel = path.isAbsolute(filePath) && filePath.startsWith(base + path.sep)
    ? filePath.slice(base.length + 1)
    : filePath;
  return rel.split("/")[0] || path.basename(path.dirname(filePath));
}

// "crescent: 12, dotenv-mbt: 4" style summary for the hidden-warnings line.
export function hiddenDepSummary(
  diagnostics: CheckDiagnostic[],
  moduleRoot?: string,
): string {
  const counts = new Map<string, number>();
  for (const d of diagnostics) {
    const origin = dependencyOrigin(d.path ?? "", moduleRoot);
    counts.set(origin, (counts.get(origin) ?? 0) + 1);
  }
  return [...counts.entries()].map(([origin, n]) => `${origin}: ${n}`).join(", ");
}

export function partitionDiagnostics(
  diagnostics: CheckDiagnostic[],
  moduleRoot?: string,
): { workspace: CheckDiagnostic[]; dependency: CheckDiagnostic[] } {
  const workspace: CheckDiagnostic[] = [];
  const dependency: CheckDiagnostic[] = [];
  for (const d of diagnostics) {
    (d.path && isDependencyPath(d.path, moduleRoot) ? dependency : workspace).push(d);
  }
  return { workspace, dependency };
}
