// The `before_agent_start` hook that injects the MoonBit tooling guide into
// the conversation.
//
// Tool descriptions alone are a weak signal: the model still reads `.mbt`
// files with grep, or shells out to `moon`, unless it is told up front which
// tools exist and when to reach for each. The `before_agent_start` event fires
// once per agent run, before the model sees the turn, and its handler may
// return a custom message — so the guide is injected as context at the start
// of every run instead of being buried in a tool listing the model may skim.
//
// The guide is a string literal rather than a file read at run time. An
// earlier version shipped it as `agents_prompt.md` and resolved the path
// relative to the running bundle (`import.meta.dirname`), which worked but
// still made correct behaviour depend on a data file surviving packaging,
// bundling, and relocation. Inlining removes that failure mode: the guide
// cannot be missing, stale, or mismatched with the code that reads it. It also
// drops the `node:fs`/`node:path` reads from this path entirely.
//
// This mirrors the `before_agent_start` hook in `extensions/moonbit.ts`, which
// still reads `./AGENTS.md` at run time.

///|
/// The guide injected at the start of every run, as an injected message.
///
/// This is the single source of truth for the guide; `AGENTS.md` carries a
/// condensed version of the same rules for the system prompt. Keeping the two
/// in step is a manual edit — the table is prose tuned for the model, so it is
/// reviewed rather than generated.
let agents_prompt : String =
  #|## MoonBit tooling
  #|
  #|This project has dedicated tools for operating with moonbit files.
  #|MUST USE these tools for working with moonbit files.
  #|
  #|**Every tool except `moon_explain_error` requires `moon_mod_filepath`:** the
  #|ABSOLUTE path of the module's `moon.mod` file (e.g. `/home/me/proj/moon.mod`).
  #|Pass it on every call — the tool runs `moon -C <module-dir>` so relative paths
  #|resolve against the module root, even if the session cwd is elsewhere.
  #|
  #|| Call this tool           | Tool function / Why run this                                        | When                                                       |
  #|| ------------------------ | ------------------------------------------------------------------- | ---------------------------------------------------------- |
  #|| `moon_check`             | Static analysis for MoonBit source — type and syntax.               | After every source edit. Before `moon_test`.               |
  #|| `moon_test`              | Run tests for the current module or a scoped package.               | After `moon_check` is clean. One call per package. Only    |
  #||                          |                                                                     | packages that changed.                                     |
  #|| `moon_fmt_info`          | Formats source in place, regenerates public interface (`.mbti`)     | Before handing off a change.                               |
  #||                          | files.                                                              |                                                            |
  #|| `moon_peek_def`          | Resolve a symbol's definition with source, compiler-resolved.       | To resolve a definition — not grep.                        |
  #|| `moon_find_references`   | Find every usage of a symbol across dependents, compiler-resolved.  | To find call sites — not grep.                             |
  #|| `moon_workspace_symbols` | Search top-level symbols across every package in the workspace.     | When you know a symbol name but not which file defines it. |
  #|| `moon_type_info`         | Type and documentation for a token at a given location.             | To check a type — not by reading and guessing from source. |
  #|| `moon_outline`           | Structure (types, functions) of a file or package.                  | Before reading a file in full. Requires a `path`.          |
  #|| `moon_rename`            | Semantic rename across the workspace — understands scope/shadowing. | Instead of sed/bash text substitution for a rename.        |
  #|| `moon_analyze`           | Public API usage counts for a package.                              | Instead of grep, to estimate usage before changing a       |
  #||                          |                                                                     | signature.                                                 |
  #|| `moon_doc`               | Search exported APIs and docs, workspace and dependencies.          | Before using an API you're not certain of the current      |
  #||                          |                                                                     | signature.                                                 |
  #|| `moon_explain_error`     | Explains a compiler error code.                                     | Before guessing at a fix for an error code you haven't     |
  #||                          |                                                                     | seen explained.                                            |
  #|
  #|### Compiler driven development
  #|
  #|1. Locate the enclosing `moon.mod` (this is the `moon_mod_filepath` you pass
  #|   to every tool call e.g. `/home/me/proj/moon.mod`)
  #|2. Find the packages: run `moon_analyze` with no `path`. It lists every local
  #|   package. A package is a directory that directly contains a `moon.pkg`;
  #|   the module root usually is not one, so `moon_outline '.',` fails.
  #|3. Discover package APIs and types with `moon_outline <package-dir>`. Use
  #|   `moon_workspace_symbols <name>` to find where a symbol lives. 
  #|4. Use `moon_doc` to discover the public API of package or dependency or  
  #|   the documentation for function, type, trait or package. 
  #|5. Edit source files (`.mbt`). Identify the package they belong to.
  #|6. `moon_check` — fix errors before moving on. Refactor and fix by compiler guidance, 
  #|    not by text. Compiler tell you what to change and where. 
  #|    Fix the reported path:lines with edit/edit_lines → re-check until clean.
  #|7. `moon_test -p package_name --target target` — Refactor & fix failures before moving on.
  #|8. `moon_fmt_info` before handoff.
  #|
  #|### Rules
  #|
  #|- `.mbt` files are never read with grep/cat/sed to find a definition, find references, infer a
  #|  type, or perform a rename — the tools above are compiler-resolved and more accurate. To learn how a
  #|  language feature is written, use `moon_outline` on that package, not a text search.
  #|- `moon_outline` takes a package directory (one holding a `moon.pkg`) or a single `.mbt` file.
  #|  It has no default: omitting `path` errors. Do not pass `.` or a bare `src/` unless that
  #|  directory itself contains `moon.pkg`.
  #|- `moon_type_info` needs the symbol's own line. Prefer `path:line:col`; a line-only `loc`
  #|  requires `symbol`, and a loc on a comment or blank line returns no information.
  #|- If a `moon_check` error/warning code's message isn't enough to know the fix, call `moon_explain_error`
  #|  with that code before guessing.
  #|- Other `moon` subcommands (e.g. `moon add`, `moon remove`, `moon build`) are not intercepted —
  #|  bash is fine for those.
  #|
  #|## Available bash commands
  #|
  #|| `moon add <package_version>` | `moon add moonbitlang/x@0.5.5` | Add a package |
  #|| `moon -C <dir> clean` | `moon -C . clean` | Clean project build in the given path |
  #|| `moon update` | `moon update` | Update package registry index |
  #|| `moon remove <package>` | `moon remove moonbitlang/x` | Remove a package |
  #|

