// bash → tool redirection.
//
// Tool descriptions are only a soft nudge — models reach for `bash` anyway
// since it feels more familiar and flexible than picking the "right" tool.
// The `tool_call` event fires before a tool executes and can block it, which
// turns the nudge into a hard rule: if the model tries to run a `moon`
// subcommand that has a dedicated tool, the bash call is blocked and the
// reason names the tool to use instead. This is only registered once the
// `moon_*` tools themselves are active — blocking bash with no working
// replacement would just strand the model.
//
// Matching is deliberately conservative: quoted segments are stripped and
// patterns are only tested at shell command positions (start of a segment or
// after ;, &&, ||, |, $(), backtick). A command that merely *mentions*
// `moon test` — `echo "moon test"`, `perl -e 's/.../moon ide hover/'`,
// `grep moon ide hover notes.md` — is not blocked. The tradeoff is that
// prefixed invocations like `sudo moon check` are not redirected.
//
// This mirrors `extensions/bash-redirect.ts`.

///|
/// Tests one anchored pattern against a command-position segment.
///
/// The patterns use `\s` and `\b`, which MoonBit's core `Regex` does not
/// support, so the test runs through a JavaScript `RegExp`. The pattern is a
/// compile-time constant (never model input), so there is no injection
/// surface. The alternative — hand-rolling the match — would have to
/// reimplement `\s` (which includes Unicode spaces) to stay faithful.
extern "js" fn regex_test(pattern : String, text : String) -> Bool =
  #| (pattern, text) => new RegExp(pattern).test(text)

///|
/// One redirect rule: an anchored pattern plus the tool that replaces it and
/// the reason shown to the model.
priv struct BashRedirect {
  pattern : String
  tool : String
  note : String
}

///|
/// The redirect table. Order matters only for readability: each pattern is
/// anchored, so at most one can match a given segment.
fn bash_redirects() -> Array[BashRedirect] {
  [
    {
      pattern: "^moon\\s+check\\b",
      tool: "moon_check",
      note: "it parses the raw NDJSON into a summarized error/warning count and filters out " +
      "dependency noise, which bash output does not do.",
    },
    {
      pattern: "^moon\\s+test\\b",
      tool: "moon_test",
      note: "it runs against an explicit, consistent target and reports pass/fail via isError, " +
      "so failures aren't missed in raw output.",
    },
    {
      pattern: "^moon\\s+fmt\\b",
      tool: "moon_fmt_info",
      note: "it runs fmt then info as one handoff — running fmt alone via bash skips the " +
      "interface-file regeneration step.",
    },
    {
      pattern: "^moon\\s+info\\b",
      tool: "moon_fmt_info",
      note: "it runs fmt before info, which running info alone via bash would skip.",
    },
    {
      pattern: "^moon\\s+explain\\b",
      tool: "moon_explain_error",
      note: "it will explain in detail the error code received from moon_check.",
    },
    {
      pattern: "^moon\\s+ide\\s+peek-def\\b",
      tool: "moon_peek_def",
      note: "it resolves the correct project root for the current session — a bare bash call " +
      "uses your shell's cwd, which is wrong in multi-root workspaces.",
    },
    {
      pattern: "^moon\\s+ide\\s+find-references\\b",
      tool: "moon_find_references",
      note: "it resolves the correct project root for the current session — a bare bash call " +
      "uses your shell's cwd, which is wrong in multi-root workspaces.",
    },
    {
      pattern: "^moon\\s+ide\\s+hover\\b",
      tool: "moon_type_info",
      note: "it's the only supported way to get hover info without an interactive editor, and " +
      "resolves the correct project root automatically.",
    },
    {
      pattern: "^moon\\s+ide\\s+outline\\b",
      tool: "moon_outline",
      note: "it resolves the correct project root for the current session — a bare bash call " +
      "uses your shell's cwd, which is wrong in multi-root workspaces.",
    },
    {
      pattern: "^moon\\s+ide\\s+rename\\b",
      tool: "moon_rename",
      note: "it dry-runs by default — a raw bash call has no equivalent safeguard and can " +
      "rewrite files immediately.",
    },
    {
      pattern: "^moon\\s+ide\\s+analyze\\b",
      tool: "moon_analyze",
      note: "it resolves the correct project root for the current session — a bare bash call " +
      "uses your shell's cwd, which is wrong in multi-root workspaces.",
    },
    {
      pattern: "^moon\\s+ide\\s+doc\\b",
      tool: "moon_doc",
      note: "it resolves the correct project root for the current session — a bare bash call " +
      "uses your shell's cwd, which is wrong in multi-root workspaces.",
    },
    {
      pattern: "^moon\\s+ide\\s+workspace-symbols\\b",
      tool: "moon_workspace_symbols",
      note: "it resolves the correct project root for the current session and returns parsed " +
      "kind/path/range data instead of raw text.",
    },
  ]
}

