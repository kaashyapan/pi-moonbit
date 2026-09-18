// The `moon_check` tool: static analysis with NDJSON parsing, level-count
// summarization, and dependency-vs-module ownership filtering.
//
// This mirrors `extensions/check-tool.ts`.
//
// The tool always checks against an explicit backend target. moon's default
// target resolution (moon.pkg preferred_target / platform default) makes
// results environment-dependent, which the model cannot reason about, so the
// caller's `target` is used when present and wasm-gc otherwise.

///|
/// Checks the module with `moon check --output-json`, then summarizes the
/// diagnostics.
fn check_execute(
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
      let target = json_string(params_any, "target").unwrap_or("wasm-gc")
      let package_arg = json_string(params_any, "package")
      let include_deps = match params_any._get("includeDeps") {
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

      let args : Array[String] = ["check", "--output-json", "--target", target]
      match package_arg {
        Some(p) => args.append(["-p", p][:])
        None => ()
      }
      let result = run_moon(pi, args, dir, signal, default_timeout_ms).wait()

      if result.killed {
        return tool_result(
          "moon check timed out after " +
          (default_timeout_ms / 1000.0).to_string() +
          "s (cold workspaces and large .mooncakes dependency trees can exceed the default budget; retry — warm runs are much faster).",
          failure_details([
            ("ok", @pi.JSValue::from_bool(false)),
            ("timedOut", @pi.JSValue::from_bool(true)),
          ]),
        )
      }

      let (diagnostics, unparsed) = parse_check_output(result.stdout)
      // The module dir passed via -C is the ownership boundary; no need to
      // walk up from the session cwd (the model may sit outside the module).
      let (workspace, dependency) = partition_diagnostics(diagnostics, dir)

      let ws = by_level(workspace)
      let dep = by_level(dependency)

      let total_errors = ws.errors.length() + dep.errors.length()
      let total_warnings = ws.warnings.length() + dep.warnings.length()
      let total_other = ws.other.length() + dep.other.length()

      let lines : Array[String] = []
      let hidden_dep_warnings = if include_deps { [] } else { dep.warnings }
      if total_errors + total_warnings + total_other == 0 &&
        unparsed.length() == 0 {
        lines.push(
          if hidden_dep_warnings.length() > 0 {
            "No errors or warnings in the module."
          } else {
            "No errors or warnings."
          },
        )
      } else {
        let summary = total_errors.to_string() +
          " error(s), " +
          total_warnings.to_string() +
          " warning(s)"
        let other = if total_other > 0 {
          ", " + total_other.to_string() + " other"
        } else {
          ""
        }
        let hidden = if hidden_dep_warnings.length() > 0 {
          " " +
          hidden_dep_warnings.length().to_string() +
          " dependency warning(s) hidden (" +
          hidden_dep_summary(hidden_dep_warnings, dir) +
          ")."
        } else {
          ""
        }
        lines.push(summary + other + "." + hidden)
      }

      // Module diagnostics first, then dependency diagnostics (errors always
      // visible; warnings only with includeDeps).
      for d in ws.errors {
        lines.push(render_diagnostic(d, ""))
      }
      for d in ws.warnings {
        lines.push(render_diagnostic(d, ""))
      }
      for d in ws.other {
        lines.push(render_diagnostic(d, ""))
      }
      for d in dep.errors {
        lines.push(render_diagnostic(d, "dependency "))
      }
      if include_deps {
        for d in dep.warnings {
          lines.push(render_diagnostic(d, "dependency "))
        }
        for d in dep.other {
          lines.push(render_diagnostic(d, "dependency "))
        }
      }

      if unparsed.length() > 0 {
        lines.push(
          "\n[" +
          unparsed.length().to_string() +
          " unparsed line(s) from moon check]",
        )
        let limit = if unparsed.length() < 20 { unparsed.length() } else { 20 }
        for i = 0; i < limit; i = i + 1 {
          lines.push(unparsed[i])
        }
      }
      let stderr = result.stderr.trim().to_owned()
      if stderr != "" {
        lines.push("\nstderr: " + stderr)
      }

      let body = truncate(lines.join("\n"))
      let details_pairs : Array[(String, @pi.JSValue)] = [
        ("ok", @pi.JSValue::from_bool(true)),
        ("target", @pi.JSValue::from_string(target)),
        ("errorCount", @pi.JSValue::from_int(total_errors)),
        ("warningCount", @pi.JSValue::from_int(ws.warnings.length())),
        ("depErrorCount", @pi.JSValue::from_int(dep.errors.length())),
        ("depWarningCount", @pi.JSValue::from_int(dep.warnings.length())),
        ("includeDeps", @pi.JSValue::from_bool(include_deps)),
        ("hasErrors", @pi.JSValue::from_bool(total_errors > 0)),
      ]
      let details = if total_errors > 0 {
        failure_details(details_pairs)
      } else {
        js_object(details_pairs)
      }
      tool_result(body, details)
    })
  }
}

