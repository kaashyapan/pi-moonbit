// The `moon version` reachability probe behind the `/moon-doctor` command.
//
// This mirrors `extensions/doctor.ts` from the TypeScript extension: probe
// the toolchain by running `moon version`, then report whether `moon` is
// reachable and, when it is not, why.

///|
/// The number of milliseconds the reachability probe is allowed to take
/// before the child process is killed. Kept in step with the TypeScript
/// `DOCTOR_TIMEOUT_MS` constant.
let doctor_timeout_ms : Double = 5000.0

///|
/// The command name registered with the harness. A human runs it as
/// `/moon-doctor`.
let doctor_command_name : String = "moon-doctor"

///|
/// Outcome of probing whether the MoonBit toolchain is reachable.
pub(all) struct MoonAvailability {
  available : Bool
  version : String?
  error : String?
}

///|
/// Runs `moon -C <dir> version` through the shared runner.
///
/// The probe is pinned to the OS temp directory so it does not depend on the
/// session's working directory: a stale or deleted session cwd would make
/// `moon -C <stale> version` fail with "failed to change directory" and be
/// misreported as "moon is not reachable". `-C` only changes the working
/// directory before the subcommand runs, and version output does not depend
/// on it.
pub fn run_moon_version(
  pi : @pi.ExtensionAPI,
  signal : @pi.AbortSignal?,
) -> @pi.Promise[@pi.ExecResult] {
  run_moon(pi, ["version"], @os.tmpdir(), signal, doctor_timeout_ms)
}

///|
/// Probes `moon version` and classifies the outcome.
///
/// The classification order matches the TypeScript implementation:
/// timeout first, then a non-zero exit (or missing binary), then success.
pub async fn check_moon_available(
  pi : @pi.ExtensionAPI,
  signal : @pi.AbortSignal?,
) -> MoonAvailability {
  let result = run_moon_version(pi, signal).wait()
  if result.killed {
    return {
      available: false,
      version: None,
      error: Some(
        "moon version timed out after " +
        (doctor_timeout_ms / 1000.0).to_string() +
        "s",
      ),
    }
  }
  if result.code != 0.0 {
    let stderr = result.stderr.trim().to_owned()
    let error = if stderr != "" {
      stderr
    } else if result.stdout.trim().to_owned() == "" {
      "`moon` is not on PATH"
    } else {
      "moon version exited with code " + result.code.to_string()
    }
    return { available: false, version: None, error: Some(error), }
  }
  let stdout = result.stdout.trim().to_owned()
  let version = if stdout == "" { "(no version output)" } else { stdout }
  { available: true, version: Some(version), error: None, }
}

///|
/// Builds the `/moon-doctor` command handler.
///
/// The handler re-probes the toolchain on demand and reports the outcome
/// through the harness UI. It is registered regardless of whether the
/// toolchain was reachable at startup, so a human can diagnose a missing
/// `moon` (or confirm it is live) without needing to know in advance that
/// the other MoonBit tools are gated on reachability.
///
/// `tools_registered` records whether the startup reachability check
/// succeeded. The doctor command runs its own fresh probe, so the two can
/// disagree if PATH was fixed mid-session; in that case the report tells the
/// human to run `/reload` to actually pick the tools up.
fn moon_doctor_handler(
  pi : @pi.ExtensionAPI,
  tools_registered : Bool,
) -> (String, @pi.ExtensionCommandContext) -> @pi.Promise[Unit] {
  fn(_args, ctx) {
    @pi.Promise::from_async(async fn() {
      let result = check_moon_available(pi, ctx.signal)
      if result.available {
        let version = result.version.unwrap_or("(no version output)")
        ctx.ui.notify(
          "moon is reachable — " +
          version +
          ". " +
          (if tools_registered {
            "MoonBit tools (moon_peek_def, moon_check, moon_test, etc.) are active."
          } else {
            "MoonBit tools were NOT registered at startup (moon wasn't reachable then). Run /reload to pick them up now."
          }),
          Some("info"),
        )
      } else {
        let reason = result.error.unwrap_or("unknown error")
        ctx.ui.notify(
          "moon is not reachable: " +
          reason +
          ". " +
          "Install the MoonBit toolchain or fix PATH, then run /moon-doctor again (or /reload) once fixed. " +
          "MoonBit tools are not registered.",
          Some("error"),
        )
      }
    })
  }
}

///|
/// Registers the always-available `/moon-doctor` command.
///
/// Called unconditionally from the extension entry point: unlike the
/// `moon_*` tools, which are gated behind a startup reachability check, the
/// doctor command exists precisely to explain why those tools may be
/// missing. `tools_registered` is the startup check's outcome, reported
/// alongside the command's own fresh probe.
pub fn register_moon_doctor(
  pi : @pi.ExtensionAPI,
  tools_registered : Bool,
) -> Unit {
  let spec : @pi.RegisteredCommandOmitNameSourceInfo = {
    description: Some(
      "MoonBit doctor: Check whether the MoonBit toolchain (`moon`) is reachable on PATH " +
      "and whether moon-ide/moon-check tools are active",
    ),
    getArgumentCompletions: None,
    handler: moon_doctor_handler(pi, tools_registered),
  }
  @pi.ExtensionAPI::registerCommand(pi, doctor_command_name, spec)
}
