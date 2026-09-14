// --- bash → tool redirection ----------------------------------------------
// Tool descriptions are only a soft nudge — models reach for `bash` anyway
// since it feels more familiar/flexible than picking the "right" tool. The
// `tool_call` event fires before a tool executes and can block it, which
// turns the nudge into a hard rule: if the model tries to run a `moon`
// subcommand we have a dedicated tool for, the bash call is blocked and the
// reason names the tool to use instead. This is only registered once the
// moon_* tools themselves are active (see moonbit.ts) — blocking bash with
// no working replacement would just strand the model.
//
// Matching is deliberately conservative: quoted segments are stripped and
// patterns are only tested at shell command positions (start of a segment
// or after ;, &&, ||, |, $(), backtick). A command that merely *mentions*
// `moon test` — `echo "moon test"`, `perl -e 's/.../moon ide hover/'`,
// `grep moon ide hover notes.md` — must not be blocked. The tradeoff is
// that prefixed invocations like `sudo moon check` won't redirect.

interface BashRedirect {
  match: RegExp;
  tool: string;
  note: string;
}

// Patterns are anchored to a command position; findBashRedirect applies
// them per separator-split segment, not to the raw command string.
export const BASH_REDIRECTS: BashRedirect[] = [
  { match: /^moon\s+check\b/, tool: "moon_check", note: "it parses the NDJSON output into a summarized diagnostic list and accepts `package` to scope it." },
  { match: /^moon\s+test\b/, tool: "moon_test", note: "it applies the configured default target and reports pass/fail clearly; use its `package`, `target`, or `update` params instead of flags." },
  { match: /^moon\s+fmt\b/, tool: "moon_fmt_info", note: "it runs fmt then info as the standard handoff sequence in one call." },
  { match: /^moon\s+info\b/, tool: "moon_fmt_info", note: "it runs fmt then info as the standard handoff sequence in one call." },
  { match: /^moon\s+ide\s+peek-def\b/, tool: "moon_peek_def", note: "it wraps this with JSON parsing, cwd handling, and cancellation support." },
  { match: /^moon\s+ide\s+find-references\b/, tool: "moon_find_references", note: "it wraps this with JSON parsing, cwd handling, and cancellation support." },
  { match: /^moon\s+ide\s+hover\b/, tool: "moon_type_info", note: "it wraps this with JSON parsing, cwd handling, and cancellation support." },
  { match: /^moon\s+ide\s+outline\b/, tool: "moon_outline", note: "it wraps this with JSON parsing, cwd handling, and cancellation support." },
  { match: /^moon\s+ide\s+rename\b/, tool: "moon_rename", note: "it dry-runs by default and only rewrites files when called with apply: true." },
  { match: /^moon\s+ide\s+analyze\b/, tool: "moon_analyze", note: "it wraps this with JSON parsing, cwd handling, and cancellation support." },
  { match: /^moon\s+ide\s+doc\b/, tool: "moon_doc", note: "it wraps this with JSON parsing, cwd handling, and cancellation support." },
];

// Removes single/double-quoted segments (content, not just delimiters) so
// string arguments never influence the match. Unbalanced quotes degrade to
// fail-open (the remainder is dropped), which is the safe direction here.
export function stripQuotedSegments(command: string): string {
  let out = "";
  let quote: '"' | "'" | null = null;
  for (let i = 0; i < command.length; i++) {
    const ch = command[i];
    if (quote) {
      if (ch === "\\" && quote === '"') i++; // skip the escaped char
      else if (ch === quote) quote = null;
      continue;
    }
    if (ch === '"' || ch === "'") {
      quote = ch;
      out += " "; // keep token separation
      continue;
    }
    out += ch;
  }
  return out;
}

export function findBashRedirect(command: string): BashRedirect | undefined {
  const unquoted = stripQuotedSegments(command);
  const segments = unquoted.split(/[;&|()`]|\$\(|\n/).map((s) => s.trim());
  return BASH_REDIRECTS.find((r) => segments.some((s) => r.match.test(s)));
}
