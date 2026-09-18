///|
#external
pub type Promise[X]

///|
#external
pub type JSValue

///|
pub type TuiMode = RendererTuiMode

///|
pub type ToolInfo = ToolDefinitionPickNameDescriptionParametersPromptGuidelines

///|
pub type BashSpawnHook = (BashSpawnContext) -> BashSpawnContext

///|
pub type ProgressCallback = (ProgressEvent) -> Unit

///|
pub type RpcEventListener = (JsonAgentSessionEvent) -> Unit

///|
pub type CustomEditorOptions = EditorOptions

///|
pub type MarkdownTransformer = (String, MarkdownTransformContext) -> String

///|
pub type PowerShellSpawnHook = BashSpawnHook

///|
pub type PowerShellToolInput = BashToolInput

///|
pub type PowerShellOperations = BashOperations

///|
pub type ProjectTrustDecision = Bool?

///|
pub type PowerShellToolDetails = BashToolDetails

///|
pub type PowerShellSpawnContext = BashSpawnContext

///|
pub type AgentSessionEventListener = (AgentSessionEvent) -> Unit

///|
pub type ReadonlyFooterDataProvider = Pick

///|
pub type AutocompleteProviderFactory = (AutocompleteProvider) -> AutocompleteProvider

// Unsupported export RpcCommand: heterogeneous union member is not runtime-discriminable: an anonymous object type needs a synthesized payload struct and an object-shaped predicate.

// Unsupported export RpcResponse: heterogeneous union member is not runtime-discriminable: an anonymous object type needs a synthesized payload struct and an object-shaped predicate.

// Unsupported export PackageSource: heterogeneous union member is not runtime-discriminable: an anonymous object type needs a synthesized payload struct and an object-shaped predicate.

// Unsupported export InlineExtension: heterogeneous union member is not runtime-discriminable: an anonymous object type needs a synthesized payload struct and an object-shaped predicate.

// Unsupported export InputEventResult: heterogeneous union member is not runtime-discriminable: an anonymous object type needs a synthesized payload struct and an object-shaped predicate.

// Unsupported export AgentSessionEvent: heterogeneous union member is not runtime-discriminable: an anonymous object type needs a synthesized payload struct and an object-shaped predicate.

// Unsupported export RpcExtensionUIRequest: heterogeneous union member is not runtime-discriminable: an anonymous object type needs a synthesized payload struct and an object-shaped predicate.

// Unsupported export RpcExtensionUIResponse: heterogeneous union member is not runtime-discriminable: an anonymous object type needs a synthesized payload struct and an object-shaped predicate.

///|
pub(all) enum ThemeColor {
  Accent
  Border
  BorderAccent
  BorderMuted
  Success
  Error_
  Warning
  Muted
  Dim
  Text
  ThinkingText
  ScrollbarTrack
  ScrollbarThumb
  SearchMatchText
  UserMessageText
  CustomMessageText
  CustomMessageLabel
  ToolTitle
  ToolOutput
  MdHeading
  MdLink
  MdLinkUrl
  MdCode
  MdCodeBlock
  MdCodeBlockBorder
  MdQuote
  MdQuoteBorder
  MdHr
  MdListBullet
  ToolDiffAdded
  ToolDiffRemoved
  ToolDiffContext
  SyntaxComment
  SyntaxKeyword
  SyntaxFunction
  SyntaxVariable
  SyntaxString
  SyntaxNumber
  SyntaxType
  SyntaxOperator
  SyntaxPunctuation
  ThinkingOff
  ThinkingMinimal
  ThinkingLow
  ThinkingMedium
  ThinkingHigh
  ThinkingXhigh
  ThinkingMax
  BashMode
}

///|
pub(all) enum InputSource {
  Interactive
  Rpc
  Extension
}

///|
pub(all) enum UIPromptKind {
  Select
  Confirm
  Input
  Editor
  Custom
}

///|
pub(all) enum AppKeybinding {
  App_interrupt
  App_clear
  App_exit
  App_suspend
  App_thinking_cycle
  App_thinking_save
  App_model_cycleForward
  App_model_cycleBackward
  App_model_select
  App_tools_expand
  App_thinking_toggle
  App_session_toggleNamedFilter
  App_editor_external
  App_message_copy
  App_message_followUp
  App_message_dequeue
  App_clipboard_pasteImage
  App_session_new
  App_session_tree
  App_session_fork
  App_session_resume
  App_tree_foldOrUp
  App_tree_unfoldOrDown
  App_tree_editLabel
  App_tree_toggleLabelTimestamp
  App_session_togglePath
  App_session_toggleSort
  App_session_rename
  App_session_delete
  App_session_deleteNoninvasive
  App_models_save
  App_models_enableAll
  App_models_clearAll
  App_models_toggleProvider
  App_models_reorderUp
  App_models_reorderDown
  App_tree_filter_default
  App_tree_filter_noTools
  App_tree_filter_userOnly
  App_tree_filter_labeledOnly
  App_tree_filter_all
  App_tree_filter_cycleForward
  App_tree_filter_cycleBackward
}

///|
pub(all) enum WidgetPlacement {
  AboveEditor
  BelowEditor
}

///|
pub(all) enum ToolExecutionMode {
  Sequential
  Parallel
}

///|
pub(all) enum SlashCommandSource {
  Extension
  Prompt
  Skill
}

///|
pub(all) enum DefaultProjectTrust {
  Ask
  Always
  Never
}

///|
pub(all) enum FullscreenExitOutput {
  Transcript
  Resume_hint
}

///|
pub(all) enum ProjectTrustEventDecision {
  Yes
  No
  Undecided
}

///|
pub(all) enum CredentialSynchronizationOperation {
  Login
  Logout
  SetRuntimeApiKey
  RemoveRuntimeApiKey
}

///|
pub(all) enum ArgsDiagnosticsItemType {
  Warning
  Error_
}

///|
pub(all) enum InputEventType {
  Input
}

///|
pub(all) enum InputEventStreamingBehavior {
  Steer
  FollowUp
}

///|
pub(all) enum CustomEntryType {
  Custom
}

///|
pub(all) enum ContextEventType {
  Context
}

///|
pub(all) enum ExtensionAPIOnArg0 {
  Project_trust
}

///|
pub(all) enum ExtensionAPIRegisterFlagArg1Member0Type {
  Boolean
}

///|
pub(all) enum ExtensionAPIRegisterFlagArg1Member1Type {
  String_
}

///|
pub(all) enum PathMetadataOrigin {
  Package
  Top_level
}

///|
pub(all) enum TurnEndEventType {
  Turn_end
}

///|
pub(all) enum AgentEndEventType {
  Agent_end
}

///|
pub(all) enum ExtensionFlagType {
  Boolean
  String_
}

///|
pub(all) enum ProgressEventType {
  Start
  Progress
  Complete
  Error_
}

///|
pub(all) enum ProgressEventAction {
  Install
  Remove
  Update
  Clone
  Pull
}

///|
pub(all) enum PromptOptionsStreamingBehavior {
  Steer
  FollowUp
}

///|
pub(all) enum SessionHeaderType {
  Session
}

///|
pub(all) enum UserBashEventType {
  User_bash
}

///|
pub(all) enum PackageManagerGetInstalledPathArg1 {
  User
  Project
}

