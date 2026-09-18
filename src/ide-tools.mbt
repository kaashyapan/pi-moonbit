// The `moon ide` navigation tools: peek-def, find-references, hover,
// outline, rename, analyze, doc.
//
// This mirrors `extensions/ide-tools.ts`.
//
// Every tool runs the underlying project check: the ide subcommands read
// their symbol/type index from prior check state (_build/), and running them
// without it produces silently wrong results — e.g. peek-def reports
// "No symbols found matching 'X'" for symbols that exist on a cold module.
//
// `moon ide` subcommands differ in --json support: on moon 0.1.20260904 only
// peek-def, find-references and hover accept it, while outline, doc, analyze
// and rename reject it ("unknown option"). So each tool passes --json only
// where the subcommand allows it; `run_moon_ide` still tries to parse JSON
// and falls back to the raw text otherwise.

///|
/// Shared parameter descriptions.
let loc_param_description : String = "Source location as path[:line[:col]], 1-based, e.g. './main.mbt:8:7'. Required; optional elsewhere as a disambiguation hint when the symbol name alone is ambiguous."

///|
/// Reads an optional string parameter from the raw tool arguments.
fn opt_param(params : @js_core.Any, key : String) -> String? {
  let v = params._get(key)
  if @js_core.is_nullish(v) {
    None
  } else {
    let s : String = v.cast()
    if s == "" {
      None
    } else {
      Some(s)
    }
  }
}

///|
/// The common `execute` prologue: resolve and validate the module dir, then
/// run one `moon ide` invocation. Returns a tool result either way.
fn run_ide_tool(
  pi : @pi.ExtensionAPI,
  args : Array[String],
  moon_mod_filepath : String,
  signal : @pi.AbortSignal?,
) -> @pi.Promise[@pi.AgentToolResult[@pi.JSValue]] {
  @pi.Promise::from_async(async fn() {
    if is_aborted(signal) {
      return aborted_result()
    }
    match validated_moon_mod_dir(moon_mod_filepath) {
      Err(reason) => invalid_moon_mod_result(moon_mod_filepath, reason)
      Ok(dir) => ide_to_content(run_moon_ide(pi, args, dir, signal).wait())
    }
  })
}

///|
/// Builds the `execute` closure for an ide tool that takes `symbol` and `loc`,
/// with the given subcommand and whether the subcommand accepts `--json`.
fn symbol_loc_execute(
  pi : @pi.ExtensionAPI,
  subcommand : String,
  extra_flags : Array[String],
) -> (
  String,
  @pi.Static,
  @pi.AbortSignal?,
  @pi.AgentToolUpdateCallback?,
  @pi.ExtensionContext,
) -> @pi.Promise[@pi.AgentToolResult[@pi.JSValue]] {
  fn(_tool_call_id, params, signal, _on_update, _ctx) {
    let params_any : @js_core.Any = @js_core.identity(params)
    let moon_mod_filepath = params_any._get("moon_mod_filepath").cast()
    let args : Array[String] = [subcommand]
    match opt_param(params_any, "symbol") {
      Some(s) => args.push(s)
      None => ()
    }
    args.append(extra_flags[:])
    match opt_param(params_any, "loc") {
      Some(l) => args.append(["--loc", l][:])
      None => ()
    }
    run_ide_tool(pi, args, moon_mod_filepath, signal)
  }
}

// --- tool registrations ----------------------------------------------------

///|
/// Registers all seven `moon ide` navigation tools.
pub fn register_ide_tools(pi : @pi.ExtensionAPI) -> Unit {
  register_peek_def(pi)
  register_find_references(pi)
  register_type_info(pi)
  register_outline(pi)
  register_rename(pi)
  register_analyze(pi)
  register_doc(pi)
  register_workspace_symbols(pi)
}