///|
/// Removes single/double-quoted segments (content, not just delimiters) so
/// string arguments never influence the match.
///
/// A space is emitted where a quoted segment was, to keep token separation.
/// Unbalanced quotes degrade to fail-open (the remainder is dropped), which is
/// the safe direction: it can only cause a miss, never a false block.
fn strip_quoted_segments(command : String) -> String {
  let out = StringBuilder()
  let mut quote : Char? = None
  let chars = command.to_array()
  let mut i = 0
  while i < chars.length() {
    let ch = chars[i]
    match quote {
      Some(q) =>
        // Inside double quotes a backslash escapes the next character; inside
        // single quotes it does not (shell semantics).
        if ch == '\\' && q == '"' {
          i = i + 2
          continue
        } else if ch == q {
          quote = None
        }
      None =>
        if ch == '"' || ch == '\'' {
          quote = Some(ch)
          out.write_string(" ")
        } else {
          out.write_char(ch)
        }
    }
    i = i + 1
  }
  out.to_string()
}

///|
/// Splits a command on shell separators, so patterns can be tested at command
/// positions rather than anywhere in the string.
///
/// Splitting on each separator character individually means `$(`, `|`, `&&`
/// and `;` all produce an empty or command-starting segment; `moon check` in
/// `$(moon check)` therefore lands at the start of a segment.
fn split_command_segments(command : String) -> Array[String] {
  let segments : Array[String] = []
  let buf = StringBuilder()
  let chars = command.to_array()
  let mut i = 0
  while i < chars.length() {
    let ch = chars[i]
    if is_separator(ch) {
      segments.push(buf.to_string())
      buf.reset()
    } else {
      buf.write_char(ch)
    }
    i = i + 1
  }
  segments.push(buf.to_string())
  let trimmed : Array[String] = []
  let mut j = 0
  while j < segments.length() {
    trimmed.push(segments[j].trim().to_owned())
    j = j + 1
  }
  trimmed
}

///|
/// The characters the TypeScript splitter treats as separators.
fn is_separator(ch : Char) -> Bool {
  ch == ';' ||
  ch == '&' ||
  ch == '|' ||
  ch == '(' ||
  ch == ')' ||
  ch == '`' ||
  ch == '\n'
}

///|
/// Finds the redirect rule matching a raw command string, if any.
fn find_bash_redirect(command : String) -> BashRedirect? {
  let segments = split_command_segments(strip_quoted_segments(command))
  let rules = bash_redirects()
  let mut ri = 0
  while ri < rules.length() {
    let rule = rules[ri]
    let mut si = 0
    while si < segments.length() {
      if regex_test(rule.pattern, segments[si]) {
        return Some(rule)
      }
      si = si + 1
    }
    ri = ri + 1
  }
  None
}

///|
/// Builds the message shown to the model in place of the blocked call.
fn redirect_message(shell : String, redirect : BashRedirect) -> String {
  "Blocked — this command was not run. Call the " +
  redirect.tool +
  " tool now instead of " +
  shell +
  ": " +
  redirect.note
}

///|
/// Builds the `tool_call` result that blocks a duplicate bash/powershell call.
///
/// Returns a plain JavaScript object (`{ block: true, reason }`) rather than a
/// MoonBit `ToolCallEventResult` struct: the generated `on_tool_call` binding
/// passes the handler's return value straight through to the runner, which
/// reads `block` and `reason` off it, so a struct would arrive in the wrong
/// shape.
fn blocked_result(reason : String) -> @pi.JSValue {
  js_object([
    ("block", @pi.JSValue::from_bool(true)),
    ("reason", @pi.JSValue::from_string(reason)),
  ])
}

///|
/// The `tool_call` handler.
///
/// The event arrives as the raw JavaScript object — the generated binding does
/// not convert it to the `ToolCallEvent` enum — so `toolName` and
/// `input.command` are read with `_get`, not pattern-matched. Any
/// unrecognized tool is ignored (`undefined`), which the runner treats as
/// "no decision".
fn tool_call_handler(
  event : @pi.ToolCallEvent,
  _ctx : @pi.ExtensionContext,
) -> @pi.JSValue {
  let event_any : @js_core.Any = @js_core.identity(event)
  let tool_name_value = event_any._get("toolName")
  if @js_core.is_nullish(tool_name_value) {
    return @js_core.identity(@js_core.undefined())
  }
  let tool_name : String = tool_name_value.cast()
  let shell = if tool_name == "bash" {
    Some("bash")
  } else if tool_name == "powershell" {
    Some("powershell")
  } else {
    None
  }
  match shell {
    None => @js_core.identity(@js_core.undefined())
    Some(shell_name) => {
      let input = event_any._get("input")
      if @js_core.is_nullish(input) {
        return @js_core.identity(@js_core.undefined())
      }
      let command_value = input._get("command")
      if @js_core.is_nullish(command_value) {
        return @js_core.identity(@js_core.undefined())
      }
      let command : String = command_value.cast()
      match find_bash_redirect(command) {
        None => @js_core.identity(@js_core.undefined())
        Some(redirect) =>
          @js_core.identity(
            blocked_result(redirect_message(shell_name, redirect)),
          )
      }
    }
  }
}

///|
/// Registers the bash/powershell → `moon_*` tool redirect hook.
///
/// Called only when the `moon_*` tools are registered: blocking bash with no
/// working replacement would strand the model.
pub fn register_bash_redirect(pi : @pi.ExtensionAPI) -> Unit {
  @pi.ExtensionAPI::on_tool_call(pi, tool_call_handler)
}
