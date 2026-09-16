// The moon_check tool: static analysis with NDJSON parsing, level-count
// summarization, and dependency-vs-module ownership filtering (see
// diagnostics.ts for the partitioning rules).

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";
import type { CheckDiagnostic } from "./diagnostics";
import {
  findModuleRoot,
  hiddenDepSummary,
  parseCheckOutput,
  partitionDiagnostics,
  runMoonCheck,
} from "./diagnostics";
import { abortedContent, failureFlagged, truncate } from "./shared";

export function registerCheckTool(pi: ExtensionAPI) {
  pi.registerTool({
    name: "moon_check",
    label: "MoonBit: Check (static analysis)",
    description:
      "Static analysis for MoonBit source — type and syntax checking without a full build. " +
      "Do NOT run `moon check` via bash for this; call this tool instead. It parses the NDJSON " +
      "output, filters out dependency noise, and returns structured error/warning counts that " +
      "raw bash output does not give you. Run this after every source edit, before moon_test — " +
      "it's cheaper than a full build and catches errors earlier. Dependency warnings (workspace " +
      "siblings, .mooncakes) are hidden behind a count by default; dependency errors always show. " +
      "Checked against an explicit backend target (default wasm-gc) so results are reproducible.",

    parameters: Type.Object({
      target: Type.Optional(
        Type.String({
          description:
            "Backend target passed to moon check --target: 'wasm', 'wasm-gc' (default), 'js', 'native', 'llvm', or 'all'. Results can differ per target, so pass the target you will test/build with when it matters.",
        }),
      ),
      package: Type.Optional(
        Type.String({ description: "Limit the check to a specific package, passed as -p <package>." }),
      ),
      includeDeps: Type.Optional(
        Type.Boolean({
          description:
            "Include diagnostics from dependency code (workspace sibling modules, .mooncakes). Default false — dependency warnings are hidden behind a count; dependency errors are always shown.",
        }),
      ),
    }),
    promptSnippet:
      "moon_check replaces `moon check` — always prefer it over running the command in bash.",
    promptGuidelines: [
      "Use this tool, not bash, for `moon check`.",
      "Typical sequence: edit source -> moon_check -> moon_test -> moon_fmt_info before handoff.",
      "Pass `target` only when the result must match a specific backend other than wasm-gc.",
      "Pass `includeDeps: true` only if you need to see hidden dependency warnings, not by default.",
    ],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      // always check against an explicit target: moon's default target
      // resolution (moon.pkg preferred_target / platform default) makes
      // results environment-dependent, which the model can't reason about
      const target = params.target ?? "wasm-gc";
      const args = ["--target", target];
      if (params.package) args.push("-p", params.package);
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
          details: failureFlagged({ ok: false }),
        };
      }

      if (result.timedOut) {
        return {
          content: [
            {
              type: "text" as const,
              text: `moon check timed out after ${result.timeoutMs / 1000}s (cold workspaces and large .mooncakes dependency trees can exceed the default budget; retry — warm runs are much faster).`,
            },
          ],
          details: failureFlagged({ ok: false, timedOut: true }),
        };
      }

      const { diagnostics, unparsedLines } = parseCheckOutput(result.stdout);
      const moduleRoot = findModuleRoot(ctx?.cwd);
      const { workspace, dependency } = partitionDiagnostics(diagnostics, moduleRoot);
      const showDeps = params.includeDeps === true;

      const byLevel = (ds: CheckDiagnostic[]) => ({
        errors: ds.filter((d) => d.level === "error"),
        warnings: ds.filter((d) => d.level === "warning"),
        other: ds.filter((d) => d.level !== "error" && d.level !== "warning"),
      });
      const ws = byLevel(workspace);
      const dep = byLevel(dependency);

      const totalErrors = ws.errors.length + dep.errors.length;
      const totalWarnings = ws.warnings.length + dep.warnings.length;
      const totalOther = ws.other.length + dep.other.length;

      const lines: string[] = [];
      const render = (d: CheckDiagnostic, tag: string) => {
        lines.push(
          `\n[${tag}${d.level ?? "?"}${d.error_code !== undefined ? ` ${d.error_code}` : ""}] ${d.path ?? "?"
          }${d.loc ? `:${d.loc}` : ""}\n${d.message ?? ""}${d.context ? `\n${d.context}` : ""}`,
        );
      };

      const hiddenDepWarnings = showDeps ? [] : dep.warnings;
      if (totalErrors + totalWarnings + totalOther === 0 && unparsedLines.length === 0) {
        lines.push(hiddenDepWarnings.length ? "No errors or warnings in the module." : "No errors or warnings.");
      } else {
        lines.push(
          `${totalErrors} error(s), ${totalWarnings} warning(s)${totalOther ? `, ${totalOther} other` : ""}.` +
          (hiddenDepWarnings.length
            ? ` ${hiddenDepWarnings.length} dependency warning(s) hidden (${hiddenDepSummary(hiddenDepWarnings, moduleRoot)}).`
            : ""),
        );
      }

      // module diagnostics first, then dependency diagnostics (errors always
      // visible; warnings only with includeDeps)
      for (const d of [...ws.errors, ...ws.warnings, ...ws.other]) render(d, "");
      for (const d of dep.errors) render(d, "dependency ");
      if (showDeps) {
        for (const d of [...dep.warnings, ...dep.other]) render(d, "dependency ");
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
        details: totalErrors > 0
          ? failureFlagged({
            ok: true,
            target,
            errorCount: totalErrors,
            warningCount: ws.warnings.length,
            depErrorCount: dep.errors.length,
            depWarningCount: dep.warnings.length,
            includeDeps: showDeps,
            hasErrors: totalErrors > 0,
          })
          : {
            ok: true,
            target,
            errorCount: totalErrors,
            warningCount: ws.warnings.length,
            depErrorCount: dep.errors.length,
            depWarningCount: dep.warnings.length,
            includeDeps: showDeps,
            hasErrors: totalErrors > 0,
          },
      };
    },
  });
}