///|
/// `moon_peek_def`: resolve a symbol's definition with source context.
fn register_peek_def(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(
    symbol_loc_execute(pi, "peek-def", ["--json"]),
  )
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "symbol",
      string_schema("Symbol query, e.g. 'foo', '@pkg.foo', 'Type::member'."),
    ),
    ("loc", loc_schema(loc_param_description)),
  ])
  register_tool(
    pi,
    ide_tool_definition(
      "moon_peek_def",
      "MoonBit: Peek Definition",
      "Resolve a MoonBit symbol's definition with source context. Do NOT run `moon ide peek-def` " +
      "via bash — call this tool instead; it's compiler-resolved, unlike grepping .mbt files, which " +
      "can't follow type-directed dispatch or re-exports. Provide `symbol` (e.g. 'Array::length', " +
      "'@pkg.foo'), `loc` (path[:line[:col]]), or both to disambiguate an overloaded or shadowed name.",
      "moon_peek_def replaces `moon ide peek-def` — use it instead of grepping or shelling out.",
      [
        "Use this tool, not bash or `moon ide peek-def`, to resolve a definition.",
        "Accepted symbol forms: foo, @pkg.foo, Type::member, @pkg.Type::member, Trait::method.",
        "If `symbol` alone is ambiguous, add `loc` to narrow it to a specific file/position.",
      ],
      properties,
      ["moon_mod_filepath"],
      execute,
    ),
  )
}

///|
/// `moon_find_references`: find every usage of a symbol across dependents.
fn register_find_references(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(
    symbol_loc_execute(pi, "find-references", ["--json"]),
  )
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    ("symbol", string_schema("Symbol query, e.g. 'println', '@pkg.foo'.")),
    ("loc", loc_schema(loc_param_description)),
  ])
  register_tool(
    pi,
    ide_tool_definition(
      "moon_find_references",
      "MoonBit: Find References",
      "Find all usages of a MoonBit symbol across dependents. Do NOT grep or run `moon ide " +
      "find-references` via bash — this tool is compiler-resolved, so it correctly follows " +
      "type-directed dispatch and trait implementations that text search misses entirely. " +
      "Provide `symbol` (e.g. 'println', '@pkg.foo'), optionally `loc` to disambiguate.",
      "moon_find_references replaces grep/`moon ide find-references` for symbol usage search.",
      [
        "Use this tool, not grep or bash, whenever you need every call site of a symbol.",
        "Accepted symbol forms: foo, @pkg.foo, Type::member, @pkg.Type::member, Trait::method.",
        "Result includes the resolved definition first, then all reference locations.",
      ],
      properties,
      ["moon_mod_filepath"],
      execute,
    ),
  )
}

///|
/// `moon_type_info`: type and docs at a position (wraps `moon ide hover`).
fn register_type_info(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(
    symbol_loc_execute(pi, "hover", ["--json"]),
  )
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "loc",
      loc_schema(
        "Source location, path:line[:col], 1-based, relative to the module root. Include a column " +
        "(path:line:col) whenever you can — a line-only `loc` makes `symbol` mandatory (moon errors " +
        "with 'hover command requires a symbol when location has no column').",
      ),
    ),
    (
      "symbol",
      string_schema(
        "Optional symbol name to disambiguate at that position. Required when `loc` has no column.",
      ),
    ),
  ])
  register_tool(
    pi,
    ide_tool_definition(
      "moon_type_info",
      "MoonBit: Type Info",
      "Type inference and documentation for whatever is at a specific position. " +
      " — do NOT try to infer " +
      "the type by reading surrounding source via bash/cat; call this tool with `loc` instead. " +
      "Prefer a full `loc` with a column (path:line:col): with a line-only `loc` you must also pass " +
      "`symbol`, or moon refuses. Place the loc on the line where the symbol is used, not on a " +
      "comment or blank line — those have no hover information.",
      "moon_type_info is the hover equivalent — always prefer it over reading source to infer a type.",
      [
        "Use this tool instead of reading source and guessing a type from context.",
        "`loc` is path:line[:col], 1-based. Add a column when possible; a line-only `loc` requires `symbol`.",
        "Target the symbol's own line. A loc on a comment or blank line returns 'No hover information found'.",
      ],
      properties,
      ["moon_mod_filepath", "loc"],
      execute,
    ),
  )
}

