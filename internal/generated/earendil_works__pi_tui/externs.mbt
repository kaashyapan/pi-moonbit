///|
extern "js" fn __ts_mbt_js_object_from_pairs(
  keys : Array[String],
  values : Array[JSValue],
) -> JSValue =
  #| (keys, values) => { const out = {}; for (let i = 0; i < keys.length; i++) out[keys[i]] = values[i]; return out; }

///|
pub extern "js" fn TUI::addChild(self : TUI, arg0 : Component) -> Unit =
  #| (self, arg0) => self.addChild(arg0)

///|
pub extern "js" fn TUI::removeChild(self : TUI, arg0 : Component) -> Unit =
  #| (self, arg0) => self.removeChild(arg0)

///|
pub extern "js" fn TUI::clear(self : TUI) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn TUI::getShowHardwareCursor(self : TUI) -> Bool =
  #| (self) => self.getShowHardwareCursor()

///|
pub extern "js" fn TUI::setShowHardwareCursor(self : TUI, arg0 : Bool) -> Unit =
  #| (self, arg0) => self.setShowHardwareCursor(arg0)

///|
pub extern "js" fn TUI::getClearOnShrink(self : TUI) -> Bool =
  #| (self) => self.getClearOnShrink()

///|
pub extern "js" fn TUI::setClearOnShrink(self : TUI, arg0 : Bool) -> Unit =
  #| (self, arg0) => self.setClearOnShrink(arg0)

///|
pub extern "js" fn TUI::setFocus(self : TUI, arg0 : Component?) -> Unit =
  #| (self, arg0) => self.setFocus((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn TUI::showOverlay(
  self : TUI,
  arg0 : Component,
  arg1 : OverlayOptions?,
) -> OverlayHandle =
  #| (self, arg0, arg1) => self.showOverlay(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn TUI::hideOverlay(self : TUI) -> Unit =
  #| (self) => self.hideOverlay()

///|
pub extern "js" fn TUI::hasOverlay(self : TUI) -> Bool =
  #| (self) => self.hasOverlay()

///|
pub extern "js" fn TUI::start(self : TUI) -> Unit =
  #| (self) => self.start()

///|
pub extern "js" fn TUI::stop(self : TUI, arg0 : TuiStopOptions?) -> Unit =
  #| (self, arg0) => self.stop((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn TUI::renderNow(self : TUI, arg0 : Bool?) -> Unit =
  #| (self, arg0) => self.renderNow((arg0 === -1 ? undefined : (arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0))))

///|
pub extern "js" fn TUI::requestRender(self : TUI, arg0 : Bool?) -> Unit =
  #| (self, arg0) => self.requestRender((arg0 === -1 ? undefined : (arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0))))

///|
pub extern "js" fn TUI::addInputListener(
  self : TUI,
  arg0 : TuiInputListener,
) -> () -> Unit =
  #| (self, arg0) => self.addInputListener(arg0)

///|
pub extern "js" fn TUI::removeInputListener(
  self : TUI,
  arg0 : TuiInputListener,
) -> Unit =
  #| (self, arg0) => self.removeInputListener(arg0)

///|
pub extern "js" fn TUI::onTerminalColorSchemeChange(
  self : TUI,
  arg0 : (String) -> Unit,
) -> () -> Unit =
  #| (self, arg0) => self.onTerminalColorSchemeChange(arg0)

