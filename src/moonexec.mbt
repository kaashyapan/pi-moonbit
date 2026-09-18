// Generic `moon` subprocess runner shared by the tools.
//
// This mirrors `extensions/moonexec.ts`. Every invocation is prefixed with
// moon's global `-C <DIR>` option, so relative paths resolve against a known
// directory regardless of the session's working directory.
//
// The options object is assembled as plain JavaScript rather than through the
// generated `ExtensionAPI::exec` binding. That binding forwards the MoonBit
// `ExecOptions` struct as-is, leaving its `Option` fields boxed
// (`signal` as an object, `timeout` as `{ _0: n }`); pi's `execCommand` reads
// those fields directly, so a boxed value silently disables the timeout and
// makes the abort signal crash on `addEventListener`.

///|
/// Maximum number of characters returned to the model before truncation.
let max_output_chars : Int = 20000

///|
/// Marker set on tool results whose outcome should be presented to the model
/// as an error. Mirrors `FAILURE_FLAG` from the TypeScript `shared.ts`: the
/// harness `tool_result` hook turns it into `isError` while keeping the
/// summarized content.
let failure_flag : String = "flagsDiagnosticFailure"

///|
/// Default subprocess budget, matching the TypeScript runner's `TIMEOUT_MS`.
let default_timeout_ms : Double = 30000.0

///|
/// Test builds can be slow on first run, so `moon test` gets its own budget.
/// Mirrors `TEST_TIMEOUT_MS` from `test-tools.ts`.
let test_timeout_ms : Double = 120000.0

///|
/// `moon ide <subcommand>` runs a project check under the hood, so it gets a
/// generous-but-bounded budget. Mirrors `TIMEOUT_MS` from `shared.ts`.
let ide_timeout_ms : Double = 30000.0

///|
/// Unwraps a MoonBit `Option` value at the JavaScript boundary.
///
/// A MoonBit `Option` is a tagged object (`{ $tag: 0 }` / `{ $tag: 1, _0 }`),
/// not JavaScript `null`/`undefined`. A value passed directly from JavaScript
/// (such as an `AbortSignal` handed to a tool's `execute`) is not wrapped, so
/// both representations are accepted: tagged objects are unwrapped, `null`
/// and `undefined` become `undefined`, and anything else is passed through.
extern "js" fn js_unwrap_option(value : @js_core.Any) -> @js_core.Any =
  #| (v) => (v !== null && typeof v === "object" && "$tag" in v) ? (v.$tag === 1 ? v._0 : undefined) : (v == null ? undefined : v)

///|
/// Builds a plain JavaScript object from string-keyed pairs.
fn js_object(pairs : Array[(String, @pi.JSValue)]) -> @pi.JSValue {
  @pi.JSValue::object_from_pairs(pairs[:].to_array())
}

///|
/// Normalizes an `AbortSignal?` argument into the raw JavaScript value pi
/// expects (`AbortSignal` or `undefined`).
fn unwrap_signal(signal : @pi.AbortSignal?) -> @pi.JSValue {
  @js_core.identity(js_unwrap_option(@js_core.identity(signal)))
}

///|
/// Reports whether the caller's `AbortSignal` has already fired.
fn is_aborted(signal : @pi.AbortSignal?) -> Bool {
  let any = js_unwrap_option(@js_core.identity(signal))
  if @js_core.is_nullish(any) {
    false
  } else {
    any._get("aborted").cast()
  }
}

///|
/// Truncates long output so a broad command result cannot flood the context
/// window.
fn truncate(s : String) -> String {
  if s.length() <= max_output_chars {
    s
  } else {
    s[:max_output_chars].to_owned() +
    "\n... [truncated " +
    (s.length() - max_output_chars).to_string() +
    " chars]"
  }
}

