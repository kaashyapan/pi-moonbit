// Translate the tools' failure marker into `isError` on the outgoing tool
// result.
//
// A tool's `execute` return value has no `isError` field in the current pi
// runtime (`AgentToolResult` does not carry one), so a failure cannot be
// flagged at the point the result is built. It is tagged with the
// `failure_flag` marker in `details` instead, and this hook — which pi runs
// after `execute` and before the result reaches the model — turns that marker
// into `isError: true` while keeping the summarized content.
//
// This is what makes the tool descriptions' "Failures are reported with
// isError: true, so treat them as something to fix" true. Without the hook the
// model sees failures, and cancellations, as ordinary successful results.
//
// Registered unconditionally, like the guide-injection hook: before the
// `moon_*` tools exist it matches nothing, and after `/reload` brings them
// online it is already in place. This mirrors the `tool_result` hook in
// `extensions/moonbit.ts`.

///|
/// Removes a property from a JavaScript object.
///
/// The marker is deleted rather than set to `undefined`: the harness spreads
/// the returned `details` onto the next event, and a present-but-undefined key
/// would still survive `Object.hasOwn` checks downstream.
extern "js" fn js_delete_key(object : @js_core.Any, key : String) -> Unit =
  #| (obj, key) => { delete obj[key] }

///|
/// The `tool_result` handler.
///
/// The event arrives as the raw JavaScript object — the generated binding does
/// not convert it to the `ToolResultEvent` enum — so `details` is read with
/// `_get`, not pattern-matched. A result without the marker is left alone
/// (`undefined`), which the runner treats as "no decision".
///
/// The marker check is a strict comparison against `true`, matching the
/// TypeScript hook's `details[FAILURE_FLAG] !== true` guard: a truthy but
/// non-boolean value does not flag the result.
fn tool_result_handler(
  event : @pi.ToolResultEvent,
  _ctx : @pi.ExtensionContext,
) -> @pi.JSValue {
  let event_any : @js_core.Any = @js_core.identity(event)
  let details = event_any._get("details")
  if @js_core.is_nullish(details) {
    return @js_core.identity(@js_core.undefined())
  }
  let anchored = details._get(failure_flag)
  let flagged = !@js_core.is_nullish(anchored) &&
    @js_core.equal(anchored, @js_core.any(true))
  if !flagged {
    return @js_core.identity(@js_core.undefined())
  }
  js_delete_key(details, failure_flag)
  js_object([
    ("details", @js_core.identity(details)),
    ("isError", @pi.JSValue::from_bool(true)),
  ])
}

///|
/// Registers the `tool_result` hook that flags failed tool results as errors.
pub fn register_tool_result(pi : @pi.ExtensionAPI) -> Unit {
  @pi.ExtensionAPI::on_tool_result(pi, tool_result_handler)
}
