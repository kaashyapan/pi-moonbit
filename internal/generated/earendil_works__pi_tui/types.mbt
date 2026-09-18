///|
#external
pub type Promise[X]

///|
#external
pub type JSValue

///|
pub type ImageProtocol = String?

///|
pub type TuiInputListener = (String) -> TuiInputListenerResult

///|
pub type KeybindingsConfig = StringRecordOfKeyIdOrArrayOfKeyIdOptional

///|
pub type MouseRegionHandler = (TuiMouseEvent) -> TuiMouseEventResult?

///|
pub type KeybindingDefinitions = StringRecordOfKeybindingDefinition

// Unsupported export KeyId: heterogeneous union member is not runtime-discriminable: the generic reference `ModifiedKeyId<...>` has no monomorphic payload type.

// Unsupported export Token: heterogeneous union member is not runtime-discriminable: the qualified name `Tokens.Generic` cannot be spelled as an enum case.

// Unsupported export SizeValue: heterogeneous union member is not runtime-discriminable: the member shape has no runtime discriminator.

///|
pub(all) enum TuiMode {
  Regular
  Fullscreen
}

///|
pub(all) enum Keybinding {
  Tui_editor_cursorUp
  Tui_editor_cursorDown
  Tui_editor_historyPrevious
  Tui_editor_historyNext
  Tui_editor_cursorLeft
  Tui_editor_cursorRight
  Tui_editor_cursorWordLeft
  Tui_editor_cursorWordRight
  Tui_editor_cursorLineStart
  Tui_editor_cursorLineEnd
  Tui_editor_jumpForward
  Tui_editor_jumpBackward
  Tui_editor_pageUp
  Tui_editor_pageDown
  Tui_editor_deleteCharBackward
  Tui_editor_deleteCharForward
  Tui_editor_deleteWordBackward
  Tui_editor_deleteWordForward
  Tui_editor_deleteToLineStart
  Tui_editor_deleteToLineEnd
  Tui_editor_yank
  Tui_editor_yankPop
  Tui_editor_undo
  Tui_input_newLine
  Tui_input_submit
  Tui_input_tab
  Tui_input_copy
  Tui_select_up
  Tui_select_down
  Tui_select_pageUp
  Tui_select_pageDown
  Tui_select_confirm
  Tui_select_cancel
  Tui_altScreen_pageUp
  Tui_altScreen_pageDown
  Tui_altScreen_halfPageUp
  Tui_altScreen_halfPageDown
  Tui_altScreen_lineUp
  Tui_altScreen_lineDown
  Tui_altScreen_previousPrompt
  Tui_altScreen_nextPrompt
  Tui_altScreen_search
  Tui_altScreen_searchNext
  Tui_altScreen_searchPrevious
  Tui_altScreen_searchClose
  Tui_altScreen_top
  Tui_altScreen_bottom
}

///|
pub(all) enum KeyEventType {
  Press
  Repeat
  Release
}

///|
pub(all) enum OverlayAnchor {
  Center
  Top_left
  Top_right
  Bottom_left
  Bottom_right
  Top_center
  Bottom_center
  Left_center
  Right_center
}

///|
pub(all) enum TuiMouseButton {
  Left
  Middle
  Right
  None
}

///|
pub(all) enum TuiMouseEventType {
  Press
  Release
  Move
  Drag
  Click
  Wheel
}

///|
pub(all) enum ScrollViewScrollbar {
  Hidden
  Auto
  Always
}

///|
pub(all) enum TerminalColorScheme {
  Dark
  Light
}

///|
pub(all) enum StackEntryBasisMember1 {
  Auto
}

///|
pub(all) enum StackOptionsAlign {
  Stretch
  Start
  Center
  End
}

///|
pub(all) enum ScrollViewOptionsAxis {
  Vertical
}

///|
pub(all) enum ScrollViewOptionsFollow {
  None
  End
}

///|
pub(all) enum ScrollViewOptionsOverscroll {
  Chain
  Contain
}

///|
pub(all) enum StackEntryOptionsBasisMember1 {
  Auto
}

///|
pub(all) enum TokenizerExtensionLevel {
  Block
  Inline
}

///|
pub(all) enum KeyValueEscape {
  Escape
}

///|
pub(all) enum KeyValueEsc {
  Esc
}

///|
pub(all) enum KeyValueEnter {
  Enter
}

///|
pub(all) enum KeyValueReturn {
  Return
}

///|
pub(all) enum KeyValueTab {
  Tab
}

///|
pub(all) enum KeyValueSpace {
  Space
}

///|
pub(all) enum KeyValueBackspace {
  Backspace
}

///|
pub(all) enum KeyValueDelete {
  Delete
}

///|
pub(all) enum KeyValueInsert {
  Insert
}

///|
pub(all) enum KeyValueClear {
  Clear
}

///|
pub(all) enum KeyValueHome {
  Home
}

///|
pub(all) enum KeyValueEnd {
  End
}

///|
pub(all) enum KeyValuePageUp {
  PageUp
}

///|
pub(all) enum KeyValuePageDown {
  PageDown
}

///|
pub(all) enum KeyValueUp {
  Up
}

///|
pub(all) enum KeyValueDown {
  Down
}

///|
pub(all) enum KeyValueLeft {
  Left
}

///|
pub(all) enum KeyValueRight {
  Right
}

