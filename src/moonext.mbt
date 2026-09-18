///|
/// Extension entry point.
///
/// This is the MoonBit port of the pi MoonBit extension. The pieces wired up
/// so far are:
///
/// - `moon_check`, `moon_test`, and `moon_fmt_info`: the build/quality tools.
/// - `moon_peek_def`, `moon_find_references`, `moon_type_info`,
///   `moon_outline`, `moon_rename`, `moon_analyze`, and `moon_doc`: the
///   compiler-aware navigation tools.
/// - `moon_explain_error`, which looks up an error code through
///   `moon explain --diagnostic`.
/// - A `tool_call` redirect that blocks bash/powershell invocations of the
///   `moon` subcommands the tools above replace.
/// - A `tool_result` hook that turns the tools' failure marker into
///   `isError: true`, so failures and cancellations are not mistaken for
///   successful results.
/// - The `/moon-doctor` command, which reports whether the toolchain is
///   reachable, and a `before_agent_start` hook that injects the MoonBit
///   tooling guide at the start of every run.
///
/// At startup the extension probes whether the MoonBit toolchain (`moon`) is
/// reachable. The `moon_*` tools are registered only if that succeeds,
/// matching the TypeScript extension: a tool that always fails with "command
/// not found" is worse than no tool at all. The `/moon-doctor` command, the
/// `tool_result` hook, and the guide-injection hook are registered
/// unconditionally: the hook has nothing to flag before the tools exist, and
/// the guide explains which tools exist, so it is still the right thing to
/// show when the toolchain is missing.

///|
using @pi {type ExtensionAPI, type Promise}

///|
/// Extension factory. The harness calls this with its `ExtensionAPI` once
/// when the extension is loaded, and awaits the returned promise.
///
/// The body is wrapped with `Promise::from_async` rather than declared with
/// `async fn` directly: the harness calls the export from JavaScript as
/// `default_main(pi)` and awaits the result, so the entry point must return a
/// real JS promise. A bare `async fn` export compiles to a callback-continuation
/// function that is not callable that way.
#export_name("default_main")
pub fn main_(pi : ExtensionAPI) -> Promise[Unit] {
  @pi.Promise::from_async(async fn() {
    let availability = check_moon_available(pi, None)
    register_moon_doctor(pi, availability.available)
    register_tool_result(pi)
    register_agent_prompt(pi)
    if availability.available {
      register_check_tool(pi)
      register_test_tools(pi)
      register_ide_tools(pi)
      register_error_tools(pi)
      register_bash_redirect(pi)
    }
  })
}
