// Extension entry point.
//
// The MoonBit compiler always emits a named export, so the compiled artifact
// exposes the extension factory as `default_main`. pi requires the module's
// default export to be the factory, so this file re-exports it as `default`.
//
// Re-exporting (rather than wrapping the call) matters: `default_main` is
// async, because it probes the toolchain before registering anything. pi does
// `await factory(api)` and then commits, so the factory must return that
// promise for the registration to be visible at commit time.
export { default_main as default } from "./moonext.js";
