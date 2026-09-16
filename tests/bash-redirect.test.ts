import { BASH_REDIRECTS, findBashRedirect } from "../extensions/bash-redirect.ts";
import { describe, expect, test, beforeAll } from "bun:test";

describe("findBashRedirect", () => {
    test("every configured redirect matches its canonical command", () => {
        for (const r of BASH_REDIRECTS) {
            // derive the canonical command from the regex itself (strip the
            // command-position anchors and expand the whitespace class)
            const sample = r.match.source
                .replace(/[\^\$]|\\b/g, "")
                .replace(/\\s\+/g, " ");
            expect(findBashRedirect(sample)).toBeDefined();
        }
    });

    test("matches chained commands at command positions", () => {
        expect(findBashRedirect("cd /tmp && moon test -p ok")?.tool).toBe("moon_test");
        expect(findBashRedirect("moon fmt && moon info")?.tool).toBe("moon_fmt_info");
        expect(findBashRedirect("$(moon check) | head")?.tool).toBe("moon_check");
    });

    test("does not match mentions inside quoted arguments", () => {
        // the case that motivated the fix: a command whose argument text merely
        // mentions a moon subcommand must pass through to bash
        expect(findBashRedirect("perl -e 's/.../moon ide hover/' README.md")).toBeUndefined();
        expect(findBashRedirect('echo "moon test"')).toBeUndefined();
        expect(findBashRedirect("grep 'moon check' notes.md")).toBeUndefined();
    });

    test("does not match mentions at non-command positions", () => {
        expect(findBashRedirect("echo use the moon check tool")).toBeUndefined();
    });

    test("maps the moon subcommands the tools wrap", () => {
        expect(findBashRedirect("moon check --output-json -p foo")?.tool).toBe("moon_check");
        expect(findBashRedirect("moon test -p foo --target wasm-gc")?.tool).toBe("moon_test");
        expect(findBashRedirect("moon fmt && moon info")?.tool).toBe("moon_fmt_info");
        expect(findBashRedirect("moon ide peek-def foo --json")?.tool).toBe("moon_peek_def");
        expect(findBashRedirect("moon ide rename old new --loc x.mbt")?.tool).toBe("moon_rename");
    });

    test("does not match non-moon or glued commands", () => {
        expect(findBashRedirect("ls -la")).toBeUndefined();
        expect(findBashRedirect("mooncheck")).toBeUndefined();
        expect(findBashRedirect("cat moon/check.txt")).toBeUndefined();
        expect(findBashRedirect("moon build")).toBeUndefined();
    });
});
