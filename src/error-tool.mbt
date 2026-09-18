// The `moon_explain_error` tool.
//
// Delegates to `moon explain --diagnostic <code>`, so explanations always
// match the installed toolchain instead of a static error-code database.
//
// Unlike the other tools this needs no module context: `moon explain` reads
// its integrated docs, not project state. The probe is pinned to the OS temp
// directory (a directory guaranteed to exist) so it does not depend on the
// session's working directory: a stale or deleted session cwd would make
// `moon -C <stale> explain` fail with "failed to change directory" and get
// misreported as a lookup failure.

///|
/// Default budget for the `moon explain` subprocess. It reads local
/// documentation, so it is normally fast; this only bounds a hung toolchain.
let explain_timeout_ms : Double = 30000.0

///|
/// The `parameters` schema for the tool: a single required integer property
/// `error_code`. It is a JSON-schema object; the harness compiles it and
/// coerces/validates the model's arguments against it.
fn error_code_schema() -> @pi.TSchema {
  let property = js_object([
    ("type", @pi.JSValue::from_string("integer")),
    (
      "description",
      @pi.JSValue::from_string("Error code from moon_check diagnostic"),
    ),
  ])
  let properties = js_object([("error_code", property)])
  let schema = js_object([
    ("type", @pi.JSValue::from_string("object")),
    ("properties", properties),
    (
      "required",
      @pi.JSValue::from_array([@pi.JSValue::from_string("error_code")]),
    ),
  ])
  @js_core.identity(schema)
}

///|
/// The tool's `execute` implementation. It mirrors the TypeScript
/// `registerErrorTools` handler: run `moon explain --diagnostic <code>` in the
/// OS temp directory, then classify the outcome as cancelled, timed out,
/// unknown code, or a successful explanation.
fn explain_execute(
  pi : @pi.ExtensionAPI,
) -> (
  String,
  @pi.Static,
  @pi.AbortSignal?,
  @pi.AgentToolUpdateCallback?,
  @pi.ExtensionContext,
) -> @pi.Promise[@pi.AgentToolResult[@pi.JSValue]] {
  fn(_tool_call_id, params, signal, _on_update, _ctx) {
    @pi.Promise::from_async(async fn() {
      let params_any : @js_core.Any = @js_core.identity(params)
      let code_value = params_any._get("error_code")
      let code_js : @pi.JSValue = @js_core.identity(code_value)
      let code = code_value.to_string()

      if is_aborted(signal) {
        return tool_result(
          "Cancelled.",
          failure_details([
            ("ok", @pi.JSValue::from_bool(false)),
            ("aborted", @pi.JSValue::from_bool(true)),
          ]),
        )
      }

      let result = run_moon(
        pi,
        ["explain", "--diagnostic", code],
        @os.tmpdir(),
        signal,
        explain_timeout_ms,
      ).wait()

      if result.killed {
        return tool_result(
          "moon explain timed out after " +
          (explain_timeout_ms / 1000.0).to_string() +
          "s.",
          failure_details([
            ("ok", @pi.JSValue::from_bool(false)),
            ("error_code", code_js),
            ("timedOut", @pi.JSValue::from_bool(true)),
          ]),
        )
      }

      // moon exits non-zero for an unknown code ("no integrated diagnostic
      // docs found for `<code>`") — surface that verbatim with guidance.
      if result.code != 0.0 {
        let stderr = result.stderr.trim().to_owned()
        let stdout = result.stdout.trim().to_owned()
        let reason = if stderr != "" {
          stderr
        } else if stdout != "" {
          stdout
        } else {
          "moon explain exited with code " + result.code.to_string() + "."
        }
        let text = truncate(
          "No explanation available for error code " +
          code +
          ".\n" +
          reason +
          "\nTreat the moon_check diagnostic message itself as authoritative.",
        )
        return tool_result(
          text,
          failure_details([
            ("ok", @pi.JSValue::from_bool(false)),
            ("error_code", code_js),
            ("exitCode", @pi.JSValue::from_double(result.code)),
            (
              "error",
              @pi.JSValue::from_string(
                "No explanation found for error code " + code,
              ),
            ),
          ]),
        )
      }

      let stdout = result.stdout.trim().to_owned()
      let body = if stdout != "" {
        stdout
      } else {
        result.stderr.trim().to_owned()
      }
      tool_result(
        truncate(body),
        js_object([
          ("ok", @pi.JSValue::from_bool(true)),
          ("error_code", code_js),
        ]),
      )
    })
  }
}

///|
/// Registers the `moon_explain_error` tool with the harness.
///
/// This is the MoonBit port of `registerErrorTools` from
/// `extensions/error-tool.ts`.
///
/// The tool definition is assembled as a plain JavaScript object and passed to
/// the harness `registerTool` method directly. The generated MoonBit
/// `registerTool` binding forwards the MoonBit `ToolDefinition` struct as-is,
/// which would leave boxed-`Option` fields such as `promptGuidelines` in the
/// shape `{ _0: [...] }`; pi's prompt builder iterates that value, so it must
/// arrive as a real array.
pub fn register_error_tools(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(explain_execute(pi))
  let parameters : @pi.JSValue = @js_core.identity(error_code_schema())
  let definition = js_object([
    ("name", @pi.JSValue::from_string("moon_explain_error")),
    ("label", @pi.JSValue::from_string("MoonBit: Explain error")),
    (
      "description",
      @pi.JSValue::from_string(
        "Ask for detailed explanation for an integer error code that was received from moon_check." +
        "Call this if the cause of error is not understood from the moon_check diagnostic message." +
        "Do not make assumptions about errors until you read this.",
      ),
    ),
    (
      "promptSnippet",
      @pi.JSValue::from_string(
        "moon_explain_error - Returns a detailed explanation of the error code.",
      ),
    ),
    (
      "promptGuidelines",
      @pi.JSValue::from_array([
        @pi.JSValue::from_string(
          "Use this tool, Do not search on the internet.",
        ),
        @pi.JSValue::from_string(
          "Do not make assumptions about error messages based on Rust or Python",
        ),
      ]),
    ),
    ("parameters", parameters),
    ("execute", execute),
  ])
  let pi_any : @js_core.Any = @js_core.identity(pi)
  let _ = pi_any._call(
    "registerTool",
    FixedArray::from_array([@js_core.identity(definition)]),
  )
}