///|
/// `moon_outline`: structure of a file or package (positional path).
fn register_outline(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(outline_execute(pi))
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "path",
      string_schema(
        "Required. A package directory — one that directly contains a `moon.pkg` — or a `.mbt` " +
        "file, relative to the module root. e.g. './src/error' or './src/error/top.mbt'. The module " +
        "root is usually NOT a package (most modules keep `moon.pkg` in subdirectories), so '.' " +
        "typically fails with 'could not find package for folder'. A directory that only contains " +
        "other packages, with no `moon.pkg` of its own, also fails.",
      ),
    ),
  ])
  register_tool(
    pi,
    ide_tool_definition(
      "moon_outline",
      "MoonBit: Outline",
      "Summarize the structure (types, functions, etc.) of a MoonBit file or package. Do NOT read " +
      "the whole file or grep for declarations to orient yourself — call this tool first. `path` is " +
      "required and must name a package directory (one containing `moon.pkg`) or a single `.mbt` " +
      "file; the module root itself is usually not a package. Note `--json` is unsupported here, so " +
      "output is plain text.",
      "moon_outline replaces reading-the-whole-file-to-orient — call it first.",
      [
        "Call this before reading a file in full, to see its shape first.",
        "Pass a package directory (e.g. './src/error') or a file (e.g. './src/error/top.mbt'). There " +
        "is no default: omitting `path` errors with 'at least one path is required'.",
        "Do not pass '.' or '../' — the module root has no `moon.pkg` in most repos. If unsure which " +
        "directories are packages, call `moon_analyze` with no `path` to list them first.",
      ],
      properties,
      ["moon_mod_filepath", "path"],
      execute,
    ),
  )
}

///|
/// The `execute` implementation for `moon_outline`, which takes an optional
/// positional path and does not accept `--json`.
fn outline_execute(
  pi : @pi.ExtensionAPI,
) -> (
  String,
  @pi.Static,
  @pi.AbortSignal?,
  @pi.AgentToolUpdateCallback?,
  @pi.ExtensionContext,
) -> @pi.Promise[@pi.AgentToolResult[@pi.JSValue]] {
  fn(_tool_call_id, params, signal, _on_update, _ctx) {
    let params_any : @js_core.Any = @js_core.identity(params)
    let moon_mod_filepath = params_any._get("moon_mod_filepath").cast()
    let args : Array[String] = ["outline"]
    match opt_param(params_any, "path") {
      Some(p) => args.push(p)
      None => ()
    }
    run_ide_tool(pi, args, moon_mod_filepath, signal)
  }
}

///|
/// `moon_rename`: semantic rename edits, dry run unless `apply: true`.
fn register_rename(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(rename_execute(pi))
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    ("old_name", string_schema("Current symbol name.")),
    ("new_name", string_schema("New symbol name.")),
    (
      "loc",
      loc_schema(
        "Location disambiguating which declaration to rename, path[:line].",
      ),
    ),
    (
      "apply",
      boolean_schema("If true, rewrite files. Defaults to false (dry run)."),
    ),
  ])
  register_tool(
    pi,
    ide_tool_definition(
      "moon_rename",
      "MoonBit: Rename Symbol",
      "Compute semantic rename edits for a MoonBit symbol across the workspace. Do NOT do a " +
      "find-and-replace via bash/sed for a rename — that misses scoping and shadowing that this " +
      "tool resolves correctly. Defaults to a dry run (returns the edit set without writing); set " +
      "apply: true only after reviewing the dry-run output, since that rewrites files on disk.",
      "moon_rename replaces sed/bash renames — it understands scope and shadowing; dry-run by default.",
      [
        "Never use sed/bash text substitution to rename a MoonBit symbol — use this tool.",
        "Always review the dry-run (apply omitted/false) output before calling again with apply: true.",
        "Give `loc` with a line/column when renaming a local variable, a shadowed name, or an " +
        "otherwise ambiguous symbol; a file-only loc restricts the initial lookup to that file.",
        "Accepted symbol forms: foo, @pkg.foo, Type::member, @pkg.Type::member.",
      ],
      properties,
      ["moon_mod_filepath", "old_name", "new_name", "loc"],
      execute,
    ),
  )
}