///|
/// Marker that opens the appended rules block. Its presence in a system
/// prompt means the rules are already there, so the append is skipped.
let system_prompt_marker : String = "## MoonBit tooling (enforced)"

///|
/// The rules appended to the harness system prompt on every run.
///
/// Kept short and imperative on purpose: this is the block that must not be
/// skimmed, so it is a decision list, not documentation. The full guide with
/// the tool table goes in the injected message.
fn tooling_rules() -> String {
  (
    #|## MoonBit tooling (enforced)
    #|You MUST use the dedicated `moon_*` tools for MoonBit (`.mbt`) files.
    #|- Do not read `.mbt` files with grep, cat, or sed to find a definition, find
    #|  references, infer a type, or rename. Use `moon_peek_def`
    #|  `moon_find_references`, `moon_type_info`, and `moon_rename` — they are
    #|  compiler-resolved and see trait impls and shadowing that text search misses.
    #|  `moon_outline` the package, don't grep.
    #|- Call `moon_outline` before reading a file in full. It requires a `path` that
    #|  is a package directory (containing `moon.pkg`) or a `.mbt` file; omitting
    #|  `path`, or passing '.', fails because the module root is not a package.
    #|- Use `moon_analyze` (no `path`) to list the module's local packages, and
    #|  `moon_workspace_symbols` to find which file defines a symbol name.
    #|- Use `moon_doc` to discover the public API of a package, dependency package, symbol within the package. 
    #|  e.g moon_doc queries are `@kaashyapan/moonext/src`, `@moonbitlang/core/string`, 
    #|  `@kaashyapan/moonext.register_tool_result`, `StringView::clamped_view`
    #|- Do not run `moon check`, `moon test`, `moon fmt`, `moon info`, or `moon ide`
    #|  through bash — those calls are intercepted and blocked. Use `moon_check`
    #|  `moon_test`, `moon_fmt_info`, or the `moon ide` tools
    #|- Pass the absolute `moon_mod_filepath` on every call.
  )
}

///|
/// Appends the enforcement rules to the harness system prompt.
///
/// The guide is injected as a custom message, which the runner appends as
/// conversation context. That is a weak position: it competes with the rest of
/// the transcript. The system prompt is re-sent on every request at higher
/// authority, so the rules that must not be missed are repeated there — a
/// different channel carrying a short decision list, not a second copy of the
/// whole guide.
///
/// Returns `None` when the event carries no system prompt. Returning one in
/// that case would replace the harness prompt with the rules alone, dropping
/// the project instructions. Returns `None` too when the rules are already
/// present, so a re-emit cannot append them twice.
fn appended_system_prompt(event : @pi.BeforeAgentStartEvent) -> String? {
  let event_any : @js_core.Any = @js_core.identity(event)
  let base_value = event_any._get("systemPrompt")
  if @js_core.is_nullish(base_value) {
    return None
  }
  let base : String = base_value.cast()
  if base.contains(system_prompt_marker) {
    return None
  }
  Some(base + "\n\n" + tooling_rules())
}

///|
/// The `before_agent_start` handler: returns the guide as a custom message and
/// appends the enforcement rules to the system prompt.
///
/// The result is a plain JavaScript object rather than the generated
/// `BeforeAgentStartEventResult` struct: the binding passes the handler's
/// return value straight through to the runner, which reads `result.message`
/// and `result.systemPrompt` off it, so a struct would arrive in the wrong
/// shape.
fn before_agent_start_handler(
  event : @pi.BeforeAgentStartEvent,
  _ctx : @pi.ExtensionContext,
) -> @pi.JSValue {
  let message = js_object([
    ("customType", @pi.JSValue::from_string("pi-moonbit-guide")),
    ("content", @pi.JSValue::from_string(agents_prompt)),
    ("display", @pi.JSValue::from_bool(true)),
  ])
  let pairs : Array[(String, @pi.JSValue)] = [("message", message)]
  match appended_system_prompt(event) {
    Some(system_prompt) =>
      pairs.push(("systemPrompt", @pi.JSValue::from_string(system_prompt)))
    None => ()
  }
  js_object(pairs)
}

///|
/// Registers the `before_agent_start` hook that injects the guide.
///
/// Registered unconditionally, like the `/moon-doctor` command: the guide
/// explains which tools exist, so it is still the right thing to show when the
/// toolchain is missing and the `moon_*` tools were never registered.
pub fn register_agent_prompt(pi : @pi.ExtensionAPI) -> Unit {
  @pi.ExtensionAPI::on_before_agent_start(pi, before_agent_start_handler)
}
