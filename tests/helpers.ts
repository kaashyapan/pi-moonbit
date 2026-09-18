// Shared test helpers.
//
// The tests load the compiled extension bundle and drive it through a stub
// ExtensionAPI. This module provides a real subprocess runner for the tests
// that must exercise the installed `moon` binary.

import { spawn } from "node:child_process";

// Runs a command and resolves with the same shape pi's `exec` returns:
// { stdout, stderr, code, killed }. pi's own execCommand is not importable
// (the package's exports map only exposes the root entry point), so this
// reproduces the small part the extension relies on.
export function realExec(
  command: string,
  args: string[],
  options?: { cwd?: string; timeout?: number; signal?: AbortSignal },
): Promise<{ stdout: string; stderr: string; code: number; killed: boolean }> {
  return new Promise((resolve) => {
    const child = spawn(command, args, {
      cwd: options?.cwd ?? process.cwd(),
      stdio: ["ignore", "pipe", "pipe"],
    });
    let stdout = "";
    let stderr = "";
    let killed = false;
    let timer: ReturnType<typeof setTimeout> | undefined;

    const kill = () => {
      if (!killed) {
        killed = true;
        child.kill("SIGTERM");
      }
    };

    if (options?.signal) {
      if (options.signal.aborted) kill();
      else options.signal.addEventListener("abort", kill, { once: true });
    }
    if (options?.timeout && options.timeout > 0) {
      timer = setTimeout(kill, options.timeout);
    }

    child.stdout?.on("data", (data) => {
      stdout += data.toString();
    });
    child.stderr?.on("data", (data) => {
      stderr += data.toString();
    });
    child.on("close", (code) => {
      if (timer) clearTimeout(timer);
      if (options?.signal) options.signal.removeEventListener("abort", kill);
      resolve({ stdout, stderr, code: code ?? 0, killed });
    });
    child.on("error", () => {
      if (timer) clearTimeout(timer);
      resolve({ stdout, stderr, code: 1, killed });
    });
  });
}
