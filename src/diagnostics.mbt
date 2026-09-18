// `moon check` diagnostics: NDJSON parsing and dependency-vs-module
// ownership partitioning.
//
// `moon check --output-json` emits one diagnostic object per line (NDJSON)
// and exits non-zero whenever there are diagnostics — that is normal, not a
// spawn failure. `moon check` reports diagnostics for the whole module AND
// its workspace siblings / mooncake dependencies. Warnings from code the
// model did not write (.mooncakes/..., moon.work siblings) are noise that
// drowns the signal and invites "fixes" in files the model should never
// touch, so `moon_check` partitions diagnostics by ownership and hides
// dependency *warnings* by default. Dependency *errors* are always shown:
// they break the build regardless of who owns the file. `includeDeps: true`
// on the tool is the escape hatch.
//
// This mirrors `extensions/diagnostics.ts`.

///|
/// One `moon check --output-json` diagnostic line. All fields except the
/// message type are optional, so each is read defensively.
pub(all) struct CheckDiagnostic {
  level : String?
  error_code : Int?
  path : String?
  loc : String?
  message : String?
  context : String?
}

///|
/// The mooncakes installation segment that marks a dependency path.
let mooncakes_segment : String = "/.mooncakes/"

///|
/// Reads a JSON field as a string; `None` when absent or null.
fn json_string(obj : @js_core.Any, key : String) -> String? {
  let v = obj._get(key)
  if @js_core.is_nullish(v) {
    None
  } else {
    Some(v.cast())
  }
}

///|
/// Reads a JSON field as an integer; `None` when absent, null, or not a
/// number. JSON numbers arrive as `Double`, so non-integral values are
/// rejected rather than silently truncated.
fn json_int(obj : @js_core.Any, key : String) -> Int? {
  let v = obj._get(key)
  if @js_core.is_nullish(v) {
    None
  } else {
    let d : Double = v.cast()
    if d == d.floor() {
      Some(d.to_int())
    } else {
      None
    }
  }
}

///|
/// Parses one NDJSON line. Returns `Some` for a diagnostic object
/// (`$message_type == "diagnostic"`) and `None` for a valid JSON line that is
/// not a diagnostic.
fn parse_diagnostic_line(line : String) -> CheckDiagnostic? {
  let parsed : Result[@js_core.Any, @js_core.ThrowError] = Ok(
    @js_core.throwable(fn() { @js_core.json_parse(line) }),
  ) catch {
    e => Err(e)
  }
  match parsed {
    Err(_) => None
    Ok(obj) => {
      let message_type : String = obj._get("$message_type").cast()
      if message_type != "diagnostic" {
        return None
      }
      Some({
        level: json_string(obj, "level"),
        error_code: json_int(obj, "error_code"),
        path: json_string(obj, "path"),
        loc: json_string(obj, "loc"),
        message: json_string(obj, "message"),
        context: json_string(obj, "context"),
      })
    }
  }
}

///|
/// Parses the NDJSON on stdout into diagnostics plus any lines that could not
/// be parsed. Non-diagnostic JSON lines are kept as unparsed so nothing is
/// silently dropped.
pub fn parse_check_output(
  stdout : String,
) -> (Array[CheckDiagnostic], Array[String]) {
  let diagnostics : Array[CheckDiagnostic] = []
  let unparsed : Array[String] = []
  for line in stdout.split("\n") {
    let trimmed = line.trim().to_owned()
    if trimmed == "" {
      continue
    }
    // Non-diagnostic JSON lines are kept as unparsed so nothing is silently
    // dropped; malformed lines are indistinguishable from them here.
    match parse_diagnostic_line(trimmed) {
      Some(d) => diagnostics.push(d)
      None => unparsed.push(trimmed)
    }
  }
  (diagnostics, unparsed)
}

///|
/// Whether a diagnostic's file belongs to a dependency rather than the module
/// under test.
///
/// The ownership boundary is the module directory derived from the tool's
/// required `moon_mod_filepath` parameter. Everything outside it is a
/// dependency — including `moon.work` sibling members (e.g. `../crescent`),
/// which the agent working in this module should not edit even though the
/// workspace links them.
pub fn is_dependency_path(file_path : String, module_root : String) -> Bool {
  if file_path.contains(mooncakes_segment) {
    return true
  }
  if module_root == "" {
    // Fail open: without a boundary, show everything.
    return false
  }
  let abs = if @path.isAbsolute(file_path) {
    file_path
  } else {
    @path.resolve([module_root, file_path])
  }
  let sep = @path.sep()
  !(abs == module_root || abs.has_prefix(module_root + sep))
}

///|
/// Short origin label for a dependency diagnostic, used in the hidden-summary
/// line: `bobzhang/crescent` for mooncakes, the sibling module/dir name
/// otherwise (resolved against the module root's parent, which is where
/// moon.work sibling members live).
pub fn dependency_origin(file_path : String, module_root : String) -> String {
  match file_path.find(mooncakes_segment) {
    Some(idx) => {
      let rest = file_path[idx + mooncakes_segment.length():].to_owned()
      let parts = rest.split("/").to_array()
      let n = if parts.length() >= 2 { 2 } else { parts.length() }
      let out = StringBuilder()
      for i = 0; i < n; i = i + 1 {
        if i > 0 {
          out.write_string("/")
        }
        out.write_string(parts[i].to_owned())
      }
      out.to_string()
    }
    None => {
      let base = if module_root != "" {
        @path.dirname(module_root)
      } else {
        @path.dirname(file_path)
      }
      let sep = @path.sep()
      let rel = if @path.isAbsolute(file_path) &&
        file_path.has_prefix(base + sep) {
        file_path[base.length() + 1:].to_owned()
      } else {
        file_path
      }
      let parts = rel.split("/").to_array()
      if parts.length() > 0 && parts[0].to_owned() != "" {
        parts[0].to_owned()
      } else {
        @path.basename(@path.dirname(file_path))
      }
    }
  }
}

///|
/// Splits diagnostics into those owned by the module and those owned by
/// dependencies.
pub fn partition_diagnostics(
  diagnostics : Array[CheckDiagnostic],
  module_root : String,
) -> (Array[CheckDiagnostic], Array[CheckDiagnostic]) {
  let workspace : Array[CheckDiagnostic] = []
  let dependency : Array[CheckDiagnostic] = []
  for d in diagnostics {
    let path_val = d.path
    if path_val is Some(p) && is_dependency_path(p, module_root) {
      dependency.push(d)
    } else {
      workspace.push(d)
    }
  }
  (workspace, dependency)
}

///|
/// `"crescent: 12, dotenv-mbt: 4"` style summary for the hidden-warnings line.
pub fn hidden_dep_summary(
  diagnostics : Array[CheckDiagnostic],
  module_root : String,
) -> String {
  let origins : Array[String] = []
  let counts : Array[Int] = []
  for d in diagnostics {
    let origin = dependency_origin(d.path.unwrap_or(""), module_root)
    match origins.search(origin) {
      Some(i) => counts[i] = counts[i] + 1
      None => {
        origins.push(origin)
        counts.push(1)
      }
    }
  }
  let parts : Array[String] = []
  for i = 0; i < origins.length(); i = i + 1 {
    parts.push(origins[i] + ": " + counts[i].to_string())
  }
  parts.join(", ")
}