///|
pub extern "js" fn TUI::setTerminalColorSchemeNotifications(
  self : TUI,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.setTerminalColorSchemeNotifications(arg0)

///|
pub extern "js" fn TUI::queryTerminalBackgroundColor(
  self : TUI,
  arg0 : TuiQueryTerminalBackgroundColorOptions,
) -> Promise[RgbColor?] =
  #| (self, arg0) => self.queryTerminalBackgroundColor(arg0)

///|
pub extern "js" fn TUI::queryTerminalColorScheme(
  self : TUI,
  arg0 : TuiQueryTerminalColorSchemeOptions,
) -> Promise[String?] =
  #| (self, arg0) => self.queryTerminalColorScheme(arg0)

///|
pub extern "js" fn TUI::render(self : TUI, arg0 : Double) -> Array[String] =
  #| (self, arg0) => self.render(arg0)

///|
pub extern "js" fn TUI::invalidate(self : TUI) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Terminal::start(
  self : Terminal,
  arg0 : (String) -> Unit,
  arg1 : () -> Unit,
) -> Unit =
  #| (self, arg0, arg1) => self.start(arg0, arg1)

///|
pub extern "js" fn Terminal::stop(self : Terminal) -> Unit =
  #| (self) => self.stop()

///|
pub extern "js" fn Terminal::drainInput(
  self : Terminal,
  arg0 : Double?,
  arg1 : Double?,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.drainInput((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)), (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn Terminal::write(self : Terminal, arg0 : String) -> Unit =
  #| (self, arg0) => self.write(arg0)

///|
pub extern "js" fn Terminal::moveBy(self : Terminal, arg0 : Double) -> Unit =
  #| (self, arg0) => self.moveBy(arg0)

///|
pub extern "js" fn Terminal::hideCursor(self : Terminal) -> Unit =
  #| (self) => self.hideCursor()

///|
pub extern "js" fn Terminal::showCursor(self : Terminal) -> Unit =
  #| (self) => self.showCursor()

///|
pub extern "js" fn Terminal::clearLine(self : Terminal) -> Unit =
  #| (self) => self.clearLine()

///|
pub extern "js" fn Terminal::clearFromCursor(self : Terminal) -> Unit =
  #| (self) => self.clearFromCursor()

///|
pub extern "js" fn Terminal::clearScreen(self : Terminal) -> Unit =
  #| (self) => self.clearScreen()

///|
pub extern "js" fn Terminal::setTitle(self : Terminal, arg0 : String) -> Unit =
  #| (self, arg0) => self.setTitle(arg0)

///|
pub extern "js" fn Terminal::setProgress(self : Terminal, arg0 : Bool) -> Unit =
  #| (self, arg0) => self.setProgress(arg0)

///|
pub extern "js" fn Component::render(
  self : Component,
  arg0 : Double,
) -> Array[String] =
  #| (self, arg0) => self.render(arg0)

///|
pub extern "js" fn Component::invalidate(self : Component) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn ImageTheme::fallbackColor(
  self : ImageTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.fallbackColor(arg0)

///|
pub extern "js" fn EditorTheme::borderColor(
  self : EditorTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.borderColor(arg0)

///|
pub extern "js" fn ViewportTUI::setLayoutRoot(
  self : ViewportTUI,
  arg0 : Component?,
) -> Unit =
  #| (self, arg0) => self.setLayoutRoot((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ViewportTUI::addChild(
  self : ViewportTUI,
  arg0 : Component,
) -> Unit =
  #| (self, arg0) => self.addChild(arg0)

///|
pub extern "js" fn ViewportTUI::removeChild(
  self : ViewportTUI,
  arg0 : Component,
) -> Unit =
  #| (self, arg0) => self.removeChild(arg0)

///|
pub extern "js" fn ViewportTUI::clear(self : ViewportTUI) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn ViewportTUI::getShowHardwareCursor(
  self : ViewportTUI,
) -> Bool =
  #| (self) => self.getShowHardwareCursor()

///|
pub extern "js" fn ViewportTUI::setShowHardwareCursor(
  self : ViewportTUI,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.setShowHardwareCursor(arg0)

///|
pub extern "js" fn ViewportTUI::getClearOnShrink(self : ViewportTUI) -> Bool =
  #| (self) => self.getClearOnShrink()

///|
pub extern "js" fn ViewportTUI::setClearOnShrink(
  self : ViewportTUI,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.setClearOnShrink(arg0)

///|
pub extern "js" fn ViewportTUI::setFocus(
  self : ViewportTUI,
  arg0 : Component?,
) -> Unit =
  #| (self, arg0) => self.setFocus((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ViewportTUI::showOverlay(
  self : ViewportTUI,
  arg0 : Component,
  arg1 : OverlayOptions?,
) -> OverlayHandle =
  #| (self, arg0, arg1) => self.showOverlay(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ViewportTUI::hideOverlay(self : ViewportTUI) -> Unit =
  #| (self) => self.hideOverlay()

///|
pub extern "js" fn ViewportTUI::hasOverlay(self : ViewportTUI) -> Bool =
  #| (self) => self.hasOverlay()

///|
pub extern "js" fn ViewportTUI::start(self : ViewportTUI) -> Unit =
  #| (self) => self.start()

///|
pub extern "js" fn ViewportTUI::stop(
  self : ViewportTUI,
  arg0 : TuiStopOptions?,
) -> Unit =
  #| (self, arg0) => self.stop((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ViewportTUI::renderNow(
  self : ViewportTUI,
  arg0 : Bool?,
) -> Unit =
  #| (self, arg0) => self.renderNow((arg0 === -1 ? undefined : (arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0))))

///|
pub extern "js" fn ViewportTUI::requestRender(
  self : ViewportTUI,
  arg0 : Bool?,
) -> Unit =
  #| (self, arg0) => self.requestRender((arg0 === -1 ? undefined : (arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0))))

///|
pub extern "js" fn ViewportTUI::addInputListener(
  self : ViewportTUI,
  arg0 : TuiInputListener,
) -> () -> Unit =
  #| (self, arg0) => self.addInputListener(arg0)

///|
pub extern "js" fn ViewportTUI::removeInputListener(
  self : ViewportTUI,
  arg0 : TuiInputListener,
) -> Unit =
  #| (self, arg0) => self.removeInputListener(arg0)

///|
pub extern "js" fn ViewportTUI::onTerminalColorSchemeChange(
  self : ViewportTUI,
  arg0 : (String) -> Unit,
) -> () -> Unit =
  #| (self, arg0) => self.onTerminalColorSchemeChange(arg0)

///|
pub extern "js" fn ViewportTUI::setTerminalColorSchemeNotifications(
  self : ViewportTUI,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.setTerminalColorSchemeNotifications(arg0)

///|
pub extern "js" fn ViewportTUI::queryTerminalBackgroundColor(
  self : ViewportTUI,
  arg0 : TuiQueryTerminalBackgroundColorOptions,
) -> Promise[RgbColor?] =
  #| (self, arg0) => self.queryTerminalBackgroundColor(arg0)

///|
pub extern "js" fn ViewportTUI::queryTerminalColorScheme(
  self : ViewportTUI,
  arg0 : TuiQueryTerminalColorSchemeOptions,
) -> Promise[String?] =
  #| (self, arg0) => self.queryTerminalColorScheme(arg0)

///|
pub extern "js" fn ViewportTUI::render(
  self : ViewportTUI,
  arg0 : Double,
) -> Array[String] =
  #| (self, arg0) => self.render(arg0)

///|
pub extern "js" fn ViewportTUI::invalidate(self : ViewportTUI) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn MarkdownTheme::heading(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.heading(arg0)

///|
pub extern "js" fn MarkdownTheme::link(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.link(arg0)

///|
pub extern "js" fn MarkdownTheme::linkUrl(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.linkUrl(arg0)

///|
pub extern "js" fn MarkdownTheme::code(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.code(arg0)

///|
pub extern "js" fn MarkdownTheme::codeBlock(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.codeBlock(arg0)

///|
pub extern "js" fn MarkdownTheme::codeBlockBorder(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.codeBlockBorder(arg0)

///|
pub extern "js" fn MarkdownTheme::quote(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.quote(arg0)

///|
pub extern "js" fn MarkdownTheme::quoteBorder(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.quoteBorder(arg0)

///|
pub extern "js" fn MarkdownTheme::hr(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.hr(arg0)

///|
pub extern "js" fn MarkdownTheme::listBullet(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.listBullet(arg0)

///|
pub extern "js" fn MarkdownTheme::bold(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.bold(arg0)

///|
pub extern "js" fn MarkdownTheme::italic(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.italic(arg0)

///|
pub extern "js" fn MarkdownTheme::strikethrough(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.strikethrough(arg0)

///|
pub extern "js" fn MarkdownTheme::underline(
  self : MarkdownTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.underline(arg0)

///|
pub extern "js" fn OverlayHandle::hide(self : OverlayHandle) -> Unit =
  #| (self) => self.hide()

///|
pub extern "js" fn OverlayHandle::setHidden(
  self : OverlayHandle,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.setHidden(arg0)

///|
pub extern "js" fn OverlayHandle::isHidden(self : OverlayHandle) -> Bool =
  #| (self) => self.isHidden()

///|
pub extern "js" fn OverlayHandle::focus(self : OverlayHandle) -> Unit =
  #| (self) => self.focus()

///|
pub extern "js" fn OverlayHandle::unfocus(
  self : OverlayHandle,
  arg0 : OverlayUnfocusOptions?,
) -> Unit =
  #| (self, arg0) => self.unfocus((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn OverlayHandle::isFocused(self : OverlayHandle) -> Bool =
  #| (self) => self.isFocused()

///|
extern "js" fn _overlay_handle_get_bounds_ret_conv_js(
  this_ : OverlayHandle,
) -> JSValue =
  #| (self) => self.getBounds()

///|
pub extern "js" fn EditorComponent::getText(self : EditorComponent) -> String =
  #| (self) => self.getText()

///|
pub extern "js" fn EditorComponent::setText(
  self : EditorComponent,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.setText(arg0)

///|
pub extern "js" fn EditorComponent::handleInput(
  self : EditorComponent,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.handleInput(arg0)

///|
pub extern "js" fn EditorComponent::render(
  self : EditorComponent,
  arg0 : Double,
) -> Array[String] =
  #| (self, arg0) => self.render(arg0)

///|
pub extern "js" fn EditorComponent::invalidate(self : EditorComponent) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn SelectListTheme::selectedPrefix(
  self : SelectListTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.selectedPrefix(arg0)

///|
pub extern "js" fn SelectListTheme::selectedText(
  self : SelectListTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.selectedText(arg0)

///|
pub extern "js" fn SelectListTheme::description(
  self : SelectListTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.description(arg0)

///|
pub extern "js" fn SelectListTheme::scrollInfo(
  self : SelectListTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.scrollInfo(arg0)

///|
pub extern "js" fn SelectListTheme::noMatch(
  self : SelectListTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.noMatch(arg0)

///|
pub extern "js" fn SettingsListTheme::label(
  self : SettingsListTheme,
  arg0 : String,
  arg1 : Bool,
) -> String =
  #| (self, arg0, arg1) => self.label(arg0, arg1)

///|
pub extern "js" fn SettingsListTheme::value(
  self : SettingsListTheme,
  arg0 : String,
  arg1 : Bool,
) -> String =
  #| (self, arg0, arg1) => self.value(arg0, arg1)

///|
pub extern "js" fn SettingsListTheme::description(
  self : SettingsListTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.description(arg0)

///|
pub extern "js" fn SettingsListTheme::hint(
  self : SettingsListTheme,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.hint(arg0)

///|
pub extern "js" fn AutocompleteProvider::getSuggestions(
  self : AutocompleteProvider,
  arg0 : Array[String],
  arg1 : Double,
  arg2 : Double,
  arg3 : AutocompleteProviderGetSuggestionsOptions,
) -> Promise[AutocompleteSuggestions?] =
  #| (self, arg0, arg1, arg2, arg3) => self.getSuggestions(arg0, arg1, arg2, arg3)

///|
pub extern "js" fn AutocompleteProvider::applyCompletion(
  self : AutocompleteProvider,
  arg0 : Array[String],
  arg1 : Double,
  arg2 : Double,
  arg3 : AutocompleteItem,
  arg4 : String,
) -> AutocompleteProviderApplyCompletionResult =
  #| (self, arg0, arg1, arg2, arg3, arg4) => self.applyCompletion(arg0, arg1, arg2, arg3, arg4)

///|
extern "js" fn _renderer_extension_renderer_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.renderer(...args)

///|
pub extern "js" fn MarkedParser::_new_(
  self : MarkedParser,
  arg0 : MarkedOptions[ParserOutput, RendererOutput]?,
) -> UnderscoreParser =
  #| (self, arg0) => self["<new>"]((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn MarkedParser::parse(
  self : MarkedParser,
  arg0 : Array[Token],
  arg1 : MarkedOptions[ParserOutput_1, RendererOutput_1]?,
) -> ParserOutput_1 =
  #| (self, arg0, arg1) => self.parse(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn MarkedParser::parseInline(
  self : MarkedParser,
  arg0 : Array[Token],
  arg1 : MarkedOptions[ParserOutput_1, RendererOutput_1]?,
) -> ParserOutput_1 =
  #| (self, arg0, arg1) => self.parseInline(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn MarkedRenderer::_new_(
  self : MarkedRenderer,
  arg0 : MarkedOptions[ParserOutput, RendererOutput]?,
) -> UnderscoreRenderer =
  #| (self, arg0) => self["<new>"]((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn MarkedTextRenderer::_new_(
  self : MarkedTextRenderer,
) -> UnderscoreTextRenderer =
  #| (self) => self["<new>"]()

///|
pub extern "js" fn MarkedTokenizer::_new_(
  self : MarkedTokenizer,
  arg0 : MarkedOptions[ParserOutput, RendererOutput]?,
) -> UnderscoreTokenizer =
  #| (self, arg0) => self["<new>"]((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn MarkedHooks::_new_(
  self : MarkedHooks,
  arg0 : MarkedOptions[ParserOutput, RendererOutput]?,
) -> UnderscoreHooks =
  #| (self, arg0) => self["<new>"]((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_box(
  paddingX : Double?,
  paddingY : Double?,
  bgFn : ((String) -> String)?,
) -> Box = "__ts_mbt_new_box"

///|
pub extern "js" fn Box::get_box_children(self : Box) -> Array[Component] =
  #| (self) => self.children

///|
pub extern "js" fn Box::set_box_children(
  self : Box,
  value : Array[Component],
) -> Unit =
  #| (self, value) => (self.children = value)

///|
pub extern "js" fn Box::add_child(self : Box, component : Component) -> Unit =
  #| (self, component) => self.addChild(component)

///|
pub extern "js" fn Box::remove_child(self : Box, component : Component) -> Unit =
  #| (self, component) => self.removeChild(component)

///|
pub extern "js" fn Box::clear(self : Box) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn Box::set_bg_fn(
  self : Box,
  bgFn : ((String) -> String)?,
) -> Unit =
  #| (self, bgFn) => self.setBgFn((bgFn == null ? undefined : (typeof bgFn === "object" && "$tag" in bgFn ? (bgFn.$tag === 1 ? bgFn._0 : undefined) : bgFn)))

///|
pub extern "js" fn Box::invalidate(self : Box) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Box::handle_mouse(
  self : Box,
  event : TuiMouseEvent,
) -> TuiMouseDispatchResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn Box::render(self : Box, width : Double) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_text(
  text : String?,
  paddingX : Double?,
  paddingY : Double?,
  customBgFn : ((String) -> String)?,
) -> Text = "__ts_mbt_new_text"

///|
pub extern "js" fn Text::set_text(self : Text, text : String) -> Unit =
  #| (self, text) => self.setText(text)

///|
pub extern "js" fn Text::set_custom_bg_fn(
  self : Text,
  customBgFn : ((String) -> String)?,
) -> Unit =
  #| (self, customBgFn) => self.setCustomBgFn((customBgFn == null ? undefined : (typeof customBgFn === "object" && "$tag" in customBgFn ? (customBgFn.$tag === 1 ? customBgFn._0 : undefined) : customBgFn)))

///|
pub extern "js" fn Text::invalidate(self : Text) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Text::render(self : Text, width : Double) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_image(
  base64Data : String,
  mimeType : String,
  theme : ImageTheme,
  options : ImageOptions?,
  dimensions : ImageDimensions?,
) -> Image = "__ts_mbt_new_image"

///|
extern "js" fn _image_get_image_id_ret_conv_js(this_ : Image) -> JSValue =
  #| (self) => self.getImageId()

///|
pub extern "js" fn Image::invalidate(self : Image) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Image::render(self : Image, width : Double) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_input(options : InputOptions?) -> Input = "__ts_mbt_new_input"

///|
pub extern "js" fn Input::get_input_on_submit(self : Input) -> (String) -> Unit =
  #| (self) => self.onSubmit

///|
pub extern "js" fn Input::set_input_on_submit(
  self : Input,
  value : (String) -> Unit,
) -> Unit =
  #| (self, value) => (self.onSubmit = value)

///|
pub extern "js" fn Input::get_input_on_escape(self : Input) -> () -> Unit =
  #| (self) => self.onEscape

///|
pub extern "js" fn Input::set_input_on_escape(
  self : Input,
  value : () -> Unit,
) -> Unit =
  #| (self, value) => (self.onEscape = value)

///|
pub extern "js" fn Input::get_input_focused(self : Input) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn Input::set_input_focused(self : Input, value : Bool) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn Input::on_submit(self : Input, arg0 : String) -> Unit =
  #| (self, arg0) => self.onSubmit(arg0)

///|
pub extern "js" fn Input::on_escape(self : Input) -> Unit =
  #| (self) => self.onEscape()

///|
pub extern "js" fn Input::get_value(self : Input) -> String =
  #| (self) => self.getValue()

///|
pub extern "js" fn Input::set_value(self : Input, value : String) -> Unit =
  #| (self, value) => self.setValue(value)

///|
pub extern "js" fn Input::handle_input(self : Input, data : String) -> Unit =
  #| (self, data) => self.handleInput(data)

///|
pub extern "js" fn Input::handle_mouse(
  self : Input,
  event : TuiMouseEvent,
) -> TuiMouseEventResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn Input::invalidate(self : Input) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Input::render(self : Input, width : Double) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_editor(
  tui : TUI,
  theme : EditorTheme,
  options : EditorOptions?,
) -> Editor = "__ts_mbt_new_editor"

///|
pub extern "js" fn Editor::get_editor_focused(self : Editor) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn Editor::set_editor_focused(
  self : Editor,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn Editor::get_editor_border_color(
  self : Editor,
) -> (String) -> String =
  #| (self) => self.borderColor

///|
pub extern "js" fn Editor::set_editor_border_color(
  self : Editor,
  value : (String) -> String,
) -> Unit =
  #| (self, value) => (self.borderColor = value)

///|
pub extern "js" fn Editor::get_editor_on_submit(
  self : Editor,
) -> (String) -> Unit =
  #| (self) => self.onSubmit

///|
pub extern "js" fn Editor::set_editor_on_submit(
  self : Editor,
  value : (String) -> Unit,
) -> Unit =
  #| (self, value) => (self.onSubmit = value)

///|
pub extern "js" fn Editor::get_editor_on_change(
  self : Editor,
) -> (String) -> Unit =
  #| (self) => self.onChange

///|
pub extern "js" fn Editor::set_editor_on_change(
  self : Editor,
  value : (String) -> Unit,
) -> Unit =
  #| (self, value) => (self.onChange = value)

///|
pub extern "js" fn Editor::get_editor_disable_submit(self : Editor) -> Bool =
  #| (self) => self.disableSubmit

///|
pub extern "js" fn Editor::set_editor_disable_submit(
  self : Editor,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.disableSubmit = value)

///|
pub extern "js" fn Editor::border_color(self : Editor, arg0 : String) -> String =
  #| (self, arg0) => self.borderColor(arg0)

///|
pub extern "js" fn Editor::on_submit(self : Editor, arg0 : String) -> Unit =
  #| (self, arg0) => self.onSubmit(arg0)

///|
pub extern "js" fn Editor::on_change(self : Editor, arg0 : String) -> Unit =
  #| (self, arg0) => self.onChange(arg0)

///|
pub extern "js" fn Editor::get_padding_x(self : Editor) -> Double =
  #| (self) => self.getPaddingX()

///|
pub extern "js" fn Editor::set_padding_x(
  self : Editor,
  padding : Double,
) -> Unit =
  #| (self, padding) => self.setPaddingX(padding)

///|
pub extern "js" fn Editor::get_autocomplete_max_visible(
  self : Editor,
) -> Double =
  #| (self) => self.getAutocompleteMaxVisible()

///|
pub extern "js" fn Editor::set_autocomplete_max_visible(
  self : Editor,
  maxVisible : Double,
) -> Unit =
  #| (self, maxVisible) => self.setAutocompleteMaxVisible(maxVisible)

///|
pub extern "js" fn Editor::set_autocomplete_provider(
  self : Editor,
  provider : AutocompleteProvider,
) -> Unit =
  #| (self, provider) => self.setAutocompleteProvider(provider)

///|
pub extern "js" fn Editor::add_to_history(self : Editor, text : String) -> Unit =
  #| (self, text) => self.addToHistory(text)

///|
pub extern "js" fn Editor::invalidate(self : Editor) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Editor::render(
  self : Editor,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn Editor::handle_mouse(
  self : Editor,
  event : TuiMouseEvent,
) -> TuiMouseEventResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn Editor::handle_input(self : Editor, data : String) -> Unit =
  #| (self, data) => self.handleInput(data)

///|
pub extern "js" fn Editor::get_text(self : Editor) -> String =
  #| (self) => self.getText()

///|
pub extern "js" fn Editor::get_expanded_text(self : Editor) -> String =
  #| (self) => self.getExpandedText()

///|
pub extern "js" fn Editor::get_lines(self : Editor) -> Array[String] =
  #| (self) => self.getLines()

///|
pub extern "js" fn Editor::get_cursor(self : Editor) -> JSValue =
  #| (self) => self.getCursor()

///|
pub extern "js" fn Editor::set_text(self : Editor, text : String) -> Unit =
  #| (self, text) => self.setText(text)

///|
pub extern "js" fn Editor::insert_text_at_cursor(
  self : Editor,
  text : String,
) -> Unit =
  #| (self, text) => self.insertTextAtCursor(text)

///|
pub extern "js" fn Editor::is_showing_autocomplete(self : Editor) -> Bool =
  #| (self) => self.isShowingAutocomplete()

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_hstack(
  children : Array[StackChild]?,
  options : StackOptions?,
) -> HStack = "__ts_mbt_new_hstack"

///|
pub extern "js" fn HStack::get_hstack_children(
  self : HStack,
) -> Array[Component] =
  #| (self) => self.children

///|
pub extern "js" fn HStack::set_hstack_children(
  self : HStack,
  value : Array[Component],
) -> Unit =
  #| (self, value) => (self.children = value)

///|
pub extern "js" fn HStack::add_child(
  self : HStack,
  component : Component,
  options : StackEntryOptions?,
) -> Unit =
  #| (self, component, options) => self.addChild(component, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn HStack::remove_child(
  self : HStack,
  component : Component,
) -> Unit =
  #| (self, component) => self.removeChild(component)

///|
pub extern "js" fn HStack::clear(self : HStack) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn HStack::invalidate(self : HStack) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn HStack::handle_mouse(
  self : HStack,
  event : TuiMouseEvent,
) -> TuiMouseDispatchResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn HStack::render(
  self : HStack,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_loader(
  ui : TUI,
  spinnerColorFn : (String) -> String,
  messageColorFn : (String) -> String,
  message : String?,
  indicator : LoaderIndicatorOptions?,
) -> Loader = "__ts_mbt_new_loader"

///|
pub extern "js" fn Loader::set_text(self : Loader, text : String) -> Unit =
  #| (self, text) => self.setText(text)

///|
pub extern "js" fn Loader::set_custom_bg_fn(
  self : Loader,
  customBgFn : ((String) -> String)?,
) -> Unit =
  #| (self, customBgFn) => self.setCustomBgFn((customBgFn == null ? undefined : (typeof customBgFn === "object" && "$tag" in customBgFn ? (customBgFn.$tag === 1 ? customBgFn._0 : undefined) : customBgFn)))

///|
pub extern "js" fn Loader::invalidate(self : Loader) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Loader::render(
  self : Loader,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn Loader::start(self : Loader) -> Unit =
  #| (self) => self.start()

///|
pub extern "js" fn Loader::stop(self : Loader) -> Unit =
  #| (self) => self.stop()

///|
pub extern "js" fn Loader::set_message(self : Loader, message : String) -> Unit =
  #| (self, message) => self.setMessage(message)

///|
pub extern "js" fn Loader::set_indicator(
  self : Loader,
  indicator : LoaderIndicatorOptions?,
) -> Unit =
  #| (self, indicator) => self.setIndicator((indicator == null ? undefined : (typeof indicator === "object" && "$tag" in indicator ? (indicator.$tag === 1 ? indicator._0 : undefined) : indicator)))

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn _new_marked_extern_js(args : JSValue) -> JSValue = "__ts_mbt_new_marked"

///|
extern "js" fn _get_marked_defaults_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.defaults

///|
extern "js" fn _set_marked_defaults_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.defaults = value)

///|
extern "js" fn _get_marked_options_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.options

///|
extern "js" fn _set_marked_options_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.options = value)

///|
extern "js" fn _get_marked_parse_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.parse

///|
extern "js" fn _set_marked_parse_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.parse = value)

///|
extern "js" fn _get_marked_parse_inline_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.parseInline

///|
extern "js" fn _set_marked_parse_inline_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.parseInline = value)

///|
extern "js" fn _get_marked_parser_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.Parser

///|
extern "js" fn _set_marked_parser_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.Parser = value)

///|
extern "js" fn _get_marked_renderer_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.Renderer

///|
extern "js" fn _set_marked_renderer_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.Renderer = value)

///|
extern "js" fn _get_marked_text_renderer_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.TextRenderer

///|
extern "js" fn _set_marked_text_renderer_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.TextRenderer = value)

///|
extern "js" fn _get_marked_lexer_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.Lexer

///|
extern "js" fn _set_marked_lexer_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.Lexer = value)

///|
extern "js" fn _get_marked_tokenizer_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.Tokenizer

///|
extern "js" fn _set_marked_tokenizer_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.Tokenizer = value)

///|
extern "js" fn _get_marked_hooks_extern_js(this_ : JSValue) -> JSValue =
  #| (self) => self.Hooks

///|
extern "js" fn _set_marked_hooks_extern_js(
  this_ : JSValue,
  value : JSValue,
) -> Unit =
  #| (self, value) => (self.Hooks = value)

///|
extern "js" fn _marked_options_extern_js(
  this_ : JSValue,
  arg0 : JSValue,
) -> JSValue =
  #| (self, arg0) => self.options(arg0)

///|
extern "js" fn _marked_walk_tokens_extern_js(
  this_ : JSValue,
  tokens : JSValue,
  callback : JSValue,
) -> JSValue =
  #| (self, tokens, callback) => self.walkTokens((() => { if (tokens === null || typeof tokens !== "object" || !("$tag" in tokens)) return tokens; if (tokens.$tag === 0) return tokens._0; else if (tokens.$tag === 1) return tokens._0; throw new Error("unexpected Auto_TokenArrayValue_or_TokensListValue tag: " + tokens.$tag); })(), callback)

///|
extern "js" fn _marked_use_extern_js(
  this_ : JSValue,
  args : JSValue,
) -> JSValue =
  #| (self, args) => self.use(args)

///|
extern "js" fn _marked_set_options_extern_js(
  this_ : JSValue,
  opt : JSValue,
) -> JSValue =
  #| (self, opt) => self.setOptions(opt)

///|
extern "js" fn _marked_lexer_extern_js(
  this_ : JSValue,
  src : JSValue,
  options : JSValue,
) -> JSValue =
  #| (self, src, options) => self.lexer(src, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
extern "js" fn _marked_parser_extern_js(
  this_ : JSValue,
  tokens : JSValue,
  options : JSValue,
) -> JSValue =
  #| (self, tokens, options) => self.parser(tokens, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_spacer(lines : Double?) -> Spacer = "__ts_mbt_new_spacer"

///|
pub extern "js" fn Spacer::set_lines(self : Spacer, lines : Double) -> Unit =
  #| (self, lines) => self.setLines(lines)

///|
pub extern "js" fn Spacer::invalidate(self : Spacer) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Spacer::render(
  self : Spacer,
  _width : Double,
) -> Array[String] =
  #| (self, _width) => self.render(_width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_vstack(
  children : Array[StackChild]?,
  options : StackOptions?,
) -> VStack = "__ts_mbt_new_vstack"

///|
pub extern "js" fn VStack::get_vstack_children(
  self : VStack,
) -> Array[Component] =
  #| (self) => self.children

///|
pub extern "js" fn VStack::set_vstack_children(
  self : VStack,
  value : Array[Component],
) -> Unit =
  #| (self, value) => (self.children = value)

///|
pub extern "js" fn VStack::add_child(
  self : VStack,
  component : Component,
  options : StackEntryOptions?,
) -> Unit =
  #| (self, component, options) => self.addChild(component, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn VStack::remove_child(
  self : VStack,
  component : Component,
) -> Unit =
  #| (self, component) => self.removeChild(component)

///|
pub extern "js" fn VStack::clear(self : VStack) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn VStack::invalidate(self : VStack) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn VStack::handle_mouse(
  self : VStack,
  event : TuiMouseEvent,
) -> TuiMouseDispatchResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn VStack::render(
  self : VStack,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_markdown(
  text : String,
  paddingX : Double,
  paddingY : Double,
  theme : MarkdownTheme,
  defaultTextStyle : DefaultTextStyle?,
  options : MarkdownOptions?,
) -> Markdown = "__ts_mbt_new_markdown"

///|
pub extern "js" fn Markdown::set_text(self : Markdown, text : String) -> Unit =
  #| (self, text) => self.setText(text)

///|
pub extern "js" fn Markdown::invalidate(self : Markdown) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Markdown::render(
  self : Markdown,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_container() -> Container = "__ts_mbt_new_container"

///|
pub extern "js" fn Container::get_container_children(
  self : Container,
) -> Array[Component] =
  #| (self) => self.children

///|
pub extern "js" fn Container::set_container_children(
  self : Container,
  value : Array[Component],
) -> Unit =
  #| (self, value) => (self.children = value)

///|
pub extern "js" fn Container::add_child(
  self : Container,
  component : Component,
) -> Unit =
  #| (self, component) => self.addChild(component)

///|
pub extern "js" fn Container::remove_child(
  self : Container,
  component : Component,
) -> Unit =
  #| (self, component) => self.removeChild(component)

///|
pub extern "js" fn Container::clear(self : Container) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn Container::invalidate(self : Container) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn Container::handle_mouse(
  self : Container,
  event : TuiMouseEvent,
) -> TuiMouseDispatchResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn Container::render(
  self : Container,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_scroll_view(
  component : Component,
  options : ScrollViewOptions?,
) -> ScrollView = "__ts_mbt_new_scroll_view"

///|
pub extern "js" fn ScrollView::get_scroll_view_children(
  self : ScrollView,
) -> Array[Component] =
  #| (self) => self.children

///|
pub extern "js" fn ScrollView::set_scroll_view_children(
  self : ScrollView,
  value : Array[Component],
) -> Unit =
  #| (self, value) => (self.children = value)

///|
pub extern "js" fn ScrollView::get_scroll_view_follow_end(
  self : ScrollView,
) -> Bool =
  #| (self) => self.followEnd

///|
pub extern "js" fn ScrollView::get_scroll_view_primary(
  self : ScrollView,
) -> Bool =
  #| (self) => self.primary

///|
extern "js" fn _get_scroll_view_overscroll_ret_conv_js(
  this_ : ScrollView,
) -> String =
  #| (self) => self.overscroll

///|
pub extern "js" fn ScrollView::get_scroll_view_scrollbar_track_style(
  self : ScrollView,
) -> (String) -> String =
  #| (self) => self.scrollbarTrackStyle

///|
pub extern "js" fn ScrollView::get_scroll_view_scrollbar_thumb_style(
  self : ScrollView,
) -> (String) -> String =
  #| (self) => self.scrollbarThumbStyle

///|
pub extern "js" fn ScrollView::get_scroll_view_scroll_top(
  self : ScrollView,
) -> Double =
  #| (self) => self.scrollTop

///|
pub extern "js" fn ScrollView::get_scroll_view_is_following_end(
  self : ScrollView,
) -> Bool =
  #| (self) => self.isFollowingEnd

///|
pub extern "js" fn ScrollView::get_scroll_view_viewport_height(
  self : ScrollView,
) -> Double =
  #| (self) => self.viewportHeight

///|
extern "js" fn _get_scroll_view_scrollbar_ret_conv_js(
  this_ : ScrollView,
) -> String =
  #| (self) => self.scrollbar

///|
pub extern "js" fn ScrollView::get_scroll_view_is_scrollbar_visible(
  self : ScrollView,
) -> Bool =
  #| (self) => self.isScrollbarVisible

///|
pub extern "js" fn ScrollView::get_scroll_view_is_scrollbar_active(
  self : ScrollView,
) -> Bool =
  #| (self) => self.isScrollbarActive

///|
pub extern "js" fn ScrollView::add_child(
  self : ScrollView,
  component : Component,
) -> Unit =
  #| (self, component) => self.addChild(component)

///|
pub extern "js" fn ScrollView::remove_child(
  self : ScrollView,
  component : Component,
) -> Unit =
  #| (self, component) => self.removeChild(component)

///|
pub extern "js" fn ScrollView::clear(self : ScrollView) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn ScrollView::invalidate(self : ScrollView) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn ScrollView::handle_mouse(
  self : ScrollView,
  event : TuiMouseEvent,
) -> TuiMouseDispatchResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn ScrollView::render(
  self : ScrollView,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn ScrollView::scrollbar_track_style(
  self : ScrollView,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.scrollbarTrackStyle(arg0)

///|
pub extern "js" fn ScrollView::scrollbar_thumb_style(
  self : ScrollView,
  arg0 : String,
) -> String =
  #| (self, arg0) => self.scrollbarThumbStyle(arg0)

///|
pub extern "js" fn ScrollView::scroll_top(self : ScrollView) -> Double =
  #| (self) => self.scrollTop()

///|
pub extern "js" fn ScrollView::is_following_end(self : ScrollView) -> Bool =
  #| (self) => self.isFollowingEnd()

///|
pub extern "js" fn ScrollView::viewport_height(self : ScrollView) -> Double =
  #| (self) => self.viewportHeight()

///|
extern "js" fn _scroll_view_scrollbar_ret_conv_js(this_ : ScrollView) -> String =
  #| (self) => self.scrollbar()

///|
pub extern "js" fn ScrollView::is_scrollbar_visible(self : ScrollView) -> Bool =
  #| (self) => self.isScrollbarVisible()

///|
pub extern "js" fn ScrollView::is_scrollbar_active(self : ScrollView) -> Bool =
  #| (self) => self.isScrollbarActive()

///|
extern "js" fn _scroll_view_set_scrollbar_ret_conv_js(
  this_ : ScrollView,
  scrollbar : String,
) -> Unit =
  #| (self, scrollbar) => self.setScrollbar(scrollbar)

///|
pub extern "js" fn ScrollView::get_content_width(
  self : ScrollView,
  width : Double,
) -> Double =
  #| (self, width) => self.getContentWidth(width)

///|
pub extern "js" fn ScrollView::set_scrollbar_active(
  self : ScrollView,
  active : Bool,
) -> Unit =
  #| (self, active) => self.setScrollbarActive(active)

///|
pub extern "js" fn ScrollView::scroll_to(
  self : ScrollView,
  scrollTop : Double,
  options : ScrollViewScrollToOptions?,
) -> Unit =
  #| (self, scrollTop, options) => self.scrollTo(scrollTop, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ScrollView::scroll_by(
  self : ScrollView,
  lines : Double,
) -> Double =
  #| (self, lines) => self.scrollBy(lines)

///|
pub extern "js" fn ScrollView::scroll_to_start(self : ScrollView) -> Unit =
  #| (self) => self.scrollToStart()

///|
pub extern "js" fn ScrollView::scroll_to_end(self : ScrollView) -> Unit =
  #| (self) => self.scrollToEnd()

///|
pub extern "js" fn ScrollView::update_layout(
  self : ScrollView,
  contentHeight : Double,
  viewportHeight : Double,
  requestRender : () -> Unit,
) -> Unit =
  #| (self, contentHeight, viewportHeight, requestRender) => self.updateLayout(contentHeight, viewportHeight, requestRender)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_select_list(
  items : Array[SelectItem],
  maxVisible : Double,
  theme : SelectListTheme,
  layout : SelectListLayoutOptions?,
) -> SelectList = "__ts_mbt_new_select_list"

///|
pub extern "js" fn SelectList::get_select_list_on_select(
  self : SelectList,
) -> (SelectItem) -> Unit =
  #| (self) => self.onSelect

///|
pub extern "js" fn SelectList::set_select_list_on_select(
  self : SelectList,
  value : (SelectItem) -> Unit,
) -> Unit =
  #| (self, value) => (self.onSelect = value)

///|
pub extern "js" fn SelectList::get_select_list_on_cancel(
  self : SelectList,
) -> () -> Unit =
  #| (self) => self.onCancel

///|
pub extern "js" fn SelectList::set_select_list_on_cancel(
  self : SelectList,
  value : () -> Unit,
) -> Unit =
  #| (self, value) => (self.onCancel = value)

///|
pub extern "js" fn SelectList::get_select_list_on_selection_change(
  self : SelectList,
) -> (SelectItem) -> Unit =
  #| (self) => self.onSelectionChange

///|
pub extern "js" fn SelectList::set_select_list_on_selection_change(
  self : SelectList,
  value : (SelectItem) -> Unit,
) -> Unit =
  #| (self, value) => (self.onSelectionChange = value)

///|
pub extern "js" fn SelectList::on_select(
  self : SelectList,
  arg0 : SelectItem,
) -> Unit =
  #| (self, arg0) => self.onSelect(arg0)

///|
pub extern "js" fn SelectList::on_cancel(self : SelectList) -> Unit =
  #| (self) => self.onCancel()

///|
pub extern "js" fn SelectList::on_selection_change(
  self : SelectList,
  arg0 : SelectItem,
) -> Unit =
  #| (self, arg0) => self.onSelectionChange(arg0)

///|
pub extern "js" fn SelectList::set_filter(
  self : SelectList,
  filter : String,
) -> Unit =
  #| (self, filter) => self.setFilter(filter)

///|
pub extern "js" fn SelectList::set_selected_index(
  self : SelectList,
  index : Double,
) -> Unit =
  #| (self, index) => self.setSelectedIndex(index)

///|
pub extern "js" fn SelectList::invalidate(self : SelectList) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn SelectList::render(
  self : SelectList,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn SelectList::handle_mouse(
  self : SelectList,
  event : TuiMouseEvent,
) -> TuiMouseEventResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn SelectList::handle_input(
  self : SelectList,
  keyData : String,
) -> Unit =
  #| (self, keyData) => self.handleInput(keyData)

///|
pub extern "js" fn SelectList::get_selected_item(
  self : SelectList,
) -> SelectItem? =
  #| (self) => self.getSelectedItem()

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_mouse_region(
  child : Component,
  onMouse : MouseRegionHandler,
) -> MouseRegion = "__ts_mbt_new_mouse_region"

///|
pub extern "js" fn MouseRegion::render(
  self : MouseRegion,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn MouseRegion::handle_mouse(
  self : MouseRegion,
  event : TuiMouseEvent,
) -> Auto_TuiMouseEventResultValue_or_TuiMouseDispatchResultValue? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn MouseRegion::invalidate(self : MouseRegion) -> Unit =
  #| (self) => self.invalidate()

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_stdin_buffer(
  options : StdinBufferOptions?,
) -> StdinBuffer = "__ts_mbt_new_stdin_buffer"

///|
pub extern "js" fn StdinBuffer::process(
  self : StdinBuffer,
  data : Auto_BufferValue_or_StringValue,
) -> Unit =
  #| (self, data) => self.process((() => { if (data === null || typeof data !== "object" || !("$tag" in data)) return data; if (data.$tag === 0) return data._0; else if (data.$tag === 1) return data._0; throw new Error("unexpected Auto_BufferValue_or_StringValue tag: " + data.$tag); })())

///|
pub extern "js" fn StdinBuffer::flush(self : StdinBuffer) -> Array[String] =
  #| (self) => self.flush()

///|
pub extern "js" fn StdinBuffer::clear(self : StdinBuffer) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn StdinBuffer::get_buffer(self : StdinBuffer) -> String =
  #| (self) => self.getBuffer()

///|
pub extern "js" fn StdinBuffer::destroy(self : StdinBuffer) -> Unit =
  #| (self) => self.destroy()

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_settings_list(
  items : Array[SettingItem],
  maxVisible : Double,
  theme : SettingsListTheme,
  onChange : (String, String) -> Unit,
  onCancel : () -> Unit,
  options : SettingsListOptions?,
) -> SettingsList = "__ts_mbt_new_settings_list"

///|
pub extern "js" fn SettingsList::update_value(
  self : SettingsList,
  id : String,
  newValue : String,
) -> Unit =
  #| (self, id, newValue) => self.updateValue(id, newValue)

///|
pub extern "js" fn SettingsList::select_item(
  self : SettingsList,
  id : String,
) -> Unit =
  #| (self, id) => self.selectItem(id)

///|
pub extern "js" fn SettingsList::invalidate(self : SettingsList) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn SettingsList::render(
  self : SettingsList,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn SettingsList::handle_mouse(
  self : SettingsList,
  event : TuiMouseEvent,
) -> TuiMouseEventResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn SettingsList::handle_input(
  self : SettingsList,
  data : String,
) -> Unit =
  #| (self, data) => self.handleInput(data)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_tui_alt_screen(
  terminal : Terminal,
  showHardwareCursor : Bool?,
  logDirectory : String?,
  options : TuiAltScreenOptions?,
) -> TuiAltScreen = "__ts_mbt_new_tui_alt_screen"

///|
pub extern "js" fn TuiAltScreen::get_tui_alt_screen_children(
  self : TuiAltScreen,
) -> Array[Component] =
  #| (self) => self.children

///|
pub extern "js" fn TuiAltScreen::set_tui_alt_screen_children(
  self : TuiAltScreen,
  value : Array[Component],
) -> Unit =
  #| (self, value) => (self.children = value)

///|
extern "js" fn _get_tui_alt_screen_mode_ret_conv_js(
  this_ : TuiAltScreen,
) -> String =
  #| (self) => self.mode

///|
pub extern "js" fn TuiAltScreen::get_tui_alt_screen_terminal(
  self : TuiAltScreen,
) -> Terminal =
  #| (self) => self.terminal

///|
pub extern "js" fn TuiAltScreen::set_tui_alt_screen_terminal(
  self : TuiAltScreen,
  value : Terminal,
) -> Unit =
  #| (self, value) => (self.terminal = value)

///|
pub extern "js" fn TuiAltScreen::get_tui_alt_screen_on_debug(
  self : TuiAltScreen,
) -> () -> Unit =
  #| (self) => self.onDebug

///|
pub extern "js" fn TuiAltScreen::set_tui_alt_screen_on_debug(
  self : TuiAltScreen,
  value : () -> Unit,
) -> Unit =
  #| (self, value) => (self.onDebug = value)

///|
pub extern "js" fn TuiAltScreen::get_tui_alt_screen_has_overlay_entries(
  self : TuiAltScreen,
) -> Bool =
  #| (self) => self.hasOverlayEntries

///|
pub extern "js" fn TuiAltScreen::get_tui_alt_screen_full_redraws(
  self : TuiAltScreen,
) -> Double =
  #| (self) => self.fullRedraws

///|
pub extern "js" fn TuiAltScreen::get_tui_alt_screen_viewport_top(
  self : TuiAltScreen,
) -> Double =
  #| (self) => self.viewportTop

///|
pub extern "js" fn TuiAltScreen::get_tui_alt_screen_is_following_output(
  self : TuiAltScreen,
) -> Bool =
  #| (self) => self.isFollowingOutput

///|
pub extern "js" fn TuiAltScreen::add_child(
  self : TuiAltScreen,
  component : Component,
) -> Unit =
  #| (self, component) => self.addChild(component)

///|
pub extern "js" fn TuiAltScreen::remove_child(
  self : TuiAltScreen,
  component : Component,
) -> Unit =
  #| (self, component) => self.removeChild(component)

///|
pub extern "js" fn TuiAltScreen::clear(self : TuiAltScreen) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn TuiAltScreen::invalidate(self : TuiAltScreen) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn TuiAltScreen::handle_mouse(
  self : TuiAltScreen,
  event : TuiMouseEvent,
) -> TuiMouseDispatchResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn TuiAltScreen::render(
  self : TuiAltScreen,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn TuiAltScreen::on_debug(self : TuiAltScreen) -> Unit =
  #| (self) => self.onDebug()

///|
pub extern "js" fn TuiAltScreen::has_overlay_entries(
  self : TuiAltScreen,
) -> Bool =
  #| (self) => self.hasOverlayEntries()

///|
pub extern "js" fn TuiAltScreen::full_redraws(self : TuiAltScreen) -> Double =
  #| (self) => self.fullRedraws()

///|
pub extern "js" fn TuiAltScreen::get_show_hardware_cursor(
  self : TuiAltScreen,
) -> Bool =
  #| (self) => self.getShowHardwareCursor()

///|
pub extern "js" fn TuiAltScreen::set_show_hardware_cursor(
  self : TuiAltScreen,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setShowHardwareCursor(enabled)

///|
pub extern "js" fn TuiAltScreen::get_clear_on_shrink(
  self : TuiAltScreen,
) -> Bool =
  #| (self) => self.getClearOnShrink()

///|
pub extern "js" fn TuiAltScreen::set_clear_on_shrink(
  self : TuiAltScreen,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setClearOnShrink(enabled)

///|
pub extern "js" fn TuiAltScreen::get_focused_component(
  self : TuiAltScreen,
) -> Component? =
  #| (self) => self.getFocusedComponent()

///|
pub extern "js" fn TuiAltScreen::set_focus(
  self : TuiAltScreen,
  component : Component?,
) -> Unit =
  #| (self, component) => self.setFocus((component == null ? undefined : (typeof component === "object" && "$tag" in component ? (component.$tag === 1 ? component._0 : undefined) : component)))

///|
pub extern "js" fn TuiAltScreen::show_overlay(
  self : TuiAltScreen,
  component : Component,
  options : OverlayOptions?,
) -> OverlayHandle =
  #| (self, component, options) => self.showOverlay(component, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn TuiAltScreen::hide_overlay(self : TuiAltScreen) -> Unit =
  #| (self) => self.hideOverlay()

///|
pub extern "js" fn TuiAltScreen::has_overlay(self : TuiAltScreen) -> Bool =
  #| (self) => self.hasOverlay()

///|
pub extern "js" fn TuiAltScreen::start(self : TuiAltScreen) -> Unit =
  #| (self) => self.start()

///|
pub extern "js" fn TuiAltScreen::add_input_listener(
  self : TuiAltScreen,
  listener : TuiInputListener,
) -> () -> Unit =
  #| (self, listener) => self.addInputListener(listener)

///|
pub extern "js" fn TuiAltScreen::remove_input_listener(
  self : TuiAltScreen,
  listener : TuiInputListener,
) -> Unit =
  #| (self, listener) => self.removeInputListener(listener)

///|
pub extern "js" fn TuiAltScreen::on_terminal_color_scheme_change(
  self : TuiAltScreen,
  listener : (String) -> Unit,
) -> () -> Unit =
  #| (self, listener) => self.onTerminalColorSchemeChange(listener)

///|
pub extern "js" fn TuiAltScreen::set_terminal_color_scheme_notifications(
  self : TuiAltScreen,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setTerminalColorSchemeNotifications(enabled)

///|
pub extern "js" fn TuiAltScreen::stop(
  self : TuiAltScreen,
  options : TuiStopOptions?,
) -> Unit =
  #| (self, options) => self.stop((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn TuiAltScreen::render_now(
  self : TuiAltScreen,
  force : Bool?,
) -> Unit =
  #| (self, force) => self.renderNow((force === -1 ? undefined : (force == null ? undefined : (typeof force === "object" && "$tag" in force ? (force.$tag === 1 ? force._0 : undefined) : force))))

///|
pub extern "js" fn TuiAltScreen::request_render(
  self : TuiAltScreen,
  force : Bool?,
) -> Unit =
  #| (self, force) => self.requestRender((force === -1 ? undefined : (force == null ? undefined : (typeof force === "object" && "$tag" in force ? (force.$tag === 1 ? force._0 : undefined) : force))))

///|
pub extern "js" fn TuiAltScreen::query_terminal_background_color(
  self : TuiAltScreen,
  _destructured_ : TuiBaseQueryTerminalBackgroundColorDestructured,
) -> Promise[RgbColor?] =
  #| (self, _destructured_) => self.queryTerminalBackgroundColor(_destructured_)

///|
pub extern "js" fn TuiAltScreen::query_terminal_color_scheme(
  self : TuiAltScreen,
  _destructured_ : TuiBaseQueryTerminalColorSchemeDestructured,
) -> Promise[String?] =
  #| (self, _destructured_) => self.queryTerminalColorScheme(_destructured_)

///|
pub extern "js" fn TuiAltScreen::viewport_top(self : TuiAltScreen) -> Double =
  #| (self) => self.viewportTop()

///|
pub extern "js" fn TuiAltScreen::is_following_output(
  self : TuiAltScreen,
) -> Bool =
  #| (self) => self.isFollowingOutput()

///|
pub extern "js" fn TuiAltScreen::get_copy_on_select(
  self : TuiAltScreen,
) -> Bool =
  #| (self) => self.getCopyOnSelect()

///|
pub extern "js" fn TuiAltScreen::set_copy_on_select(
  self : TuiAltScreen,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setCopyOnSelect(enabled)

///|
pub extern "js" fn TuiAltScreen::has_active_selection(
  self : TuiAltScreen,
) -> Bool =
  #| (self) => self.hasActiveSelection()

///|
pub extern "js" fn TuiAltScreen::copy_active_selection_to_clipboard(
  self : TuiAltScreen,
) -> Promise[Bool] =
  #| (self) => self.copyActiveSelectionToClipboard()

///|
pub extern "js" fn TuiAltScreen::set_layout_root(
  self : TuiAltScreen,
  component : Component?,
) -> Unit =
  #| (self, component) => self.setLayoutRoot((component == null ? undefined : (typeof component === "object" && "$tag" in component ? (component.$tag === 1 ? component._0 : undefined) : component)))

///|
pub extern "js" fn TuiAltScreen::scroll_by(
  self : TuiAltScreen,
  lines : Double,
) -> Unit =
  #| (self, lines) => self.scrollBy(lines)

///|
pub extern "js" fn TuiAltScreen::scroll_to_top(self : TuiAltScreen) -> Unit =
  #| (self) => self.scrollToTop()

///|
pub extern "js" fn TuiAltScreen::scroll_to_bottom(self : TuiAltScreen) -> Unit =
  #| (self) => self.scrollToBottom()

///|
pub extern "js" fn TuiAltScreen::flash(
  self : TuiAltScreen,
  message : String,
  durationMs : Double?,
) -> Unit =
  #| (self, message, durationMs) => self.flash(message, (durationMs == null ? undefined : (typeof durationMs === "object" && "$tag" in durationMs ? (durationMs.$tag === 1 ? durationMs._0 : undefined) : durationMs)))

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_truncated_text(
  text : String,
  paddingX : Double?,
  paddingY : Double?,
) -> TruncatedText = "__ts_mbt_new_truncated_text"

///|
pub extern "js" fn TruncatedText::invalidate(self : TruncatedText) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn TruncatedText::render(
  self : TruncatedText,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_tui_main_screen() -> TuiMainScreen = "__ts_mbt_new_tui_main_screen"

///|
pub extern "js" fn TuiMainScreen::get_tui_main_screen_children(
  self : TuiMainScreen,
) -> Array[Component] =
  #| (self) => self.children

///|
pub extern "js" fn TuiMainScreen::set_tui_main_screen_children(
  self : TuiMainScreen,
  value : Array[Component],
) -> Unit =
  #| (self, value) => (self.children = value)

///|
extern "js" fn _get_tui_main_screen_mode_ret_conv_js(
  this_ : TuiMainScreen,
) -> String =
  #| (self) => self.mode

///|
pub extern "js" fn TuiMainScreen::get_tui_main_screen_terminal(
  self : TuiMainScreen,
) -> Terminal =
  #| (self) => self.terminal

///|
pub extern "js" fn TuiMainScreen::set_tui_main_screen_terminal(
  self : TuiMainScreen,
  value : Terminal,
) -> Unit =
  #| (self, value) => (self.terminal = value)

///|
pub extern "js" fn TuiMainScreen::get_tui_main_screen_on_debug(
  self : TuiMainScreen,
) -> () -> Unit =
  #| (self) => self.onDebug

///|
pub extern "js" fn TuiMainScreen::set_tui_main_screen_on_debug(
  self : TuiMainScreen,
  value : () -> Unit,
) -> Unit =
  #| (self, value) => (self.onDebug = value)

///|
pub extern "js" fn TuiMainScreen::get_tui_main_screen_has_overlay_entries(
  self : TuiMainScreen,
) -> Bool =
  #| (self) => self.hasOverlayEntries

///|
pub extern "js" fn TuiMainScreen::get_tui_main_screen_full_redraws(
  self : TuiMainScreen,
) -> Double =
  #| (self) => self.fullRedraws

///|
pub extern "js" fn TuiMainScreen::add_child(
  self : TuiMainScreen,
  component : Component,
) -> Unit =
  #| (self, component) => self.addChild(component)

///|
pub extern "js" fn TuiMainScreen::remove_child(
  self : TuiMainScreen,
  component : Component,
) -> Unit =
  #| (self, component) => self.removeChild(component)

///|
pub extern "js" fn TuiMainScreen::clear(self : TuiMainScreen) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn TuiMainScreen::invalidate(self : TuiMainScreen) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn TuiMainScreen::handle_mouse(
  self : TuiMainScreen,
  event : TuiMouseEvent,
) -> TuiMouseDispatchResult? =
  #| (self, event) => self.handleMouse(event)

///|
pub extern "js" fn TuiMainScreen::render(
  self : TuiMainScreen,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn TuiMainScreen::on_debug(self : TuiMainScreen) -> Unit =
  #| (self) => self.onDebug()

///|
pub extern "js" fn TuiMainScreen::has_overlay_entries(
  self : TuiMainScreen,
) -> Bool =
  #| (self) => self.hasOverlayEntries()

///|
pub extern "js" fn TuiMainScreen::full_redraws(self : TuiMainScreen) -> Double =
  #| (self) => self.fullRedraws()

///|
pub extern "js" fn TuiMainScreen::get_show_hardware_cursor(
  self : TuiMainScreen,
) -> Bool =
  #| (self) => self.getShowHardwareCursor()

///|
pub extern "js" fn TuiMainScreen::set_show_hardware_cursor(
  self : TuiMainScreen,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setShowHardwareCursor(enabled)

///|
pub extern "js" fn TuiMainScreen::get_clear_on_shrink(
  self : TuiMainScreen,
) -> Bool =
  #| (self) => self.getClearOnShrink()

///|
pub extern "js" fn TuiMainScreen::set_clear_on_shrink(
  self : TuiMainScreen,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setClearOnShrink(enabled)

///|
pub extern "js" fn TuiMainScreen::get_focused_component(
  self : TuiMainScreen,
) -> Component? =
  #| (self) => self.getFocusedComponent()

///|
pub extern "js" fn TuiMainScreen::set_focus(
  self : TuiMainScreen,
  component : Component?,
) -> Unit =
  #| (self, component) => self.setFocus((component == null ? undefined : (typeof component === "object" && "$tag" in component ? (component.$tag === 1 ? component._0 : undefined) : component)))

///|
pub extern "js" fn TuiMainScreen::show_overlay(
  self : TuiMainScreen,
  component : Component,
  options : OverlayOptions?,
) -> OverlayHandle =
  #| (self, component, options) => self.showOverlay(component, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn TuiMainScreen::hide_overlay(self : TuiMainScreen) -> Unit =
  #| (self) => self.hideOverlay()

///|
pub extern "js" fn TuiMainScreen::has_overlay(self : TuiMainScreen) -> Bool =
  #| (self) => self.hasOverlay()

///|
pub extern "js" fn TuiMainScreen::start(self : TuiMainScreen) -> Unit =
  #| (self) => self.start()

///|
pub extern "js" fn TuiMainScreen::add_input_listener(
  self : TuiMainScreen,
  listener : TuiInputListener,
) -> () -> Unit =
  #| (self, listener) => self.addInputListener(listener)

///|
pub extern "js" fn TuiMainScreen::remove_input_listener(
  self : TuiMainScreen,
  listener : TuiInputListener,
) -> Unit =
  #| (self, listener) => self.removeInputListener(listener)

///|
pub extern "js" fn TuiMainScreen::on_terminal_color_scheme_change(
  self : TuiMainScreen,
  listener : (String) -> Unit,
) -> () -> Unit =
  #| (self, listener) => self.onTerminalColorSchemeChange(listener)

///|
pub extern "js" fn TuiMainScreen::set_terminal_color_scheme_notifications(
  self : TuiMainScreen,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setTerminalColorSchemeNotifications(enabled)

///|
pub extern "js" fn TuiMainScreen::stop(
  self : TuiMainScreen,
  options : TuiStopOptions?,
) -> Unit =
  #| (self, options) => self.stop((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn TuiMainScreen::render_now(
  self : TuiMainScreen,
  force : Bool?,
) -> Unit =
  #| (self, force) => self.renderNow((force === -1 ? undefined : (force == null ? undefined : (typeof force === "object" && "$tag" in force ? (force.$tag === 1 ? force._0 : undefined) : force))))

///|
pub extern "js" fn TuiMainScreen::request_render(
  self : TuiMainScreen,
  force : Bool?,
) -> Unit =
  #| (self, force) => self.requestRender((force === -1 ? undefined : (force == null ? undefined : (typeof force === "object" && "$tag" in force ? (force.$tag === 1 ? force._0 : undefined) : force))))

///|
pub extern "js" fn TuiMainScreen::query_terminal_background_color(
  self : TuiMainScreen,
  _destructured_ : TuiBaseQueryTerminalBackgroundColorDestructured,
) -> Promise[RgbColor?] =
  #| (self, _destructured_) => self.queryTerminalBackgroundColor(_destructured_)

///|
pub extern "js" fn TuiMainScreen::query_terminal_color_scheme(
  self : TuiMainScreen,
  _destructured_ : TuiBaseQueryTerminalColorSchemeDestructured,
) -> Promise[String?] =
  #| (self, _destructured_) => self.queryTerminalColorScheme(_destructured_)

///|
pub extern "js" fn TuiMainScreen::capture_render_state(
  self : TuiMainScreen,
) -> TuiMainScreenRenderState =
  #| (self) => self.captureRenderState()

///|
pub extern "js" fn TuiMainScreen::restore_render_state(
  self : TuiMainScreen,
  state : TuiMainScreenRenderState,
) -> Unit =
  #| (self, state) => self.restoreRenderState(state)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_process_terminal() -> ProcessTerminal = "__ts_mbt_new_process_terminal"

///|
pub extern "js" fn ProcessTerminal::get_process_terminal_kitty_protocol_active(
  self : ProcessTerminal,
) -> Bool =
  #| (self) => self.kittyProtocolActive

///|
pub extern "js" fn ProcessTerminal::get_process_terminal_modify_other_keys_active(
  self : ProcessTerminal,
) -> Bool =
  #| (self) => self.modifyOtherKeysActive

///|
pub extern "js" fn ProcessTerminal::get_process_terminal_columns(
  self : ProcessTerminal,
) -> Double =
  #| (self) => self.columns

///|
pub extern "js" fn ProcessTerminal::get_process_terminal_rows(
  self : ProcessTerminal,
) -> Double =
  #| (self) => self.rows

///|
pub extern "js" fn ProcessTerminal::kitty_protocol_active(
  self : ProcessTerminal,
) -> Bool =
  #| (self) => self.kittyProtocolActive()

///|
pub extern "js" fn ProcessTerminal::modify_other_keys_active(
  self : ProcessTerminal,
) -> Bool =
  #| (self) => self.modifyOtherKeysActive()

///|
pub extern "js" fn ProcessTerminal::start(
  self : ProcessTerminal,
  onInput : (String) -> Unit,
  onResize : () -> Unit,
) -> Unit =
  #| (self, onInput, onResize) => self.start(onInput, onResize)

///|
pub extern "js" fn ProcessTerminal::drain_input(
  self : ProcessTerminal,
  maxMs : Double?,
  idleMs : Double?,
) -> Promise[Unit] =
  #| (self, maxMs, idleMs) => self.drainInput((maxMs == null ? undefined : (typeof maxMs === "object" && "$tag" in maxMs ? (maxMs.$tag === 1 ? maxMs._0 : undefined) : maxMs)), (idleMs == null ? undefined : (typeof idleMs === "object" && "$tag" in idleMs ? (idleMs.$tag === 1 ? idleMs._0 : undefined) : idleMs)))

///|
pub extern "js" fn ProcessTerminal::stop(self : ProcessTerminal) -> Unit =
  #| (self) => self.stop()

///|
pub extern "js" fn ProcessTerminal::write(
  self : ProcessTerminal,
  data : String,
) -> Unit =
  #| (self, data) => self.write(data)

///|
pub extern "js" fn ProcessTerminal::columns(self : ProcessTerminal) -> Double =
  #| (self) => self.columns()

///|
pub extern "js" fn ProcessTerminal::rows(self : ProcessTerminal) -> Double =
  #| (self) => self.rows()

///|
pub extern "js" fn ProcessTerminal::move_by(
  self : ProcessTerminal,
  lines : Double,
) -> Unit =
  #| (self, lines) => self.moveBy(lines)

///|
pub extern "js" fn ProcessTerminal::hide_cursor(self : ProcessTerminal) -> Unit =
  #| (self) => self.hideCursor()

///|
pub extern "js" fn ProcessTerminal::show_cursor(self : ProcessTerminal) -> Unit =
  #| (self) => self.showCursor()

///|
pub extern "js" fn ProcessTerminal::clear_line(self : ProcessTerminal) -> Unit =
  #| (self) => self.clearLine()

///|
pub extern "js" fn ProcessTerminal::clear_from_cursor(
  self : ProcessTerminal,
) -> Unit =
  #| (self) => self.clearFromCursor()

///|
pub extern "js" fn ProcessTerminal::clear_screen(
  self : ProcessTerminal,
) -> Unit =
  #| (self) => self.clearScreen()

///|
pub extern "js" fn ProcessTerminal::set_title(
  self : ProcessTerminal,
  title : String,
) -> Unit =
  #| (self, title) => self.setTitle(title)

///|
pub extern "js" fn ProcessTerminal::set_progress(
  self : ProcessTerminal,
  active : Bool,
) -> Unit =
  #| (self, active) => self.setProgress(active)

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_cancellable_loader() -> CancellableLoader = "__ts_mbt_new_cancellable_loader"

///|
pub extern "js" fn CancellableLoader::get_cancellable_loader_on_abort(
  self : CancellableLoader,
) -> () -> Unit =
  #| (self) => self.onAbort

///|
pub extern "js" fn CancellableLoader::set_cancellable_loader_on_abort(
  self : CancellableLoader,
  value : () -> Unit,
) -> Unit =
  #| (self, value) => (self.onAbort = value)

///|
pub extern "js" fn CancellableLoader::get_cancellable_loader_signal(
  self : CancellableLoader,
) -> AbortSignal =
  #| (self) => self.signal

///|
pub extern "js" fn CancellableLoader::get_cancellable_loader_aborted(
  self : CancellableLoader,
) -> Bool =
  #| (self) => self.aborted

///|
pub extern "js" fn CancellableLoader::set_text(
  self : CancellableLoader,
  text : String,
) -> Unit =
  #| (self, text) => self.setText(text)

///|
pub extern "js" fn CancellableLoader::set_custom_bg_fn(
  self : CancellableLoader,
  customBgFn : ((String) -> String)?,
) -> Unit =
  #| (self, customBgFn) => self.setCustomBgFn((customBgFn == null ? undefined : (typeof customBgFn === "object" && "$tag" in customBgFn ? (customBgFn.$tag === 1 ? customBgFn._0 : undefined) : customBgFn)))

///|
pub extern "js" fn CancellableLoader::invalidate(
  self : CancellableLoader,
) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn CancellableLoader::render(
  self : CancellableLoader,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn CancellableLoader::start(self : CancellableLoader) -> Unit =
  #| (self) => self.start()

///|
pub extern "js" fn CancellableLoader::stop(self : CancellableLoader) -> Unit =
  #| (self) => self.stop()

///|
pub extern "js" fn CancellableLoader::set_message(
  self : CancellableLoader,
  message : String,
) -> Unit =
  #| (self, message) => self.setMessage(message)

///|
pub extern "js" fn CancellableLoader::set_indicator(
  self : CancellableLoader,
  indicator : LoaderIndicatorOptions?,
) -> Unit =
  #| (self, indicator) => self.setIndicator((indicator == null ? undefined : (typeof indicator === "object" && "$tag" in indicator ? (indicator.$tag === 1 ? indicator._0 : undefined) : indicator)))

///|
pub extern "js" fn CancellableLoader::on_abort(
  self : CancellableLoader,
) -> Unit =
  #| (self) => self.onAbort()

///|
pub extern "js" fn CancellableLoader::signal(
  self : CancellableLoader,
) -> AbortSignal =
  #| (self) => self.signal()

///|
pub extern "js" fn CancellableLoader::aborted(self : CancellableLoader) -> Bool =
  #| (self) => self.aborted()

///|
pub extern "js" fn CancellableLoader::handle_input(
  self : CancellableLoader,
  data : String,
) -> Unit =
  #| (self, data) => self.handleInput(data)

///|
pub extern "js" fn CancellableLoader::dispose(self : CancellableLoader) -> Unit =
  #| (self) => self.dispose()

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_keybindings_manager(
  definitions : KeybindingDefinitions,
  userBindings : KeybindingsConfig?,
) -> KeybindingsManager = "__ts_mbt_new_keybindings_manager"

///|
extern "js" fn _keybindings_manager_matches_ret_conv_js(
  this_ : KeybindingsManager,
  data : String,
  keybinding : String,
) -> Bool =
  #| (self, data, keybinding) => self.matches(data, keybinding)

///|
extern "js" fn _keybindings_manager_get_keys_ret_conv_js(
  this_ : KeybindingsManager,
  keybinding : String,
) -> Array[KeyId] =
  #| (self, keybinding) => self.getKeys(keybinding)

///|
extern "js" fn _keybindings_manager_get_definition_ret_conv_js(
  this_ : KeybindingsManager,
  keybinding : String,
) -> KeybindingDefinition =
  #| (self, keybinding) => self.getDefinition(keybinding)

///|
pub extern "js" fn KeybindingsManager::get_conflicts(
  self : KeybindingsManager,
) -> Array[KeybindingConflict] =
  #| (self) => self.getConflicts()

///|
pub extern "js" fn KeybindingsManager::set_user_bindings(
  self : KeybindingsManager,
  userBindings : KeybindingsConfig,
) -> Unit =
  #| (self, userBindings) => self.setUserBindings(userBindings)

///|
pub extern "js" fn KeybindingsManager::get_user_bindings(
  self : KeybindingsManager,
) -> KeybindingsConfig =
  #| (self) => self.getUserBindings()

///|
pub extern "js" fn KeybindingsManager::get_resolved_bindings(
  self : KeybindingsManager,
) -> KeybindingsConfig =
  #| (self) => self.getResolvedBindings()

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn new_combined_autocomplete_provider(
  commands : Array[Auto_SlashCommandValue_or_AutocompleteItemValue]?,
  basePath : String,
  fdPath : String?,
) -> CombinedAutocompleteProvider = "__ts_mbt_new_combined_autocomplete_provider"

///|
pub extern "js" fn CombinedAutocompleteProvider::get_suggestions(
  self : CombinedAutocompleteProvider,
  lines : Array[String],
  cursorLine : Double,
  cursorCol : Double,
  options : CombinedAutocompleteProviderGetSuggestionsOptions,
) -> Promise[AutocompleteSuggestions?] =
  #| (self, lines, cursorLine, cursorCol, options) => self.getSuggestions(lines, cursorLine, cursorCol, options)

///|
pub extern "js" fn CombinedAutocompleteProvider::apply_completion(
  self : CombinedAutocompleteProvider,
  lines : Array[String],
  cursorLine : Double,
  cursorCol : Double,
  item : AutocompleteItem,
  prefix : String,
) -> JSValue =
  #| (self, lines, cursorLine, cursorCol, item, prefix) => self.applyCompletion(lines, cursorLine, cursorCol, item, prefix)

///|
pub extern "js" fn CombinedAutocompleteProvider::should_trigger_file_completion(
  self : CombinedAutocompleteProvider,
  lines : Array[String],
  cursorLine : Double,
  cursorCol : Double,
) -> Bool =
  #| (self, lines, cursorLine, cursorCol) => self.shouldTriggerFileCompletion(lines, cursorLine, cursorCol)

///|
#module("@earendil-works/pi-tui")
extern "js" fn parse_key(data : String) -> String? = "parseKey"

///|
#module("@earendil-works/pi-tui")
pub extern "js" fn hyperlink(text : String, url : String) -> String = "hyperlink"

///|
#module("@earendil-works/pi-tui")
extern "js" fn fuzzy_match(query : String, text : String) -> FuzzyMatch = "fuzzyMatch"

///|
#module("@earendil-works/pi-tui")
extern "js" fn matches_key(data : String, keyId : KeyId) -> Bool = "matchesKey"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn encode_kitty(base64Data : String, options : JSValue?) -> String = "__ts_mbt_encode_kitty"

///|
#module("@earendil-works/pi-tui")
extern "js" fn fuzzy_filter(
  items : Array[JSValue],
  query : String,
  getText : (JSValue) -> String,
) -> Array[JSValue] = "fuzzyFilter"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn is_focusable(component : Component?) -> Bool = "__ts_mbt_is_focusable"

///|
#module("@earendil-works/pi-tui")
extern "js" fn is_key_repeat(data : String) -> Bool = "isKeyRepeat"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn render_image(
  base64Data : String,
  imageDimensions : ImageDimensions,
  options : ImageRenderOptions?,
) -> JSValue? = "__ts_mbt_render_image"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn render_latex(
  source : String,
  options : RenderLatexOptions?,
) -> String? = "__ts_mbt_render_latex"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn encode_iterm2(base64Data : String, options : JSValue?) -> String = "__ts_mbt_encode_iterm2"

///|
#module("@earendil-works/pi-tui")
extern "js" fn is_key_release(data : String) -> Bool = "isKeyRelease"

///|
#module("@earendil-works/pi-tui")
extern "js" fn visible_width(str : String) -> Double = "visibleWidth"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn image_fallback(
  mimeType : String,
  dimensions : ImageDimensions?,
  filename : String?,
) -> String = "__ts_mbt_image_fallback"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn is_viewport_tui(tui : TUI) -> Bool = "__ts_mbt_is_viewport_tui"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn slice_by_column(
  line : String,
  startCol : Double,
  length : Double,
  strict : Bool?,
) -> String = "__ts_mbt_slice_by_column"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_keybindings() -> KeybindingsManager = "getKeybindings"

///|
#module("@earendil-works/pi-tui")
extern "js" fn set_keybindings(keybindings : KeybindingsManager) -> Unit = "setKeybindings"

///|
#module("@earendil-works/pi-tui")
extern "js" fn allocate_image_id() -> Double = "allocateImageId"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_capabilities() -> TerminalCapabilities = "getCapabilities"

///|
#module("@earendil-works/pi-tui")
extern "js" fn set_capabilities(caps : TerminalCapabilities) -> Unit = "setCapabilities"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn truncate_to_width(
  text : String,
  maxWidth : Double,
  ellipsis : String?,
  pad : Bool?,
) -> String = "__ts_mbt_truncate_to_width"

///|
#module("@earendil-works/pi-tui")
extern "js" fn composite_tui_line(
  baseLine : String,
  overlayLine : String,
  startCol : Double,
  overlayWidth : Double,
  totalWidth : Double,
) -> String = "compositeTuiLine"

///|
#module("@earendil-works/pi-tui")
extern "js" fn delete_kitty_image(imageId : Double) -> String = "deleteKittyImage"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_gif_dimensions(base64Data : String) -> ImageDimensions? = "getGifDimensions"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_png_dimensions(base64Data : String) -> ImageDimensions? = "getPngDimensions"

///|
#module("@earendil-works/pi-tui")
extern "js" fn wrap_text_with_ansi(
  text : String,
  width : Double,
) -> Array[String] = "wrapTextWithAnsi"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_cell_dimensions() -> CellDimensions = "getCellDimensions"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_jpeg_dimensions(base64Data : String) -> ImageDimensions? = "getJpegDimensions"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_webp_dimensions(base64Data : String) -> ImageDimensions? = "getWebpDimensions"

///|
#module("@earendil-works/pi-tui")
extern "js" fn set_cell_dimensions(dims : CellDimensions) -> Unit = "setCellDimensions"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn calculate_image_rows(
  imageDimensions : ImageDimensions,
  targetWidthCells : Double,
  cellDimensions : CellDimensions?,
) -> Double = "__ts_mbt_calculate_image_rows"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn detect_capabilities(
  tmuxForwardsHyperlink : (() -> Bool)?,
) -> TerminalCapabilities = "__ts_mbt_detect_capabilities"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_image_dimensions(
  base64Data : String,
  mimeType : String,
) -> ImageDimensions? = "getImageDimensions"

///|
#module("@earendil-works/pi-tui")
extern "js" fn get_osc8_link_at_column(
  line : String,
  column : Double,
) -> String? = "getOsc8LinkAtColumn"

///|
#module("@earendil-works/pi-tui")
extern "js" fn decode_kitty_printable(data : String) -> String? = "decodeKittyPrintable"

///|
#module("@earendil-works/pi-tui")
extern "js" fn delete_all_kitty_images() -> String = "deleteAllKittyImages"

///|
#module("@earendil-works/pi-tui")
extern "js" fn is_kitty_protocol_active() -> Bool = "isKittyProtocolActive"

///|
#module("@earendil-works/pi-tui")
extern "js" fn reset_capabilities_cache() -> Unit = "resetCapabilitiesCache"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn set_capability_overrides(
  overrides : TerminalCapabilitiesPartial,
) -> Unit = "__ts_mbt_set_capability_overrides"

///|
#module("@earendil-works/pi-tui")
extern "js" fn set_kitty_protocol_active(active : Bool) -> Unit = "setKittyProtocolActive"

///|
#module("@earendil-works/pi-tui")
extern "js" fn strip_terminal_sequences(str : String) -> String = "stripTerminalSequences"

///|
#module("@earendil-works/pi-tui")
extern "js" fn parse_osc11_background_color(data : String) -> RgbColor? = "parseOsc11BackgroundColor"

///|
#module("@earendil-works/pi-tui")
extern "js" fn parse_terminal_color_scheme_report(data : String) -> String? = "parseTerminalColorSchemeReport"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn _promise_then_extern_js(
  p : JSValue,
  on_ok : (JSValue) -> Unit,
) -> Unit = "__ts_mbt_promise_then"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn _promise_then_catch_extern_js(
  p : JSValue,
  on_ok : (JSValue) -> Unit,
  on_err : (JSValue) -> Unit,
) -> Unit = "__ts_mbt_promise_then_catch"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
extern "js" fn _promise_map_extern_js(
  p : JSValue,
  f : (JSValue) -> JSValue,
) -> JSValue = "__ts_mbt_promise_map"

// Starts a MoonBit async fn from a sync context. Only ever called with
// wrapper fns that never raise and perform all effects in their body:
// an async fn that completes without suspending returns its result
// instead of calling the continuations, so this trampoline must not be
// trusted with error delivery.

///|
extern "js" fn _start_async_extern_js(f : async () -> Unit) -> Unit =
  #| (f) => { f((_ok) => {}, (_e) => {}) }

///|
extern "js" fn _async_error_exit_extern_js(err : JSValue) -> Unit =
  #| (e) => { console.error("unhandled async error:", e); if (typeof process !== "undefined" && process.exit) process.exit(1); else throw e; }

///|
extern "js" fn _promise_ctor_extern_js(
  executor : ((JSValue) -> Unit, (JSValue) -> Unit) -> Unit,
) -> JSValue =
  #| (executor) => new Promise((resolve, reject) => executor(resolve, reject))

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn get_key() -> JSValue = "__ts_mbt_get_key"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn get_tokens() -> JSValue = "__ts_mbt_get_tokens"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn get_cursor_marker() -> JSValue = "__ts_mbt_get_cursor_marker"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn get_tui_keybindings() -> JSValue = "__ts_mbt_get_tui_keybindings"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn tui_input_listener_result_undefined() -> TuiInputListenerResult = "__ts_mbt_tui_input_listener_result_undefined"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn size_value_from_double(value : Double) -> SizeValue = "__ts_mbt_size_value_from_double"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn key_id_from_base_key(value : BaseKey) -> KeyId = "__ts_mbt_key_id_from_base_key"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn key_id_from_modified_key_id(value : ModifiedKeyId) -> KeyId = "__ts_mbt_key_id_from_modified_key_id"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn token_from_marked_token(value : MarkedToken) -> Token = "__ts_mbt_token_from_marked_token"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn token_from_tokens_generic(value : Tokens_Generic) -> Token = "__ts_mbt_token_from_tokens_generic"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn maybe_promise_from_promise(
  value : Promise[JSValue],
) -> MaybePromise = "__ts_mbt_maybe_promise_from_promise"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn stack_child_from_component(value : Component) -> StackChild = "__ts_mbt_stack_child_from_component"

///|
#module("@tsmbt-bridge/earendil_works__pi_tui")
pub extern "js" fn stack_child_from_stack_entry(
  value : StackEntry,
) -> StackChild = "__ts_mbt_stack_child_from_stack_entry"

///|
extern "js" fn __ts_mbt_option_return_is_absent(value : JSValue) -> Bool =
  #| (value) => value === undefined || value === null
