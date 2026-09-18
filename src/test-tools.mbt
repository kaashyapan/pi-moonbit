// The verify/finalize tools: `moon_test` and `moon_fmt_info`.
//
// This mirrors `extensions/test-tools.ts`.
//
// For `moon_test`, a non-zero exit is normal (failed tests). Only a spawn
// failure is a spawn-level error; failed tests are still flagged via
// `failure_flag` so the model treats them as "fix this".
//
// `moon_fmt_info` combines the standard handoff sequence: `moon fmt`
// (rewrites source in place) then `moon info` (regenerates .mbti interface
// files — review their diff). info only runs when fmt succeeded.

///|
/// Runs `moon test` against an explicit target and reports pass/fail.
fn test_execute(
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
      // Always test against an explicit target (default wasm-gc), mirroring
      // moon_check — otherwise moon resolves the target from moon.pkg /
      // platform defaults and check vs test results can silently disagree.
      let target = json_string(params_any, "target").unwrap_or("wasm-gc")
      let package_arg = json_string(params_any, "package")
      let update = match params_any._get("update") {
        v =>
          if @js_core.is_nullish(v) {
            false
          } else {
            let b : Bool = v.cast()
            b
          }
      }
      let moon_mod_filepath = params_any._get("moon_mod_filepath").cast()

      if is_aborted(signal) {
        return aborted_result()
      }

      let mod = validated_moon_mod_dir(moon_mod_filepath)
      match mod {
        Err(reason) => return invalid_moon_mod_result(moon_mod_filepath, reason)
        Ok(_) => ()
      }
      let dir = match mod {
        Ok(d) => d
        Err(_) => ""
      }

      let args : Array[String] = ["test", "--target", target]
      match package_arg {
        Some(p) => args.append(["-p", p][:])
        None => ()
      }
      if update {
        args.push("--update")
      }
      let result = run_moon(pi, args, dir, signal, test_timeout_ms).wait()

      if result.killed {
        return tool_result(
          "moon test timed out after " +
          (test_timeout_ms / 1000.0).to_string() +
          "s.",
          failure_details([
            ("ok", @pi.JSValue::from_bool(false)),
            ("timedOut", @pi.JSValue::from_bool(true)),
          ]),
        )
      }

      let failed = result.code != 0.0
      let stdout = result.stdout.trim().to_owned()
      let stderr = result.stderr.trim().to_owned()
      let body = (if failed {
          "Tests failed (exit " + result.code.to_string() + ")."
        } else {
          "Tests passed."
        }) +
        (if stdout != "" { "\n" + stdout } else { "" }) +
        (if stderr != "" { "\nstderr:\n" + stderr } else { "" })

      let details_pairs : Array[(String, @pi.JSValue)] = [
        ("ok", @pi.JSValue::from_bool(!failed)),
        ("target", @pi.JSValue::from_string(target)),
        ("exitCode", @pi.JSValue::from_double(result.code)),
      ]
      let details = if failed {
        failure_details(details_pairs)
      } else {
        js_object(details_pairs)
      }
      tool_result(truncate(body), details)
    })
  }
}

///|
/// Runs `moon fmt` then `moon info` as one handoff step. `info` is skipped
/// when `fmt` fails, since formatting must succeed before interfaces are
/// regenerated.
fn fmt_info_execute(
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
      let package_arg = json_string(params_any, "package")
      let moon_mod_filepath = params_any._get("moon_mod_filepath").cast()

      if is_aborted(signal) {
        return aborted_result()
      }

      let mod = validated_moon_mod_dir(moon_mod_filepath)
      match mod {
        Err(reason) => return invalid_moon_mod_result(moon_mod_filepath, reason)
        Ok(_) => ()
      }
      let dir = match mod {
        Ok(d) => d
        Err(_) => ""
      }

      let sections : Array[String] = []

      // 1) moon fmt
      let fmt = run_moon(pi, ["fmt"], dir, signal, default_timeout_ms).wait()
      if fmt.killed {
        return tool_result(
          "moon fmt timed out after " +
          (default_timeout_ms / 1000.0).to_string() +
          "s.",
          failure_details([
            ("ok", @pi.JSValue::from_bool(false)),
            ("step", @pi.JSValue::from_string("fmt")),
            ("timedOut", @pi.JSValue::from_bool(true)),
          ]),
        )
      }
      sections.push("## moon fmt (exit " + fmt.code.to_string() + ")")
      let fmt_stdout = fmt.stdout.trim().to_owned()
      sections.push(if fmt_stdout != "" { fmt_stdout } else { "(no stdout)" })
      let fmt_stderr = fmt.stderr.trim().to_owned()
      if fmt_stderr != "" {
        sections.push("stderr:\n" + fmt_stderr)
      }

      if fmt.code != 0.0 {
        return tool_result(
          truncate(
            sections.join("\n") + "\n\nmoon fmt failed; skipping moon info.",
          ),
          failure_details([
            ("ok", @pi.JSValue::from_bool(false)),
            ("step", @pi.JSValue::from_string("fmt")),
            ("exitCode", @pi.JSValue::from_double(fmt.code)),
          ]),
        )
      }

      // 2) moon info
      let info_args : Array[String] = ["info"]
      match package_arg {
        Some(p) => info_args.append(["-p", p][:])
        None => ()
      }
      let info = run_moon(pi, info_args, dir, signal, default_timeout_ms).wait()
      if info.killed {
        return tool_result(
          truncate(
            sections.join("\n") +
            "\n\n## moon info\nTimed out after " +
            (default_timeout_ms / 1000.0).to_string() +
            "s.",
          ),
          failure_details([
            ("ok", @pi.JSValue::from_bool(false)),
            ("step", @pi.JSValue::from_string("info")),
            ("timedOut", @pi.JSValue::from_bool(true)),
          ]),
        )
      }
      sections.push("## moon info (exit " + info.code.to_string() + ")")
      let info_stdout = info.stdout.trim().to_owned()
      sections.push(if info_stdout != "" { info_stdout } else { "(no stdout)" })
      let info_stderr = info.stderr.trim().to_owned()
      if info_stderr != "" {
        sections.push("stderr:\n" + info_stderr)
      }

      let ok = info.code == 0.0
      let details_pairs : Array[(String, @pi.JSValue)] = [
        ("ok", @pi.JSValue::from_bool(ok)),
        ("fmtExit", @pi.JSValue::from_double(fmt.code)),
        ("infoExit", @pi.JSValue::from_double(info.code)),
      ]
      let details = if ok {
        js_object(details_pairs)
      } else {
        failure_details(details_pairs)
      }
      tool_result(truncate(sections.join("\n")), details)
    })
  }
}

