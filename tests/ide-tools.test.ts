// Tests for the IDE tool descriptions and schemas.
//
// These assert the contract each tool advertises to the model, not the exact
// prose. The behaviour of `moon ide` itself belongs to the moon binary; what is
// tested here is that the port does not promise something the binary refuses to
// do. Two cases were observed against the sample repositories under
// ~/moonbit-docs/next/sources and are pinned below:
//
//   - `moon ide outline` with no path errors with "at least one path is
//     required", and `outline .` errors with "could not find package for
//     folder" because a module root normally has no moon.pkg. So `path` is
//     required and cannot be the module root.
//   - `moon ide hover --loc <path>:<line>` (no column) errors with "hover
//     command requires a symbol when location has no column". So a column is
//     what makes `loc` self-sufficient.
//
// Every runner call is bounded, so a regression that hangs a subprocess fails
// the test rather than the suite.

import { describe, expect, test, beforeAll } from "bun:test";
import extensionDefault from "../extensions/index.js";

const SAMPLE_ROOT = "/home/moondev/moonbit-docs/next/sources";
const LANGUAGE_MOD = `${SAMPLE_ROOT}/language/moon.mod`;
const ASYNC_MOD = `${SAMPLE_ROOT}/async/moon.mod`;

const tools = new Map<string, any>();
let execCommands: string[][] = [];

// Stub ExtensionAPI with a real subprocess runner, so the sample repositories
// are exercised through the installed `moon`.
function makeStubPi() {
  return {
    registerTool: (tool: any) => tools.set(tool.name, tool),
    registerCommand: () => {},
    on: () => {},
    exec: async (command: string, args: string[], options: any) => {
      const { spawnSync } = await import("node:child_process");
      execCommands.push([command, ...args]);
      const r = spawnSync(command, args, {
        encoding: "utf8",
        cwd: options?.cwd,
        timeout: 120_000,
      });
      return {
        stdout: r.stdout ?? "",
        stderr: r.stderr ?? "",
        code: r.status ?? 1,
        killed: false,
      };
    },
  };
}

beforeAll(async () => {
  await (extensionDefault as any)(makeStubPi());
});

function schema(name: string) {
  const tool = tools.get(name);
  if (!tool) throw new Error(`tool ${name} not registered`);
  return tool.parameters;
}

async function execute(name: string, params: Record<string, unknown>) {
  const tool = tools.get(name);
  if (!tool) throw new Error(`tool ${name} not registered`);
  return await tool.execute("id", params, undefined, undefined, {});
}

describe("ide tool schemas", () => {
  test("moon_outline requires path, and does not advertise the module root", () => {
    const s = schema("moon_outline");
    expect(s.required).toContain("path");
    // The description must not suggest '.' or a bare 'src/' works everywhere.
    expect(s.properties.path.description).toContain("moon.pkg");
    const all = JSON.stringify(s) + JSON.stringify(tools.get("moon_outline").description);
    expect(all).not.toContain("Omit to outline the current package");
    expect(all).not.toContain("omit to outline the current package");
  });

  test("moon_type_info explains the column requirement", () => {
    const tool = tools.get("moon_type_info");
    const all = JSON.stringify(tool.parameters) + tool.description + tool.promptGuidelines.join(" ");
    // A line-only loc needs `symbol`; the schema must say so, since the moon
    // binary rejects the combination silently otherwise.
    expect(all).toContain("symbol");
    expect(all.toLowerCase()).toContain("column");
  });

  test("moon_workspace_symbols is registered with the expected schema", () => {
    const s = schema("moon_workspace_symbols");
    expect(s.required).toEqual(["moon_mod_filepath", "query"]);
    expect(s.properties.query.type).toBe("string");
    expect(s.properties.moon_mod_filepath.type).toBe("string");
  });

  test("moon_analyze points at itself for package discovery", () => {
    const tool = tools.get("moon_analyze");
    const all = JSON.stringify(tool.parameters) + tool.promptGuidelines.join(" ");
    // The corrected guidance sends the model here when it needs package paths.
    expect(all).toMatch(/discover|list/i);
  });
});

describe("ide tools against the sample repositories", () => {
  test("moon_analyze with no path lists the module's local packages", async () => {
    execCommands = [];
    const res = await execute("moon_analyze", { moon_mod_filepath: LANGUAGE_MOD });
    expect(res.details.ok).toBe(true);
    const text = res.content[0].text;
    // Several packages of the language sample must be named.
    expect(text).toContain("package \"moonbit-community/language/error\"");
    expect(text).toContain("package \"moonbit-community/language/attributes\"");
  }, 180_000);

  test("moon_outline works on a package directory", async () => {
    const res = await execute("moon_outline", {
      moon_mod_filepath: LANGUAGE_MOD,
      path: "./src/error",
    });
    expect(res.details.ok).toBe(true);
    // `suberror` only appears in that package's top.mbt.
    expect(res.content[0].text).toContain("suberror E1");
  }, 180_000);

  test("moon_outline on a package-directory path succeeds where '.' fails", async () => {
    const bad = await execute("moon_outline", { moon_mod_filepath: LANGUAGE_MOD, path: "." });
    expect(bad.details.flagsDiagnosticFailure).toBe(true);
    expect(bad.content[0].text).toContain("could not find package");

    const good = await execute("moon_outline", { moon_mod_filepath: ASYNC_MOD, path: "./src" });
    expect(good.details.ok).toBe(true);
    expect(good.content[0].text).toContain("async fn");
  }, 180_000);

  test("moon_workspace_symbols finds a symbol by name", async () => {
    const res = await execute("moon_workspace_symbols", {
      moon_mod_filepath: ASYNC_MOD,
      query: "my_async_function",
    });
    expect(res.details.ok).toBe(true);
    const body = JSON.parse(res.content[0].text);
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBeGreaterThan(0);
    expect(body[0].location.path).toContain("async.mbt");
  }, 180_000);

  test("moon_type_info needs a column, as the schema warns", async () => {
    const lineOnly = await execute("moon_type_info", {
      moon_mod_filepath: LANGUAGE_MOD,
      loc: "./src/error/top.mbt:18",
    });
    expect(lineOnly.details.flagsDiagnosticFailure).toBe(true);
    expect(lineOnly.content[0].text).toContain("requires a symbol");

    const withColumn = await execute("moon_type_info", {
      moon_mod_filepath: LANGUAGE_MOD,
      loc: "./src/error/top.mbt:18:4",
    });
    expect(withColumn.details.ok).toBe(true);
  }, 180_000);
});
