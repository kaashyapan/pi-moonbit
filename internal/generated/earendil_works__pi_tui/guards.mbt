///|
pub fn[ParserOutput, RendererOutput] RendererExtension::renderer(
  self : RendererExtension[ParserOutput, RendererOutput],
  arg0 : RendererThis[ParserOutput, RendererOutput],
  arg1 : Tokens_Generic,
) -> Auto_FalseValue_or_RendererOutputValue? {
  let field_fn : (RendererThis[ParserOutput, RendererOutput], Tokens_Generic) -> Auto_FalseValue_or_RendererOutputValue? = unsafeCast(
    _renderer_extension_renderer_get_extern_js(unsafeCast(self)),
  )
  field_fn(arg0, arg1)
}

///|
pub fn[ParserOutput, RendererOutput] new_marked(
  args : Array[MarkedExtension[ParserOutput, RendererOutput]],
) -> Marked[ParserOutput, RendererOutput] {
  unsafeCast(_new_marked_extern_js(unsafeCast(args)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_defaults(
  self : Marked[ParserOutput, RendererOutput],
) -> MarkedOptions[ParserOutput, RendererOutput] {
  unsafeCast(_get_marked_defaults_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_defaults(
  self : Marked[ParserOutput, RendererOutput],
  value : MarkedOptions[ParserOutput, RendererOutput],
) -> Unit {
  _set_marked_defaults_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_options(
  self : Marked[ParserOutput, RendererOutput],
) -> (MarkedOptions[ParserOutput, RendererOutput]) -> This {
  unsafeCast(_get_marked_options_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_options(
  self : Marked[ParserOutput, RendererOutput],
  value : (MarkedOptions[ParserOutput, RendererOutput]) -> This,
) -> Unit {
  _set_marked_options_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_parse(
  self : Marked[ParserOutput, RendererOutput],
) -> JSValue {
  unsafeCast(_get_marked_parse_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_parse(
  self : Marked[ParserOutput, RendererOutput],
  value : JSValue,
) -> Unit {
  _set_marked_parse_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_parse_inline(
  self : Marked[ParserOutput, RendererOutput],
) -> JSValue {
  unsafeCast(_get_marked_parse_inline_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_parse_inline(
  self : Marked[ParserOutput, RendererOutput],
  value : JSValue,
) -> Unit {
  _set_marked_parse_inline_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_parser(
  self : Marked[ParserOutput, RendererOutput],
) -> MarkedParser {
  unsafeCast(_get_marked_parser_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_parser(
  self : Marked[ParserOutput, RendererOutput],
  value : MarkedParser,
) -> Unit {
  _set_marked_parser_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_renderer(
  self : Marked[ParserOutput, RendererOutput],
) -> MarkedRenderer {
  unsafeCast(_get_marked_renderer_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_renderer(
  self : Marked[ParserOutput, RendererOutput],
  value : MarkedRenderer,
) -> Unit {
  _set_marked_renderer_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_text_renderer(
  self : Marked[ParserOutput, RendererOutput],
) -> MarkedTextRenderer {
  unsafeCast(_get_marked_text_renderer_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_text_renderer(
  self : Marked[ParserOutput, RendererOutput],
  value : MarkedTextRenderer,
) -> Unit {
  _set_marked_text_renderer_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_lexer(
  self : Marked[ParserOutput, RendererOutput],
) -> JSValue {
  unsafeCast(_get_marked_lexer_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_lexer(
  self : Marked[ParserOutput, RendererOutput],
  value : JSValue,
) -> Unit {
  _set_marked_lexer_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_tokenizer(
  self : Marked[ParserOutput, RendererOutput],
) -> MarkedTokenizer {
  unsafeCast(_get_marked_tokenizer_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_tokenizer(
  self : Marked[ParserOutput, RendererOutput],
  value : MarkedTokenizer,
) -> Unit {
  _set_marked_tokenizer_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::get_marked_hooks(
  self : Marked[ParserOutput, RendererOutput],
) -> MarkedHooks {
  unsafeCast(_get_marked_hooks_extern_js(unsafeCast(self)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_marked_hooks(
  self : Marked[ParserOutput, RendererOutput],
  value : MarkedHooks,
) -> Unit {
  _set_marked_hooks_extern_js(unsafeCast(self), unsafeCast(value))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::options(
  self : Marked[ParserOutput, RendererOutput],
  arg0 : MarkedOptions[ParserOutput, RendererOutput],
) -> Marked[ParserOutput, RendererOutput] {
  unsafeCast(_marked_options_extern_js(unsafeCast(self), unsafeCast(arg0)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::walk_tokens(
  self : Marked[ParserOutput, RendererOutput],
  tokens : Auto_TokenArrayValue_or_TokensListValue,
  callback : (Token) -> Auto_MaybePromiseValue_or_MaybePromiseArrayValue,
) -> Array[MaybePromise] {
  unsafeCast(
    _marked_walk_tokens_extern_js(
      unsafeCast(self),
      unsafeCast(tokens),
      unsafeCast(callback),
    ),
  )
}

///|
pub fn[ParserOutput, RendererOutput] Marked::use_(
  self : Marked[ParserOutput, RendererOutput],
  args : Array[MarkedExtension[ParserOutput, RendererOutput]],
) -> Marked[ParserOutput, RendererOutput] {
  unsafeCast(_marked_use_extern_js(unsafeCast(self), unsafeCast(args)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::set_options(
  self : Marked[ParserOutput, RendererOutput],
  opt : MarkedOptions[ParserOutput, RendererOutput],
) -> Marked[ParserOutput, RendererOutput] {
  unsafeCast(_marked_set_options_extern_js(unsafeCast(self), unsafeCast(opt)))
}

///|
pub fn[ParserOutput, RendererOutput] Marked::lexer(
  self : Marked[ParserOutput, RendererOutput],
  src : String,
  options : MarkedOptions[ParserOutput, RendererOutput]?,
) -> TokensList {
  unsafeCast(
    _marked_lexer_extern_js(
      unsafeCast(self),
      unsafeCast(src),
      unsafeCast(options),
    ),
  )
}

///|
pub fn[ParserOutput, RendererOutput] Marked::parser(
  self : Marked[ParserOutput, RendererOutput],
  tokens : Array[Token],
  options : MarkedOptions[ParserOutput, RendererOutput]?,
) -> ParserOutput {
  unsafeCast(
    _marked_parser_extern_js(
      unsafeCast(self),
      unsafeCast(tokens),
      unsafeCast(options),
    ),
  )
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
pub fn renderImage(
  base64Data : String,
  imageDimensions : ImageDimensions,
  options : ImageRenderOptions?,
) -> JSValue? {
  __ts_mbt_wrap_option_return(
    unsafeCast(render_image(base64Data, imageDimensions, options)),
  )
}

///|
pub fn getGifDimensions(base64Data : String) -> ImageDimensions? {
  __ts_mbt_wrap_option_return(unsafeCast(get_gif_dimensions(base64Data)))
}

///|
pub fn getPngDimensions(base64Data : String) -> ImageDimensions? {
  __ts_mbt_wrap_option_return(unsafeCast(get_png_dimensions(base64Data)))
}

///|
pub fn getJpegDimensions(base64Data : String) -> ImageDimensions? {
  __ts_mbt_wrap_option_return(unsafeCast(get_jpeg_dimensions(base64Data)))
}

///|
pub fn getWebpDimensions(base64Data : String) -> ImageDimensions? {
  __ts_mbt_wrap_option_return(unsafeCast(get_webp_dimensions(base64Data)))
}

///|
pub fn getImageDimensions(
  base64Data : String,
  mimeType : String,
) -> ImageDimensions? {
  __ts_mbt_wrap_option_return(
    unsafeCast(get_image_dimensions(base64Data, mimeType)),
  )
}

///|
pub fn parseOsc11BackgroundColor(data : String) -> RgbColor? {
  __ts_mbt_wrap_option_return(unsafeCast(parse_osc11_background_color(data)))
}
