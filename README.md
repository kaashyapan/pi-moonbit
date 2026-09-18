# moonbit Pi extension

Wraps `moon ide` subcommands (plus `check`, `test`, and the `fmt`+`info`
handoff) as discrete Pi tools, so the model reaches for compiler-aware
navigation instead of grepping `.mbt` source.

[https://www.npmjs.com/package/pi-moonbit](https://www.npmjs.com/package/pi-moonbit)

## Install

One of

```bash
pi install npm:pi-moonbit

pi install git:git@github.com:kaashyapan/pi-moonbit.git

pi install https://github.com/kaashyapan/pi-moonbit.git

```

## Tools registered

**Navigation / IDE**

- `moon_peek_def` — resolve a definition, with source context
- `moon_find_references` — find usages across dependents
- `moon_type_info` — type and docs at a position (wraps `moon ide hover`)
- `moon_outline` — structure of a file or package (positional path)
- `moon_rename` — compute rename edits (dry run unless `apply: true`)
- `moon_analyze` — public API usage counts
- `moon_doc` — search exported APIs/docs
- `moon_error_explain` - Explain an error code

**Build / quality**

- `moon_check` — static analysis via `moon check --output-json`, summarized
- `moon_test` — run tests (`-p`, `--target`, optional `--update`)
- `moon_fmt_info` — `moon fmt` then `moon info` (handoff sequence)

## Caveat
- The extension defaults to run its tools on the wasm-gc target for speed. 
- The LLM can override with the supported_target. 
- If the LLM fails to do that, the tools may not work.
- If you encounter problems raise an issue

## Why these tools - Token efficiency

1. Calling dedicated tools that return json instead of streaming to and from bash is more token efficient.
2. Keeping in `pi` spirit with minimal prompting, the package includes ./extensions/AGENTS.md file.
3. Some QOL improvements, like moon check does not return diagnostic messages from dependencies.
4. The error explain tool will placed to save a lot of tokens, where the model only needs to look up the error code necessary instead of running an explain on the entire project.
5. Better tool reliability. You can be more sure that the model will use the tool for the purpose.
Higher chances of it picking moon ide over grep on the entire codebase. Verify with tool-stats.

## Important

It is Important that your skills and AGENTS.md and other prompt files DO NOT mention 
moon check, moon ide, moon test etc..

The package prompt already includes the necessary instructions

The package blocks running these commands over bash. Giving these instructions will most likely
confuse the model.

