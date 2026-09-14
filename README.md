# moonbit Pi extension

Wraps `moon ide` subcommands (plus `check`, `test`, and the `fmt`+`info`
handoff) as discrete Pi tools, so the model reaches for compiler-aware
navigation instead of grepping `.mbt` source.

## Install

Project-local (recommended to start):

```bash
mkdir -p .pi/extensions
cp moonbit.ts .pi/extensions/moonbit.ts
```

Global (all projects):

```bash
mkdir -p ~/.pi/agent/extensions
cp moonbit.ts ~/.pi/agent/extensions/moonbit.ts
```

Restart Pi (or `/restart`) after adding it.

## Toolchain gating

At startup the extension runs `moon version`. The `moon_*` tools below are
registered **only if that succeeds** — a tool that always fails with
"command not found" is worse than no tool at all, since the model tends to
either retry it or misattribute the failure to something in the code rather
than the environment.

A `moon-doctor` command is **always** registered, regardless of the startup
result, so a human can check reachability directly:

```
/moon-doctor
```

It re-runs `moon version` on demand and reports either the version string
(plus whether the tools are currently live) or the failure reason (PATH
issue vs. something else). If it becomes reachable after startup — e.g. you
fixed PATH mid-session — run `/reload` afterward to actually register the
tools; `/moon-doctor` only diagnoses, it doesn't re-register anything
itself.

## Tools registered

**Navigation / IDE**

- `moon_peek_def` — resolve a definition, with source context
- `moon_find_references` — find usages across dependents
- `moon_hover` — type/docs at a position
- `moon_outline` — structure of a file or package (positional path)
- `moon_rename` — compute rename edits (dry run unless `apply: true`)
- `moon_analyze` — public API usage counts
- `moon_doc` — search exported APIs/docs

**Build / quality**

- `moon_check` — static analysis via `moon check --output-json`, summarized
- `moon_test` — run tests (`-p`, `--target`, optional `--update`)
- `moon_fmt_info` — `moon fmt` then `moon info` (handoff sequence)

(All of the above are gated behind the `moon version` check — see
"Toolchain gating" above.)

### Cancellation

Every tool honours the Pi `AbortSignal`. If the user/model cancels a call,
the underlying `moon` process is aborted and the tool returns a short
"Cancelled." result with `isError: true`.

### Working directory

Every tool passes the Pi session's `ctx.cwd` into the subprocess so `moon`
runs in the correct project root (important for multi-root workspaces and
when the session is not already inside a MoonBit module).

### moon_check specifics

`moon check --output-json` emits **NDJSON** (one JSON object per line), not
a single JSON document, so it gets its own parsing path. A non-zero exit
code is *normal* ("the package has errors") — only a spawn failure is a
true execution error. Compile errors are still flagged via `isError: true`
on the tool result. Optionally pass `package` (`-p <package>`).

### moon_test specifics

Non-zero exit (failed tests) is a normal outcome, reported with
`isError: true` so the model treats failures as something to fix. Optional
`package` (`-p`), `target` (`--target`), and `update` (`--update` for
snapshot refresh — default false). Timeout is 120s (longer than IDE tools).

### moon_fmt_info specifics

Runs `moon fmt` then, only if fmt succeeds, `moon info`. This is the
standard handoff sequence from the MoonBit agent guide: format source, then
regenerate `.mbti` interface files. Review generated `.mbti` diffs when the
public API should remain stable. Optional `package` / `target` apply to
`moon info` only; fmt is always module-wide.

### Outline path shape

`moon ide outline` takes a **positional** path (`moon ide outline <path>`),
not `--loc`. The `moon_outline` tool therefore exposes a `path` parameter
that is appended as a positional argument.

### find-references and loc

Official docs note that `-loc` is not yet supported for
`find-references` (always global). The tool still accepts an optional
`loc` for forward compatibility; newer toolchains may honour it.

## Deliberately left out

- `gen-symbols` isn't exposed as a tool — it's a one-time setup step
  (`moon ide gen-symbols`) that writes `./symbols.jsonl`, not something the
  model needs to invoke mid-task. Run it once per package as part of repo
  setup, or add a `postinstall`/onboarding script if it needs regenerating
  regularly.

  `moon_workspace_symbols` may benefit from a prior index; regenerate when
  top-level declarations change substantially.

## Why separate tools instead of one `moon_ide` tool with a `command` param

Each intent has a genuinely different useful parameter shape (`rename` needs
two names plus an `apply` flag; `doc`/`workspace-symbols` just need a query
string; `hover` requires a line number). Splitting them:

- lets each tool's `description` teach the model *when* to reach for it,
  which a single overloaded description can't do as precisely
- avoids the model constructing a `command` + free-form `args` string that
  round-trips through less validation
- matches the CLI's own framing (`moon ide --help` already organizes by
  intent, not by a single verb+args form)

## Rename safety

`moon_rename` always dry-runs by default and prefixes dry-run output with an
explicit marker. The model has to set `apply: true` deliberately to rewrite
files — this is intentional friction, not an oversight, so a rename doesn't
silently land as a side effect of an exploratory call.

## Suggested sequencing

1. Edit source  
2. `moon_check --diagnostic-limit 1` (Check if there are errors)  
3. `moon_check` (cheap, catch type/syntax errors)  
4. `moon_test` (after check is clean)  
5. `moon_fmt_info` before handoff