///|
pub(all) enum KeyValueF1 {
  F1
}

///|
pub(all) enum KeyValueF2 {
  F2
}

///|
pub(all) enum KeyValueF3 {
  F3
}

///|
pub(all) enum KeyValueF4 {
  F4
}

///|
pub(all) enum KeyValueF5 {
  F5
}

///|
pub(all) enum KeyValueF6 {
  F6
}

///|
pub(all) enum KeyValueF7 {
  F7
}

///|
pub(all) enum KeyValueF8 {
  F8
}

///|
pub(all) enum KeyValueF9 {
  F9
}

///|
pub(all) enum KeyValueF10 {
  F10
}

///|
pub(all) enum KeyValueF11 {
  F11
}

///|
pub(all) enum KeyValueF12 {
  F12
}

///|
pub(all) enum KeyValueBacktick {
  Member
}

///|
pub(all) enum KeyValueHyphen {
  Member
}

///|
pub(all) enum KeyValueEquals {
  Member
}

///|
pub(all) enum KeyValueLeftbracket {
  Member
}

///|
pub(all) enum KeyValueRightbracket {
  Member
}

///|
pub(all) enum KeyValueBackslash {
  Member
}

///|
pub(all) enum KeyValueSemicolon {
  Member
}

///|
pub(all) enum KeyValueQuote {
  Member
}

///|
pub(all) enum KeyValueComma {
  Member
}

///|
pub(all) enum KeyValuePeriod {
  Member
}

///|
pub(all) enum KeyValueSlash {
  Member
}

///|
pub(all) enum KeyValueExclamation {
  Member
}

///|
pub(all) enum KeyValueAt {
  Member
}

///|
pub(all) enum KeyValueHash {
  Member
}

///|
pub(all) enum KeyValueDollar {
  Dollar
}

///|
pub(all) enum KeyValuePercent {
  Member
}

///|
pub(all) enum KeyValueCaret {
  Member
}

///|
pub(all) enum KeyValueAmpersand {
  Member
}

///|
pub(all) enum KeyValueAsterisk {
  Member
}

///|
pub(all) enum KeyValueLeftparen {
  Member
}

///|
pub(all) enum KeyValueRightparen {
  Member
}

///|
pub(all) enum KeyValueUnderscore {
  Member
}

///|
pub(all) enum KeyValuePlus {
  Member
}

///|
pub(all) enum KeyValuePipe {
  Member
}

///|
pub(all) enum KeyValueTilde {
  Member
}

///|
pub(all) enum KeyValueLeftbrace {
  Member
}

///|
pub(all) enum KeyValueRightbrace {
  Member
}

///|
pub(all) enum KeyValueColon {
  Member
}

///|
pub(all) enum KeyValueLessthan {
  Member
}

///|
pub(all) enum KeyValueGreaterthan {
  Member
}