///|
/// Runs `moon -C <dir> <args>` and returns the process result.
///
/// `dir` is mandatory: a moon invocation without it would silently run against
/// whatever directory the session happens to be in. The child is also spawned
/// with `cwd = dir`, so a stale or deleted session cwd cannot make the spawn
/// itself fail.
pub fn run_moon(
  pi : @pi.ExtensionAPI,
  args : Array[String],
  dir : String,
  signal : @pi.AbortSignal?,
  timeout_ms : Double,
) -> @pi.Promise[@pi.ExecResult] {
  let full_args : Array[String] = ["-C", dir]
  full_args.append(args[:])
  let options = js_object([
    ("signal", unwrap_signal(signal)),
    ("timeout", @pi.JSValue::from_double(timeout_ms)),
    ("cwd", @pi.JSValue::from_string(dir)),
  ])
  let pi_any : @js_core.Any = @js_core.identity(pi)
  let result = pi_any._call(
    "exec",
    FixedArray::from_array([
      @js_core.any("moon"),
      @js_core.identity(full_args),
      @js_core.identity(options),
    ]),
  )
  result.cast()
}

// --- result shaping --------------------------------------------------------

///|
/// Builds a tool result carrying a single text block plus structured details.
///
/// The result is built directly as a JavaScript object and cast to the
/// harness `AgentToolResult` type. This is deliberate: the `execute` return
/// value is handed to JavaScript as-is, so a MoonBit struct/enum would reach
/// pi in the wrong shape. The expected JS shape is
/// `{ content: [{ type: "text", text }], details }`.
fn tool_result(
  text : String,
  details : @pi.JSValue,
) -> @pi.AgentToolResult[@pi.JSValue] {
  let text_block = js_object([
    ("type", @pi.JSValue::from_string("text")),
    ("text", @pi.JSValue::from_string(text)),
  ])
  let content = @pi.JSValue::from_array([text_block])
  let result = js_object([("content", content), ("details", details)])
  @js_core.identity(result)
}

///|
/// Builds the details object for a failed tool result, tagging it with the
/// failure flag so the harness presents it as an error.
fn failure_details(pairs : Array[(String, @pi.JSValue)]) -> @pi.JSValue {
  pairs.push((failure_flag, @pi.JSValue::from_bool(true)))
  js_object(pairs)
}

///|
/// The standard cancelled result, returned when the model/user aborts a call.
fn aborted_result() -> @pi.AgentToolResult[@pi.JSValue] {
  tool_result(
    "Cancelled.",
    failure_details([
      ("ok", @pi.JSValue::from_bool(false)),
      ("aborted", @pi.JSValue::from_bool(true)),
    ]),
  )
}

// --- moon_mod_filepath validation ------------------------------------------

///|
/// ASCII-case-insensitive check for a trailing `/moon.mod`.
///
/// Hand-rolled rather than `to_lower().has_suffix(...)`: core's `to_lower`
/// compiles in a runtime charset builder (over 4KB of generated code) for the
/// sake of one call, and module paths are ASCII in practice.
fn ends_with_moon_mod(s : String) -> Bool {
  let suffix = "/moon.mod"
  let m = suffix.length()
  let n = s.length()
  if n < m {
    return false
  }
  for i in 0..<m {
    let a = s[n - m + i]
    let b = suffix[i]
    let eq = a == b || (a >= 65 && a <= 90 && a + 32 == b)
    if !eq {
      return false
    }
  }
  true
}

///|
/// Converts the `moon_mod_filepath` parameter into the directory passed to
/// `moon -C <DIR>`: strips a trailing `/moon.mod` and resolves to an absolute
/// path. Accepts the bare directory too, so a model that already stripped the
/// filename still works.
fn moon_mod_dir(moon_mod_filepath : String) -> Result[String, String] {
  let trimmed = moon_mod_filepath.trim().to_owned()
  if trimmed == "" {
    return Err(
      "moon_mod_filepath is required — pass the absolute path of the module's " +
      "moon.mod file (e.g. '/home/me/proj/moon.mod').",
    )
  }
  if !@path.isAbsolute(trimmed) {
    return Err(
      "moon_mod_filepath must be an absolute path; got '" +
      moon_mod_filepath +
      "'. Pass the absolute path of the module's moon.mod file.",
    )
  }
  let stripped = if ends_with_moon_mod(trimmed) {
    trimmed[:trimmed.length() - 9].to_owned()
  } else {
    trimmed
  }
  Ok(@path.resolve([stripped]))
}

