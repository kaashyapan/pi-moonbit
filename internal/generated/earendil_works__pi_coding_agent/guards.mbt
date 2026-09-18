///|
pub fn[TDetails, TState] ExtensionAPI::registerTool(
  self : ExtensionAPI,
  arg0 : ToolDefinition[TSchema, TDetails, TState],
) -> Unit {
  let field_fn : (ToolDefinition[TSchema, TDetails, TState]) -> Unit = unsafeCast(
    _extension_api_registerTool_generic_get_extern_js(unsafeCast(self)),
  )
  field_fn(arg0)
}

///|
pub fn[T] ExtensionAPI::registerMessageRenderer(
  self : ExtensionAPI,
  arg0 : String,
  arg1 : (CustomMessage[T], MessageRenderOptions, Theme) -> Component?,
) -> Unit {
  let field_fn : (
    String,
    (CustomMessage[T], MessageRenderOptions, Theme) -> Component?,
  ) -> Unit = unsafeCast(
    _extension_api_registerMessageRenderer_generic_get_extern_js(
      unsafeCast(self),
    ),
  )
  field_fn(arg0, arg1)
}

///|
pub fn[T] ExtensionAPI::registerEntryRenderer(
  self : ExtensionAPI,
  arg0 : String,
  arg1 : (CustomEntry[T], EntryRenderOptions, Theme) -> Component?,
) -> Unit {
  let field_fn : (
    String,
    (CustomEntry[T], EntryRenderOptions, Theme) -> Component?,
  ) -> Unit = unsafeCast(
    _extension_api_registerEntryRenderer_generic_get_extern_js(unsafeCast(self)),
  )
  field_fn(arg0, arg1)
}

///|
pub fn ExtensionAPI::sendMessage(
  self : ExtensionAPI,
  arg0 : Pick,
  arg1 : JSValue?,
) -> Unit {
  let field_fn : (Pick, JSValue?) -> Unit = unsafeCast(
    _extension_api_sendMessage_generic_get_extern_js(unsafeCast(self)),
  )
  field_fn(arg0, arg1)
}

///|
pub fn[T] ExtensionAPI::appendEntry(
  self : ExtensionAPI,
  arg0 : String,
  arg1 : T?,
) -> Unit {
  let field_fn : (String, T?) -> Unit = unsafeCast(
    _extension_api_appendEntry_generic_get_extern_js(unsafeCast(self)),
  )
  field_fn(arg0, arg1)
}

///|
pub fn[TParams, TDetails, TState] ToolDefinition::execute(
  self : ToolDefinition[TParams, TDetails, TState],
  arg0 : String,
  arg1 : Static,
  arg2 : AbortSignal?,
  arg3 : AgentToolUpdateCallback?,
  arg4 : ExtensionContext,
) -> Promise[AgentToolResult[TDetails]] {
  let field_fn : (
    String,
    Static,
    AbortSignal?,
    AgentToolUpdateCallback?,
    ExtensionContext,
  ) -> Promise[AgentToolResult[TDetails]] = unsafeCast(
    _tool_definition_execute_get_extern_js(unsafeCast(self)),
  )
  field_fn(arg0, arg1, arg2, arg3, arg4)
}

///|
pub fn[T] ExtensionUIContext::custom(
  self : ExtensionUIContext,
  arg0 : (TUI, Theme, KeybindingsManager, (T) -> Unit) -> Promise[Component],
  arg1 : JSValue?,
) -> Promise[T] {
  let field_fn : (
    (TUI, Theme, KeybindingsManager, (T) -> Unit) -> Promise[Component],
    JSValue?,
  ) -> Promise[T] = unsafeCast(
    _extension_uicontext_custom_generic_get_extern_js(unsafeCast(self)),
  )
  field_fn(arg0, arg1)
}

///|
pub fn[TState, TArgs] ToolRenderContext::invalidate(
  self : ToolRenderContext[TState, TArgs],
) -> Unit {
  let field_fn : () -> Unit = unsafeCast(
    _tool_render_context_invalidate_get_extern_js(unsafeCast(self)),
  )
  field_fn()
}

///|
pub fn ReplacedSessionContext::sendMessage(
  self : ReplacedSessionContext,
  arg0 : Pick,
  arg1 : JSValue?,
) -> Promise[Unit] {
  let field_fn : (Pick, JSValue?) -> Promise[Unit] = unsafeCast(
    _replaced_session_context_sendMessage_generic_get_extern_js(
      unsafeCast(self),
    ),
  )
  field_fn(arg0, arg1)
}

///|
pub fn[T] Promise::then(self : Promise[T], on_ok : (T) -> Unit) -> Unit {
  _promise_then_extern_js(unsafeCast(self), unsafeCast(on_ok))
}

///|
pub fn[T] Promise::then_catch(
  self : Promise[T],
  on_ok : (T) -> Unit,
  on_err : (JSValue) -> Unit,
) -> Unit {
  _promise_then_catch_extern_js(unsafeCast(self), unsafeCast(on_ok), on_err)
}

///|
pub fn[T, U] Promise::map(self : Promise[T], f : (T) -> U) -> Promise[U] {
  unsafeCast(_promise_map_extern_js(unsafeCast(self), unsafeCast(f)))
}

///|
pub async fn[T] Promise::wait(self : Promise[T]) -> T {
  let raw = _promise_suspend_js(fn(ok, err) {
    _promise_then_catch_extern_js(unsafeCast(self), ok, fn(e) {
      err(JsRejection(e))
    })
  })
  unsafeCast(raw)
}

///|
/// Lift a MoonBit async fn into a JS promise: raises become rejections,
/// including raises that happen before the first suspension.
pub fn[T] Promise::from_async(f : async () -> T) -> Promise[T] {
  unsafeCast(
    _promise_ctor_extern_js(fn(resolve, reject) {
      _start_async_extern_js(async fn() {
        try {
          let value = f()
          resolve(unsafeCast(value))
        } catch {
          e => reject(unsafeCast(e))
        }
      })
    }),
  )
}

///|
pub fn run_async(f : async () -> Unit) -> Unit {
  _start_async_extern_js(async fn() {
    f() catch {
      e => _async_error_exit_extern_js(unsafeCast(e))
    }
  })
}

///|
fn[A, B] unsafeCast(value : A) -> B = "%identity"

///|
pub fn parseSkillBlock(text : String) -> ParsedSkillBlock? {
  __ts_mbt_wrap_option_return(unsafeCast(parse_skill_block(text)))
}

///|
pub fn readStoredCredential(
  providerId : String,
  authPath : String?,
) -> Credential? {
  __ts_mbt_wrap_option_return(
    unsafeCast(read_stored_credential(providerId, authPath)),
  )
}

///|
pub fn getLastAssistantUsage(entries : Array[SessionEntry]) -> Usage? {
  __ts_mbt_wrap_option_return(unsafeCast(get_last_assistant_usage(entries)))
}

///|
pub fn getLatestCompactionEntry(
  entries : Array[SessionEntry],
) -> CompactionEntry[JSValue]? {
  __ts_mbt_wrap_option_return(unsafeCast(get_latest_compaction_entry(entries)))
}
