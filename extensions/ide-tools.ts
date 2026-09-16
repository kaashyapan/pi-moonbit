// The `moon ide` navigation tools: peek-def, find-references, hover,
// outline, rename, analyze, doc.
//
// Every tool passes --no-check so an ide call doesn't pay for a full
// project check (moon_check owns that job). On a cold module — no prior
// check state — the ide runner in shared.ts transparently retries once
// with the check.
//
// `moon ide` subcommands differ in --json support: on moon 0.1.20260904
// only peek-def, find-references and hover accept it, while outline, doc,
// analyze and rename reject it ("unknown option"). So each tool passes
// --json only where the subcommand allows it; runMoonIde still tries to
// parse JSON and falls back to the raw text otherwise.

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";
import { LocParam, runMoonIde, toContent } from "./shared";

export function registerIdeTools(pi: ExtensionAPI) {
  pi.registerTool({
    name: "moon_peek_def",
    label: "MoonBit: Peek Definition",
    description:
      "Resolve a MoonBit symbol's definition with source context. Do NOT run `moon ide peek-def` " +
      "via bash — call this tool instead; it's compiler-resolved, unlike grepping .mbt files, which " +
      "can't follow type-directed dispatch or re-exports. Provide `symbol` (e.g. 'Array::length', " +
      "'@pkg.foo'), `loc` (path[:line[:col]]), or both to disambiguate an overloaded or shadowed name.",
    parameters: Type.Object({
      symbol: Type.Optional(
        Type.String({
          description: "Symbol query, e.g. 'foo', '@pkg.foo', 'Type::member'.",
        }),
      ),
      loc: LocParam,
    }),
    promptGuidelines: [
      "Use this tool, not bash or `moon ide peek-def`, to resolve a definition.",
      "Accepted symbol forms: foo, @pkg.foo, Type::member, @pkg.Type::member, Trait::method.",
      "If `symbol` alone is ambiguous, add `loc` to narrow it to a specific file/position.",
    ],
    promptSnippet:
      "moon_peek_def replaces `moon ide peek-def` — use it instead of grepping or shelling out.",
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["peek-def", "--no-check", "--json"];
      if (params.symbol) args.splice(1, 0, params.symbol);
      if (params.loc) args.push("--loc", params.loc);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_find_references",
    label: "MoonBit: Find References",
    description:
      "Find all usages of a MoonBit symbol across dependents. Do NOT grep or run `moon ide " +
      "find-references` via bash — this tool is compiler-resolved, so it correctly follows " +
      "type-directed dispatch and trait implementations that text search misses entirely. " +
      "Provide `symbol` (e.g. 'println', '@pkg.foo'), optionally `loc` to disambiguate.",
    parameters: Type.Object({
      symbol: Type.Optional(
        Type.String({ description: "Symbol query, e.g. 'println', '@pkg.foo'." }),
      ),
      loc: LocParam,
    }),
    promptGuidelines: [
      "Use this tool, not grep or bash, whenever you need every call site of a symbol.",
      "Accepted symbol forms: foo, @pkg.foo, Type::member, @pkg.Type::member, Trait::method.",
      "Result includes the resolved definition first, then all reference locations.",
    ],
    promptSnippet:
      "moon_find_references replaces grep/`moon ide find-references` for symbol usage search.",

    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["find-references", "--no-check", "--json"];
      if (params.symbol) args.splice(1, 0, params.symbol);
      if (params.loc) args.push("--loc", params.loc);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_type_info",
    label: "MoonBit: Type Info",
    description:
      "Type inference and documentation for whatever is at a specific position. " +
      " — do NOT try to infer " +
      "the type by reading surrounding source via bash/cat; call this tool with `loc` instead. " +
      "Requires `loc` with a line number; add `symbol` only to disambiguate multiple items on one line.",
    parameters: Type.Object({
      loc: Type.String({
        description: "Source location, path:line[:col], 1-based. Line is required.",
      }),
      symbol: Type.Optional(
        Type.String({ description: "Optional symbol name to disambiguate at that position." }),
      ),
    }),
    promptGuidelines: [
      "Use this tool instead of reading source and guessing a type from context.",
      "`loc` must include a line number (path:line[:col], 1-based); column narrows further.",
    ],
    promptSnippet: "moon_type_info is the hover equivalent — always prefer it over reading source to infer a type.",
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["hover", "--no-check", "--json", "--loc", params.loc];
      if (params.symbol) args.splice(1, 0, params.symbol);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_outline",
    label: "MoonBit: Outline",
    description:
      "Summarize the structure (types, functions, etc.) of a MoonBit file or package. Do NOT read " +
      "the whole file or grep for declarations to orient yourself — call this tool first. Pass a " +
      "file or directory `path`; omit to outline the current package.",
    parameters: Type.Object({
      path: Type.Optional(
        Type.String({
          description:
            "File or package/directory path (positional argument to `moon ide outline`). e.g. '.', './src/lib.mbt'. Omit to outline the current package.",
        }),
      ),
    }),
    promptGuidelines: [
      "Call this before reading a file in full, to see its shape first.",
      "Omit `path` to outline the current package; pass a file path for just that file.",
    ],
    promptSnippet: "moon_outline replaces reading-the-whole-file-to-orient — call it first.",

    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["outline", "--no-check"];
      if (params.path) args.push(params.path);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_rename",
    label: "MoonBit: Rename Symbol",
    description:
      "Compute semantic rename edits for a MoonBit symbol across the workspace. Do NOT do a " +
      "find-and-replace via bash/sed for a rename — that misses scoping and shadowing that this " +
      "tool resolves correctly. Defaults to a dry run (returns the edit set without writing); set " +
      "apply: true only after reviewing the dry-run output, since that rewrites files on disk.",
    parameters: Type.Object({
      old_name: Type.String({ description: "Current symbol name." }),
      new_name: Type.String({ description: "New symbol name." }),
      loc: Type.String({ description: "Location disambiguating which declaration to rename, path[:line]." }),
      apply: Type.Optional(
        Type.Boolean({ description: "If true, rewrite files. Defaults to false (dry run)." }),
      ),
    }),
    promptGuidelines: [
      "Never use sed/bash text substitution to rename a MoonBit symbol — use this tool.",
      "Always review the dry-run (apply omitted/false) output before calling again with apply: true.",
      "Give `loc` with a line/column when renaming a local variable, a shadowed name, or an "
      + "otherwise ambiguous symbol; a file-only loc restricts the initial lookup to that file.",
      "Accepted symbol forms: foo, @pkg.foo, Type::member, @pkg.Type::member.",
    ],
    promptSnippet:
      "moon_rename replaces sed/bash renames — it understands scope and shadowing; dry-run by default.",

    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      // NOTE: `moon ide rename` rejects --json (moon 0.1.20260904); its
      // output is a patch-style edit list (or an apply summary).
      const args = ["rename", params.old_name, params.new_name, "--no-check", "--loc", params.loc];
      if (params.apply) args.push("--apply");
      const result = await runMoonIde(args, ctx?.cwd, signal);
      if (!params.apply && result.ok && !result.aborted) {
        result.raw =
          "[DRY RUN — no files written; call again with apply: true to rewrite]\n" + result.raw;
      }
      return toContent(result);
    },
  });

  pi.registerTool({
    name: "moon_analyze",
    label: "MoonBit: Analyze API Usage",
    description:
      "Report public API usage counts for a package. Do NOT grep call sites to estimate usage — " +
      "this tool gives compiler-verified counts. Pass a package directory (`path`) to scope the " +
      "report; omit to analyze all local packages in the module.",
    parameters: Type.Object({
      path: Type.Optional(
        Type.String({
          description:
            "Package directory to scope the analysis, e.g. './types'. Omit to analyze all local packages. NOTE: this maps to the positional <package-dir> argument of `moon ide analyze`; it does not take a symbol name.",
        }),
      ),
    }),
    promptGuidelines: [
      "Use this instead of grepping for call sites when you need usage counts, e.g. before removing "
      + "or changing a public API.",
      "`path` is a package directory (e.g. './types'), not a symbol name.",
    ],
    promptSnippet: "moon_analyze replaces grep-for-usage-counts with compiler-verified numbers.",
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const args = ["analyze", "--no-check"];
      if (params.path) args.push(params.path);
      return toContent(await runMoonIde(args, ctx?.cwd, signal));
    },
  });

  pi.registerTool({
    name: "moon_doc",
    label: "MoonBit: Search Docs",
    description:
      "Search exported APIs and documentation across the workspace and its dependencies. Do NOT " +
      "guess an API's signature from memory or training data — MoonBit APIs change between " +
      "versions; call this tool to confirm the actual current signature and docs.",
    parameters: Type.Object({
      query: Type.String({ description: "Doc/API search query, e.g. '@json' or a function name." }),
    }),
    promptGuidelines: [
      "Call this before using an API you're not 100% certain of the current signature.",
      "Query can be a package (e.g. '@json') or a function/type name.",
    ],
    promptSnippet: "moon_doc replaces guessing API signatures from memory — always check here first.",
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      return toContent(await runMoonIde(["doc", "--no-check", params.query], ctx?.cwd, signal));
    },
  });
}