///|
/// Verifies the directory derived from `moon_mod_filepath` actually is a
/// MoonBit module (exists, is a directory, contains moon.mod). Returns a short
/// reason string when invalid.
///
/// This check lives here because without it moon produces misleading results:
/// a nonexistent dir errors with a cryptic "failed to change directory", and
/// `moon ide` against a directory without a moon.mod misleadingly reports
/// "No symbols found matching 'X'".
fn invalid_moon_mod_dir_reason(dir : String) -> String? {
  if !@fs.existsSync(dir) {
    return Some(
      "moon_mod_filepath points to a nonexistent location: " +
      dir +
      ". Pass the absolute path of the module's moon.mod file (e.g. '/home/me/proj/moon.mod').",
    )
  }
  let stat : Result[@fs.Stat, @js_core.ThrowError] = Ok(@fs.statSync(dir)) catch {
    e => Err(e)
  }
  match stat {
    Err(_) =>
      Some(
        "moon_mod_filepath is not a directory: " +
        dir +
        ". Pass the absolute path of the module's moon.mod file (e.g. '/home/me/proj/moon.mod').",
      )
    Ok(s) =>
      if !s.isDirectory() {
        Some(
          "moon_mod_filepath is not a directory: " +
          dir +
          ". Pass the absolute path of the module's moon.mod file (e.g. '/home/me/proj/moon.mod').",
        )
      } else if !@fs.existsSync(@path.join2(dir, "moon.mod")) {
        Some(
          "No moon.mod found in " +
          dir +
          ". moon_mod_filepath must be the absolute path of a MoonBit module's moon.mod file " +
          "(e.g. '/home/me/proj/moon.mod'), not a directory without one or a workspace subdir.",
        )
      } else {
        None
      }
  }
}

///|
/// One-call resolve + validate for tool `execute` bodies. On failure the tool
/// returns `invalid_moon_mod_result` so the model gets an actionable message
/// rather than a cryptically failed run.
fn validated_moon_mod_dir(moon_mod_filepath : String) -> Result[String, String] {
  match moon_mod_dir(moon_mod_filepath) {
    Err(e) => Err(e)
    Ok(d) =>
      match invalid_moon_mod_dir_reason(d) {
        Some(reason) => Err(reason)
        None => Ok(d)
      }
  }
}

///|
/// Builds the standard failed tool result for an invalid `moon_mod_filepath`.
fn invalid_moon_mod_result(
  moon_mod_filepath : String,
  reason : String,
) -> @pi.AgentToolResult[@pi.JSValue] {
  let text = "Invalid moon_mod_filepath: '" +
    moon_mod_filepath +
    "'.\n" +
    reason +
    "\nFix the parameter and call this tool again. Do not guess a moon.mod path — " +
    "locate the module's moon.mod on disk first."
  tool_result(
    text,
    failure_details([
      ("ok", @pi.JSValue::from_bool(false)),
      ("error", @pi.JSValue::from_string(reason)),
      ("moon_mod_filepath", @pi.JSValue::from_string(moon_mod_filepath)),
    ]),
  )
}

// --- shared tool-definition helpers ----------------------------------------

///|
/// Builds a JSON-schema string property.
fn string_schema(description : String) -> @pi.JSValue {
  js_object([
    ("type", @pi.JSValue::from_string("string")),
    ("description", @pi.JSValue::from_string(description)),
  ])
}

///|
/// Builds a JSON-schema boolean property.
fn boolean_schema(description : String) -> @pi.JSValue {
  js_object([
    ("type", @pi.JSValue::from_string("boolean")),
    ("description", @pi.JSValue::from_string(description)),
  ])
}

///|
/// Builds a JSON array of strings as a JS value.
fn string_array(items : Array[String]) -> @pi.JSValue {
  let values : Array[@pi.JSValue] = []
  for item in items {
    values.push(@pi.JSValue::from_string(item))
  }
  @pi.JSValue::from_array(values[:].to_array())
}

///|
/// The shared `moon_mod_filepath` parameter schema. Every tool except
/// `moon_explain_error` takes it: it identifies WHICH MoonBit module to
/// operate on, and is converted to a `moon -C <DIR>` working directory.
fn moon_mod_filepath_schema() -> @pi.JSValue {
  string_schema(
    "Absolute path to the module's moon.mod file, e.g. '/home/me/proj/moon.mod'. " +
    "Identifies the MoonBit module this call operates on; all relative paths in other " +
    "parameters are resolved against its directory.",
  )
}

///|
/// The `loc` parameter schema: a `path[:line[:col]]` location, 1-based.
fn loc_schema(description : String) -> @pi.JSValue {
  string_schema(description)
}

