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
      "MoonBit: Check (static analysis) - Run moon_check to verify syntax and type correctness without building object files. Always run this after editing MoonBit source and before moon_test — it's much cheaper than a full build and catches errors early. Returns diagnostics grouped by level (error/warning) with counts. Diagnostics from dependency code (workspace siblings, .mooncakes) are partitioned out: dependency warnings are summarized as counts, dependency errors are always shown; pass includeDeps to list them all. Always checked against a backend target (default wasm-gc).",
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
    promptGuidelines: [`Follow this sequence`,
      "1. Edit source",
      "2. `moon_check --diagnostic - limit 1` (Check if there are errors)",
      "3. `moon_check` (cheap, catch type/syntax errors)",
      "4. `moon_test` (after check is clean)",
      "5. `moon_fmt_info` before handoff`",
      "Returns a json response."],
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