///|
/// The `execute` implementation for `moon_rename`. `moon ide rename` rejects
/// `--json` (moon 0.1.20260904); its output is a patch-style edit list, or an
/// apply summary. A dry run prefixes the output so the model cannot mistake
/// it for an applied change.
fn rename_execute(
  pi : @pi.ExtensionAPI,
) -> (
  String,
  @pi.Static,
  @pi.AbortSignal?,
  @pi.AgentToolUpdateCallback?,
  @pi.ExtensionContext,
) -> @pi.Promise[@pi.AgentToolResult[@pi.JSValue]] {
  fn(_tool_call_id, params, signal, _on_update, _ctx) {
    let params_any : @js_core.Any = @js_core.identity(params)
    let moon_mod_filepath = params_any._get("moon_mod_filepath").cast()
    let old_name : String = params_any._get("old_name").cast()
    let new_name : String = params_any._get("new_name").cast()
    let loc : String = params_any._get("loc").cast()
    let apply = match params_any._get("apply") {
      v => if @js_core.is_nullish(v) { false } else { (v.cast() : Bool) }
    }
    let args : Array[String] = ["rename", old_name, new_name, "--loc", loc]
    if apply {
      args.push("--apply")
    }
    @pi.Promise::from_async(async fn() {
      if is_aborted(signal) {
        return aborted_result()
      }
      match validated_moon_mod_dir(moon_mod_filepath) {
        Err(reason) => invalid_moon_mod_result(moon_mod_filepath, reason)
        Ok(dir) => {
          let result = run_moon_ide(pi, args, dir, signal).wait()
          if !apply && result.ok && !result.aborted {
            ide_to_content({
              ok: result.ok,
              json: result.json,
              raw: "[DRY RUN — no files written; call again with apply: true to rewrite]\n" +
              result.raw,
              stderr: result.stderr,
              aborted: result.aborted,
            })
          } else {
            ide_to_content(result)
          }
        }
      }
    })
  }
}

///|
/// `moon_analyze`: public API usage counts for a package.
fn register_analyze(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(
    path_only_execute(pi, "analyze"),
  )
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "path",
      string_schema(
        "Package directory to scope the analysis — one that directly contains a `moon.pkg`, e.g. " +
        "'./src/types'. Omit to analyze every local package in the module, which is also the fastest " +
        "way to list which package directories exist. NOTE: this maps to the positional <package-dir> " +
        "argument of `moon ide analyze`; it does not take a symbol name.",
      ),
    ),
  ])
  register_tool(
    pi,
    ide_tool_definition(
      "moon_analyze",
      "MoonBit: Analyze API Usage",
      "Report public API usage counts for a package. Do NOT grep call sites to estimate usage — " +
      "this tool gives compiler-verified counts. Pass a package directory (`path`) to scope the " +
      "report; omit to analyze all local packages in the module.",
      "moon_analyze replaces grep-for-usage-counts with compiler-verified numbers.",
      [
        "Use this instead of grepping for call sites when you need usage counts, e.g. before removing " +
        "or changing a public API.",
        "`path` is a package directory (e.g. './types'), not a symbol name.",
        "Call with no `path` to discover the module's package directories before calling " +
        "moon_outline or moon_peek_def, which need a real package path.",
      ],
      properties,
      ["moon_mod_filepath"],
      execute,
    ),
  )
}

///|
/// `moon_workspace_symbols`: search top-level symbols across the workspace.
///
/// This is the entry point when you know a name but not where it lives. It is
/// the tool `moon ide find-references` and `moon_peek_def` assume you have
/// already used.
fn register_workspace_symbols(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(workspace_symbols_execute(pi))
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "query",
      string_schema(
        "Substring to match against top-level symbol names, e.g. 'div' or 'S3Config'. Not a " +
        "regex and not a path.",
      ),
    ),
  ])
  register_tool(
    pi,
    ide_tool_definition(
      "moon_workspace_symbols",
      "MoonBit: Workspace Symbols",
      "Search top-level symbols (functions, types, enums, traits, methods) across every package in " +
      "the workspace, returning each match's kind, file, and range. Use this when you know a symbol " +
      "name but not which file defines it — it is cheaper and more accurate than grepping for a name " +
      "you cannot yet locate. Once you have the location, follow up with `moon_peek_def` (source " +
      "context) or `moon_find_references` (call sites).",
      "moon_workspace_symbols finds a symbol by name when you don't know which file to open.",
      [
        "Use this instead of grepping the tree for a symbol name you can't place.",
        "`query` is a plain substring, not a regex; it matches symbol names, not paths.",
      ],
      properties,
      ["moon_mod_filepath", "query"],
      execute,
    ),
  )
}

