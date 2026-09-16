# moonbit Pi extension

Wraps `moon ide` subcommands (plus `check`, `test`, and the `fmt`+`info`
handoff) as discrete Pi tools, so the model reaches for compiler-aware
navigation instead of grepping `.mbt` source.

## Install

Project-local (recommended to start). The extension is modular, so copy the
whole `extensions/` directory — `moonbit.ts` imports the other modules:

```bash
pi install npm:pi-moonbit
```

## Caveat
- The extension defaults to run its tools on the wasm-gc target for speed. 
- The LLM can override with the supported_target. 
- If the LLM fails to do that, the tools may not work.
- If you encounter problems raise an issue

## Tools registered

**Navigation / IDE**

- `moon_peek_def` — resolve a definition, with source context
- `moon_find_references` — find usages across dependents
- `moon_type_info` — type and docs at a position (wraps `moon ide hover`)
- `moon_outline` — structure of a file or package (positional path)
- `moon_rename` — compute rename edits (dry run unless `apply: true`)
- `moon_analyze` — public API usage counts
- `moon_doc` — search exported APIs/docs

**Build / quality**

- `moon_check` — static analysis via `moon check --output-json`, summarized
- `moon_test` — run tests (`-p`, `--target`, optional `--update`)
- `moon_fmt_info` — `moon fmt` then `moon info` (handoff sequence)

## Sequencing

1. Edit .mbt source file
2. `moon_check --diagnostic-limit 1` (Check if there are errors)  
3. `moon_check` (cheap, catch type/syntax errors)  
4. `moon_test` (after check is clean)  
5. `moon_fmt_info` before handoff
