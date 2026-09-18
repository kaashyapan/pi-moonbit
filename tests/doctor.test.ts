// Tests for the /moon-doctor command and its reachability probe.
//
// The extension is compiled to JavaScript by `moon build`, and the compiled
// module exposes only `default_main` — the extension factory. So these tests
// load the built bundle, install it into a stub ExtensionAPI, and drive the
// registered `moon-doctor` command through its public surface.
//
// Behaviour tests replace `exec` with a stub so they do not depend on the
// toolchain being installed. One test runs against the real `moon` binary.

import { describe, expect, test, beforeAll } from "bun:test";
import extensionDefault from "../extensions/index.js";
import { realExec } from "./helpers";

const commands = new Map<string, any>();
const tools = new Map<string, any>();

// A minimal stand-in for ExtensionCommandContext: the command handler only
// reads `signal` and calls `ui.notify`.
function makeContext() {
  const notifications: Array<{ message: string; level?: string }> = [];
  const ctx = {
    signal: undefined as AbortSignal | undefined,
    ui: {
      notify: (message: string, level?: string) => {
        notifications.push({ message, level });
      },
    },
  };
  return { ctx, notifications };
}

// A stub ExtensionAPI whose `exec` returns whatever `probe` decides. The
// extension probes `moon version` once at startup and again per command run,
// so the callback is invoked with each call's args.
function makeStubPi(probe: (args: string[]) => any) {
  return {
    registerTool: (tool: any) => tools.set(tool.name, tool),
    registerCommand: (name: string, spec: any) => commands.set(name, spec),
    on: () => { },
    exec: async (_command: string, args: string[]) => probe(args),
  };
}

const okProbe = () => ({
  stdout: "moon 0.1.20260904 (test)\n",
  stderr: "",
  code: 0,
  killed: false,
});

beforeAll(() => {
  commands.clear();
  tools.clear();
});

describe("moon-doctor command registration", () => {
  test("registers moon-doctor with a description and handler", async () => {
    commands.clear();
    await (extensionDefault as any)(
      makeStubPi((args) => (args.includes("version") ? okProbe() : okProbe())),
    );
    expect(commands.has("moon-doctor")).toBe(true);
    const spec = commands.get("moon-doctor");
    expect(typeof spec.handler).toBe("function");
    expect(spec.description).toContain("MoonBit toolchain");
  });

  test("is registered even when the startup probe fails", async () => {
    commands.clear();
    const isolatedTools = new Map<string, any>();
    const pi = {
      registerTool: (tool: any) => isolatedTools.set(tool.name, tool),
      registerCommand: (name: string, spec: any) => commands.set(name, spec),
      on: () => { },
      exec: async () => ({ stdout: "", stderr: "`moon` is not on PATH", code: 1, killed: false }),
    };
    await (extensionDefault as any)(pi);
    // The doctor exists precisely to explain why the tools are missing.
    expect(commands.has("moon-doctor")).toBe(true);
    expect(isolatedTools.size).toBe(0);
  });
});

describe("moon-doctor reporting", () => {
  test("reports the version when moon is reachable and tools are live", async () => {
    commands.clear();
    await (extensionDefault as any)(
      makeStubPi((args) => (args.includes("version") ? okProbe() : okProbe())),
    );
    const { ctx, notifications } = makeContext();
    await commands.get("moon-doctor").handler("", ctx);

    expect(notifications).toHaveLength(1);
    expect(notifications[0].level).toBe("info");
    expect(notifications[0].message).toContain("moon is reachable");
    expect(notifications[0].message).toContain("moon 0.1.20260904 (test)");
    expect(notifications[0].message).toContain("are active");
  });

  test("reports the failure reason when moon is not reachable", async () => {
    commands.clear();
    await (extensionDefault as any)(
      makeStubPi(() => ({
        stdout: "",
        stderr: "`moon` is not on PATH",
        code: 1,
        killed: false,
      })),
    );
    const { ctx, notifications } = makeContext();
    await commands.get("moon-doctor").handler("", ctx);

    expect(notifications).toHaveLength(1);
    expect(notifications[0].level).toBe("error");
    expect(notifications[0].message).toContain("moon is not reachable");
    expect(notifications[0].message).toContain("`moon` is not on PATH");
    expect(notifications[0].message).toContain("Install the MoonBit toolchain");
    expect(notifications[0].message).toContain("MoonBit tools are not registered");
  });

  test("reports a timeout", async () => {
    commands.clear();
    await (extensionDefault as any)(
      makeStubPi((args) =>
        args.includes("version")
          ? { stdout: "", stderr: "", code: 1, killed: true }
          : okProbe(),
      ),
    );
    // Startup probe timed out, so the tools are not registered, but the
    // command is registered and re-probes on demand.
    const { ctx, notifications } = makeContext();
    await commands.get("moon-doctor").handler("", ctx);
    expect(notifications[0].level).toBe("error");
    expect(notifications[0].message).toContain("timed out");
  });

  test("tells the user to reload when PATH was fixed mid-session", async () => {
    commands.clear();
    let call = 0;
    await (extensionDefault as any)(
      makeStubPi(() => {
        call += 1;
        // First call is the startup probe; later calls are the command probe.
        return call === 1
          ? { stdout: "", stderr: "not on PATH", code: 1, killed: false }
          : okProbe();
      }),
    );
    const { ctx, notifications } = makeContext();
    await commands.get("moon-doctor").handler("", ctx);

    expect(notifications).toHaveLength(1);
    expect(notifications[0].level).toBe("info");
    expect(notifications[0].message).toContain("moon is reachable");
    expect(notifications[0].message).toContain("NOT registered at startup");
    expect(notifications[0].message).toContain("/reload");
  });
});


describe("moon-doctor against the real toolchain", () => {
  test(
    "reports a reachable toolchain with its version",
    async () => {
      commands.clear();
      const pi = {
        registerTool: () => { },
        registerCommand: (name: string, spec: any) => commands.set(name, spec),
        on: () => { },
        exec: realExec,
      };
      await (extensionDefault as any)(pi);
      const { ctx, notifications } = makeContext();
      await commands.get("moon-doctor").handler("", ctx);

      expect(notifications).toHaveLength(1);
      expect(notifications[0].level).toBe("info");
      expect(notifications[0].message).toMatch(/moon is reachable — moon \d/);
    },
    30_000,
  );
});