///|
pub(all) enum KeyValueQuestion {
  Member
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorUpDefaultKeys {
  Up
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorUpDescription {
  Move_cursor_up
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorDownDefaultKeys {
  Down
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorDownDescription {
  Move_cursor_down
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_historyPreviousDescription {
  Select_previous_prompt_history_entry
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_historyNextDescription {
  Select_next_prompt_history_entry
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLeftDefaultKeysItem0 {
  Left
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLeftDefaultKeysItem1 {
  Ctrl_b
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLeftDescription {
  Move_cursor_left
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorRightDefaultKeysItem0 {
  Right
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorRightDefaultKeysItem1 {
  Ctrl_f
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorRightDescription {
  Move_cursor_right
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorWordLeftDefaultKeysItem0 {
  Alt_left
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorWordLeftDefaultKeysItem1 {
  Ctrl_left
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorWordLeftDefaultKeysItem2 {
  Alt_b
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorWordLeftDescription {
  Move_cursor_word_left
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorWordRightDefaultKeysItem0 {
  Alt_right
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorWordRightDefaultKeysItem1 {
  Ctrl_right
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorWordRightDefaultKeysItem2 {
  Alt_f
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorWordRightDescription {
  Move_cursor_word_right
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLineStartDefaultKeysItem0 {
  Home
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLineStartDefaultKeysItem1 {
  Ctrl_home
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLineStartDefaultKeysItem2 {
  Ctrl_a
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLineStartDescription {
  Move_to_line_start
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLineEndDefaultKeysItem0 {
  End
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLineEndDefaultKeysItem1 {
  Ctrl_end
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLineEndDefaultKeysItem2 {
  Ctrl_e
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_cursorLineEndDescription {
  Move_to_line_end
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_jumpForwardDefaultKeys {
  Ctrl__
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_jumpForwardDescription {
  Jump_forward_to_character
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_jumpBackwardDefaultKeys {
  Ctrl_alt__
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_jumpBackwardDescription {
  Jump_backward_to_character
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_pageUpDefaultKeysItem0 {
  PageUp
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_pageUpDefaultKeysItem1 {
  Ctrl_pageUp
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_pageUpDescription {
  Page_up
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_pageDownDefaultKeysItem0 {
  PageDown
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_pageDownDefaultKeysItem1 {
  Ctrl_pageDown
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_pageDownDescription {
  Page_down
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteCharBackwardDefaultKeys {
  Backspace
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteCharBackwardDescription {
  Delete_character_backward
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteCharForwardDefaultKeysItem0 {
  Delete
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteCharForwardDefaultKeysItem1 {
  Ctrl_d
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteCharForwardDescription {
  Delete_character_forward
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteWordBackwardDefaultKeysItem0 {
  Ctrl_w
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteWordBackwardDefaultKeysItem1 {
  Alt_backspace
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteWordBackwardDescription {
  Delete_word_backward
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteWordForwardDefaultKeysItem0 {
  Alt_d
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteWordForwardDefaultKeysItem1 {
  Alt_delete
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteWordForwardDescription {
  Delete_word_forward
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteToLineStartDefaultKeys {
  Ctrl_u
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteToLineStartDescription {
  Delete_to_line_start
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteToLineEndDefaultKeys {
  Ctrl_k
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_deleteToLineEndDescription {
  Delete_to_line_end
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_yankDefaultKeys {
  Ctrl_y
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_yankDescription {
  Yank
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_yankPopDefaultKeys {
  Alt_y
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_yankPopDescription {
  Yank_pop
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_undoDefaultKeys {
  Ctrl__
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_editor_undoDescription {
  Undo
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_newLineDefaultKeysItem0 {
  Shift_enter
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_newLineDefaultKeysItem1 {
  Ctrl_j
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_newLineDescription {
  Insert_newline
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_submitDefaultKeys {
  Enter
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_submitDescription {
  Submit_input
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_tabDefaultKeys {
  Tab
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_tabDescription {
  Tab___autocomplete
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_copyDefaultKeys {
  Ctrl_c
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_input_copyDescription {
  Copy_selection
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_upDefaultKeys {
  Up
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_upDescription {
  Move_selection_up
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_downDefaultKeys {
  Down
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_downDescription {
  Move_selection_down
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_pageUpDefaultKeys {
  PageUp
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_pageUpDescription {
  Selection_page_up
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_pageDownDefaultKeys {
  PageDown
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_pageDownDescription {
  Selection_page_down
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_confirmDefaultKeys {
  Enter
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_confirmDescription {
  Confirm_selection
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_cancelDefaultKeysItem0 {
  Escape
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_cancelDefaultKeysItem1 {
  Ctrl_c
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_select_cancelDescription {
  Cancel_selection
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_pageUpDefaultKeys {
  PageUp
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_pageUpDescription {
  Scroll_viewport_up_one_page
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_pageDownDefaultKeys {
  PageDown
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_pageDownDescription {
  Scroll_viewport_down_one_page
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_halfPageUpDescription {
  Scroll_viewport_up_half_a_page
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_halfPageDownDescription {
  Scroll_viewport_down_half_a_page
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_lineUpDescription {
  Scroll_viewport_up_one_line
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_lineDownDescription {
  Scroll_viewport_down_one_line
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_previousPromptDefaultKeysItem0 {
  Ctrl_shift_up
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_previousPromptDefaultKeysItem1 {
  Ctrl_up
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_previousPromptDescription {
  Jump_to_previous_semantic_prompt
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_nextPromptDefaultKeysItem0 {
  Ctrl_shift_down
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_nextPromptDefaultKeysItem1 {
  Ctrl_down
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_nextPromptDescription {
  Jump_to_next_semantic_prompt
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchDefaultKeys {
  Ctrl_shift_f
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchDescription {
  Search_the_primary_scroll_view
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchNextDefaultKeysItem0 {
  Enter
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchNextDefaultKeysItem1 {
  Ctrl_g
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchNextDescription {
  Select_the_next_search_match
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchPreviousDefaultKeysItem0 {
  Shift_enter
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchPreviousDefaultKeysItem1 {
  Ctrl_shift_g
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchPreviousDescription {
  Select_the_previous_search_match
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchCloseDefaultKeys {
  Escape
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_searchCloseDescription {
  Close_transcript_search
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_topDefaultKeys {
  Home
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_topDescription {
  Scroll_viewport_to_top
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_bottomDefaultKeys {
  End
}

///|
pub(all) enum TUI_KEYBINDINGSValueTui_altScreen_bottomDescription {
  Scroll_viewport_to_bottom
}

///|
pub(all) enum ScrollViewOverscroll {
  Chain
  Contain
}

///|
pub(all) enum StackChild {
  ComponentValue(Component)
  StackEntryValue(StackEntry)
}

///|
#warnings("-9")
pub(all) struct TUI {
  // readonly in TypeScript; not enforced by generated MoonBit struct
  mode : TuiMode
  children : Array[Component]
  terminal : Terminal
  onDebug : (() -> Unit)?
  // readonly in TypeScript; not enforced by generated MoonBit struct
  fullRedraws : Double
  addChild : (Component) -> Unit
  removeChild : (Component) -> Unit
  clear : () -> Unit
  getShowHardwareCursor : () -> Bool
  setShowHardwareCursor : (Bool) -> Unit
  getClearOnShrink : () -> Bool
  setClearOnShrink : (Bool) -> Unit
  setFocus : (Component?) -> Unit
  showOverlay : (Component, OverlayOptions?) -> OverlayHandle
  hideOverlay : () -> Unit
  hasOverlay : () -> Bool
  start : () -> Unit
  stop : (TuiStopOptions?) -> Unit
  renderNow : (Bool?) -> Unit
  requestRender : (Bool?) -> Unit
  addInputListener : (TuiInputListener) -> () -> Unit
  removeInputListener : (TuiInputListener) -> Unit
  onTerminalColorSchemeChange : ((String) -> Unit) -> () -> Unit
  setTerminalColorSchemeNotifications : (Bool) -> Unit
  queryTerminalBackgroundColor : (TuiQueryTerminalBackgroundColorOptions) -> Promise[
    RgbColor?,
  ]
  queryTerminalColorScheme : (TuiQueryTerminalColorSchemeOptions) -> Promise[
    String?,
  ]
  render : (Double) -> Array[String]
  handleInput : ((String) -> Unit)?
  handleMouse : ((TuiMouseEvent) -> TuiMouseEventResult?)?
  wantsKeyRelease : Bool?
  invalidate : () -> Unit
}

///|
#warnings("-9")
pub(all) struct RgbColor {
  r : Double
  g : Double
  b : Double
}

///|
#warnings("-9")
pub(all) struct Terminal {
  start : ((String) -> Unit, () -> Unit) -> Unit
  stop : () -> Unit
  drainInput : (Double?, Double?) -> Promise[Unit]
  write : (String) -> Unit
  // readonly in TypeScript; not enforced by generated MoonBit struct
  columns : Double
  // readonly in TypeScript; not enforced by generated MoonBit struct
  rows : Double
  // readonly in TypeScript; not enforced by generated MoonBit struct
  kittyProtocolActive : Bool
  moveBy : (Double) -> Unit
  hideCursor : () -> Unit
  showCursor : () -> Unit
  clearLine : () -> Unit
  clearFromCursor : () -> Unit
  clearScreen : () -> Unit
  setTitle : (String) -> Unit
  setProgress : (Bool) -> Unit
}

///|
#warnings("-9")
pub(all) struct Component {
  render : (Double) -> Array[String]
  handleInput : ((String) -> Unit)?
  handleMouse : ((TuiMouseEvent) -> TuiMouseEventResult?)?
  wantsKeyRelease : Bool?
  invalidate : () -> Unit
}

///|
#warnings("-9")
pub(all) struct Focusable {
  focused : Bool
}

///|
#warnings("-9")
pub(all) struct FuzzyMatch {
  matches : Bool
  score : Double
}

///|
#warnings("-9")
pub(all) struct ImageTheme {
  fallbackColor : (String) -> String
}

///|
#warnings("-9")
pub(all) struct SelectItem {
  value : String
  label : String
  description : String?
}

///|
#warnings("-9")
pub(all) struct StackEntry {
  component : Component
  basis : Auto_NumberValue_or_StackEntryBasisMember1Value?
  grow : Double?
  shrink : Double?
  minSize : Double?
  maxSize : Double?
  visible : ((LayoutViewport) -> Bool)?
}

///|
#warnings("-9")
pub(all) struct EditorTheme {
  borderColor : (String) -> String
  selectList : SelectListTheme
}

///|
#warnings("-9")
pub(all) struct Keybindings {
  tui_editor_cursorUp : Bool
  tui_editor_cursorDown : Bool
  tui_editor_historyPrevious : Bool
  tui_editor_historyNext : Bool
  tui_editor_cursorLeft : Bool
  tui_editor_cursorRight : Bool
  tui_editor_cursorWordLeft : Bool
  tui_editor_cursorWordRight : Bool
  tui_editor_cursorLineStart : Bool
  tui_editor_cursorLineEnd : Bool
  tui_editor_jumpForward : Bool
  tui_editor_jumpBackward : Bool
  tui_editor_pageUp : Bool
  tui_editor_pageDown : Bool
  tui_editor_deleteCharBackward : Bool
  tui_editor_deleteCharForward : Bool
  tui_editor_deleteWordBackward : Bool
  tui_editor_deleteWordForward : Bool
  tui_editor_deleteToLineStart : Bool
  tui_editor_deleteToLineEnd : Bool
  tui_editor_yank : Bool
  tui_editor_yankPop : Bool
  tui_editor_undo : Bool
  tui_input_newLine : Bool
  tui_input_submit : Bool
  tui_input_tab : Bool
  tui_input_copy : Bool
  tui_select_up : Bool
  tui_select_down : Bool
  tui_select_pageUp : Bool
  tui_select_pageDown : Bool
  tui_select_confirm : Bool
  tui_select_cancel : Bool
  tui_altScreen_pageUp : Bool
  tui_altScreen_pageDown : Bool
  tui_altScreen_halfPageUp : Bool
  tui_altScreen_halfPageDown : Bool
  tui_altScreen_lineUp : Bool
  tui_altScreen_lineDown : Bool
  tui_altScreen_previousPrompt : Bool
  tui_altScreen_nextPrompt : Bool
  tui_altScreen_search : Bool
  tui_altScreen_searchNext : Bool
  tui_altScreen_searchPrevious : Bool
  tui_altScreen_searchClose : Bool
  tui_altScreen_top : Bool
  tui_altScreen_bottom : Bool
}

///|
#warnings("-9")
pub(all) struct SettingItem {
  id : String
  label : String
  description : String?
  currentValue : String
  values : Array[String]?
  submenu : ((String, (String?, JSValue?) -> Unit) -> Component)?
}

///|
#warnings("-9")
pub(all) struct ViewportTUI {
  // readonly in TypeScript; not enforced by generated MoonBit struct
  _computed_ : Bool
  setLayoutRoot : (Component?) -> Unit
  // readonly in TypeScript; not enforced by generated MoonBit struct
  mode : TuiMode
  children : Array[Component]
  terminal : Terminal
  onDebug : (() -> Unit)?
  // readonly in TypeScript; not enforced by generated MoonBit struct
  fullRedraws : Double
  addChild : (Component) -> Unit
  removeChild : (Component) -> Unit
  clear : () -> Unit
  getShowHardwareCursor : () -> Bool
  setShowHardwareCursor : (Bool) -> Unit
  getClearOnShrink : () -> Bool
  setClearOnShrink : (Bool) -> Unit
  setFocus : (Component?) -> Unit
  showOverlay : (Component, OverlayOptions?) -> OverlayHandle
  hideOverlay : () -> Unit
  hasOverlay : () -> Bool
  start : () -> Unit
  stop : (TuiStopOptions?) -> Unit
  renderNow : (Bool?) -> Unit
  requestRender : (Bool?) -> Unit
  addInputListener : (TuiInputListener) -> () -> Unit
  removeInputListener : (TuiInputListener) -> Unit
  onTerminalColorSchemeChange : ((String) -> Unit) -> () -> Unit
  setTerminalColorSchemeNotifications : (Bool) -> Unit
  queryTerminalBackgroundColor : (TuiQueryTerminalBackgroundColorOptions) -> Promise[
    RgbColor?,
  ]
  queryTerminalColorScheme : (TuiQueryTerminalColorSchemeOptions) -> Promise[
    String?,
  ]
  render : (Double) -> Array[String]
  handleInput : ((String) -> Unit)?
  handleMouse : ((TuiMouseEvent) -> TuiMouseEventResult?)?
  wantsKeyRelease : Bool?
  invalidate : () -> Unit
}

///|
#warnings("-9")
pub(all) struct ImageOptions {
  maxWidthCells : Double?
  maxHeightCells : Double?
  filename : String?
  imageId : Double?
}

///|
#warnings("-9")
pub(all) struct SlashCommand {
  name : String
  description : String?
  argumentHint : String?
  getArgumentCompletions : ((String) -> JSValue?)?
}

///|
#warnings("-9")
pub(all) struct StackOptions {
  gap : Double?
  align : StackOptionsAlign?
}

///|
#warnings("-9")
pub(all) struct EditorOptions {
  paddingX : Double?
  autocompleteMaxVisible : Double?
}

///|
#warnings("-9")
pub(all) struct MarkdownTheme {
  heading : (String) -> String
  link : (String) -> String
  linkUrl : (String) -> String
  code : (String) -> String
  codeBlock : (String) -> String
  codeBlockBorder : (String) -> String
  quote : (String) -> String
  quoteBorder : (String) -> String
  hr : (String) -> String
  listBullet : (String) -> String
  bold : (String) -> String
  italic : (String) -> String
  strikethrough : (String) -> String
  underline : (String) -> String
  highlightCode : (String, String?) -> Array[String]?
  codeBlockIndent : String?
}

///|
#warnings("-9")
pub(all) struct OverlayBounds {
  row : Double
  col : Double
  width : Double
  height : Double
}

///|
#warnings("-9")
pub(all) struct OverlayHandle {
  hide : () -> Unit
  setHidden : (Bool) -> Unit
  isHidden : () -> Bool
  focus : () -> Unit
  unfocus : (OverlayUnfocusOptions?) -> Unit
  isFocused : () -> Bool
  getBounds : () -> OverlayBounds?
}

///|
#warnings("-9")
pub(all) struct OverlayMargin {
  top : Double?
  right : Double?
  bottom : Double?
  left : Double?
}

///|
#warnings("-9")
pub(all) struct TuiMouseEvent {
  type_ : TuiMouseEventType
  button : TuiMouseButton
  x : Double
  y : Double
  screenX : Double
  screenY : Double
  width : Double
  height : Double
  shift : Bool
  alt : Bool
  ctrl : Bool
  wheelDelta : Double?
  clickCount : Double?
}

///|
#warnings("-9")
pub(all) struct CellDimensions {
  widthPx : Double
  heightPx : Double
}

///|
#warnings("-9")
pub(all) struct OverlayOptions {
  width : SizeValue?
  minWidth : Double?
  maxHeight : SizeValue?
  anchor : OverlayAnchor?
  offsetX : Double?
  offsetY : Double?
  row : SizeValue?
  col : SizeValue?
  margin : Auto_NumberValue_or_OverlayMarginValue?
  visible : ((Double, Double) -> Bool)?
  nonCapturing : Bool?
}

///|
#warnings("-9")
pub(all) struct TuiStopOptions {
  preserveScreen : Bool?
}

///|
#warnings("-9")
pub(all) struct EditorComponent {
  getText : () -> String
  setText : (String) -> Unit
  handleInput : (String) -> Unit
  onSubmit : ((String) -> Unit)?
  onChange : ((String) -> Unit)?
  addToHistory : ((String) -> Unit)?
  insertTextAtCursor : ((String) -> Unit)?
  getExpandedText : (() -> String)?
  setAutocompleteProvider : ((AutocompleteProvider) -> Unit)?
  borderColor : ((String) -> String)?
  setPaddingX : ((Double) -> Unit)?
  setAutocompleteMaxVisible : ((Double) -> Unit)?
  render : (Double) -> Array[String]
  handleMouse : ((TuiMouseEvent) -> TuiMouseEventResult?)?
  wantsKeyRelease : Bool?
  invalidate : () -> Unit
}

///|
#warnings("-9")
pub(all) struct ImageDimensions {
  widthPx : Double
  heightPx : Double
}

///|
#warnings("-9")
pub(all) struct MarkdownOptions {
  preserveOrderedListMarkers : Bool?
  preserveBackslashEscapes : Bool?
  transform : ((String, Double) -> String)?
  renderLatex : Bool?
}

///|
#warnings("-9")
pub(all) struct SelectListTheme {
  selectedPrefix : (String) -> String
  selectedText : (String) -> String
  description : (String) -> String
  scrollInfo : (String) -> String
  noMatch : (String) -> String
}

///|
#warnings("-9")
pub(all) struct AutocompleteItem {
  value : String
  label : String
  description : String?
}

///|
#warnings("-9")
pub(all) struct DefaultTextStyle {
  color : ((String) -> String)?
  bgColor : ((String) -> String)?
  bold : Bool?
  italic : Bool?
  strikethrough : Bool?
  underline : Bool?
}

///|
#warnings("-9")
pub(all) struct ScrollViewOptions {
  axis : ScrollViewOptionsAxis?
  follow : ScrollViewOptionsFollow?
  primary : Bool?
  overscroll : ScrollViewOptionsOverscroll?
  scrollbar : ScrollViewScrollbar?
  scrollbarTrackStyle : ((String) -> String)?
  scrollbarThumbStyle : ((String) -> String)?
  scrollbarHideDelayMs : Double?
}

///|
#warnings("-9")
pub(all) struct SettingsListTheme {
  label : (String, Bool) -> String
  value : (String, Bool) -> String
  description : (String) -> String
  cursor : String
  hint : (String) -> String
}

///|
#warnings("-9")
pub(all) struct StackEntryOptions {
  basis : Auto_NumberValue_or_StackEntryOptionsBasisMember1Value?
  grow : Double?
  shrink : Double?
  minSize : Double?
  maxSize : Double?
  visible : ((LayoutViewport) -> Bool)?
}

///|
#warnings("-9")
pub(all) struct ImageRenderOptions {
  maxWidthCells : Double?
  maxHeightCells : Double?
  preserveAspectRatio : Bool?
  imageId : Double?
  moveCursor : Bool?
}

///|
#warnings("-9")
pub(all) struct KeybindingConflict {
  key : KeyId
  keybindings : Array[String]
}

///|
#warnings("-9")
pub(all) struct RenderLatexOptions {
  display : Bool?
}

///|
#warnings("-9")
pub(all) struct StdinBufferOptions {
  timeout : Double?
  escapeTimeout : Double?
}

///|
#warnings("-9")
pub(all) struct StdinBufferEventMap {
  data : Array[String]
  paste : Array[String]
}

///|
#warnings("-9")
pub(all) struct TuiAltScreenOptions {
  wheelScrollLines : Double?
  mouse : Bool?
  searchMatchStyle : ((String) -> String)?
  searchCurrentMatchStyle : ((String) -> String)?
  searchNavigationButtonStyle : ((String, Bool) -> String)?
  scrollToEndIndicator : (() -> String)?
  openUrl : ((String) -> Unit)?
  onRightClickPaste : (() -> Unit)?
  copyOnSelect : Bool?
  copySelection : ((String) -> Promise[Bool])?
}

///|
#warnings("-9")
pub(all) struct TuiMouseEventResult {
  handled : Bool?
  capture : Bool?
  focus : Bool?
  render : Bool?
}

///|
#warnings("-9")
pub(all) struct AutocompleteProvider {
  triggerCharacters : Array[String]?
  getSuggestions : (
    Array[String],
    Double,
    Double,
    AutocompleteProviderGetSuggestionsOptions,
  ) -> Promise[AutocompleteSuggestions?]
  applyCompletion : (Array[String], Double, Double, AutocompleteItem, String) -> AutocompleteProviderApplyCompletionResult
  shouldTriggerFileCompletion : ((Array[String], Double, Double) -> Bool)?
}

///|
#warnings("-9")
pub(all) struct KeybindingDefinition {
  defaultKeys : Auto_KeyIdValue_or_KeyIdArrayValue
  description : String?
}

///|
#warnings("-9")
pub(all) struct TerminalCapabilities {
  images : ImageProtocol
  trueColor : Bool
  hyperlinks : Bool
}

///|
#warnings("-9")
pub(all) struct OverlayUnfocusOptions {
  target : Component?
}

///|
#warnings("-9")
pub(all) struct LoaderIndicatorOptions {
  frames : Array[String]?
  intervalMs : Double?
}

///|
#warnings("-9")
pub(all) struct AutocompleteSuggestions {
  items : Array[AutocompleteItem]
  prefix : String
}

///|
#warnings("-9")
pub(all) struct SelectListLayoutOptions {
  minPrimaryColumnWidth : Double?
  maxPrimaryColumnWidth : Double?
  truncatePrimary : ((SelectListTruncatePrimaryContext) -> String)?
}

///|
#warnings("-9")
pub(all) struct TuiMainScreenRenderState {
  previousLines : Array[String]
  previousWidth : Double
  previousHeight : Double
  cursorRow : Double
  hardwareCursorRow : Double
  maxLinesRendered : Double
  previousViewportTop : Double
}

///|
#warnings("-9")
pub(all) struct ScrollViewScrollToOptions {
  disableFollow : Bool?
}

///|
#warnings("-9")
pub(all) struct SelectListTruncatePrimaryContext {
  text : String
  maxWidth : Double
  columnWidth : Double
  item : SelectItem
  isSelected : Bool
}

///|
#warnings("-9")
pub(all) struct TerminalCapabilitiesPartial {
  images : ImageProtocol?
  trueColor : Bool?
  hyperlinks : Bool?
}

///|
#warnings("-9")
pub(all) struct LayoutViewport {
  width : Double
  height : Double
}

///|
#warnings("-9")
pub(all) struct TuiMouseDispatchResult {
  handled : Bool
  target : TuiMouseDispatchTarget
  focusTarget : Component?
  capture : Bool?
  focus : Bool?
  render : Bool?
}

///|
#warnings("-9")
pub(all) struct TuiMouseDispatchTarget {
  component : Component
  originX : Double
  originY : Double
  width : Double
  height : Double
}

///|
#warnings("-9")
pub(all) struct InputOptions {
  prompt : String?
  placeholder : String?
  placeholderStyle : ((String) -> String)?
}

///|
#warnings("-9")
pub(all) struct MarkedOptions[ParserOutput, RendererOutput] {
  hooks : UnderscoreHooks?
  renderer : UnderscoreRenderer?
  tokenizer : UnderscoreTokenizer?
  extensions : MarkedOptionsExtensions?
  walkTokens : ((Token) -> JSValue)?
}

///|
#warnings("-9")
pub(all) struct MarkedExtension[ParserOutput, RendererOutput] {
  async_ : Bool?
  breaks : Bool?
  extensions : Array[JSValue]?
  gfm : Bool?
  hooks : JSValue?
  pedantic : Bool?
  renderer : JSValue?
  silent : Bool?
  tokenizer : TokenizerObject?
  walkTokens : ((Token) -> Promise[Unit])?
}

///|
#warnings("-9")
pub(all) struct TokenizerExtension {
  name : String
  level : TokenizerExtensionLevel
  start : TokenizerStartFunction?
  tokenizer : TokenizerExtensionFunction
  childTokens : Array[String]?
}

///|
#warnings("-9")
pub(all) struct RendererExtension[ParserOutput, RendererOutput] {
  name : String
  renderer : (RendererThis[ParserOutput, RendererOutput], Tokens_Generic) -> Auto_FalseValue_or_RendererOutputValue?
}

///|
#warnings("-9")
pub(all) struct RendererThis[ParserOutput, RendererOutput] {
  parser : UnderscoreParser
}

///|
#warnings("-9")
pub(all) struct SettingsListOptions {
  enableSearch : Bool?
}

///|
#warnings("-9")
pub(all) struct TuiQueryTerminalBackgroundColorOptions {
  timeoutMs : Double
}

///|
#warnings("-9")
pub(all) struct TuiQueryTerminalColorSchemeOptions {
  timeoutMs : Double
}

///|
#warnings("-9")
pub(all) struct AutocompleteProviderGetSuggestionsOptions {
  signal : AbortSignal
  force : Bool?
}

///|
#warnings("-9")
pub(all) struct AutocompleteProviderApplyCompletionResult {
  lines : Array[String]
  cursorLine : Double
  cursorCol : Double
}

///|
#warnings("-9")
pub(all) struct MarkedOptionsExtensions {
  renderers : JSValue
  childTokens : JSValue
  inline : Array[TokenizerExtensionFunction]?
  block : Array[TokenizerExtensionFunction]?
  startInline : Array[TokenizerStartFunction]?
  startBlock : Array[TokenizerStartFunction]?
}

///|
#warnings("-9")
pub(all) struct MarkedParser {
  _new_ : (MarkedOptions[ParserOutput, RendererOutput]?) -> UnderscoreParser
  parse : (Array[Token], MarkedOptions[ParserOutput_1, RendererOutput_1]?) -> ParserOutput_1
  parseInline : (Array[Token], MarkedOptions[ParserOutput_1, RendererOutput_1]?) -> ParserOutput_1
}

///|
#warnings("-9")
pub(all) struct MarkedRenderer {
  _new_ : (MarkedOptions[ParserOutput, RendererOutput]?) -> UnderscoreRenderer
}

///|
#warnings("-9")
pub(all) struct MarkedTextRenderer {
  _new_ : () -> UnderscoreTextRenderer
}

///|
#warnings("-9")
pub(all) struct MarkedTokenizer {
  _new_ : (MarkedOptions[ParserOutput, RendererOutput]?) -> UnderscoreTokenizer
}

///|
#warnings("-9")
pub(all) struct MarkedHooks {
  _new_ : (MarkedOptions[ParserOutput, RendererOutput]?) -> UnderscoreHooks
  passThroughHooks : Set
  passThroughHooksRespectAsync : Set
}

///|
#warnings("-9")
pub(all) struct TuiBaseQueryTerminalBackgroundColorDestructured {
  timeoutMs : Double
}

///|
#warnings("-9")
pub(all) struct TuiBaseQueryTerminalColorSchemeDestructured {
  timeoutMs : Double
}

///|
#warnings("-9")
pub(all) struct CombinedAutocompleteProviderGetSuggestionsOptions {
  signal : AbortSignal
  force : Bool?
}

///|
#warnings("-3")
#external
pub type Box

///|
#warnings("-3")
#external
pub type Text

///|
#warnings("-3")
#external
pub type Image

///|
#warnings("-3")
#external
pub type Input

///|
#warnings("-3")
#external
pub type Editor

///|
#warnings("-3")
#external
pub type HStack

///|
#warnings("-3")
#external
pub type Loader

///|
#warnings("-3")
#external
pub type Marked[ParserOutput, RendererOutput]

///|
#warnings("-3")
#external
pub type Spacer

///|
#warnings("-3")
#external
pub type VStack

///|
#warnings("-3")
#external
pub type Markdown

///|
#warnings("-3")
#external
pub type Container

///|
#warnings("-3")
#external
pub type ScrollView

///|
#warnings("-3")
#external
pub type SelectList

///|
#warnings("-3")
#external
pub type MouseRegion

///|
#warnings("-3")
#external
pub type StdinBuffer

///|
#warnings("-3")
#external
pub type SettingsList

///|
#warnings("-3")
#external
pub type TuiAltScreen

///|
#warnings("-3")
#external
pub type TruncatedText

///|
#warnings("-3")
#external
pub type TuiMainScreen

///|
#warnings("-3")
#external
pub type ProcessTerminal

///|
#warnings("-3")
#external
pub type CancellableLoader

///|
#warnings("-3")
#external
pub type KeybindingsManager

///|
#warnings("-3")
#external
pub type CombinedAutocompleteProvider

///|
pub(all) enum Auto_BufferValue_or_StringValue {
  StringValue(String)
  BufferValue(Buffer)
}

///|
pub(all) enum Auto_KeyIdValue_or_KeyIdArrayValue {
  KeyIdValue(KeyId)
  KeyIdArrayValue(Array[KeyId])
}

///|
pub(all) enum Auto_FalseValue_or_RendererOutputValue {
  RendererOutputValue(RendererOutput)
  FalseValue
}

///|
pub(all) enum Auto_NumberValue_or_OverlayMarginValue {
  OverlayMarginValue(OverlayMargin)
  NumberValue(Double)
}

///|
pub(all) enum Auto_TokenArrayValue_or_TokensListValue {
  TokenArrayValue(Array[Token])
  TokensListValue(TokensList)
}

///|
pub(all) enum Auto_NumberValue_or_StackEntryBasisMember1Value {
  NumberValue(Double)
  StackEntryBasisMember1Value(StackEntryBasisMember1)
}

///|
pub(all) enum Auto_SlashCommandValue_or_AutocompleteItemValue {
  AutocompleteItemValue(AutocompleteItem)
  SlashCommandValue(SlashCommand)
}

///|
pub(all) enum Auto_MaybePromiseValue_or_MaybePromiseArrayValue {
  MaybePromiseValue(MaybePromise)
  MaybePromiseArrayValue(Array[MaybePromise])
}

///|
pub(all) enum Auto_NumberValue_or_StackEntryOptionsBasisMember1Value {
  NumberValue(Double)
  StackEntryOptionsBasisMember1Value(StackEntryOptionsBasisMember1)
}

///|
pub(all) enum Auto_TuiMouseEventResultValue_or_TuiMouseDispatchResultValue {
  TuiMouseDispatchResultValue(TuiMouseDispatchResult)
  TuiMouseEventResultValue(TuiMouseEventResult)
}

///|
#warnings("-3")
#external
pub type Set

///|
#warnings("-3")
#external
pub type Omit

///|
#warnings("-3")
#external
pub type This

///|
#warnings("-3")
#external
pub type KeyId

///|
#warnings("-3")
#external
pub type Token

///|
#warnings("-3")
#external
pub type Buffer

///|
#warnings("-3")
#external
pub type BaseKey

///|
#warnings("-3")
#external
pub type SizeValue

///|
#warnings("-3")
#external
pub type TokensList

///|
#warnings("-3")
#external
pub type AbortSignal

///|
#warnings("-3")
#external
pub type MarkedToken

///|
#warnings("-3")
#external
pub type MaybePromise

///|
#warnings("-3")
#external
pub type ParserOutput

///|
#warnings("-3")
#external
pub type ModifiedKeyId

///|
#warnings("-3")
#external
pub type ParserOutput_1

///|
#warnings("-3")
#external
pub type RendererOutput

///|
#warnings("-3")
#external
pub type Tokens_Generic

///|
#warnings("-3")
#external
pub type TokenizerObject

///|
#warnings("-3")
#external
pub type UnderscoreHooks

///|
#warnings("-3")
#external
pub type RendererOutput_1

///|
#warnings("-3")
#external
pub type UnderscoreParser

///|
#warnings("-3")
#external
pub type UnderscoreRenderer

///|
#warnings("-3")
#external
pub type UnderscoreTokenizer

///|
#warnings("-3")
#external
pub type TokenizerStartFunction

///|
#warnings("-3")
#external
pub type TuiInputListenerResult

///|
#warnings("-3")
#external
pub type UnderscoreTextRenderer

///|
#warnings("-3")
#external
pub type TokenizerExtensionFunction

///|
#warnings("-3")
#external
pub type StringRecordOfKeybindingDefinition

///|
#warnings("-3")
#external
pub type StringRecordOfKeyIdOrArrayOfKeyIdOptional