// --- `moon ide` runner ------------------------------------------------------

///|
/// The outcome of running one `moon ide` subcommand. Mirrors `MoonIdeResult`
/// from the TypeScript `shared.ts`.
priv struct IdeResult {
  ok : Bool
  /// Pretty-printed JSON when stdout parsed, otherwise `None`.
  json : String?
  raw : String
  stderr : String
  aborted : Bool
}

///|
/// Best-effort parse of `moon ide` stdout as JSON. Returns the pretty-printed
/// text, or `None` when stdout is empty or not valid JSON.
///
/// Subcommands that do not support `--json` return plain text: the parse
/// fails and the caller falls back to the raw text. `throwable` is required
/// because MoonBit `try` does not catch JavaScript exceptions, and
/// `JSON.parse` raises on invalid input.
fn try_pretty_json(stdout : String) -> String? {
  let trimmed = stdout.trim().to_owned()
  if trimmed == "" {
    return None
  }
  let parsed : Result[@js_core.Any, @js_core.ThrowError] = Ok(
    @js_core.throwable(fn() { @js_core.json_parse(trimmed) }),
  ) catch {
    e => Err(e)
  }
  match parsed {
    Ok(v) => Some(@js_core.json_stringify_pretty(v, 2))
    Err(_) => None
  }
}

///|
/// Runs `moon ide <args>` and shapes the result, parsing stdout as JSON when
/// possible.
///
/// `moon ide <subcommand>` runs a project check under the hood, so it gets a
/// generous-but-bounded timeout; the caller's AbortSignal still wins.
fn run_moon_ide(
  pi : @pi.ExtensionAPI,
  args : Array[String],
  dir : String,
  signal : @pi.AbortSignal?,
) -> @pi.Promise[IdeResult] {
  let full_args : Array[String] = ["ide"]
  full_args.append(args[:])
  @pi.Promise::from_async(async fn() {
    if is_aborted(signal) {
      return { ok: false, json: None, raw: "", stderr: "", aborted: true, }
    }
    let result = run_moon(pi, full_args, dir, signal, ide_timeout_ms).wait()
    {
      ok: result.code == 0.0 && !result.killed,
      json: try_pretty_json(result.stdout),
      raw: result.stdout,
      stderr: result.stderr,
      aborted: result.killed && is_aborted(signal),
    }
  })
}

///|
/// Shapes an `IdeResult` into a tool result. Mirrors `toContent` from the
/// TypeScript `shared.ts`: the parsed JSON is preferred over the raw text, a
/// failed run is surfaced with its stderr and flagged as an error.
fn ide_to_content(result : IdeResult) -> @pi.AgentToolResult[@pi.JSValue] {
  if result.aborted {
    return aborted_result()
  }
  let raw = result.raw.trim().to_owned()
  let body = match result.json {
    Some(json) => json
    None => if raw != "" { raw } else { "(no stdout)" }
  }
  if result.ok {
    tool_result(
      truncate(body),
      js_object([
        ("ok", @pi.JSValue::from_bool(true)),
        ("stderr", @pi.JSValue::from_string(result.stderr)),
      ]),
    )
  } else {
    tool_result(
      truncate(
        "moon ide failed.\nstdout: " + body + "\nstderr: " + result.stderr,
      ),
      failure_details([
        ("ok", @pi.JSValue::from_bool(false)),
        ("stderr", @pi.JSValue::from_string(result.stderr)),
      ]),
    )
  }
}

///|
/// Registers a tool definition with the harness.
///
/// The definition is assembled as a plain JavaScript object and passed to the
/// harness `registerTool` method directly. The generated MoonBit
/// `registerTool` binding forwards the MoonBit `ToolDefinition` struct as-is,
/// which would leave boxed-`Option` fields such as `promptGuidelines` in the
/// shape `{ _0: [...] }`; pi's prompt builder iterates that value, so it must
/// arrive as a real array.
fn register_tool(pi : @pi.ExtensionAPI, definition : @pi.JSValue) -> Unit {
  let pi_any : @js_core.Any = @js_core.identity(pi)
  let _ = pi_any._call(
    "registerTool",
    FixedArray::from_array([@js_core.identity(definition)]),
  )
}
