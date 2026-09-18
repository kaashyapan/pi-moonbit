## MoonBit tooling

This project has dedicated tools for operating with moonbit files.
MUST USE these tools for working with moonbit files.

| Call this tool         | Tool function / Why run this                                        | When                                                       |
| ---------------------- | ------------------------------------------------------------------- | ---------------------------------------------------------- |
| `moon_check`           | Static analysis for MoonBit source — type and syntax.               | After every source edit. Before `moon_test`.               |
| `moon_test`            | Run tests for the current module or a scoped package.               | After `moon_check` is clean. One call per package. Only    |
|                        |                                                                     | packages that changed.                                     |
| `moon_fmt_info`        | Formats source in place, regenerates public interface (`.mbti`)     | Before handing off a change.                               |
|                        | files.                                                              |                                                            |
| `moon_peek_def`        | Resolve a symbol's definition with source, compiler-resolved.       | To resolve a definition — not grep.                        |
| `moon_find_references` | Find every usage of a symbol across dependents, compiler-resolved.  | To find call sites — not grep.                             |
| `moon_type_info`       | Type and documentation for a token at a given location.             | To check a type — not by reading and guessing from source. |
| `moon_outline`         | Structure (types, functions) of a file or package.                  | Before reading a file in full.                             |
| `moon_rename`          | Semantic rename across the workspace — understands scope/shadowing. | Instead of sed/bash text substitution for a rename.        |
| `moon_analyze`         | Public API usage counts for a package.                              | Instead of grep, to estimate usage before changing a       |
|                        |                                                                     | signature.                                                 |
| `moon_doc`             | Search exported APIs and docs, workspace and dependencies.          | Before using an API you're not certain of the current      |
|                        |                                                                     | signature.                                                 |
| `moon_explain_error`   | Explains a compiler error code.                                     | Before guessing at a fix for an error code you haven't     |
|                        |                                                                     | seen explained.                                            |

### Standard workflow

1. Locate the enclosing `moon.mod` (this is the `moon_mod_filepath` you pass
   to every tool call e.g. `/home/me/proj/moon.mod`) 
2. Locate all the packages in the project i.e each directory with a `moon.pkg`.
3. Discover available package APIs, interfaces and functions with moon_analyze & moon_outline.
4. Edit source files (`.mbt`). Indentify the package they belong to.
5. `moon_check` — fix errors before moving on.
6. `moon_test -p package_name --target target` — fix failures before moving on.
7. `moon_fmt_info` before handoff.

### Rules

- `.mbt` files are never read with grep/cat/sed to find a definition, find references, infer a
  type, or perform a rename — the tools above are compiler-resolved and more accurate.
- If a `moon_check` error/warning code's message isn't enough to know the fix, call `moon_explain_error`
  with that code before guessing.
- If `/moon_doctor` reports the toolchain isn't reachable, say so — do not work around it by
  shelling out to `moon` directly.
- Bash calls to `moon check`, `moon test`, `moon fmt`, `moon info`, or `moon ide` are
  intercepted and blocked — you will get an error naming the tool to call instead. Use the
  recommended tool directly. Other `moon` subcommands (e.g. `moon add`, `moon remove`, `moon build`)
  are not intercepted — bash is fine for those.
