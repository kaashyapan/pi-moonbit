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
      "MoonBit: Peek Definition - Resolve a MoonBit symbol's definition and show source context. Prefer this over grepping .mbt files for a declaration. Provide either `symbol` (e.g. 'Array::length', '@pkg.foo') or `loc`, or both to disambiguate.",
    parameters: Type.Object({
      symbol: Type.Optional(
        Type.String({
          description: "Symbol query, e.g. 'foo', '@pkg.foo', 'Type::member'.",
        }),
      ),
      loc: LocParam,
    }),
    promptGuidelines: [
      "`moon ide peek-def <symbol>`, `moon ide peek-def <token> --loc <path[:line[:col]]>`, `moon ide peek-def --loc <path:line:col>`",
      "Accepted symbol forms: `foo`, `@pkg.foo`, `Type::member`, `@pkg.Type::member`, `Trait::method`",
      "Output: matching definitions with inline source context as json."
    ],
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
      "MoonBit: Find References - Find all usages of a MoonBit symbol across dependents. Prefer this over grepping for a name — it's compiler-resolved, so it correctly follows type-directed dispatch that text search can't. Provide `symbol`.",
    parameters: Type.Object({
      symbol: Type.Optional(
        Type.String({ description: "Symbol query, e.g. 'println', '@pkg.foo'." }),
      ),
      loc: LocParam,
    }),
    promptGuidelines: [
      "Accepted symbol forms: `foo`, `@pkg.foo`, `Type::member`, `@pkg.Type::member`, `Trait::method`",
      "Output: the resolved definition followed by all reference locations as json."
    ],
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
      "MoonBit: Type Info - Show the type and docs for whatever is at a source position (wraps `moon ide hover`; there is no interactive hover for an LLM). Requires `loc` with a line number.",
    parameters: Type.Object({
      loc: Type.String({
        description: "Source location, path:line[:col], 1-based. Line is required.",
      }),
      symbol: Type.Optional(
        Type.String({ description: "Optional symbol name to disambiguate at that position." }),
      ),
    }),
    promptGuidelines: ["Output: highlighted source context plus type and documentation text."],
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
      "MoonBit: Outline - Summarize the structure (types, functions, etc.) of a MoonBit file or package. Use this to orient in a file instead of reading it whole or grepping for declarations. Pass a file or directory path; omit to outline the current package.",
    parameters: Type.Object({
      path: Type.Optional(
        Type.String({
          description:
            "File or package/directory path (positional argument to `moon ide outline`). e.g. '.', './src/lib.mbt'. Omit to outline the current package.",
        }),
      ),
    }),
    promptGuidelines: ["Output: declaration snippets with line numbers."],
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
      "MoonBit: Rename Symbol - Compute semantic rename edits for a MoonBit symbol across the workspace. Defaults to a dry run (returns the edit set without writing). Set apply: true only after reviewing the dry-run output, since this rewrites files on disk.",
    parameters: Type.Object({
      old_name: Type.String({ description: "Current symbol name." }),
      new_name: Type.String({ description: "New symbol name." }),
      loc: Type.String({ description: "Location disambiguating which declaration to rename, path[:line]." }),
      apply: Type.Optional(
        Type.Boolean({ description: "If true, rewrite files. Defaults to false (dry run)." }),
      ),
    }),
    promptGuidelines: [
      "Without --loc, <symbol> is treated as a semantic query and searched across the current module or workspace.",
      "With file-only --loc, the initial symbol lookup is restricted to that file.",
      "With line or column in --loc, the symbol is resolved from the exact source position first. Use this for local variables, shadowed names, or ambiguous symbols.",
      "Accepted symbol forms: `foo`, `@pkg.foo`, `Type::member`, `@pkg.Type::member`",
      "Output: a patch-style edit list. With --apply, rewrites files and prints a summary."],
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
      "MoonBit: Analyze API Usage - Report public API usage counts for a package. Pass a package directory to scope the report; omit to analyze all local packages in the module.",
    parameters: Type.Object({
      path: Type.Optional(
        Type.String({
          description:
            "Package directory to scope the analysis, e.g. './types'. Omit to analyze all local packages. NOTE: this maps to the positional <package-dir> argument of `moon ide analyze`; it does not take a symbol name.",
        }),
      ),
    }),
    promptGuidelines: ["Output: exported items annotated with usage counts."],
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
      "MoonBit: Search Docs - Search exported APIs and documentation across the workspace and its dependencies, e.g. `@json`. Prefer this over guessing API signatures from memory.",
    parameters: Type.Object({
      query: Type.String({ description: "Doc/API search query, e.g. '@json' or a function name." }),
    }),
    promptGuidelines: ["Output: package lists, symbol summaries, or detailed documentation views."],
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      return toContent(await runMoonIde(["doc", "--no-check", params.query], ctx?.cwd, signal));
    },
  });
}