///|
/// Diagnostics split by level.
priv struct ByLevel {
  errors : Array[CheckDiagnostic]
  warnings : Array[CheckDiagnostic]
  other : Array[CheckDiagnostic]
}

///|
/// Groups diagnostics into errors, warnings, and everything else.
fn by_level(ds : Array[CheckDiagnostic]) -> ByLevel {
  let errors : Array[CheckDiagnostic] = []
  let warnings : Array[CheckDiagnostic] = []
  let other : Array[CheckDiagnostic] = []
  for d in ds {
    match d.level {
      Some("error") => errors.push(d)
      Some("warning") => warnings.push(d)
      _ => other.push(d)
    }
  }
  { errors, warnings, other, }
}

///|
/// Renders one diagnostic in the same `[level code] path:loc` form the
/// TypeScript tool uses.
fn render_diagnostic(d : CheckDiagnostic, tag : String) -> String {
  let level = d.level.unwrap_or("?")
  let code = match d.error_code {
    Some(c) => " " + c.to_string()
    None => ""
  }
  let path = d.path.unwrap_or("?")
  let loc = match d.loc {
    Some(l) => ":" + l
    None => ""
  }
  let message = d.message.unwrap_or("")
  let context = match d.context {
    Some(c) => "\n" + c
    None => ""
  }
  "\n[" + tag + level + code + "] " + path + loc + "\n" + message + context
}

///|
/// Registers the `moon_check` tool with the harness.
pub fn register_check_tool(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(check_execute(pi))
  let parameters : @pi.JSValue = @js_core.identity(check_schema())
  let definition = js_object([
    ("name", @pi.JSValue::from_string("moon_check")),
    ("label", @pi.JSValue::from_string("MoonBit: Check (static analysis)")),
    (
      "description",
      @pi.JSValue::from_string(
        "Static analysis for MoonBit source — type and syntax checking without a full build. " +
        "Do NOT run `moon check` via bash for this; call this tool instead. It parses the NDJSON " +
        "output, filters out dependency noise, and returns structured error/warning counts that " +
        "raw bash output does not give you. Run this after every source edit, before moon_test — " +
        "it's cheaper than a full build and catches errors earlier. Dependency warnings (workspace " +
        "siblings, .mooncakes) are hidden behind a count by default; dependency errors always show. " +
        "Checked against an explicit backend target (default wasm-gc) so results are reproducible.",
      ),
    ),
    (
      "promptSnippet",
      @pi.JSValue::from_string(
        "moon_check replaces `moon check` — always prefer it over running the command in bash.",
      ),
    ),
    (
      "promptGuidelines",
      string_array([
        "Use this tool, not bash, for `moon check`.", "Typical sequence: edit source -> moon_check -> moon_test -> moon_fmt_info before handoff.",
        "Pass `target` only when the result must match a specific backend other than wasm-gc.",
        "Pass `includeDeps: true` only if you need to see hidden dependency warnings, not by default.",
      ]),
    ),
    ("parameters", parameters),
    ("execute", execute),
  ])
  register_tool(pi, definition)
}

///|
/// The `parameters` schema for `moon_check`: a required `moon_mod_filepath`
/// plus optional `target`, `package`, and `includeDeps`.
fn check_schema() -> @pi.TSchema {
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "target",
      string_schema(
        "Backend target passed to moon check --target: 'wasm', 'wasm-gc' (default), 'js', 'native', 'llvm', or 'all'. Results can differ per target, so pass the target you will test/build with when it matters.",
      ),
    ),
    (
      "package",
      string_schema(
        "Limit the check to a specific package, passed as -p <package>.",
      ),
    ),
    (
      "includeDeps",
      boolean_schema(
        "Include diagnostics from dependency code (workspace sibling modules, .mooncakes). Default false — dependency warnings are hidden behind a count; dependency errors are always shown.",
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
