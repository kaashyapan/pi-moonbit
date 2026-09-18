import os from "node:os";
import { runMoon } from "./moonexec";

// --- toolchain reachability check ---------------------------------------

interface MoonAvailability {
    available: boolean;
    version?: string;
    error?: string;
}

const DOCTOR_TIMEOUT_MS = 5_000;

// Probes `moon version` through the shared runner. No module is needed to
// answer "is the toolchain on PATH", but runMoon mandates a -C dir — so we
// pin it to the OS temp dir, which always exists. That keeps the probe
// independent of the session's cwd: a stale or deleted ctx.cwd would make
// `moon -C <stale> version` fail with "failed to change directory" and get
// misreported as "moon is not reachable".
//
// `moon -C <dir> version` is a valid call: -C only changes the working
// directory before the subcommand runs, and version output doesn't depend
// on it.
export async function checkMoonAvailable(signal?: AbortSignal): Promise<MoonAvailability> {
    const r = await runMoon(["version"], {
        dir: os.tmpdir(),
        signal,
        timeout: DOCTOR_TIMEOUT_MS,
    });
    if (r.aborted) {
        return { available: false, error: "aborted" };
    }
    if (r.spawnFailed) {
        const msg = r.spawnMessage ?? "";
        const reason = msg.includes("ENOENT")
            ? "`moon` is not on PATH"
            : r.stderr.trim() || msg;
        return { available: false, error: reason };
    }
    if (r.timedOut) {
        return {
            available: false,
            error: `moon version timed out after ${r.timeoutMs / 1000}s`,
        };
    }
    if (!r.ok) {
        return {
            available: false,
            error: r.stderr.trim() || `moon version exited with code ${r.exitCode ?? "?"}`,
        };
    }
    return {
        available: true,
        version: r.stdout.trim() || "(no version output)",
    };
}
