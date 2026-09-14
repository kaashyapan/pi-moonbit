// The verify/finalize tools: moon_test and moon_fmt_info.
//
// For moon_test, non-zero exit is normal (failed tests). Only spawn failure
// is a spawn-level error; failed tests are still flagged via isError so the
// model treats them as "fix this".
//
// moon_fmt_info combines the standard handoff sequence: `moon fmt` (rewrites
// source in place) then `moon info` (regenerates .mbti interface files —
// review their diff). info only runs when fmt succeeded.

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";
import { runMoon } from "./moonexec";
import { abortedContent, failureFlagged, truncate } from "./shared";

// test builds can be slow on first run; give them their own budget.
const TEST_TIMEOUT_MS = 120_000;

export function registerTestTools(pi: ExtensionAPI) {
  pi.registerTool({
    name: "moon_test",
    label: "MoonBit: Test",
    description:
      "MoonBit: Test - Run `moon test` for the current module or a scoped package. Always runs against an explicit backend target (default wasm — pass the same target you used for moon_check). Prefer moon_check first (cheaper).",
    parameters: Type.Object({
      target: Type.Optional(
        Type.String({
          description:
            "Backend target passed to moon test --target: 'wasm', 'wasm-gc' (default), 'js', 'native', 'llvm', or 'all'. Keep it consistent with the moon_check target so the two agree.",
        }),
      ),
      package: Type.Optional(
        Type.String({ description: "Limit to a package (-p <package>)." }),
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
      // always test against an explicit target (default wasm), mirroring
      // moon_check — otherwise moon resolves the target from moon.pkg /
      // platform defaults and check vs test results can silently disagree
      const target = params.target ?? "wasm-gc";
      const args = ["test", "--target", target];
      if (params.package) args.push("-p", params.package);
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
          details: failureFlagged({ ok: false }),
        };
      }

      if (result.timedOut) {
        return {
          content: [
            {
              type: "text" as const,
              text: `moon test timed out after ${result.timeoutMs / 1000}s.`,
            },
          ],
          details: failureFlagged({ ok: false, timedOut: true }),
        };
      }

      const failed = !result.ok;
      const body = [
        result.ok ? "Tests passed." : `Tests failed (exit ${result.exitCode ?? "?"}).`,
        result.stdout.trim() ? `\n${result.stdout.trim()}` : "",
        result.stderr.trim() ? `\nstderr:\n${result.stderr.trim()}` : "",
      ]
        .filter(Boolean)
        .join("");

      return {
        content: [{ type: "text" as const, text: truncate(body) }],
        details: failed
          ? failureFlagged({ ok: result.ok, target, exitCode: result.exitCode })
          : { ok: result.ok, target, exitCode: result.exitCode },
      };
    },
  });

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
          details: failureFlagged({ ok: false, step: "fmt" }),
        };
      }

      if (fmt.timedOut) {
        return {
          content: [
            {
              type: "text" as const,
              text: `moon fmt timed out after ${fmt.timeoutMs / 1000}s.`,
            },
          ],
          details: failureFlagged({ ok: false, step: "fmt", timedOut: true }),
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
          details: failureFlagged({ ok: false, step: "fmt", exitCode: fmt.exitCode }),
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
          details: failureFlagged({ ok: false, step: "info" }),
        };
      }

      if (info.timedOut) {
        return {
          content: [
            {
              type: "text" as const,
              text: truncate(
                sections.filter(Boolean).join("\n") +
                `\n\n## moon info\nTimed out after ${info.timeoutMs / 1000}s.`,
              ),
            },
          ],
          details: failureFlagged({ ok: false, step: "info", timedOut: true }),
        };
      }
      sections.push(
        `## moon info (exit ${info.exitCode ?? 0})`,
        info.stdout.trim() || "(no stdout)",
        info.stderr.trim() ? `stderr:\n${info.stderr.trim()}` : "",
      );

      const ok = info.ok;
      const baseDetails = {
        ok,
        fmtExit: fmt.exitCode,
        infoExit: info.exitCode,
      };
      return {
        content: [
          {
            type: "text" as const,
            text: truncate(sections.filter(Boolean).join("\n")),
          },
        ],
        details: ok ? baseDetails : failureFlagged(baseDetails),
      };
    },
  });
}