///|
pub(all) enum SettingsConfigSteeringMode {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsConfigFollowUpMode {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsConfigDoubleEscapeAction {
  Fork
  Tree
  None
}

///|
pub(all) enum SettingsConfigTreeFilterMode {
  Default
  No_tools
  User_only
  Labeled_only
  All
}

///|
pub(all) enum SettingsConfigOutputPad {
  N0
  N1
}

///|
pub(all) enum ToolDefinitionRenderShell {
  Default
  Self
}

///|
pub(all) enum TurnStartEventType {
  Turn_start
}

///|
pub(all) enum AgentStartEventType {
  Agent_start
}

///|
pub(all) enum CompactionEntryType {
  Compaction
}

///|
pub(all) enum LsToolCallEventToolName {
  Ls
}

///|
pub(all) enum LsToolCallEventType {
  Tool_call
}

///|
pub(all) enum MessageEndEventType {
  Message_end
}

///|
pub(all) enum RpcSessionStateSteeringMode {
  All
  One_at_a_time
}

///|
pub(all) enum RpcSessionStateFollowUpMode {
  All
  One_at_a_time
}

///|
pub(all) enum ModelChangeEntryType {
  Model_change
}

///|
pub(all) enum PrintModeOptionsMode {
  Text
  Json
}

///|
pub(all) enum SessionInfoEntryType {
  Session_info
}

///|
pub(all) enum SessionTreeEventType {
  Session_tree
}

///|
pub(all) enum TruncationResultTruncatedBy {
  Lines
  Bytes
}

///|
pub(all) enum UIPromptEndEventType {
  Ui_prompt_end
}

///|
pub(all) enum UIPromptEndEventReason {
  Ui_prompt
}

///|
pub(all) enum AgentSettledEventType {
  Agent_settled
}

///|
pub(all) enum BashToolCallEventToolName {
  Bash
}

///|
pub(all) enum BashToolCallEventType {
  Tool_call
}

///|
pub(all) enum EditToolCallEventToolName {
  Edit
}

///|
pub(all) enum EditToolCallEventType {
  Tool_call
}

///|
pub(all) enum FindToolCallEventToolName {
  Find
}

///|
pub(all) enum FindToolCallEventType {
  Tool_call
}

///|
pub(all) enum GrepToolCallEventToolName {
  Grep
}

///|
pub(all) enum GrepToolCallEventType {
  Tool_call
}

///|
pub(all) enum MessageStartEventType {
  Message_start
}

///|
pub(all) enum ProjectTrustEventType {
  Project_trust
}

///|
pub(all) enum ReadToolCallEventToolName {
  Read
}

///|
pub(all) enum ReadToolCallEventType {
  Tool_call
}

///|
pub(all) enum ResourceCollisionResourceType {
  Extension
  Skill
  Prompt
  Theme
}

///|
pub(all) enum SessionStartEventType {
  Session_start
}

///|
pub(all) enum SessionStartEventReason {
  Startup
  Reload
  New
  Resume
  Fork
}

///|
pub(all) enum SettingsCallbacksOnSteeringModeChangeArg0 {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsCallbacksOnFollowUpModeChangeArg0 {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsCallbacksOnDoubleEscapeActionChangeArg0 {
  Fork
  Tree
  None
}

///|
pub(all) enum SettingsCallbacksOnTreeFilterModeChangeArg0 {
  Default
  No_tools
  User_only
  Labeled_only
  All
}

///|
pub(all) enum SettingsCallbacksOnOutputPadChangeArg0 {
  N0
  N1
}

///|
pub(all) enum BranchSummaryEntryType {
  Branch_summary
}

///|
pub(all) enum CustomMessageEntryType {
  Custom_message
}

///|
pub(all) enum MessageUpdateEventType {
  Message_update
}

///|
pub(all) enum ResourceDiagnosticType {
  Warning
  Error_
  Collision
}

///|
pub(all) enum UIPromptStartEventType {
  Ui_prompt_start
}

///|
pub(all) enum UIPromptStartEventReason {
  Ui_prompt
}

///|
pub(all) enum WriteToolCallEventToolName {
  Write
}

///|
pub(all) enum WriteToolCallEventType {
  Tool_call
}

///|
pub(all) enum CustomToolCallEventType {
  Tool_call
}

///|
pub(all) enum ProviderModelConfigInputItem {
  Text
  Image
}

///|
pub(all) enum SessionCompactEventType {
  Session_compact
}

///|
pub(all) enum SessionCompactEventReason {
  Manual
  Threshold
  Overflow
}

///|
pub(all) enum SessionMessageEntryType {
  Message
}

///|
pub(all) enum ModelScopeDiagnosticType {
  Warning
}

///|
pub(all) enum ModelScopeDiagnosticCode {
  No_match
  Invalid_thinking_level
}

///|
pub(all) enum SessionShutdownEventType {
  Session_shutdown
}

///|
pub(all) enum SessionShutdownEventReason {
  Quit
  Reload
  New
  Resume
  Fork
}

///|
pub(all) enum BeforeAgentStartEventType {
  Before_agent_start
}

///|
pub(all) enum ToolExecutionEndEventType {
  Tool_execution_end
}

///|
pub(all) enum SessionBeforeForkEventType {
  Session_before_fork
}

///|
pub(all) enum SessionBeforeForkEventPosition {
  Before
  At
}

///|
pub(all) enum SessionBeforeTreeEventType {
  Session_before_tree
}

///|
pub(all) enum PowerShellToolCallEventToolName {
  Powershell
}

///|
pub(all) enum PowerShellToolCallEventType {
  Tool_call
}

///|
pub(all) enum SessionInfoChangedEventType {
  Session_info_changed
}

///|
pub(all) enum ToolExecutionStartEventType {
  Tool_execution_start
}

///|
pub(all) enum MarkdownTransformContextMessageType {
  User
  Assistant
  Assistant_thinking
}

///|
pub(all) enum SessionBeforeSwitchEventType {
  Session_before_switch
}

///|
pub(all) enum SessionBeforeSwitchEventReason {
  New
  Resume
}

///|
pub(all) enum ThinkingLevelChangeEntryType {
  Thinking_level_change
}

///|
pub(all) enum ToolExecutionUpdateEventType {
  Tool_execution_update
}

///|
pub(all) enum CreateAgentSessionOptionsNoTools {
  All
  Builtin
}

///|
pub(all) enum SessionBeforeCompactEventType {
  Session_before_compact
}

///|
pub(all) enum SessionBeforeCompactEventReason {
  Manual
  Threshold
  Overflow
}

///|
pub(all) enum BeforeProviderHeadersEventType {
  Before_provider_headers
}

///|
pub(all) enum BeforeProviderRequestEventType {
  Before_provider_request
}

///|
pub(all) enum AgentSessionRuntimeDiagnosticType {
  Info
  Warning
  Error_
}

///|
pub(all) enum CreateAgentSessionFromServicesOptionsNoTools {
  All
  Builtin
}

///|
pub(all) enum SettingsPartialSteeringMode {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsPartialFollowUpMode {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsPartialDoubleEscapeAction {
  Fork
  Tree
  None
}

///|
pub(all) enum SettingsPartialTreeFilterMode {
  Default
  No_tools
  User_only
  Labeled_only
  All
}

///|
pub(all) enum SettingsPartialOutputPad {
  N0
  N1
}

///|
pub(all) enum ResourcesDiscoverEventType {
  Resources_discover
}

///|
pub(all) enum ResourcesDiscoverEventReason {
  Startup
  Reload
}

///|
pub(all) enum SessionCompactFailedEventType {
  Session_compact_failed
}

///|
pub(all) enum SessionCompactFailedEventReason {
  Manual
  Threshold
  Overflow
}

///|
pub(all) enum AfterProviderResponseEventType {
  After_provider_response
}

///|
pub(all) enum ModelSelectEventType {
  Model_select
}

///|
pub(all) enum ThinkingLevelSelectEventType {
  Thinking_level_select
}

///|
pub(all) enum CustomMessageRole {
  Custom
}

///|
pub(all) enum ConfiguredPackageScope {
  User
  Project
}

///|
pub(all) enum ShellConfigCommandTransport {
  Argv
  Stdin
}

///|
pub(all) enum RpcSlashCommandSource {
  Extension
  Prompt
  Skill
}

///|
pub(all) enum ProviderConfigInputModelsMember0ItemInputItem {
  Text
  Image
}

///|
pub(all) enum ProviderConfigInputRefreshModelsMember0ReturnArg0ItemInputItem {
  Text
  Image
}

///|
pub(all) enum AuthStatusSource {
  Stored
  Runtime
  Environment
  Fallback
  Models_json_key
  Models_json_command
}

///|
pub(all) enum BashExecutionMessageRole {
  BashExecution
}

///|
pub(all) enum BeforeAgentStartCombinedResultMessagesMember0ItemArg1 {
  CustomType
  Content
  Display
  Details
}

///|
pub(all) enum SettingsSteeringMode {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsFollowUpMode {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsDoubleEscapeAction {
  Fork
  Tree
  None
}

///|
pub(all) enum SettingsTreeFilterMode {
  Default
  No_tools
  User_only
  Labeled_only
  All
}

///|
pub(all) enum SettingsOutputPad {
  N0
  N1
}

///|
pub(all) enum TerminalSettingsHyperlinksMember1 {
  Auto
}

///|
pub(all) enum TerminalSettingsImagesMember0 {
  Kitty
}

///|
pub(all) enum TerminalSettingsImagesMember1 {
  Iterm2
}

///|
pub(all) enum TerminalSettingsImagesMember2 {
  Auto
}

///|
pub(all) enum TerminalSettingsTrueColorMember1 {
  Auto
}

///|
pub(all) enum PackageUpdateType {
  Npm
  Git
}

///|
pub(all) enum AuthSelectorProviderAuthType {
  Oauth
  Api_key
}

///|
pub(all) enum ToolRenderersRenderShell {
  Default
  Self
}

///|
pub(all) enum BranchSummaryMessageRole {
  BranchSummary
}

///|
pub(all) enum CompactionSummaryMessageRole {
  CompactionSummary
}

///|
pub(all) enum AgentSessionSendCustomMessageOptionsDeliverAs {
  Steer
  FollowUp
  NextTurn
}

///|
pub(all) enum AgentSessionSendUserMessageOptionsDeliverAs {
  Steer
  FollowUp
}

///|
pub(all) enum AgentSessionRuntimeForkOptionsPosition {
  Before
  At
}

///|
pub(all) enum IsToolCallEventTypeToolName {
  Bash
}

///|
pub(all) enum FormatSkillsForPromptFileReadTool {
  Read
  Bash
}

///|
pub(all) enum IsToolCallEventType_string_tool_call_eventToolName {
  Powershell
}

///|
pub(all) enum RpcClientSetSteeringModeMode {
  All
  One_at_a_time
}

///|
pub(all) enum RpcClientSetFollowUpModeMode {
  All
  One_at_a_time
}

///|
pub(all) enum AgentSessionSteeringMode {
  All
  One_at_a_time
}

///|
pub(all) enum AgentSessionFollowUpMode {
  All
  One_at_a_time
}

///|
pub(all) enum AgentSessionSteeringModeReturn {
  All
  One_at_a_time
}

///|
pub(all) enum AgentSessionFollowUpModeReturn {
  All
  One_at_a_time
}

///|
pub(all) enum AgentSessionSendCustomMessageMessageArg1 {
  CustomType
  Content
  Display
  Details
}

///|
pub(all) enum AgentSessionCycleModelDirection {
  Forward
  Backward
}

///|
pub(all) enum AgentSessionSetSteeringModeMode {
  All
  One_at_a_time
}

///|
pub(all) enum AgentSessionSetFollowUpModeMode {
  All
  One_at_a_time
}

///|
pub(all) enum ExtensionRunnerEmitReturnArg0TargetType {
  Session_before_switch
}

///|
pub(all) enum ExtensionRunnerEmitReturnArg0FalseTargetType {
  Session_before_fork
}

///|
pub(all) enum ExtensionRunnerEmitReturnArg0FalseFalseTargetType {
  Session_before_compact
}

///|
pub(all) enum ExtensionRunnerEmitReturnArg0FalseFalseFalseTargetType {
  Session_before_tree
}

///|
pub(all) enum ExtensionRunnerEmitResourcesDiscoverReason {
  Startup
  Reload
}

///|
pub(all) enum ExtensionRunnerEmitInputStreamingBehavior {
  Steer
  FollowUp
}

///|
pub(all) enum SettingsManagerGetSteeringModeReturn {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsManagerSetSteeringModeMode {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsManagerGetFollowUpModeReturn {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsManagerSetFollowUpModeMode {
  All
  One_at_a_time
}

///|
pub(all) enum SettingsManagerGetDoubleEscapeActionReturn {
  Fork
  Tree
  None
}

///|
pub(all) enum SettingsManagerSetDoubleEscapeActionAction {
  Fork
  Tree
  None
}

///|
pub(all) enum SettingsManagerGetTreeFilterModeReturn {
  Default
  No_tools
  User_only
  Labeled_only
  All
}

///|
pub(all) enum SettingsManagerSetTreeFilterModeMode {
  Default
  No_tools
  User_only
  Labeled_only
  All
}

///|
pub(all) enum SettingsManagerGetOutputPadReturn {
  N0
  N1
}

///|
pub(all) enum SettingsManagerSetOutputPadPadding {
  N0
  N1
}

///|
pub(all) enum DefaultPackageManagerGetInstalledPathScope {
  User
  Project
}

///|
pub(all) enum OAuthSelectorComponentConstructorMode {
  Login
  Logout
}

///|
pub(all) enum OAuthSelectorComponentConstructorOnSelectArg1 {
  Oauth
  Api_key
}

///|
pub(all) enum FileEntry {
  SessionHeaderValue(SessionHeader)
  SessionEntryValue(SessionEntry)
}

///|
pub(all) enum SessionEntry {
  SessionMessageEntryValue(SessionMessageEntry)
  ThinkingLevelChangeEntryValue(ThinkingLevelChangeEntry)
  ModelChangeEntryValue(ModelChangeEntry)
  CompactionEntryValue(CompactionEntry[JSValue])
  BranchSummaryEntryValue(BranchSummaryEntry[JSValue])
  CustomEntryValue(CustomEntry[JSValue])
  CustomMessageEntryValue(CustomMessageEntry[JSValue])
  LabelEntryValue(LabelEntry)
  SessionInfoEntryValue(SessionInfoEntry)
}

///|
pub(all) enum ToolCallEvent {
  BashToolCallEventValue(BashToolCallEvent)
  PowerShellToolCallEventValue(PowerShellToolCallEvent)
  ReadToolCallEventValue(ReadToolCallEvent)
  EditToolCallEventValue(EditToolCallEvent)
  WriteToolCallEventValue(WriteToolCallEvent)
  GrepToolCallEventValue(GrepToolCallEvent)
  FindToolCallEventValue(FindToolCallEvent)
  LsToolCallEventValue(LsToolCallEvent)
  CustomToolCallEventValue(CustomToolCallEvent)
}

///|
pub(all) enum ExtensionEvent {
  ProjectTrustEventValue(ProjectTrustEvent)
  ResourcesDiscoverEventValue(ResourcesDiscoverEvent)
  SessionEventValue(SessionEvent)
  ContextEventValue(ContextEvent)
  BeforeProviderRequestEventValue(BeforeProviderRequestEvent)
  BeforeProviderHeadersEventValue(BeforeProviderHeadersEvent)
  AfterProviderResponseEventValue(AfterProviderResponseEvent)
  BeforeAgentStartEventValue(BeforeAgentStartEvent)
  AgentStartEventValue(AgentStartEvent)
  AgentEndEventValue(AgentEndEvent)
  AgentSettledEventValue(AgentSettledEvent)
  UIPromptStartEventValue(UIPromptStartEvent)
  UIPromptEndEventValue(UIPromptEndEvent)
  TurnStartEventValue(TurnStartEvent)
  TurnEndEventValue(TurnEndEvent)
  MessageStartEventValue(MessageStartEvent)
  MessageUpdateEventValue(MessageUpdateEvent)
  MessageEndEventValue(MessageEndEvent)
  ToolExecutionStartEventValue(ToolExecutionStartEvent)
  ToolExecutionUpdateEventValue(ToolExecutionUpdateEvent)
  ToolExecutionEndEventValue(ToolExecutionEndEvent)
  ModelSelectEventValue(ModelSelectEvent)
  ThinkingLevelSelectEventValue(ThinkingLevelSelectEvent)
  UserBashEventValue(UserBashEvent)
  InputEventValue(InputEvent)
  ToolCallEventValue(ToolCallEvent)
  ToolResultEventValue(ToolResultEvent)
}

///|
pub(all) enum ToolResultEvent {
  BashToolResultEventValue(BashToolResultEvent)
  PowerShellToolResultEventValue(PowerShellToolResultEvent)
  ReadToolResultEventValue(ReadToolResultEvent)
  EditToolResultEventValue(EditToolResultEvent)
  WriteToolResultEventValue(WriteToolResultEvent)
  GrepToolResultEventValue(GrepToolResultEvent)
  FindToolResultEventValue(FindToolResultEvent)
  LsToolResultEventValue(LsToolResultEvent)
  CustomToolResultEventValue(CustomToolResultEvent)
}

///|
pub(all) enum JsonAgentSessionEvent {
  AgentSessionEventValue(AgentSessionEvent)
  JsonMessageUpdateEventValue(JsonMessageUpdateEvent)
}

///|
#warnings("-9")
pub(all) struct Args {
  provider : String?
  model : String?
  apiKey : String?
  systemPrompt : String?
  appendSystemPrompt : Array[String]?
  thinking : ThinkingLevel?
  continue_ : Bool?
  resume_ : Bool?
  help : Bool?
  version : Bool?
  mode : Mode?
  name : String?
  noSession : Bool?
  session : String?
  sessionId : String?
  fork : String?
  sessionDir : String?
  models : Array[String]?
  tools : Array[String]?
  excludeTools : Array[String]?
  noTools : Bool?
  noBuiltinTools : Bool?
  extensions : Array[String]?
  noExtensions : Bool?
  print : Bool?
  export_ : String?
  noSkills : Bool?
  skills : Array[String]?
  promptTemplates : Array[String]?
  noPromptTemplates : Bool?
  themes : Array[String]?
  useTheme : String?
  noThemes : Bool?
  noContextFiles : Bool?
  listModels : Auto_TrueValue_or_StringValue?
  offline : Bool?
  tuiMode : TuiMode?
  verbose : Bool?
  projectTrustOverride : Bool?
  messages : Array[String]
  fileArgs : Array[String]
  unknownFlags : Map
  diagnostics : Array[JSValue]
}

///|
#warnings("-9")
pub(all) struct Skill {
  name : String
  description : String
  filePath : String
  baseDir : String
  sourceInfo : SourceInfo
  disableModelInvocation : Bool
}

///|
#warnings("-9")
pub(all) struct EventBus {
  emit : (String, JSValue) -> Unit
  on : (String, (JSValue) -> Unit) -> () -> Unit
}

///|
#warnings("-9")
pub(all) struct Extension {
  path : String
  resolvedPath : String
  hidden : Bool?
  sourceInfo : SourceInfo
  handlers : Map
  tools : Map
  messageRenderers : Map
  markdownTransformer : MarkdownTransformer?
  entryRenderers : Map?
  commands : Map
  flags : Map
  shortcuts : Map
}

///|
#warnings("-9")
pub(all) struct ModelInfo {
  provider : String
  id : String
  contextWindow : Double
  reasoning : Bool
}

///|
#warnings("-9")
pub(all) struct ExecResult {
  stdout : String
  stderr : String
  code : Double
  killed : Bool
}

///|
#warnings("-9")
pub(all) struct InputEvent {
  type_ : InputEventType
  text : String
  images : Array[ImageContent]?
  source : InputSource
  streamingBehavior : InputEventStreamingBehavior?
}

///|
#warnings("-9")
pub(all) struct SourceInfo {
  path : String
  source : String
  scope : SourceScope
  origin : SourceOrigin
  baseDir : String?
}

///|
#warnings("-9")
pub(all) struct CustomEntry[T] {
  type_ : CustomEntryType
  customType : String
  data : T?
}

///|
#warnings("-9")
pub(all) struct ExecOptions {
  signal : AbortSignal?
  timeout : Double?
  cwd : String?
}

///|
#warnings("-9")
pub(all) struct MainOptions {
  extensionFactories : Array[InlineExtension]?
}

///|
#warnings("-9")
pub(all) struct ScopedModel {
  model : Model[Api]
  thinkingLevel : ThinkingLevel?
}

///|
#warnings("-9")
pub(all) struct SessionInfo {
  path : String
  id : String
  cwd : String
  name : String?
  parentSessionPath : String?
  created : Date
  modified : Date
  messageCount : Double
  firstMessage : String
  allMessagesText : String
}

///|
#warnings("-9")
pub(all) struct ContextEvent {
  type_ : ContextEventType
  messages : Array[AgentMessage]
}

///|
#warnings("-9")
pub(all) struct ContextUsage {
  tokens : Double?
  contextWindow : Double
  percent : Double?
}

///|
#warnings("-9")
pub(all) struct ExtensionAPI {
  on : (String, ProjectTrustHandler) -> Unit
  on_resources_discover : (
    (ResourcesDiscoverEvent, ExtensionContext) -> JSValue,
  ) -> Unit
  on_session_before_switch : (
    (SessionBeforeSwitchEvent, ExtensionContext) -> JSValue,
  ) -> Unit
  on_session_before_fork : (
    (SessionBeforeForkEvent, ExtensionContext) -> JSValue,
  ) -> Unit
  on_session_before_compact : (
    (SessionBeforeCompactEvent, ExtensionContext) -> JSValue,
  ) -> Unit
  on_session_before_tree : (
    (SessionBeforeTreeEvent, ExtensionContext) -> JSValue,
  ) -> Unit
  on_context : ((ContextEvent, ExtensionContext) -> JSValue) -> Unit
  on_before_provider_request : (
    (BeforeProviderRequestEvent, ExtensionContext) -> JSValue,
  ) -> Unit
  on_before_agent_start : ((BeforeAgentStartEvent, ExtensionContext) -> JSValue) -> Unit
  on_message_end : ((MessageEndEvent, ExtensionContext) -> JSValue) -> Unit
  on_tool_call : ((ToolCallEvent, ExtensionContext) -> JSValue) -> Unit
  on_tool_result : ((ToolResultEvent, ExtensionContext) -> JSValue) -> Unit
  on_user_bash : ((UserBashEvent, ExtensionContext) -> JSValue) -> Unit
  on_input : ((InputEvent, ExtensionContext) -> JSValue) -> Unit
  registerTool : (ToolDefinition[TSchema, TDetails, TState[JSValue, JSValue]]) -> Unit
  registerCommand : (String, RegisteredCommandOmitNameSourceInfo) -> Unit
  registerShortcut : (KeyId, ExtensionApiRegisterShortcutOptions) -> Unit
  registerFlag : (String, JSValue) -> Unit
  getFlag : (String) -> Auto_BoolValue_or_StringValue?
  registerMessageRenderer : (
    String,
    (CustomMessage[JSValue], MessageRenderOptions, Theme) -> Component?,
  ) -> Unit
  registerMarkdownTransformer : (MarkdownTransformer) -> Unit
  registerEntryRenderer : (
    String,
    (CustomEntry[JSValue], EntryRenderOptions, Theme) -> Component?,
  ) -> Unit
  sendMessage : (Pick, JSValue?) -> Unit
  sendUserMessage : (JSValue, JSValue?) -> Unit
  appendEntry : (String, JSValue?) -> Unit
  setSessionName : (String) -> Unit
  getSessionName : () -> String?
  setLabel : (String, String?) -> Unit
  exec : (String, Array[String], ExecOptions?) -> Promise[ExecResult]
  getActiveTools : () -> Array[String]
  getAllTools : () -> Array[ToolInfo]
  setActiveTools : (Array[String]) -> Unit
  getCommands : () -> Array[SlashCommandInfo]
  setModel : (Model[JSValue]) -> Promise[Bool]
  getThinkingLevel : () -> ThinkingLevel
  setThinkingLevel : (ThinkingLevel) -> Unit
  registerProvider : (Provider[JSValue]) -> Unit
  unregisterProvider : (String) -> Unit
  events : EventBus
}

///|
#warnings("-9")
pub(all) struct LsOperations {
  exists : (String) -> Promise[Bool]
  stat : (String) -> Promise[JSValue]
  readdir : (String) -> Promise[Array[String]]
}

///|
#warnings("-9")
pub(all) struct PathMetadata {
  source : String
  scope : SourceScope
  origin : PathMetadataOrigin
  baseDir : String?
}

///|
#warnings("-9")
pub(all) struct ResizedImage {
  data : String
  mimeType : String
  originalWidth : Double
  originalHeight : Double
  width : Double
  height : Double
  wasResized : Bool
}

///|
#warnings("-9")
pub(all) struct SessionStats {
  sessionFile : String?
  sessionId : String
  userMessages : Double
  assistantMessages : Double
  toolCalls : Double
  toolResults : Double
  totalMessages : Double
  tokens : SessionStatsTokens
  cost : Double
  contextUsage : ContextUsage?
}

///|
#warnings("-9")
pub(all) struct ToolsOptions {
  read : ReadToolOptions?
  bash : BashToolOptions?
  powershell : PowerShellToolOptions?
  write : WriteToolOptions?
  edit : EditToolOptions?
  grep : GrepToolOptions?
  find : FindToolOptions?
  ls : LsToolOptions?
}

///|
#warnings("-9")
pub(all) struct TurnEndEvent {
  type_ : TurnEndEventType
  turnIndex : Double
  message : AgentMessage
  toolResults : Array[ToolResultMessage[JSValue]]
}

///|
#warnings("-9")
pub(all) struct AgentEndEvent {
  type_ : AgentEndEventType
  messages : Array[AgentMessage]
}

///|
#warnings("-9")
pub(all) struct ExtensionFlag {
  name : String
  description : String?
  type_ : ExtensionFlagType
  default : Auto_BoolValue_or_StringValue?
  extensionPath : String
}

///|
#warnings("-9")
pub(all) struct ImageSettings {
  autoResize : Bool?
  blockImages : Bool?
}

///|
#warnings("-9")
pub(all) struct LsToolDetails {
  truncation : TruncationResult?
  entryLimitReached : Double?
}

///|
#warnings("-9")
pub(all) struct LsToolOptions {
  operations : LsOperations?
}

///|
#warnings("-9")
pub(all) struct ProgressEvent {
  type_ : ProgressEventType
  action : ProgressEventAction
  source : String
  message : String?
}

///|
#warnings("-9")
pub(all) struct PromptOptions {
  expandPromptTemplates : Bool?
  images : Array[ImageContent]?
  streamingBehavior : PromptOptionsStreamingBehavior?
  source : InputSource?
  preflightResult : ((Bool) -> Unit)?
}

///|
#warnings("-9")
pub(all) struct ResolvedPaths {
  extensions : Array[ResolvedResource]
  skills : Array[ResolvedResource]
  prompts : Array[ResolvedResource]
  themes : Array[ResolvedResource]
}

///|
#warnings("-9")
pub(all) struct RetrySettings {
  enabled : Bool?
  maxRetries : Double?
  baseDelayMs : Double?
  provider : ProviderRetrySettings?
}

///|
#warnings("-9")
pub(all) struct SessionHeader {
  type_ : SessionHeaderType
  version : Double?
  id : String
  timestamp : String
  cwd : String
  parentSession : String?
}

///|
#warnings("-9")
pub(all) struct UserBashEvent {
  type_ : UserBashEventType
  command : String
  excludeFromContext : Bool
  cwd : String
}

///|
#warnings("-9")
pub(all) struct BashOperations {
  exec : (String, String, BashOperationsExecOptions) -> Promise[JSValue]
}

///|
#warnings("-9")
pub(all) struct CompactOptions {
  customInstructions : String?
  onComplete : ((CompactionResult[JSValue]) -> Unit)?
  onError : ((Error_) -> Unit)?
}

///|
#warnings("-9")
pub(all) struct CutPointResult {
  firstKeptEntryIndex : Double
  turnStartIndex : Double
  isSplitTurn : Bool
}

///|
#warnings("-9")
pub(all) struct EditDiffResult {
  diff : String
  firstChangedLine : Double?
}

///|
#warnings("-9")
pub(all) struct EditOperations {
  readFile : (String) -> Promise[Buffer]
  writeFile : (String, String) -> Promise[Unit]
  access : (String) -> Promise[Unit]
}

///|
#warnings("-9")
pub(all) struct ExtensionError {
  extensionPath : String
  event : String
  error : String
  stack : String?
}

///|
#warnings("-9")
pub(all) struct FileOperations {
  read : Set
  written : Set
  edited : Set
}

///|
#warnings("-9")
pub(all) struct FindOperations {
  exists : (String) -> Promise[Bool]
  glob : (String, String, FindOperationsGlobOptions) -> Promise[Array[String]]
}

///|
#warnings("-9")
pub(all) struct GrepOperations {
  isDirectory : (String) -> Promise[Bool]
  readFile : (String) -> Promise[String]
}

///|
#warnings("-9")
pub(all) struct PackageManager {
  resolve : (((String) -> Promise[MissingSourceAction])?) -> Promise[
    ResolvedPaths,
  ]
  install : (String, JSValue?) -> Promise[Unit]
  installAndPersist : (String, JSValue?) -> Promise[Unit]
  remove : (String, JSValue?) -> Promise[Unit]
  removeAndPersist : (String, JSValue?) -> Promise[Bool]
  update : (String?) -> Promise[Unit]
  listConfiguredPackages : () -> Array[ConfiguredPackage]
  resolveExtensionSources : (Array[String], JSValue?) -> Promise[ResolvedPaths]
  addSourceToSettings : (String, JSValue?) -> Bool
  removeSourceFromSettings : (String, JSValue?) -> Bool
  setProgressCallback : (ProgressCallback?) -> Unit
  getInstalledPath : (String, String) -> String?
}

///|
#warnings("-9")
pub(all) struct PromptTemplate {
  name : String
  description : String
  argumentHint : String?
  content : String
  sourceInfo : SourceInfo
  filePath : String
}

///|
#warnings("-9")
pub(all) struct ProviderConfig {
  name : String?
  baseUrl : String?
  apiKey : String?
  api : Api?
  streamSimple : (Model[Api], Context, SimpleStreamOptions?) -> AssistantMessageEventStream?
  headers : StringRecordOfString?
  authHeader : Bool?
  models : Array[ProviderModelConfig]?
  refreshModels : ((RefreshModelsContext) -> Promise[Array[ProviderModelConfig]])?
  oauth : ProviderConfigOauth?
}

///|
#warnings("-9")
pub(all) struct ReadOperations {
  readFile : (String) -> Promise[Buffer]
  access : (String) -> Promise[Unit]
  detectImageMimeType : ((String) -> Promise[String?])?
}

///|
#warnings("-9")
pub(all) struct RegisteredTool {
  definition : ToolDefinition[JSValue, JSValue, JSValue]
  sourceInfo : SourceInfo
}

///|
#warnings("-9")
pub(all) struct ResourceLoader {
  getExtensions : () -> LoadExtensionsResult
  getSkills : () -> ResourceLoaderGetSkillsResult
  getPrompts : () -> ResourceLoaderGetPromptsResult
  getThemes : () -> ResourceLoaderGetThemesResult
  getAgentsFiles : () -> ResourceLoaderGetAgentsFilesResult
  getSystemPrompt : () -> String?
  getSystemPromptSource : () -> JSValue?
  getAppendSystemPrompt : () -> Array[String]
  getAppendSystemPromptSources : () -> Array[JSValue]
  extendResources : (ResourceExtensionPaths) -> Unit
  reload : (ResourceLoaderReloadOptions?) -> Promise[Unit]
}

///|
#warnings("-9")
pub(all) struct SessionContext {
  messages : Array[AgentMessage]
  thinkingLevel : String
  model : SessionContextModel?
}

///|
#warnings("-9")
pub(all) struct SettingsConfig {
  autoCompact : Bool
  defaultModel : String
  currentModel : Model[JSValue]?
  availableDefaultModels : Array[Model[JSValue]]
  showImages : Bool
  imageWidthCells : Double
  autoResizeImages : Bool
  blockImages : Bool
  enableSkillCommands : Bool
  steeringMode : SettingsConfigSteeringMode
  followUpMode : SettingsConfigFollowUpMode
  transport : Transport
  httpIdleTimeoutMs : Double
  thinkingLevel : ThinkingLevel
  availableThinkingLevels : Array[ThinkingLevel]
  modelThinkingLevels : StringRecordOfThinkingLevel
  currentTheme : String
  terminalTheme : TerminalTheme
  availableThemes : Array[String]
  hideThinkingBlock : Bool
  mermaidRenderingMode : MermaidRenderingMode
  showCacheMissNotices : Bool
  collapseChangelog : Bool
  enableInstallTelemetry : Bool
  doubleEscapeAction : SettingsConfigDoubleEscapeAction
  treeFilterMode : SettingsConfigTreeFilterMode
  showHardwareCursor : Bool
  editorPaddingX : Double
  outputPad : SettingsConfigOutputPad
  autocompleteMaxVisible : Double
  quietStartup : Bool
  defaultProjectTrust : DefaultProjectTrust
  clearOnShrink : Bool
  showTerminalProgress : Bool
  tuiMode : TuiMode
  fullscreenExitOutput : FullscreenExitOutput
  fullscreenScrollbar : ScrollViewScrollbar
  fullscreenCopyOnSelect : Bool
  warnings : WarningSettings
}

///|
#warnings("-9")
pub(all) struct ToolDefinition[TParams, TDetails, TState] {
  name : String
  label : String
  description : String
  promptSnippet : String?
  promptGuidelines : Array[String]?
  parameters : TSchema
  constrainedSampling : Auto_FalseValue_or_ConstrainedSamplingConfigValue?
  renderShell : ToolDefinitionRenderShell?
  prepareArguments : ((JSValue) -> Static)?
  executionMode : ToolExecutionMode?
  execute : (
    String,
    Static,
    AbortSignal?,
    AgentToolUpdateCallback?,
    ExtensionContext,
  ) -> Promise[AgentToolResult[TDetails]]
  renderCall : ((Static, Theme, ToolRenderContext[TState, Static]) -> Component)?
  renderResult : ((
    AgentToolResult[TDetails],
    ToolRenderResultOptions,
    Theme,
    ToolRenderContext[TState, Static],
  ) -> Component)?
}

///|
#warnings("-9")
pub(all) struct TurnStartEvent {
  type_ : TurnStartEventType
  turnIndex : Double
  timestamp : Double
}

///|
#warnings("-9")
pub(all) struct AgentStartEvent {
  type_ : AgentStartEventType
}

///|
#warnings("-9")
pub(all) struct AgentToolResult[T] {
  content : Array[Auto_TextContentValue_or_ImageContentValue]
  details : T
  usage : Usage?
  addedToolNames : Array[String]?
  terminate : Bool?
}

///|
#warnings("-9")
pub(all) struct BashToolDetails {
  truncation : TruncationResult?
  fullOutputPath : String?
}

///|
#warnings("-9")
pub(all) struct BashToolOptions {
  operations : BashOperations?
  commandPrefix : String?
  shellPath : String?
  exposeSessionEnvironment : Bool?
  spawnHook : BashSpawnHook?
}

///|
#warnings("-9")
pub(all) struct CompactionEntry[T] {
  type_ : CompactionEntryType
  summary : String
  firstKeptEntryId : String
  tokensBefore : Double
  details : T?
  usage : Usage?
  fromHook : Bool?
}

///|
#warnings("-9")
pub(all) struct EditToolDetails {
  diff : String
  patch : String
  firstChangedLine : Double?
}

///|
#warnings("-9")
pub(all) struct EditToolOptions {
  operations : EditOperations?
}

///|
#warnings("-9")
pub(all) struct FindToolDetails {
  truncation : TruncationResult?
  resultLimitReached : Double?
}

///|
#warnings("-9")
pub(all) struct FindToolOptions {
  operations : FindOperations?
}

///|
#warnings("-9")
pub(all) struct GrepToolDetails {
  truncation : TruncationResult?
  matchLimitReached : Double?
  linesTruncated : Bool?
}

///|
#warnings("-9")
pub(all) struct GrepToolOptions {
  operations : GrepOperations?
}

///|
#warnings("-9")
pub(all) struct LsToolCallEvent {
  toolName : LsToolCallEventToolName
  input : LsToolInput
  type_ : LsToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct MessageEndEvent {
  type_ : MessageEndEventType
  message : AgentMessage
}

///|
#warnings("-9")
pub(all) struct ReadToolDetails {
  truncation : TruncationResult?
}

///|
#warnings("-9")
pub(all) struct ReadToolOptions {
  autoResizeImages : Bool?
  operations : ReadOperations?
}

///|
#warnings("-9")
pub(all) struct ResolvedCommand {
  invocationName : String
  name : String
  sourceInfo : SourceInfo
  description : String?
  getArgumentCompletions : ((String) -> JSValue?)?
  handler : (String, ExtensionCommandContext) -> Promise[Unit]
}

///|
#warnings("-9")
pub(all) struct RpcSessionState {
  model : Model[JSValue]?
  thinkingLevel : ThinkingLevel
  isStreaming : Bool
  isCompacting : Bool
  steeringMode : RpcSessionStateSteeringMode
  followUpMode : RpcSessionStateFollowUpMode
  sessionFile : String?
  sessionId : String
  sessionName : String?
  autoCompactionEnabled : Bool
  messageCount : Double
  pendingMessageCount : Double
}

///|
#warnings("-9")
pub(all) struct SessionTreeNode {
  entry : JSValue
  children : Array[SessionTreeNode]
  label : String?
  labelTimestamp : String?
}

///|
#warnings("-9")
pub(all) struct WriteOperations {
  writeFile : (String, String) -> Promise[Unit]
  mkdir : (String) -> Promise[Unit]
}

///|
#warnings("-9")
pub(all) struct BashSpawnContext {
  command : String
  cwd : String
  env : NodeJS_ProcessEnv
}

///|
#warnings("-9")
pub(all) struct CompactionResult[T] {
  summary : String
  firstKeptEntryId : String
  tokensBefore : Double
  estimatedTokensAfter : Double?
  usage : Usage?
  details : T?
}

///|
#warnings("-9")
pub(all) struct ExtensionActions {
  sendMessage : SendMessageHandler
  sendUserMessage : SendUserMessageHandler
  appendEntry : AppendEntryHandler
  setSessionName : SetSessionNameHandler
  getSessionName : GetSessionNameHandler
  setLabel : SetLabelHandler
  getActiveTools : GetActiveToolsHandler
  getAllTools : GetAllToolsHandler
  setActiveTools : SetActiveToolsHandler
  refreshTools : RefreshToolsHandler
  getCommands : GetCommandsHandler
  setModel : SetModelHandler
  getThinkingLevel : GetThinkingLevelHandler
  setThinkingLevel : SetThinkingLevelHandler
}

///|
#warnings("-9")
pub(all) struct ExtensionContext {
  ui : ExtensionUIContext
  mode : ExtensionMode
  hasUI : Bool
  cwd : String
  sessionManager : ReadonlySessionManager
  modelRegistry : ModelRegistry
  model : Model[JSValue]?
  scopedModels : Array[ScopedModel]
  thinkingLevel : ThinkingLevel?
  isIdle : () -> Bool
  isProjectTrusted : () -> Bool
  signal : AbortSignal?
  abort : () -> Unit
  hasPendingMessages : () -> Bool
  shutdown : () -> Unit
  getContextUsage : () -> ContextUsage?
  compact : (CompactOptions?) -> Unit
  getSystemPrompt : () -> String
}

///|
#warnings("-9")
pub(all) struct ExtensionRuntime {
  flagValues : Map
  pendingProviderRegistrations : Array[JSValue]
  pendingNativeProviderRegistrations : Array[JSValue]
  assertActive : () -> Unit
  invalidate : (String?) -> Unit
  trackEventBusSubscription : (() -> Unit) -> () -> Unit
  registerProvider : (String, ProviderConfig, String?) -> Unit
  registerNativeProvider : (Provider[JSValue], String?) -> Unit
  unregisterProvider : (String, String?) -> Unit
  sendMessage : SendMessageHandler
  sendUserMessage : SendUserMessageHandler
  appendEntry : AppendEntryHandler
  setSessionName : SetSessionNameHandler
  getSessionName : GetSessionNameHandler
  setLabel : SetLabelHandler
  getActiveTools : GetActiveToolsHandler
  getAllTools : GetAllToolsHandler
  setActiveTools : SetActiveToolsHandler
  refreshTools : RefreshToolsHandler
  getCommands : GetCommandsHandler
  setModel : SetModelHandler
  getThinkingLevel : GetThinkingLevelHandler
  setThinkingLevel : SetThinkingLevelHandler
}

///|
#warnings("-9")
pub(all) struct LoadSkillsResult {
  skills : Array[Skill]
  diagnostics : Array[ResourceDiagnostic]
}

///|
#warnings("-9")
pub(all) struct ModelChangeEntry {
  type_ : ModelChangeEntryType
  provider : String
  modelId : String
  id : String
  parentId : String?
  timestamp : String
}

///|
#warnings("-9")
pub(all) struct ModelCycleResult {
  model : Model[JSValue]
  thinkingLevel : ThinkingLevel
  isScoped : Bool
}

///|
#warnings("-9")
pub(all) struct ParsedSkillBlock {
  name : String
  location : String
  content : String
  userMessage : String?
}

///|
#warnings("-9")
pub(all) struct PrintModeOptions {
  mode : PrintModeOptionsMode
  messages : Array[String]?
  initialMessage : String?
  initialImages : Array[ImageContent]?
}

///|
#warnings("-9")
pub(all) struct ResolvedResource {
  path : String
  enabled : Bool
  metadata : PathMetadata
}

///|
#warnings("-9")
pub(all) struct RpcClientOptions {
  cliPath : String?
  cwd : String?
  env : StringRecordOfString?
  provider : String?
  model : String?
  args : Array[String]?
}

///|
#warnings("-9")
pub(all) struct SessionEntryBase {
  type_ : String
  id : String
  parentId : String?
  timestamp : String
}

///|
#warnings("-9")
pub(all) struct SessionInfoEntry {
  type_ : SessionInfoEntryType
  name : String?
  id : String
  parentId : String?
  timestamp : String
}

///|
#warnings("-9")
pub(all) struct SessionTreeEvent {
  type_ : SessionTreeEventType
  newLeafId : String?
  oldLeafId : String?
  summaryEntry : BranchSummaryEntry[JSValue]?
  fromExtension : Bool?
}

///|
#warnings("-9")
pub(all) struct SkillFrontmatter {
  name : String?
  description : String?
  disable_model_invocation : Bool?
}

///|
#warnings("-9")
pub(all) struct SlashCommandInfo {
  name : String
  description : String?
  source : SlashCommandSource
  sourceInfo : SourceInfo
}

///|
#warnings("-9")
pub(all) struct TruncationResult {
  content : String
  truncated : Bool
  truncatedBy : TruncationResultTruncatedBy?
  totalLines : Double
  totalBytes : Double
  outputLines : Double
  outputBytes : Double
  lastLinePartial : Bool
  firstLineExceedsLimit : Bool
  maxLines : Double
  maxBytes : Double
}

///|
#warnings("-9")
pub(all) struct UIPromptEndEvent {
  type_ : UIPromptEndEventType
  reason : UIPromptEndEventReason
  kind : UIPromptKind
  title : String?
}

///|
#warnings("-9")
pub(all) struct WriteToolOptions {
  operations : WriteOperations?
}

///|
#warnings("-9")
pub(all) struct AgentSettledEvent {
  type_ : AgentSettledEventType
}

///|
#warnings("-9")
pub(all) struct BashToolCallEvent {
  toolName : BashToolCallEventToolName
  input : BashToolInput
  type_ : BashToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct BranchPreparation {
  messages : Array[AgentMessage]
  fileOps : FileOperations
  totalTokens : Double
}

///|
#warnings("-9")
pub(all) struct EditToolCallEvent {
  toolName : EditToolCallEventToolName
  input : EditToolInput
  type_ : EditToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct ExtensionShortcut {
  shortcut : KeyId
  description : String?
  handler : (ExtensionContext) -> Promise[Unit]
  extensionPath : String
}

///|
#warnings("-9")
pub(all) struct FindToolCallEvent {
  toolName : FindToolCallEventToolName
  input : FindToolInput
  type_ : FindToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct GrepToolCallEvent {
  toolName : GrepToolCallEventToolName
  input : GrepToolInput
  type_ : GrepToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct MessageStartEvent {
  type_ : MessageStartEventType
  message : AgentMessage
}

///|
#warnings("-9")
pub(all) struct NewSessionOptions {
  id : String?
  parentSession : String?
}

///|
#warnings("-9")
pub(all) struct ProjectTrustEvent {
  type_ : ProjectTrustEventType
  cwd : String
}

///|
#warnings("-9")
pub(all) struct ReadToolCallEvent {
  toolName : ReadToolCallEventToolName
  input : ReadToolInput
  type_ : ReadToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct RegisteredCommand {
  name : String
  sourceInfo : SourceInfo
  description : String?
  getArgumentCompletions : ((String) -> JSValue?)?
  handler : (String, ExtensionCommandContext) -> Promise[Unit]
}

///|
#warnings("-9")
pub(all) struct RenderDiffOptions {
  filePath : String?
}

///|
#warnings("-9")
pub(all) struct ResourceCollision {
  resourceType : ResourceCollisionResourceType
  name : String
  winnerPath : String
  loserPath : String
  winnerSource : String?
  loserSource : String?
}

///|
#warnings("-9")
pub(all) struct SessionStartEvent {
  type_ : SessionStartEventType
  reason : SessionStartEventReason
  previousSessionFile : String?
}

///|
#warnings("-9")
pub(all) struct SettingsCallbacks {
  onAutoCompactChange : (Bool) -> Unit
  onShowImagesChange : (Bool) -> Unit
  onImageWidthCellsChange : (Double) -> Unit
  onAutoResizeImagesChange : (Bool) -> Unit
  onBlockImagesChange : (Bool) -> Unit
  onEnableSkillCommandsChange : (Bool) -> Unit
  onSteeringModeChange : (String) -> Unit
  onFollowUpModeChange : (String) -> Unit
  onTransportChange : (Transport) -> Unit
  onHttpIdleTimeoutMsChange : (Double) -> Unit
  onModelThinkingLevelChange : (String, String, ThinkingLevel) -> Unit
  onModelThinkingLevelRemove : (String, String) -> Unit
  onThemeChange : (String) -> Unit
  onThemePreview : ((String) -> Unit)?
  onHideThinkingBlockChange : (Bool) -> Unit
  onMermaidRenderingModeChange : (MermaidRenderingMode) -> Unit
  onShowCacheMissNoticesChange : (Bool) -> Unit
  onCollapseChangelogChange : (Bool) -> Unit
  onEnableInstallTelemetryChange : (Bool) -> Unit
  onDoubleEscapeActionChange : (String) -> Unit
  onTreeFilterModeChange : (String) -> Unit
  onShowHardwareCursorChange : (Bool) -> Unit
  onEditorPaddingXChange : (Double) -> Unit
  onOutputPadChange : (Int) -> Unit
  onAutocompleteMaxVisibleChange : (Double) -> Unit
  onQuietStartupChange : (Bool) -> Unit
  onDefaultProjectTrustChange : (String) -> Unit
  onClearOnShrinkChange : (Bool) -> Unit
  onShowTerminalProgressChange : (Bool) -> Unit
  onTuiModeChange : (TuiMode) -> Unit
  onFullscreenExitOutputChange : (String) -> Unit
  onFullscreenScrollbarChange : (ScrollViewScrollbar) -> Unit
  onFullscreenCopyOnSelectChange : (Bool) -> Unit
  onWarningsChange : (WarningSettings) -> Unit
  onCancel : () -> Unit
}

///|
#warnings("-9")
pub(all) struct TruncationOptions {
  maxLines : Double?
  maxBytes : Double?
}

///|
#warnings("-9")
pub(all) struct AgentSessionConfig {
  agent : Agent
  sessionManager : SessionManager
  settingsManager : SettingsManager
  cwd : String
  scopedModels : Array[JSValue]?
  resourceLoader : ResourceLoader
  customTools : Array[ToolDefinition[JSValue, JSValue, JSValue]]?
  modelRuntime : ModelRuntime
  initialActiveToolNames : Array[String]?
  allowedToolNames : Array[String]?
  excludedToolNames : Array[String]?
  baseToolsOverride : StringRecordOfAgentTool?
  extensionRunnerRef : AgentSessionConfigExtensionRunnerRef?
  sessionStartEvent : SessionStartEvent?
}

///|
#warnings("-9")
pub(all) struct BranchSummaryEntry[T] {
  type_ : BranchSummaryEntryType
  fromId : String
  summary : String
  details : T?
  usage : Usage?
  fromHook : Bool?
}

///|
#warnings("-9")
pub(all) struct CompactionSettings {
  enabled : Bool?
  reserveTokens : Double?
  keepRecentTokens : Double?
}

///|
#warnings("-9")
pub(all) struct CustomMessageEntry[T] {
  type_ : CustomMessageEntryType
  customType : String
  content : JSValue
  details : T?
  display : Bool
}

///|
#warnings("-9")
pub(all) struct EntryRenderOptions {
  expanded : Bool
}

///|
#warnings("-9")
pub(all) struct EventBusController {
  clear : () -> Unit
  emit : (String, JSValue) -> Unit
  on : (String, (JSValue) -> Unit) -> () -> Unit
}

///|
#warnings("-9")
pub(all) struct ExtensionUIContext {
  select : (String, Array[String], ExtensionUIDialogOptions?) -> Promise[
    String?,
  ]
  confirm : (String, String, ExtensionUIDialogOptions?) -> Promise[Bool]
  input : (String, String?, ExtensionUIDialogOptions?) -> Promise[String?]
  notify : (String, String?) -> Unit
  onTerminalInput : (TerminalInputHandler) -> () -> Unit
  setStatus : (String, String?) -> Unit
  setWorkingMessage : (String?) -> Unit
  setWorkingVisible : (Bool) -> Unit
  setWorkingIndicator : (WorkingIndicatorOptions?) -> Unit
  setHiddenThinkingLabel : (String?) -> Unit
  setWidget : (String, Array[String]?, ExtensionWidgetOptions?) -> Unit
  setFooter : (((TUI, Theme, ReadonlyFooterDataProvider) -> Component)?) -> Unit
  setHeader : (((TUI, Theme) -> Component)?) -> Unit
  setTitle : (String) -> Unit
  custom : (
    (TUI, Theme, KeybindingsManager, (JSValue) -> Unit) -> Promise[Component],
    JSValue?,
  ) -> Promise[JSValue]
  pasteToEditor : (String) -> Unit
  setEditorText : (String) -> Unit
  getEditorText : () -> String
  editor : (String, String?) -> Promise[String?]
  addAutocompleteProvider : (AutocompleteProviderFactory) -> Unit
  setEditorComponent : (EditorFactory?) -> Unit
  getEditorComponent : () -> EditorFactory?
  // readonly in TypeScript; not enforced by generated MoonBit struct
  theme : Theme
  getAllThemes : () -> Array[JSValue]
  getTheme : (String) -> Theme?
  setTheme : (Auto_ThemeValue_or_StringValue) -> ExtensionUicontextSetThemeResult
  getToolsExpanded : () -> Bool
  setToolsExpanded : (Bool) -> Unit
}

///|
#warnings("-9")
pub(all) struct MessageUpdateEvent {
  type_ : MessageUpdateEventType
  message : AgentMessage
  assistantMessageEvent : AssistantMessageEvent
}

///|
#warnings("-9")
pub(all) struct ProjectTrustUpdate {
  path : String
  decision : ProjectTrustDecision
}

///|
#warnings("-9")
pub(all) struct ResourceDiagnostic {
  type_ : ResourceDiagnosticType
  message : String
  path : String?
  collision : ResourceCollision?
}

///|
#warnings("-9")
pub(all) struct UIPromptStartEvent {
  type_ : UIPromptStartEventType
  reason : UIPromptStartEventReason
  kind : UIPromptKind
  title : String?
}

///|
#warnings("-9")
pub(all) struct WriteToolCallEvent {
  toolName : WriteToolCallEventToolName
  input : WriteToolInput
  type_ : WriteToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct BranchSummaryResult {
  summary : String?
  usage : Usage?
  readFiles : Array[String]?
  modifiedFiles : Array[String]?
  aborted : Bool?
  error : String?
}

///|
#warnings("-9")
pub(all) struct CustomToolCallEvent {
  toolName : String
  input : StringRecordOfUnknown
  type_ : CustomToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct ProjectTrustContext {
  cwd : String
  mode : ExtensionMode
  hasUI : Bool
  ui : ExtensionUIContextPickSelectConfirmInputNotify
}

///|
#warnings("-9")
pub(all) struct ProviderModelConfig {
  id : String
  name : String
  api : Api?
  baseUrl : String?
  reasoning : Bool
  thinkingLevelMap : JSValue?
  input : Array[ProviderModelConfigInputItem]
  cost : JSValue
  contextWindow : Double
  maxTokens : Double
  headers : StringRecordOfString?
  compat : JSValue?
}

///|
#warnings("-9")
pub(all) struct SessionCompactEvent {
  type_ : SessionCompactEventType
  compactionEntry : CompactionEntry[JSValue]
  fromExtension : Bool
  reason : SessionCompactEventReason
  willRetry : Bool
}

///|
#warnings("-9")
pub(all) struct SessionMessageEntry {
  type_ : SessionMessageEntryType
  message : AgentMessage
  id : String
  parentId : String?
  timestamp : String
}

///|
#warnings("-9")
pub(all) struct ToolCallEventResult {
  block : Bool?
  reason : String?
  terminate : Bool?
}

///|
#warnings("-9")
pub(all) struct UserBashEventResult {
  operations : BashOperations?
  result : BashResult?
}

///|
#warnings("-9")
pub(all) struct AgentSessionServices {
  cwd : String
  agentDir : String
  modelRuntime : ModelRuntime
  settingsManager : SettingsManager
  resourceLoader : ResourceLoader
  diagnostics : Array[AgentSessionRuntimeDiagnostic]
}

///|
#warnings("-9")
pub(all) struct CollectEntriesResult {
  entries : Array[SessionEntry]
  commonAncestorId : String?
}

///|
#warnings("-9")
pub(all) struct LoadExtensionsResult {
  extensions : Array[Extension]
  errors : Array[JSValue]
  runtime : ExtensionRuntime
}

///|
#warnings("-9")
pub(all) struct MessageRenderOptions {
  expanded : Bool
  outputPad : Double
}

///|
#warnings("-9")
pub(all) struct ModelScopeDiagnostic {
  type_ : ModelScopeDiagnosticType
  code : ModelScopeDiagnosticCode
  message : String
  pattern : String
}

///|
#warnings("-9")
pub(all) struct SessionShutdownEvent {
  type_ : SessionShutdownEventType
  reason : SessionShutdownEventReason
  targetSessionFile : String?
}

///|
#warnings("-9")
pub(all) struct ToolExecutionOptions {
  showImages : Bool?
  imageWidthCells : Double?
}

///|
#warnings("-9")
pub(all) struct VisualTruncateResult {
  visualLines : Array[String]
  skippedCount : Double
}

///|
#warnings("-9")
pub(all) struct BeforeAgentStartEvent {
  type_ : BeforeAgentStartEventType
  prompt : String
  images : Array[ImageContent]?
  systemPrompt : String
  systemPromptOptions : BuildSystemPromptOptions
}

///|
#warnings("-3")
#external
pub type PowerShellToolOptions

///|
#warnings("-9")
pub(all) struct ResolveCliModelResult {
  model : Model[Api]?
  thinkingLevel : ThinkingLevel?
  warning : String?
  error : String?
}

///|
#warnings("-9")
pub(all) struct ToolExecutionEndEvent {
  type_ : ToolExecutionEndEventType
  toolCallId : String
  toolName : String
  result : JSValue
  isError : Bool
}

///|
#warnings("-9")
pub(all) struct ExtensionWidgetOptions {
  placement : WidgetPlacement?
}

///|
#warnings("-9")
pub(all) struct InteractiveModeOptions {
  migratedProviders : Array[String]?
  startupDiagnostics : Array[AgentSessionRuntimeDiagnostic]?
  modelFallbackMessage : String?
  autoTrustOnReloadCwd : String?
  initialMessage : String?
  initialImages : Array[ImageContent]?
  initialMessages : Array[String]?
  verbose : Bool?
  tuiMode : TuiMode?
  initialThemeSetting : String?
}

///|
#warnings("-9")
pub(all) struct ProjectTrustStoreEntry {
  path : String
  decision : Bool
}

///|
#warnings("-9")
pub(all) struct SessionBeforeForkEvent {
  type_ : SessionBeforeForkEventType
  entryId : String
  position : SessionBeforeForkEventPosition
}

///|
#warnings("-9")
pub(all) struct SessionBeforeTreeEvent {
  type_ : SessionBeforeTreeEventType
  preparation : TreePreparation
  signal : AbortSignal
}

///|
#warnings("-9")
pub(all) struct ExtensionCommandContext {
  getSystemPromptOptions : () -> BuildSystemPromptOptions
  waitForIdle : () -> Promise[Unit]
  newSession : (JSValue?) -> Promise[JSValue]
  fork : (String, JSValue?) -> Promise[JSValue]
  navigateTree : (String, JSValue?) -> Promise[JSValue]
  switchSession : (String, JSValue?) -> Promise[JSValue]
  reload : () -> Promise[Unit]
  ui : ExtensionUIContext
  mode : ExtensionMode
  hasUI : Bool
  cwd : String
  sessionManager : ReadonlySessionManager
  modelRegistry : ModelRegistry
  model : Model[JSValue]?
  scopedModels : Array[ScopedModel]
  thinkingLevel : ThinkingLevel?
  isIdle : () -> Bool
  isProjectTrusted : () -> Bool
  signal : AbortSignal?
  abort : () -> Unit
  hasPendingMessages : () -> Bool
  shutdown : () -> Unit
  getContextUsage : () -> ContextUsage?
  compact : (CompactOptions?) -> Unit
  getSystemPrompt : () -> String
}

///|
#warnings("-9")
pub(all) struct ExtensionContextActions {
  getModel : () -> Model[JSValue]?
  getScopedModels : () -> Array[ScopedModel]
  isIdle : () -> Bool
  isProjectTrusted : () -> Bool
  getSignal : () -> AbortSignal?
  abort : () -> Unit
  hasPendingMessages : () -> Bool
  shutdown : () -> Unit
  getContextUsage : () -> ContextUsage?
  compact : (CompactOptions?) -> Unit
  getSystemPrompt : () -> String
  getSystemPromptOptions : (() -> BuildSystemPromptOptions)?
}

///|
#warnings("-9")
pub(all) struct PowerShellToolCallEvent {
  toolName : PowerShellToolCallEventToolName
  input : PowerShellToolInput
  type_ : PowerShellToolCallEventType
  toolCallId : String
}

///|
#warnings("-9")
pub(all) struct ProjectTrustEventResult {
  trusted : ProjectTrustEventDecision
  remember : Bool?
}

///|
#warnings("-9")
pub(all) struct ResolveModelScopeResult {
  scopedModels : Array[ScopedModel]
  diagnostics : Array[ModelScopeDiagnostic]
}

///|
#warnings("-9")
pub(all) struct SessionInfoChangedEvent {
  type_ : SessionInfoChangedEventType
  name : String?
}

///|
#warnings("-9")
pub(all) struct ToolExecutionStartEvent {
  type_ : ToolExecutionStartEventType
  toolCallId : String
  toolName : String
  args : JSValue
}

///|
#warnings("-9")
pub(all) struct ToolRenderResultOptions {
  expanded : Bool
  isPartial : Bool
}

///|
#warnings("-9")
pub(all) struct WorkingIndicatorOptions {
  frames : Array[String]?
  intervalMs : Double?
}

///|
#warnings("-9")
pub(all) struct BuildSystemPromptOptions {
  customPrompt : String?
  selectedTools : Array[String]?
  toolSnippets : StringRecordOfString?
  promptGuidelines : Array[String]?
  appendSystemPrompt : String?
  cwd : String
  contextFiles : Array[JSValue]?
  skills : Array[Skill]?
}

///|
#warnings("-9")
pub(all) struct CreateAgentSessionResult {
  session : AgentSession
  extensionsResult : LoadExtensionsResult
  modelFallbackMessage : String?
}

///|
#warnings("-9")
pub(all) struct ExtensionUIDialogOptions {
  signal : AbortSignal?
  timeout : Double?
}

///|
#warnings("-9")
pub(all) struct LoadSkillsFromDirOptions {
  dir : String
  source : String
}

///|
#warnings("-9")
pub(all) struct MarkdownTransformContext {
  messageType : MarkdownTransformContextMessageType
  isStreaming : Bool
  availableWidth : Double
}

///|
#warnings("-9")
pub(all) struct SessionBeforeSwitchEvent {
  type_ : SessionBeforeSwitchEventType
  reason : SessionBeforeSwitchEventReason
  targetSessionFile : String?
}

///|
#warnings("-9")
pub(all) struct ThinkingLevelChangeEntry {
  type_ : ThinkingLevelChangeEntryType
  thinkingLevel : String
  id : String
  parentId : String?
  timestamp : String
}

///|
#warnings("-9")
pub(all) struct ToolExecutionUpdateEvent {
  type_ : ToolExecutionUpdateEventType
  toolCallId : String
  toolName : String
  args : JSValue
  partialResult : JSValue
}

///|
#warnings("-9")
pub(all) struct CreateAgentSessionOptions {
  cwd : String?
  agentDir : String?
  modelRuntime : ModelRuntime?
  model : Model[JSValue]?
  thinkingLevel : ThinkingLevel?
  scopedModels : Array[JSValue]?
  noTools : CreateAgentSessionOptionsNoTools?
  tools : Array[String]?
  excludeTools : Array[String]?
  customTools : Array[ToolDefinition[JSValue, JSValue, JSValue]]?
  resourceLoader : ResourceLoader?
  sessionManager : SessionManager?
  settingsManager : SettingsManager?
  sessionStartEvent : SessionStartEvent?
}

///|
#warnings("-9")
pub(all) struct CreateModelRuntimeOptions {
  credentials : CredentialStore?
  authPath : String?
  modelsPath : String?
  modelsStore : ModelsStore?
  modelsStorePath : String?
  allowModelNetwork : Bool?
  modelRefreshTimeoutMs : Double?
  catalogBaseUrl : String?
  signal : AbortSignal?
  refreshOnCreate : Bool?
}

///|
#warnings("-9")
pub(all) struct ModelRuntimeAuthOverrides {
  apiKey : String?
  env : StringRecordOfString?
  minOAuthValidityMs : Double?
}

///|
#warnings("-9")
pub(all) struct SessionBeforeCompactEvent {
  type_ : SessionBeforeCompactEventType
  preparation : CompactionPreparation
  branchEntries : Array[SessionEntry]
  customInstructions : String?
  reason : SessionBeforeCompactEventReason
  willRetry : Bool
  signal : AbortSignal
}

///|
#warnings("-9")
pub(all) struct BeforeProviderHeadersEvent {
  type_ : BeforeProviderHeadersEventType
  headers : ProviderHeaders
}

///|
#warnings("-9")
pub(all) struct BeforeProviderRequestEvent {
  type_ : BeforeProviderRequestEventType
  payload : JSValue
}

///|
#warnings("-9")
pub(all) struct BeforeAgentStartEventResult {
  message : CustomMessagePickCustomTypeContentDisplayDetails?
  systemPrompt : String?
}

///|
#warnings("-9")
pub(all) struct GenerateBranchSummaryOptions {
  model : Model[JSValue]
  apiKey : String?
  headers : StringRecordOfString?
  env : StringRecordOfString?
  signal : AbortSignal
  customInstructions : String?
  replaceInstructions : Bool?
  reserveTokens : Double?
  streamFn : StreamFn?
  retry : RetryPolicy?
  callbacks : RetryCallbacks?
}

///|
#warnings("-9")
pub(all) struct SettingsManagerCreateOptions {
  projectTrusted : Bool?
}

///|
#warnings("-9")
pub(all) struct AgentSessionRuntimeDiagnostic {
  type_ : AgentSessionRuntimeDiagnosticType
  message : String
}

///|
#warnings("-9")
pub(all) struct ExtensionCommandContextActions {
  waitForIdle : () -> Promise[Unit]
  newSession : (JSValue?) -> Promise[JSValue]
  fork : (String, JSValue?) -> Promise[JSValue]
  navigateTree : (String, JSValue?) -> Promise[JSValue]
  switchSession : (String, JSValue?) -> Promise[JSValue]
  reload : () -> Promise[Unit]
}

///|
#warnings("-9")
pub(all) struct CreateAgentSessionRuntimeResult {
  services : AgentSessionServices
  diagnostics : Array[AgentSessionRuntimeDiagnostic]
  session : AgentSession
  extensionsResult : LoadExtensionsResult
  modelFallbackMessage : String?
}

///|
#warnings("-9")
pub(all) struct CreateAgentSessionServicesOptions {
  cwd : String
  agentDir : String?
  settingsManager : SettingsManager?
  modelRuntime : ModelRuntime?
  modelRuntimeSignal : AbortSignal?
  extensionFlagValues : Map?
  resourceLoaderOptions : DefaultResourceLoaderOptionsOmitCwdAgentDirSettingsManager?
  resourceLoaderReloadOptions : ResourceLoaderReloadOptions?
}

///|
#warnings("-9")
pub(all) struct CreateAgentSessionFromServicesOptions {
  services : AgentSessionServices
  sessionManager : SessionManager
  sessionStartEvent : SessionStartEvent?
  model : Model[JSValue]?
  thinkingLevel : ThinkingLevel?
  scopedModels : Array[JSValue]?
  tools : Array[String]?
  excludeTools : Array[String]?
  noTools : CreateAgentSessionFromServicesOptionsNoTools?
  customTools : Array[ToolDefinition[JSValue, JSValue, JSValue]]?
}

///|
#warnings("-9")
pub(all) struct TruncateLineResult {
  text : String
  wasTruncated : Bool
}

///|
#warnings("-9")
pub(all) struct GenerateDiffStringResult {
  diff : String
  firstChangedLine : Double?
}

///|
#warnings("-9")
pub(all) struct GenerateSummaryWithUsageResult {
  text : String
  usage : Usage
}

///|
#warnings("-9")
pub(all) struct RegisteredCommandOmitNameSourceInfo {
  description : String?
  getArgumentCompletions : ((String) -> JSValue?)?
  handler : (String, ExtensionCommandContext) -> Promise[Unit]
}

///|
#warnings("-9")
pub(all) struct ExtensionUIContextPickSelectConfirmInputNotify {
  select : (String, Array[String], ExtensionUIDialogOptions?) -> Promise[
    String?,
  ]
  confirm : (String, String, ExtensionUIDialogOptions?) -> Promise[Bool]
  input : (String, String?, ExtensionUIDialogOptions?) -> Promise[String?]
  notify : (String, String?) -> Unit
}

///|
#warnings("-9")
pub(all) struct CustomMessagePickCustomTypeContentDisplayDetails {
  customType : String
  content : JSValue
  display : Bool
  details : JSValue?
}

///|
#warnings("-9")
pub(all) struct DefaultResourceLoaderOptionsOmitCwdAgentDirSettingsManager {
  eventBus : EventBus?
  additionalExtensionPaths : Array[String]?
  additionalSkillPaths : Array[String]?
  additionalPromptTemplatePaths : Array[String]?
  additionalThemePaths : Array[String]?
  extensionFactories : Array[InlineExtension]?
  noExtensions : Bool?
  noSkills : Bool?
  noPromptTemplates : Bool?
  noThemes : Bool?
  noContextFiles : Bool?
  systemPrompt : String?
  appendSystemPrompt : Array[String]?
  extensionsOverride : ((LoadExtensionsResult) -> LoadExtensionsResult)?
  skillsOverride : ((JSValue) -> JSValue)?
  promptsOverride : ((JSValue) -> JSValue)?
  themesOverride : ((JSValue) -> JSValue)?
  agentsFilesOverride : ((JSValue) -> JSValue)?
  systemPromptOverride : ((String?) -> String?)?
  appendSystemPromptOverride : ((Array[String]) -> Array[String])?
}

///|
#warnings("-9")
pub(all) struct SettingsPartial {
  lastChangelogVersion : String?
  defaultProvider : String?
  defaultModel : String?
  defaultThinkingLevel : ThinkingLevel?
  modelThinkingLevels : StringRecordOfThinkingLevel?
  transport : TransportSetting?
  steeringMode : SettingsPartialSteeringMode?
  followUpMode : SettingsPartialFollowUpMode?
  theme : String?
  compaction : CompactionSettings?
  branchSummary : BranchSummarySettings?
  retry : RetrySettings?
  hideThinkingBlock : Bool?
  showCacheMissNotices : Bool?
  externalEditor : String?
  shellPath : String?
  quietStartup : Bool?
  defaultProjectTrust : DefaultProjectTrust?
  shellCommandPrefix : String?
  npmCommand : Array[String]?
  collapseChangelog : Bool?
  enableInstallTelemetry : Bool?
  enableAnalytics : Bool?
  trackingId : String?
  packages : Array[PackageSource]?
  extensions : Array[String]?
  skills : Array[String]?
  prompts : Array[String]?
  themes : Array[String]?
  enableSkillCommands : Bool?
  terminal : TerminalSettings?
  images : ImageSettings?
  enabledModels : Array[String]?
  defaultTools : Array[String]?
  doubleEscapeAction : SettingsPartialDoubleEscapeAction?
  treeFilterMode : SettingsPartialTreeFilterMode?
  thinkingBudgets : ThinkingBudgetsSettings?
  editorPaddingX : Double?
  outputPad : SettingsPartialOutputPad?
  autocompleteMaxVisible : Double?
  showHardwareCursor : Bool?
  markdown : MarkdownSettings?
  warnings : WarningSettings?
  sessionDir : String?
  httpProxy : String?
  httpIdleTimeoutMs : Double?
  websocketConnectTimeoutMs : Double?
  tuiMode : TuiMode?
  fullscreenExitOutput : FullscreenExitOutput?
  fullscreenScrollbar : ScrollViewScrollbar?
  fullscreenCopyOnSelect : Bool?
}

///|
#warnings("-9")
pub(all) struct ResourcesDiscoverEvent {
  type_ : ResourcesDiscoverEventType
  cwd : String
  reason : ResourcesDiscoverEventReason
}

///|
#warnings("-9")
pub(all) struct ResourcesDiscoverResult {
  skillPaths : Array[String]?
  promptPaths : Array[String]?
  themePaths : Array[String]?
}

///|
#warnings("-9")
pub(all) struct SessionBeforeSwitchResult {
  cancel : Bool?
}

///|
#warnings("-9")
pub(all) struct SessionBeforeForkResult {
  cancel : Bool?
  skipConversationRestore : Bool?
}

///|
#warnings("-9")
pub(all) struct SessionBeforeCompactResult {
  cancel : Bool?
  compaction : CompactionResult[JSValue]?
}

///|
#warnings("-9")
pub(all) struct SessionCompactFailedEvent {
  type_ : SessionCompactFailedEventType
  reason : SessionCompactFailedEventReason
  errorMessage : String?
  aborted : Bool
  willRetry : Bool
  fromExtension : Bool
}

///|
#warnings("-9")
pub(all) struct SessionBeforeTreeResult {
  cancel : Bool?
  summary : SessionBeforeTreeResultSummary?
  customInstructions : String?
  replaceInstructions : Bool?
  label : String?
}

///|
#warnings("-9")
pub(all) struct ContextEventResult {
  messages : Array[AgentMessage]?
}

///|
#warnings("-9")
pub(all) struct AfterProviderResponseEvent {
  type_ : AfterProviderResponseEventType
  status : Double
  headers : StringRecordOfString
}

///|
#warnings("-9")
pub(all) struct MessageEndEventResult {
  message : AgentMessage?
}

///|
#warnings("-9")
pub(all) struct ModelSelectEvent {
  type_ : ModelSelectEventType
  model : Model[JSValue]
  previousModel : Model[JSValue]?
  source : ModelSelectSource
}

///|
#warnings("-9")
pub(all) struct ThinkingLevelSelectEvent {
  type_ : ThinkingLevelSelectEventType
  level : ThinkingLevel
  previousLevel : ThinkingLevel
}

///|
#warnings("-9")
pub(all) struct ToolResultEventResult {
  content : Array[Auto_TextContentValue_or_ImageContentValue]?
  details : JSValue?
  isError : Bool?
  usage : Usage?
}

///|
#warnings("-9")
pub(all) struct CustomMessage[T] {
  role : CustomMessageRole
  customType : String
  content : JSValue
  display : Bool
  details : T?
  timestamp : Double
}

///|
#warnings("-9")
pub(all) struct ProviderRetrySettings {
  timeoutMs : Double?
  maxRetries : Double?
  maxRetryDelayMs : Double?
}

///|
#warnings("-9")
pub(all) struct ConfiguredPackage {
  source : String
  scope : ConfiguredPackageScope
  filtered : Bool
  installedPath : String?
}

///|
#warnings("-9")
pub(all) struct ResourceExtensionPaths {
  skillPaths : Array[JSValue]?
  promptPaths : Array[JSValue]?
  themePaths : Array[JSValue]?
}

///|
#warnings("-9")
pub(all) struct ResourceLoaderReloadOptions {
  resolveProjectTrust : ((JSValue) -> Promise[Bool])?
}

///|
#warnings("-9")
pub(all) struct WarningSettings {
  anthropicExtraUsage : Bool?
}

///|
#warnings("-9")
pub(all) struct ToolRenderContext[TState, TArgs] {
  args : TArgs
  toolCallId : String
  invalidate : () -> Unit
  lastComponent : Component?
  state : TState
  cwd : String
  executionStarted : Bool
  argsComplete : Bool
  isPartial : Bool
  expanded : Bool
  showImages : Bool
  isError : Bool
}

///|
#warnings("-9")
pub(all) struct BashResult {
  output : String
  exitCode : Double?
  cancelled : Bool
  truncated : Bool
  fullOutputPath : String?
}

///|
#warnings("-9")
pub(all) struct TreePreparation {
  targetId : String
  oldLeafId : String?
  commonAncestorId : String?
  entriesToSummarize : Array[SessionEntry]
  userWantsSummary : Bool
  customInstructions : String?
  replaceInstructions : Bool?
  label : String?
}

///|
#warnings("-9")
pub(all) struct ReplacedSessionContext {
  sendMessage : (Pick, JSValue?) -> Promise[Unit]
  sendUserMessage : (JSValue, JSValue?) -> Promise[Unit]
  getSystemPromptOptions : () -> BuildSystemPromptOptions
  waitForIdle : () -> Promise[Unit]
  newSession : (JSValue?) -> Promise[JSValue]
  fork : (String, JSValue?) -> Promise[JSValue]
  navigateTree : (String, JSValue?) -> Promise[JSValue]
  switchSession : (String, JSValue?) -> Promise[JSValue]
  reload : () -> Promise[Unit]
  ui : ExtensionUIContext
  mode : ExtensionMode
  hasUI : Bool
  cwd : String
  sessionManager : ReadonlySessionManager
  modelRegistry : ModelRegistry
  model : Model[JSValue]?
  scopedModels : Array[ScopedModel]
  thinkingLevel : ThinkingLevel?
  isIdle : () -> Bool
  isProjectTrusted : () -> Bool
  signal : AbortSignal?
  abort : () -> Unit
  hasPendingMessages : () -> Bool
  shutdown : () -> Unit
  getContextUsage : () -> ContextUsage?
  compact : (CompactOptions?) -> Unit
  getSystemPrompt : () -> String
}

///|
#warnings("-9")
pub(all) struct DefaultResourceLoaderOptions {
  cwd : String
  agentDir : String
  settingsManager : SettingsManager?
  eventBus : EventBus?
  additionalExtensionPaths : Array[String]?
  additionalSkillPaths : Array[String]?
  additionalPromptTemplatePaths : Array[String]?
  additionalThemePaths : Array[String]?
  extensionFactories : Array[InlineExtension]?
  noExtensions : Bool?
  noSkills : Bool?
  noPromptTemplates : Bool?
  noThemes : Bool?
  noContextFiles : Bool?
  systemPrompt : String?
  appendSystemPrompt : Array[String]?
  extensionsOverride : ((LoadExtensionsResult) -> LoadExtensionsResult)?
  skillsOverride : ((JSValue) -> JSValue)?
  promptsOverride : ((JSValue) -> JSValue)?
  themesOverride : ((JSValue) -> JSValue)?
  agentsFilesOverride : ((JSValue) -> JSValue)?
  systemPromptOverride : ((String?) -> String?)?
  appendSystemPromptOverride : ((Array[String]) -> Array[String])?
}

///|
#warnings("-9")
pub(all) struct CompactionPreparation {
  firstKeptEntryId : String
  messagesToSummarize : Array[AgentMessage]
  turnPrefixMessages : Array[AgentMessage]
  isSplitTurn : Bool
  tokensBefore : Double
  previousSummary : String?
  fileOps : FileOperations
  settings : CompactionSettings
}

///|
#warnings("-9")
pub(all) struct LoadSkillsOptions {
  cwd : String
  agentDir : String
  skillPaths : Array[String]
  includeDefaults : Bool
}

///|
#warnings("-9")
pub(all) struct ImageResizeOptions {
  maxWidth : Double?
  maxHeight : Double?
  maxBytes : Double?
  jpegQuality : Double?
}

///|
#warnings("-9")
pub(all) struct ShellConfig {
  shell : String
  args : Array[String]
  commandTransport : ShellConfigCommandTransport?
}

///|
#warnings("-9")
pub(all) struct BashRenderState {
  startedAt : Double?
  endedAt : Double?
  interval : NodeJS_Timeout?
}

///|
#warnings("-9")
pub(all) struct EditRenderState {
  callComponent : EditCallRenderComponent?
}

///|
#warnings("-9")
pub(all) struct ParsedFrontmatter[T] {
  frontmatter : StringRecordOfUnknown
  body : String
}

///|
#warnings("-9")
pub(all) struct RpcSlashCommand {
  name : String
  description : String?
  source : RpcSlashCommandSource
  sourceInfo : SourceInfo
}

///|
#warnings("-9")
pub(all) struct ModelMutationOptions {
  persist : Bool?
}

///|
#warnings("-9")
pub(all) struct ExtensionBindings {
  uiContext : ExtensionUIContext?
  mode : ExtensionMode?
  commandContextActions : ExtensionCommandContextActions?
  abortHandler : (() -> Unit)?
  shutdownHandler : ShutdownHandler?
  onError : ExtensionErrorListener?
}

///|
#warnings("-9")
pub(all) struct ProviderConfigInput {
  name : String?
  baseUrl : String?
  apiKey : String?
  api : Api?
  streamSimple : (Model[Api], Context, SimpleStreamOptions?) -> AssistantMessageEventStream?
  headers : StringRecordOfString?
  authHeader : Bool?
  oauth : ExtensionOAuthConfig?
  models : Array[JSValue]?
  refreshModels : ((RefreshModelsContext) -> Promise[Array[JSValue]])?
}

///|
#warnings("-9")
pub(all) struct ExtensionOAuthConfig {
  name : String
  isSubscription : Bool?
  usesCallbackServer : Bool?
  login : (OAuthLoginCallbacks) -> Promise[OAuthCredentials]
  refreshToken : (OAuthCredentials, AbortSignal) -> Promise[OAuthCredentials]
  getApiKey : (OAuthCredentials) -> String
  modifyModels : ((Array[Model[Api]], OAuthCredentials) -> Array[Model[Api]])?
}

///|
#warnings("-9")
pub(all) struct CompatibilityRequestConfig {
  headers : ProviderHeaders?
  authHeader : Bool
}

///|
#warnings("-9")
pub(all) struct AuthStatus {
  configured : Bool
  source : AuthStatusSource?
  label : String?
}

///|
#warnings("-9")
pub(all) struct BashExecutionMessage {
  role : BashExecutionMessageRole
  command : String
  output : String
  exitCode : Double?
  cancelled : Bool
  truncated : Bool
  fullOutputPath : String?
  timestamp : Double
  excludeFromContext : Bool?
}

///|
#warnings("-9")
pub(all) struct BeforeAgentStartCombinedResult {
  messages : Array[Pick]?
  systemPrompt : String?
}

///|
#warnings("-9")
pub(all) struct LatestPiRelease {
  version : String
  packageName : String?
  note : String?
}

///|
#warnings("-9")
pub(all) struct SettingsStorage {
  withLock : (SettingsScope, (String?) -> String?) -> Unit
}

///|
#warnings("-9")
pub(all) struct Settings {
  lastChangelogVersion : String?
  defaultProvider : String?
  defaultModel : String?
  defaultThinkingLevel : ThinkingLevel?
  modelThinkingLevels : StringRecordOfThinkingLevel?
  transport : TransportSetting?
  steeringMode : SettingsSteeringMode?
  followUpMode : SettingsFollowUpMode?
  theme : String?
  compaction : CompactionSettings?
  branchSummary : BranchSummarySettings?
  retry : RetrySettings?
  hideThinkingBlock : Bool?
  showCacheMissNotices : Bool?
  externalEditor : String?
  shellPath : String?
  quietStartup : Bool?
  defaultProjectTrust : DefaultProjectTrust?
  shellCommandPrefix : String?
  npmCommand : Array[String]?
  collapseChangelog : Bool?
  enableInstallTelemetry : Bool?
  enableAnalytics : Bool?
  trackingId : String?
  packages : Array[PackageSource]?
  extensions : Array[String]?
  skills : Array[String]?
  prompts : Array[String]?
  themes : Array[String]?
  enableSkillCommands : Bool?
  terminal : TerminalSettings?
  images : ImageSettings?
  enabledModels : Array[String]?
  defaultTools : Array[String]?
  doubleEscapeAction : SettingsDoubleEscapeAction?
  treeFilterMode : SettingsTreeFilterMode?
  thinkingBudgets : ThinkingBudgetsSettings?
  editorPaddingX : Double?
  outputPad : SettingsOutputPad?
  autocompleteMaxVisible : Double?
  showHardwareCursor : Bool?
  markdown : MarkdownSettings?
  warnings : WarningSettings?
  sessionDir : String?
  httpProxy : String?
  httpIdleTimeoutMs : Double?
  websocketConnectTimeoutMs : Double?
  tuiMode : TuiMode?
  fullscreenExitOutput : FullscreenExitOutput?
  fullscreenScrollbar : ScrollViewScrollbar?
  fullscreenCopyOnSelect : Bool?
}

///|
#warnings("-9")
pub(all) struct BranchSummarySettings {
  reserveTokens : Double?
  skipPrompt : Bool?
}

///|
#warnings("-9")
pub(all) struct TerminalSettings {
  showImages : Bool?
  imageWidthCells : Double?
  clearOnShrink : Bool?
  showTerminalProgress : Bool?
  hyperlinks : Auto_BoolValue_or_TerminalSettingsHyperlinksMember1Value?
  images : JSValue?
  trueColor : Auto_BoolValue_or_TerminalSettingsTrueColorMember1Value?
}

///|
#warnings("-9")
pub(all) struct ThinkingBudgetsSettings {
  minimal : Double?
  low : Double?
  medium : Double?
  high : Double?
}

///|
#warnings("-9")
pub(all) struct MarkdownSettings {
  codeBlockIndent : String?
  mermaid : MermaidRenderingMode?
}

///|
#warnings("-9")
pub(all) struct SettingsError {
  scope : SettingsScope
  path : String?
  error : Error_
}

///|
#warnings("-9")
pub(all) struct PackageUpdate {
  source : String
  displayName : String
  type_ : PackageUpdateType
  scope : SourceScope
}

///|
#warnings("-9")
pub(all) struct PackageManagerOptions {
  cwd : String
  agentDir : String
  settingsManager : SettingsManager
}

///|
#warnings("-9")
pub(all) struct ScopedModelItem {
  model : Model[JSValue]
  thinkingLevel : String?
}

///|
#warnings("-9")
pub(all) struct DefaultModelReference {
  provider : String
  id : String
}

///|
#warnings("-9")
pub(all) struct AuthSelectorProvider {
  id : String
  name : String
  authType : AuthSelectorProviderAuthType
  method_ : Auto_OAuthAuthValue_or_ApiKeyAuthValue?
  status : AuthCheck?
}

///|
#warnings("-9")
pub(all) struct ToolRenderers {
  renderShell : ToolRenderersRenderShell?
  renderCall : ((JSValue, Theme, ToolRenderContext[JSValue, JSValue]) -> Component)?
  renderResult : ((
    AgentToolResult[JSValue],
    ToolRenderResultOptions,
    Theme,
    ToolRenderContext[JSValue, JSValue],
  ) -> Component)?
}

///|
#warnings("-9")
pub(all) struct ExtensionInputOptions {
  tui : TUI?
  timeout : Double?
}

///|
#warnings("-9")
pub(all) struct ExtensionSelectorOptions {
  tui : TUI?
  timeout : Double?
  onToggleToolsExpanded : (() -> Unit)?
}

///|
#warnings("-9")
pub(all) struct UserMessageItem {
  id : String
  text : String
  timestamp : String?
}

///|
#warnings("-9")
pub(all) struct BranchSummaryMessage {
  role : BranchSummaryMessageRole
  summary : String
  fromId : String?
  timestamp : Double
}

///|
#warnings("-9")
pub(all) struct CompactionSummaryMessage {
  role : CompactionSummaryMessageRole
  summary : String
  tokensBefore : Double
  timestamp : Double
}

///|
#warnings("-9")
pub(all) struct ExtensionApiRegisterShortcutOptions {
  description : String?
  handler : (ExtensionContext) -> Promise[Unit]
}

///|
#warnings("-9")
pub(all) struct SessionStatsTokens {
  input : Double
  output : Double
  cacheRead : Double
  cacheWrite : Double
  total : Double
}

///|
#warnings("-9")
pub(all) struct BashOperationsExecOptions {
  onData : (Buffer) -> Unit
  signal : AbortSignal?
  timeout : Double?
  env : NodeJS_ProcessEnv?
}

///|
#warnings("-9")
pub(all) struct FindOperationsGlobOptions {
  ignore : Array[String]
  limit : Double
}

///|
#warnings("-9")
pub(all) struct ProviderConfigOauth {
  name : String
  isSubscription : Bool?
  usesCallbackServer : Bool?
  login : (OAuthLoginCallbacks) -> Promise[OAuthCredentials]
  refreshToken : (OAuthCredentials, AbortSignal) -> Promise[OAuthCredentials]
  getApiKey : (OAuthCredentials) -> String
  modifyModels : ((Array[Model[Api]], OAuthCredentials) -> Array[Model[Api]])?
}

///|
#warnings("-9")
pub(all) struct ResourceLoaderGetSkillsResult {
  skills : Array[Skill]
  diagnostics : Array[ResourceDiagnostic]
}

///|
#warnings("-9")
pub(all) struct ResourceLoaderGetPromptsResult {
  prompts : Array[PromptTemplate]
  diagnostics : Array[ResourceDiagnostic]
}

///|
#warnings("-9")
pub(all) struct ResourceLoaderGetThemesResult {
  themes : Array[Theme]
  diagnostics : Array[ResourceDiagnostic]
}

///|
#warnings("-9")
pub(all) struct ResourceLoaderGetAgentsFilesResult {
  agentsFiles : Array[JSValue]
}

///|
#warnings("-9")
pub(all) struct SessionContextModel {
  provider : String
  modelId : String
}

///|
#warnings("-9")
pub(all) struct AgentSessionConfigExtensionRunnerRef {
  current : ExtensionRunner?
}

///|
#warnings("-9")
pub(all) struct ExtensionUicontextSetThemeResult {
  success : Bool
  error : String?
}

///|
#warnings("-9")
pub(all) struct SessionBeforeTreeResultSummary {
  summary : String
  details : JSValue?
  usage : Usage?
}

///|
#warnings("-9")
pub(all) struct AgentSessionSendCustomMessageOptions {
  triggerTurn : Bool?
  deliverAs : AgentSessionSendCustomMessageOptionsDeliverAs?
}

///|
#warnings("-9")
pub(all) struct AgentSessionSendUserMessageOptions {
  deliverAs : AgentSessionSendUserMessageOptionsDeliverAs?
  expandPromptTemplates : Bool?
}

///|
#warnings("-9")
pub(all) struct AgentSessionReloadOptions {
  beforeSessionStart : (() -> Promise[Unit])?
}

///|
#warnings("-9")
pub(all) struct AgentSessionExecuteBashOptions {
  excludeFromContext : Bool?
  id : String?
  operations : BashOperations?
}

///|
#warnings("-9")
pub(all) struct AgentSessionRecordBashResultOptions {
  excludeFromContext : Bool?
}

///|
#warnings("-9")
pub(all) struct AgentSessionNavigateTreeOptions {
  summarize : Bool?
  customInstructions : String?
  replaceInstructions : Bool?
  label : String?
}

///|
#warnings("-9")
pub(all) struct AgentSessionExportToHtmlOptions {
  themeName : String?
}

///|
#warnings("-9")
pub(all) struct ExtensionRunnerBindCoreProviderActions {
  registerProvider : ((String, ProviderConfig) -> Unit)?
  registerNativeProvider : ((Provider[JSValue]) -> Unit)?
  unregisterProvider : ((String) -> Unit)?
}

///|
#warnings("-9")
pub(all) struct AgentSessionRuntimeSwitchSessionOptions {
  cwdOverride : String?
  withSession : ((ReplacedSessionContext) -> Promise[Unit])?
  projectTrustContextFactory : ((String) -> ProjectTrustContext)?
}

///|
#warnings("-9")
pub(all) struct AgentSessionRuntimeNewSessionOptions {
  parentSession : String?
  setup : ((SessionManager) -> Promise[Unit])?
  withSession : ((ReplacedSessionContext) -> Promise[Unit])?
}

///|
#warnings("-9")
pub(all) struct AgentSessionRuntimeForkOptions {
  position : AgentSessionRuntimeForkOptionsPosition?
  withSession : ((ReplacedSessionContext) -> Promise[Unit])?
}

///|
#warnings("-9")
pub(all) struct DefaultPackageManagerAddSourceToSettingsOptions {
  local_ : Bool?
}

///|
#warnings("-9")
pub(all) struct DefaultPackageManagerRemoveSourceFromSettingsOptions {
  local_ : Bool?
}

///|
#warnings("-9")
pub(all) struct DefaultPackageManagerResolveExtensionSourcesOptions {
  local_ : Bool?
  temporary : Bool?
}

///|
#warnings("-9")
pub(all) struct DefaultPackageManagerInstallOptions {
  local_ : Bool?
}

///|
#warnings("-9")
pub(all) struct DefaultPackageManagerInstallAndPersistOptions {
  local_ : Bool?
}

///|
#warnings("-9")
pub(all) struct DefaultPackageManagerRemoveOptions {
  local_ : Bool?
}

///|
#warnings("-9")
pub(all) struct DefaultPackageManagerRemoveAndPersistOptions {
  local_ : Bool?
}

///|
#warnings("-9")
pub(all) struct ToolExecutionComponentUpdateResultResult {
  content : Array[JSValue]
  details : JSValue?
  isError : Bool
}

///|
#warnings("-3")
#external
pub type Theme

///|
#warnings("-3")
#external
pub type RpcClient

///|
#warnings("-3")
#external
pub type AgentSession

///|
#warnings("-3")
#external
pub type CustomEditor

///|
#warnings("-3")
#external
pub type ModelRuntime

///|
#warnings("-3")
#external
pub type DynamicBorder

///|
#warnings("-3")
#external
pub type ModelRegistry

///|
#warnings("-3")
#external
pub type ArminComponent

///|
#warnings("-3")
#external
pub type BorderedLoader

///|
#warnings("-3")
#external
pub type SessionManager

///|
#warnings("-3")
#external
pub type ExtensionRunner

///|
#warnings("-3")
#external
pub type FooterComponent

///|
#warnings("-3")
#external
pub type InteractiveMode

///|
#warnings("-3")
#external
pub type SettingsManager

///|
#warnings("-3")
#external
pub type ProjectTrustStore

///|
#warnings("-3")
#external
pub type KeybindingsManager

///|
#warnings("-3")
#external
pub type AgentSessionRuntime

///|
#warnings("-3")
#external
pub type LoginDialogComponent

///|
#warnings("-3")
#external
pub type UserMessageComponent

///|
#warnings("-3")
#external
pub type DefaultPackageManager

///|
#warnings("-3")
#external
pub type DefaultResourceLoader

///|
#warnings("-3")
#external
pub type TreeSelectorComponent

///|
#warnings("-3")
#external
pub type BashExecutionComponent

///|
#warnings("-3")
#external
pub type CustomMessageComponent

///|
#warnings("-3")
#external
pub type ModelSelectorComponent

///|
#warnings("-3")
#external
pub type OAuthSelectorComponent

///|
#warnings("-3")
#external
pub type ThemeSelectorComponent

///|
#warnings("-3")
#external
pub type ToolExecutionComponent

///|
#warnings("-3")
#external
pub type ExtensionInputComponent

///|
#warnings("-3")
#external
pub type ExtensionEditorComponent

///|
#warnings("-3")
#external
pub type SessionSelectorComponent

///|
#warnings("-3")
#external
pub type AssistantMessageComponent

///|
#warnings("-3")
#external
pub type SettingsSelectorComponent

///|
#warnings("-3")
#external
pub type ThinkingSelectorComponent

///|
#warnings("-3")
#external
pub type ExtensionSelectorComponent

///|
#warnings("-3")
#external
pub type ShowImagesSelectorComponent

///|
#warnings("-3")
#external
pub type UserMessageSelectorComponent

///|
#warnings("-3")
#external
pub type BranchSummaryMessageComponent

///|
#warnings("-3")
#external
pub type CredentialSynchronizationError

///|
#warnings("-3")
#external
pub type SkillInvocationMessageComponent

///|
#warnings("-3")
#external
pub type CompactionSummaryMessageComponent

///|
pub(all) enum Auto_BoolValue_or_StringValue {
  BoolValue(Bool)
  StringValue(String)
}

///|
pub(all) enum Auto_TrueValue_or_StringValue {
  StringValue(String)
  TrueValue
}

///|
pub(all) enum Auto_ThemeValue_or_StringValue {
  StringValue(String)
  ThemeValue(Theme)
}

///|
pub(all) enum Auto_OAuthAuthValue_or_ApiKeyAuthValue {
  ApiKeyAuthValue(ApiKeyAuth)
  OAuthAuthValue(OAuthAuth)
}

///|
pub(all) enum Auto_TextContentValue_or_ImageContentValue {
  TextContentValue(TextContent)
  ImageContentValue(ImageContent)
}

///|
pub(all) enum Auto_FalseValue_or_ConstrainedSamplingConfigValue {
  FalseValue
  ConstrainedSamplingConfigValue(ConstrainedSamplingConfig)
}

///|
pub(all) enum Auto_BoolValue_or_TerminalSettingsTrueColorMember1Value {
  BoolValue(Bool)
  TerminalSettingsTrueColorMember1Value(TerminalSettingsTrueColorMember1)
}

///|
pub(all) enum Auto_BoolValue_or_TerminalSettingsHyperlinksMember1Value {
  BoolValue(Bool)
  TerminalSettingsHyperlinksMember1Value(TerminalSettingsHyperlinksMember1)
}

///|
pub(all) enum Auto_MessageValue_or_CustomMessageValue_or_BashExecutionMessageValue {
  MessageValue(Message)
  CustomMessageValue(CustomMessage[JSValue])
  BashExecutionMessageValue(BashExecutionMessage)
}

///|
#warnings("-3")
#external
pub type Api

///|
#warnings("-3")
#external
pub type Map

///|
#warnings("-3")
#external
pub type Set

///|
#warnings("-3")
#external
pub type TUI

///|
#warnings("-3")
#external
pub type Date

///|
#warnings("-3")
#external
pub type Mode

///|
#warnings("-3")
#external
pub type Pick

///|
#warnings("-3")
#external
pub type Tool[TParameters]

///|
#warnings("-3")
#external
pub type Agent

///|
#warnings("-3")
#external
pub type Input

///|
#warnings("-3")
#external
pub type KeyId

///|
#warnings("-3")
#external
pub type Model[TApi]

///|
#warnings("-3")
#external
pub type Usage

///|
#warnings("-3")
#external
pub type Buffer

///|
#warnings("-3")
#external
pub type Error_

///|
#warnings("-3")
#external
pub type Record

///|
#warnings("-3")
#external
pub type Static

///|
#warnings("-3")
#external
pub type TState[CallStack, Visited]

///|
#warnings("-3")
#external
pub type BaseKey

///|
#warnings("-3")
#external
pub type Context

///|
#warnings("-3")
#external
pub type Exclude

///|
#warnings("-3")
#external
pub type Message

///|
#warnings("-3")
#external
pub type Partial

///|
#warnings("-3")
#external
pub type TSchema

///|
#warnings("-3")
#external
pub type ThemeBg

///|
#warnings("-3")
#external
pub type AuthType

///|
#warnings("-3")
#external
pub type KnownApi

///|
#warnings("-3")
#external
pub type Provider[TApi]

///|
#warnings("-3")
#external
pub type StreamFn

///|
#warnings("-3")
#external
pub type TDetails

///|
#warnings("-3")
#external
pub type TreeList

///|
#warnings("-3")
#external
pub type AgentTool[TParameters, TDetails]

///|
#warnings("-3")
#external
pub type AuthCheck

///|
#warnings("-3")
#external
pub type ColorMode

///|
#warnings("-3")
#external
pub type Component

///|
#warnings("-3")
#external
pub type OAuthAuth

///|
#warnings("-3")
#external
pub type Transport

///|
#warnings("-3")
#external
pub type AgentState

///|
#warnings("-3")
#external
pub type ApiKeyAuth

///|
#warnings("-3")
#external
pub type AuthResult

///|
#warnings("-3")
#external
pub type Credential

///|
#warnings("-3")
#external
pub type FilterMode

///|
#warnings("-3")
#external
pub type Keybinding

///|
#warnings("-3")
#external
pub type LabelEntry

///|
#warnings("-3")
#external
pub type ReturnType

///|
#warnings("-3")
#external
pub type SelectList

///|
#warnings("-3")
#external
pub type Uint8Array

///|
#warnings("-3")
#external
pub type AbortSignal

///|
#warnings("-3")
#external
pub type EditorTheme

///|
#warnings("-3")
#external
pub type LsToolInput

///|
#warnings("-3")
#external
pub type ModelsStore

///|
#warnings("-3")
#external
pub type RetryPolicy

///|
#warnings("-3")
#external
pub type SessionList

///|
#warnings("-3")
#external
pub type SourceScope

///|
#warnings("-3")
#external
pub type TextContent

///|
#warnings("-3")
#external
pub type UserMessage

///|
#warnings("-3")
#external
pub type AgentMessage

///|
#warnings("-3")
#external
pub type AuthInfoLink

///|
#warnings("-3")
#external
pub type ErrorOptions

///|
#warnings("-3")
#external
pub type ImageContent

///|
#warnings("-3")
#external
pub type SessionEvent

///|
#warnings("-3")
#external
pub type SettingsList

///|
#warnings("-3")
#external
pub type SourceOrigin

///|
#warnings("-3")
#external
pub type BashToolInput

///|
#warnings("-3")
#external
pub type EditToolInput

///|
#warnings("-3")
#external
pub type EditorFactory

///|
#warnings("-3")
#external
pub type EditorOptions

///|
#warnings("-3")
#external
pub type EntryRenderer

///|
#warnings("-3")
#external
pub type ExtensionMode

///|
#warnings("-3")
#external
pub type FindToolInput

///|
#warnings("-3")
#external
pub type GrepToolInput

///|
#warnings("-3")
#external
pub type MarkdownTheme

///|
#warnings("-3")
#external
pub type ModifiedKeyId

///|
#warnings("-3")
#external
pub type PackageSource

///|
#warnings("-3")
#external
pub type ReadToolInput

///|
#warnings("-3")
#external
pub type SettingsScope

///|
#warnings("-3")
#external
pub type TerminalTheme

///|
#warnings("-3")
#external
pub type ThinkingLevel

///|
#warnings("-3")
#external
pub type TuiMouseEvent

///|
#warnings("-3")
#external
pub type CredentialInfo

///|
#warnings("-3")
#external
pub type DeferredHandle

///|
#warnings("-3")
#external
pub type NodeJS_Timeout

///|
#warnings("-3")
#external
pub type RetryCallbacks

///|
#warnings("-3")
#external
pub type SessionsLoader

///|
#warnings("-3")
#external
pub type WriteToolInput

///|
#warnings("-3")
#external
pub type AuthInteraction

///|
#warnings("-3")
#external
pub type CredentialStore

///|
#warnings("-3")
#external
pub type InlineExtension

///|
#warnings("-3")
#external
pub type MessageRenderer

///|
#warnings("-3")
#external
pub type OAuthCredential

///|
#warnings("-3")
#external
pub type ProviderHeaders

///|
#warnings("-3")
#external
pub type RendererTuiMode

///|
#warnings("-3")
#external
pub type RunnerEmitEvent

///|
#warnings("-3")
#external
pub type SelectListTheme

///|
#warnings("-3")
#external
pub type SetLabelHandler

///|
#warnings("-3")
#external
pub type SetModelHandler

///|
#warnings("-3")
#external
pub type ShutdownHandler

///|
#warnings("-3")
#external
pub type UserMessageList

///|
#warnings("-3")
#external
pub type ApiKeyCredential

///|
#warnings("-3")
#external
pub type AssistantMessage

///|
#warnings("-3")
#external
pub type ExtensionFactory

///|
#warnings("-3")
#external
pub type InputEventResult

///|
#warnings("-3")
#external
pub type OAuthCredentials

///|
#warnings("-3")
#external
pub type TransportSetting

///|
#warnings("-3")
#external
pub type AgentSessionEvent

///|
#warnings("-3")
#external
pub type KeybindingsConfig

///|
#warnings("-3")
#external
pub type LsToolResultEvent

///|
#warnings("-3")
#external
pub type ModelSelectSource

///|
#warnings("-3")
#external
pub type NodeJS_ProcessEnv

///|
#warnings("-3")
#external
pub type SettingsListTheme

///|
#warnings("-3")
#external
pub type ToolResultMessage[TDetails]

///|
#warnings("-3")
#external
pub type AppendEntryHandler

///|
#warnings("-3")
#external
pub type GetAllToolsHandler

///|
#warnings("-3")
#external
pub type GetCommandsHandler

///|
#warnings("-3")
#external
pub type KeybindingConflict

///|
#warnings("-3")
#external
pub type SendMessageHandler

///|
#warnings("-3")
#external
pub type BashToolResultEvent

///|
#warnings("-3")
#external
pub type EditToolResultEvent

///|
#warnings("-3")
#external
pub type FindToolResultEvent

///|
#warnings("-3")
#external
pub type GrepToolResultEvent

///|
#warnings("-3")
#external
pub type MissingSourceAction

///|
#warnings("-3")
#external
pub type ModelsRefreshResult

///|
#warnings("-3")
#external
pub type OAuthDeviceCodeInfo

///|
#warnings("-3")
#external
pub type OAuthLoginCallbacks

///|
#warnings("-3")
#external
pub type ProjectTrustHandler

///|
#warnings("-3")
#external
pub type ReadToolResultEvent

///|
#warnings("-3")
#external
pub type RefreshToolsHandler

///|
#warnings("-3")
#external
pub type ResolvedRequestAuth

///|
#warnings("-3")
#external
pub type ScrollViewScrollbar

///|
#warnings("-3")
#external
pub type SessionListProgress

///|
#warnings("-3")
#external
pub type SimpleStreamOptions

///|
#warnings("-3")
#external
pub type AuthOperationOptions

///|
#warnings("-3")
#external
pub type AutocompleteProvider

///|
#warnings("-3")
#external
pub type KeybindingDefinition

///|
#warnings("-3")
#external
pub type MermaidRenderingMode

///|
#warnings("-3")
#external
pub type ModelsRefreshOptions

///|
#warnings("-3")
#external
pub type RefreshModelsContext

///|
#warnings("-3")
#external
pub type StringRecordOfString

///|
#warnings("-3")
#external
pub type TerminalInputHandler

///|
#warnings("-3")
#external
pub type WriteToolResultEvent

///|
#warnings("-3")
#external
pub type AssistantMessageEvent

///|
#warnings("-3")
#external
pub type CustomToolResultEvent

///|
#warnings("-3")
#external
pub type GetActiveToolsHandler

///|
#warnings("-3")
#external
pub type GetSessionNameHandler

///|
#warnings("-3")
#external
pub type SetActiveToolsHandler

///|
#warnings("-3")
#external
pub type SetSessionNameHandler

///|
#warnings("-3")
#external
pub type StringRecordOfUnknown

///|
#warnings("-3")
#external
pub type ExtensionErrorListener

///|
#warnings("-3")
#external
pub type JsonMessageUpdateEvent

///|
#warnings("-3")
#external
pub type ModelsApiStreamOptions

///|
#warnings("-3")
#external
pub type ReadonlySessionManager

///|
#warnings("-3")
#external
pub type SendUserMessageHandler

///|
#warnings("-3")
#external
pub type WorkingStatusIndicator

///|
#warnings("-3")
#external
pub type AgentToolUpdateCallback

///|
#warnings("-3")
#external
pub type EditCallRenderComponent

///|
#warnings("-3")
#external
pub type GetThinkingLevelHandler

///|
#warnings("-3")
#external
pub type SetThinkingLevelHandler

///|
#warnings("-3")
#external
pub type StringRecordOfAgentTool

///|
#warnings("-3")
#external
pub type ConstrainedSamplingConfig

///|
#warnings("-3")
#external
pub type ModelsSimpleStreamOptions

///|
#warnings("-3")
#external
pub type PowerShellToolResultEvent

///|
#warnings("-3")
#external
pub type ModelsDeferredFetchOptions

///|
#warnings("-3")
#external
pub type AssistantMessageEventStream

///|
#warnings("-3")
#external
pub type ModelsDeferredCancelOptions

///|
#warnings("-3")
#external
pub type StringRecordOfThinkingLevel

///|
#warnings("-3")
#external
pub type CreateAgentSessionRuntimeFactory

///|
#warnings("-3")
#external
pub type ToolDefinitionPickNameDescriptionParametersPromptGuidelines
