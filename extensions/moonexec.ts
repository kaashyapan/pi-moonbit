import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execFile } from "node:child_process";
import { Type } from "typebox";

const TIMEOUT_MS = 30_000;

// --- generic moon runner ------------------------------------------------

interface MoonRunResult {
    ok: boolean;
    spawnFailed: boolean;
    // execFile killed the child after its own timeout fired (error.killed,
    // code === null). Distinguished from spawnFailed so callers report a
    // clear "timed out after Xs" instead of a misleading "command not
    // found"-style spawn error.
    timedOut: boolean;
    stdout: string;
    stderr: string;
    aborted: boolean;
    spawnMessage?: string;
    exitCode?: number | null;
    // The timeout actually applied to this run, so callers can report
    // "timed out after Xs" without reaching for module-level constants.
    timeoutMs: number;
}

export function runMoon(
    args: string[],
    opts: { cwd?: string; signal?: AbortSignal; timeout?: number } = {},
): Promise<MoonRunResult> {
    const { cwd, signal, timeout = TIMEOUT_MS } = opts;
    return new Promise((resolve) => {
        if (signal?.aborted) {
            resolve({
                ok: false,
                spawnFailed: false,
                timedOut: false,
                stdout: "",
                stderr: "",
                aborted: true,
                timeoutMs: timeout,
            });
            return;
        }
        execFile(
            "moon",
            args,
            { cwd, timeout, maxBuffer: 10 * 1024 * 1024, signal },
            (error, stdout, stderr) => {
                const out = stdout?.toString() ?? "";
                const err = stderr?.toString() ?? "";
                if (signal?.aborted || (error as NodeJS.ErrnoException | null)?.code === "ABORT_ERR") {
                    resolve({
                        ok: false,
                        spawnFailed: false,
                        timedOut: false,
                        stdout: out,
                        stderr: err,
                        aborted: true,
                        timeoutMs: timeout,
                    });
                    return;
                }
                if (error?.killed) {
                    resolve({
                        ok: false,
                        spawnFailed: false,
                        timedOut: true,
                        stdout: out,
                        stderr: err,
                        aborted: false,
                        timeoutMs: timeout,
                    });
                    return;
                }
                // Non-zero exit is a normal process result (tests failed, check found
                // errors). Only true spawn failures lack a numeric exit code.
                const spawnFailed =
                    !!error && !("code" in error && typeof (error as any).code === "number");
                const exitCode =
                    error && "code" in error && typeof (error as any).code === "number"
                        ? ((error as any).code as number)
                        : error
                            ? null
                            : 0;
                resolve({
                    ok: !error,
                    spawnFailed,
                    timedOut: false,
                    stdout: out,
                    stderr: err,
                    aborted: false,
                    spawnMessage: spawnFailed ? String(error) : undefined,
                    exitCode,
                    timeoutMs: timeout,
                });
            },
        );
    });
}