///|
/// Registers `moon_test` and `moon_fmt_info` with the harness.
pub fn register_test_tools(pi : @pi.ExtensionAPI) -> Unit {
  register_moon_test(pi)
  register_moon_fmt_info(pi)
}

///|
/// Registers the `moon_test` tool.
fn register_moon_test(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(test_execute(pi))
  let definition = js_object([
    ("name", @pi.JSValue::from_string("moon_test")),
    ("label", @pi.JSValue::from_string("MoonBit: Test")),
    (
      "description",
      @pi.JSValue::from_string(
        "Do NOT run `moon test` via bash — call this tool instead. " +
        "Failures are reported with isError: true, so treat them as something to fix. " +
        "If you edited files across multiple packages, run one moon_test call per package, " +
        "or omit package to test everything if unsure. Always prefer specifying the package that has changed.",
      ),
    ),
    (
      "promptSnippet",
      @pi.JSValue::from_string(
        "moon_test replaces `moon test` — run moon_check first, then this, against a consistent target.",
      ),
    ),
    (
      "promptGuidelines",
      string_array([
        "Use this tool, not bash, to run tests.", "Run moon_check first — cheaper, and catches errors that would fail every test anyway.",
        "Run against one target at a time; pass the same target you used for moon_check.",
        "Scope with `package` to the package(s) you actually edited, rather than testing the whole module by default.",
      ]),
    ),
    ("parameters", @js_core.identity(test_schema())),
    ("execute", execute),
  ])
  register_tool(pi, definition)
}

///|
/// Registers the `moon_fmt_info` tool.
fn register_moon_fmt_info(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(fmt_info_execute(pi))
  let definition = js_object([
    ("name", @pi.JSValue::from_string("moon_fmt_info")),
    ("label", @pi.JSValue::from_string("MoonBit: Format + Info")),
    (
      "description",
      @pi.JSValue::from_string(
        "MoonBit: Format - Formats source in place, then regenerates public interface (.mbti) files. " +
        "Run this after edits are done and moon_check is clean, not mid-edit.",
      ),
    ),
    ("parameters", @js_core.identity(fmt_info_schema())),
    ("execute", execute),
  ])
  register_tool(pi, definition)
}

///|
/// The `parameters` schema for `moon_test`: required `moon_mod_filepath` plus
/// optional `target`, `package`, and `update`.
fn test_schema() -> @pi.TSchema {
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "target",
      string_schema(
        "Backend target passed to moon test --target: 'wasm', 'wasm-gc' (default), 'js', 'native', 'llvm', or 'all'. Keep it consistent with the moon_check target so the two agree.",
      ),
    ),
    ("package", string_schema("Package to be tested (-p <package>).")),
    (
      "update",
      boolean_schema(
        "If true, pass --update to refresh snapshot tests. Defaults to false — only set when intentionally updating snapshots.",
      ),
    ),
  ])
  @js_core.identity(
    js_object([
      ("type", @pi.JSValue::from_string("object")),
      ("properties", properties),
      ("required", string_array(["moon_mod_filepath"])),
    ]),
  )
}

///|
/// The `parameters` schema for `moon_fmt_info`: required `moon_mod_filepath`
/// plus an optional `package` scope for `moon info`.
fn fmt_info_schema() -> @pi.TSchema {
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "package",
      string_schema(
        "Optional package scope for moon info (-p <package>). fmt always runs module-wide.",
      ),
    ),
  ])
  @js_core.identity(
    js_object([
      ("type", @pi.JSValue::from_string("object")),
      ("properties", properties),
      ("required", string_array(["moon_mod_filepath"])),
    ]),
  )
}