///|
/// The `execute` implementation for `moon_workspace_symbols`.
///
/// `--json` is supported here, unlike `outline`, so the result is parsed and
/// pretty-printed like `peek-def`.
fn workspace_symbols_execute(
  pi : @pi.ExtensionAPI,
) -> (
  String,
  @pi.Static,
  @pi.AbortSignal?,
  @pi.AgentToolUpdateCallback?,
  @pi.ExtensionContext,
) -> @pi.Promise[@pi.AgentToolResult[@pi.JSValue]] {
  fn(_tool_call_id, params, signal, _on_update, _ctx) {
    let params_any : @js_core.Any = @js_core.identity(params)
    let moon_mod_filepath = params_any._get("moon_mod_filepath").cast()
    let query : String = params_any._get("query").cast()
    run_ide_tool(
      pi,
      ["workspace-symbols", query, "--json"],
      moon_mod_filepath,
      signal,
    )
  }
}

///|
/// `moon_doc`: search exported APIs and documentation.
fn register_doc(pi : @pi.ExtensionAPI) -> Unit {
  let execute : @pi.JSValue = @js_core.identity(doc_execute(pi))
  let properties = js_object([
    ("moon_mod_filepath", moon_mod_filepath_schema()),
    (
      "query",
      string_schema("Doc/API search query, e.g. '@json' or a function name."),
    ),
  ])
  register_tool(
    pi,
    ide_tool_definition(
      "moon_doc",
      "MoonBit: Search Docs",
      "Search exported APIs and documentation across the workspace and its dependencies. Do NOT " +
      "guess an API's signature from memory or training data — MoonBit APIs change between " +
      "versions; call this tool to confirm the actual current signature and docs.",
      "moon_doc replaces guessing API signatures from memory — always check here first.",
      [
        "Call this before using an API you're not 100% certain of the current signature.",
        "Query can be a package (e.g. '@json') or a function/type name.",
      ],
      properties,
      ["moon_mod_filepath", "query"],
      execute,
    ),
  )
}

///|
/// The `execute` implementation for `moon_doc`, which takes a required
/// `query` positional argument.
fn doc_execute(
  pi : @pi.ExtensionAPI,
) -> (
  String,
  @pi.Static,
  @pi.AbortSignal?,
  @pi.AgentToolUpdateCallback?,
  @pi.ExtensionContext,
) -> @pi.Promise[@pi.AgentToolResult[@pi.JSValue]] {
  fn(_tool_call_id, params, signal, _on_update, _ctx) {
    let params_any : @js_core.Any = @js_core.identity(params)
    let moon_mod_filepath = params_any._get("moon_mod_filepath").cast()
    let query : String = params_any._get("query").cast()
    run_ide_tool(pi, ["doc", query], moon_mod_filepath, signal)
  }
}

///|
/// The `execute` implementation for tools taking only an optional positional
/// `path` (currently `moon_analyze`).
fn path_only_execute(
  pi : @pi.ExtensionAPI,
  subcommand : String,
) -> (
  String,
  @pi.Static,
  @pi.AbortSignal?,
  @pi.AgentToolUpdateCallback?,
  @pi.ExtensionContext,
) -> @pi.Promise[@pi.AgentToolResult[@pi.JSValue]] {
  fn(_tool_call_id, params, signal, _on_update, _ctx) {
    let params_any : @js_core.Any = @js_core.identity(params)
    let moon_mod_filepath = params_any._get("moon_mod_filepath").cast()
    let args : Array[String] = [subcommand]
    match opt_param(params_any, "path") {
      Some(p) => args.push(p)
      None => ()
    }
    run_ide_tool(pi, args, moon_mod_filepath, signal)
  }
}

///|
/// Assembles an ide tool definition with the shared prompt metadata.
fn ide_tool_definition(
  name : String,
  label : String,
  description : String,
  prompt_snippet : String,
  prompt_guidelines : Array[String],
  properties : @pi.JSValue,
  required : Array[String],
  execute : @pi.JSValue,
) -> @pi.JSValue {
  let parameters = js_object([
    ("type", @pi.JSValue::from_string("object")),
    ("properties", properties),
    ("required", string_array(required)),
  ])
  js_object([
    ("name", @pi.JSValue::from_string(name)),
    ("label", @pi.JSValue::from_string(label)),
    ("description", @pi.JSValue::from_string(description)),
    ("promptSnippet", @pi.JSValue::from_string(prompt_snippet)),
    ("promptGuidelines", string_array(prompt_guidelines)),
    ("parameters", @js_core.identity(parameters)),
    ("execute", execute),
  ])
}
