import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execFile } from "node:child_process";
import { Type } from "typebox";

// --- toolchain reachability check ---------------------------------------

interface MoonAvailability {
    available: boolean;
    version?: string;
    error?: string;
}

const DOCTOR_TIMEOUT_MS = 5_000;

export function checkMoonAvailable(cwd?: string, signal?: AbortSignal): Promise<MoonAvailability> {
    return new Promise((resolve) => {
        if (signal?.aborted) {
            resolve({ available: false, error: "aborted" });
            return;
        }
        execFile(
            "moon",
            ["version"],
            { cwd, timeout: DOCTOR_TIMEOUT_MS, signal },
            (error, stdout, stderr) => {
                if (error) {
                    if (signal?.aborted || (error as NodeJS.ErrnoException).code === "ABORT_ERR") {
                        resolve({ available: false, error: "aborted" });
                        return;
                    }
                    const reason =
                        (error as NodeJS.ErrnoException).code === "ENOENT"
                            ? "`moon` is not on PATH"
                            : (stderr?.toString().trim() || String(error));
                    resolve({ available: false, error: reason });
                    return;
                }
                resolve({ available: true, version: stdout?.toString().trim() || "(no version output)" });
            },
        );
    });
}