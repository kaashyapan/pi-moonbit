import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execFile } from "node:child_process";
import { Type } from "typebox";

const TIMEOUT_MS = 30_000;

// --- generic moon runner ------------------------------------------------

interface MoonRunResult {
    ok: boolean;
    spawnFailed: boolean;
    stdout: string;
    stderr: string;
    aborted: boolean;
    spawnMessage?: string;
    exitCode?: number | null;
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
                stdout: "",
                stderr: "",
                aborted: true,
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
                        stdout: out,
                        stderr: err,
                        aborted: true,
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
                    stdout: out,
                    stderr: err,
                    aborted: false,
                    spawnMessage: spawnFailed ? String(error) : undefined,
                    exitCode,
                });
            },
        );
    });
}
