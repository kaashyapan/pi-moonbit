///|
extern "js" fn __ts_mbt_js_object_from_pairs(
  keys : Array[String],
  values : Array[JSValue],
) -> JSValue =
  #| (keys, values) => { const out = {}; for (let i = 0; i < keys.length; i++) out[keys[i]] = values[i]; return out; }

///|
pub extern "js" fn EventBus::emit(
  self : EventBus,
  arg0 : String,
  arg1 : JSValue,
) -> Unit =
  #| (self, arg0, arg1) => self.emit(arg0, arg1)

///|
pub extern "js" fn EventBus::on(
  self : EventBus,
  arg0 : String,
  arg1 : (JSValue) -> Unit,
) -> () -> Unit =
  #| (self, arg0, arg1) => self.on(arg0, arg1)

///|
pub extern "js" fn ExtensionAPI::on(
  self : ExtensionAPI,
  arg0 : String,
  arg1 : ProjectTrustHandler,
) -> Unit =
  #| (self, arg0, arg1) => self.on(arg0, arg1)

///|
pub extern "js" fn ExtensionAPI::on_resources_discover(
  self : ExtensionAPI,
  arg0 : (ResourcesDiscoverEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("resources_discover", arg0)

///|
pub extern "js" fn ExtensionAPI::on_session_before_switch(
  self : ExtensionAPI,
  arg0 : (SessionBeforeSwitchEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("session_before_switch", arg0)

///|
pub extern "js" fn ExtensionAPI::on_session_before_fork(
  self : ExtensionAPI,
  arg0 : (SessionBeforeForkEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("session_before_fork", arg0)

///|
pub extern "js" fn ExtensionAPI::on_session_before_compact(
  self : ExtensionAPI,
  arg0 : (SessionBeforeCompactEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("session_before_compact", arg0)

///|
pub extern "js" fn ExtensionAPI::on_session_before_tree(
  self : ExtensionAPI,
  arg0 : (SessionBeforeTreeEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("session_before_tree", arg0)

///|
pub extern "js" fn ExtensionAPI::on_context(
  self : ExtensionAPI,
  arg0 : (ContextEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("context", arg0)

///|
pub extern "js" fn ExtensionAPI::on_before_provider_request(
  self : ExtensionAPI,
  arg0 : (BeforeProviderRequestEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("before_provider_request", arg0)

///|
pub extern "js" fn ExtensionAPI::on_before_agent_start(
  self : ExtensionAPI,
  arg0 : (BeforeAgentStartEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("before_agent_start", arg0)

///|
pub extern "js" fn ExtensionAPI::on_message_end(
  self : ExtensionAPI,
  arg0 : (MessageEndEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("message_end", arg0)

///|
pub extern "js" fn ExtensionAPI::on_tool_call(
  self : ExtensionAPI,
  arg0 : (ToolCallEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("tool_call", arg0)

///|
pub extern "js" fn ExtensionAPI::on_tool_result(
  self : ExtensionAPI,
  arg0 : (ToolResultEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("tool_result", arg0)

///|
pub extern "js" fn ExtensionAPI::on_user_bash(
  self : ExtensionAPI,
  arg0 : (UserBashEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("user_bash", arg0)

///|
pub extern "js" fn ExtensionAPI::on_input(
  self : ExtensionAPI,
  arg0 : (InputEvent, ExtensionContext) -> JSValue,
) -> Unit =
  #| (self, arg0) => self.on("input", arg0)

///|
extern "js" fn _extension_api_registerTool_generic_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.registerTool(...args)

///|
pub extern "js" fn ExtensionAPI::registerCommand(
  self : ExtensionAPI,
  arg0 : String,
  arg1 : RegisteredCommandOmitNameSourceInfo,
) -> Unit =
  #| (self, arg0, arg1) => self.registerCommand(arg0, arg1)

///|
pub extern "js" fn ExtensionAPI::registerShortcut(
  self : ExtensionAPI,
  arg0 : KeyId,
  arg1 : ExtensionApiRegisterShortcutOptions,
) -> Unit =
  #| (self, arg0, arg1) => self.registerShortcut(arg0, arg1)

///|
pub extern "js" fn ExtensionAPI::registerFlag(
  self : ExtensionAPI,
  arg0 : String,
  arg1 : JSValue,
) -> Unit =
  #| (self, arg0, arg1) => self.registerFlag(arg0, arg1)

///|
pub extern "js" fn ExtensionAPI::getFlag(
  self : ExtensionAPI,
  arg0 : String,
) -> Auto_BoolValue_or_StringValue? =
  #| (self, arg0) => ((__ts_mbt_raw) => __ts_mbt_raw == null ? undefined : (() => { if (typeof __ts_mbt_raw === "boolean") return { "$tag": 0, "_0": __ts_mbt_raw }; else if (typeof __ts_mbt_raw === "string") return { "$tag": 1, "_0": __ts_mbt_raw }; throw new Error("unexpected Auto_BoolValue_or_StringValue value"); })())(self.getFlag(arg0))

///|
extern "js" fn _extension_api_registerMessageRenderer_generic_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.registerMessageRenderer(...args)

///|
pub extern "js" fn ExtensionAPI::registerMarkdownTransformer(
  self : ExtensionAPI,
  arg0 : MarkdownTransformer,
) -> Unit =
  #| (self, arg0) => self.registerMarkdownTransformer(arg0)

///|
extern "js" fn _extension_api_registerEntryRenderer_generic_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.registerEntryRenderer(...args)

///|
extern "js" fn _extension_api_sendMessage_generic_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.sendMessage(...args)

///|
pub extern "js" fn ExtensionAPI::sendUserMessage(
  self : ExtensionAPI,
  arg0 : JSValue,
  arg1 : JSValue?,
) -> Unit =
  #| (self, arg0, arg1) => self.sendUserMessage(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
extern "js" fn _extension_api_appendEntry_generic_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.appendEntry(...args)

///|
pub extern "js" fn ExtensionAPI::setSessionName(
  self : ExtensionAPI,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.setSessionName(arg0)

///|
pub extern "js" fn ExtensionAPI::getSessionName(self : ExtensionAPI) -> String? =
  #| (self) => self.getSessionName()

///|
pub extern "js" fn ExtensionAPI::setLabel(
  self : ExtensionAPI,
  arg0 : String,
  arg1 : String?,
) -> Unit =
  #| (self, arg0, arg1) => self.setLabel(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionAPI::exec(
  self : ExtensionAPI,
  arg0 : String,
  arg1 : Array[String],
  arg2 : ExecOptions?,
) -> Promise[ExecResult] =
  #| (self, arg0, arg1, arg2) => self.exec(arg0, arg1, (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionAPI::getActiveTools(
  self : ExtensionAPI,
) -> Array[String] =
  #| (self) => self.getActiveTools()

///|
pub extern "js" fn ExtensionAPI::getAllTools(
  self : ExtensionAPI,
) -> Array[ToolInfo] =
  #| (self) => self.getAllTools()

///|
pub extern "js" fn ExtensionAPI::setActiveTools(
  self : ExtensionAPI,
  arg0 : Array[String],
) -> Unit =
  #| (self, arg0) => self.setActiveTools(arg0)

///|
pub extern "js" fn ExtensionAPI::getCommands(
  self : ExtensionAPI,
) -> Array[SlashCommandInfo] =
  #| (self) => self.getCommands()

///|
pub extern "js" fn ExtensionAPI::setModel(
  self : ExtensionAPI,
  arg0 : Model[JSValue],
) -> Promise[Bool] =
  #| (self, arg0) => self.setModel(arg0)

///|
pub extern "js" fn ExtensionAPI::getThinkingLevel(
  self : ExtensionAPI,
) -> ThinkingLevel =
  #| (self) => self.getThinkingLevel()

///|
pub extern "js" fn ExtensionAPI::setThinkingLevel(
  self : ExtensionAPI,
  arg0 : ThinkingLevel,
) -> Unit =
  #| (self, arg0) => self.setThinkingLevel(arg0)

///|
pub extern "js" fn ExtensionAPI::registerProvider(
  self : ExtensionAPI,
  arg0 : Provider[JSValue],
) -> Unit =
  #| (self, arg0) => self.registerProvider(arg0)

///|
pub extern "js" fn ExtensionAPI::unregisterProvider(
  self : ExtensionAPI,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.unregisterProvider(arg0)

///|
pub extern "js" fn LsOperations::exists(
  self : LsOperations,
  arg0 : String,
) -> Promise[Bool] =
  #| (self, arg0) => self.exists(arg0)

///|
pub extern "js" fn LsOperations::stat(
  self : LsOperations,
  arg0 : String,
) -> Promise[JSValue] =
  #| (self, arg0) => self.stat(arg0)

///|
pub extern "js" fn LsOperations::readdir(
  self : LsOperations,
  arg0 : String,
) -> Promise[Array[String]] =
  #| (self, arg0) => self.readdir(arg0)

///|
pub extern "js" fn BashOperations::exec(
  self : BashOperations,
  arg0 : String,
  arg1 : String,
  arg2 : BashOperationsExecOptions,
) -> Promise[JSValue] =
  #| (self, arg0, arg1, arg2) => self.exec(arg0, arg1, arg2)

///|
pub extern "js" fn EditOperations::readFile(
  self : EditOperations,
  arg0 : String,
) -> Promise[Buffer] =
  #| (self, arg0) => self.readFile(arg0)

///|
pub extern "js" fn EditOperations::writeFile(
  self : EditOperations,
  arg0 : String,
  arg1 : String,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.writeFile(arg0, arg1)

///|
pub extern "js" fn EditOperations::access(
  self : EditOperations,
  arg0 : String,
) -> Promise[Unit] =
  #| (self, arg0) => self.access(arg0)

///|
pub extern "js" fn FindOperations::exists(
  self : FindOperations,
  arg0 : String,
) -> Promise[Bool] =
  #| (self, arg0) => self.exists(arg0)

///|
pub extern "js" fn FindOperations::glob(
  self : FindOperations,
  arg0 : String,
  arg1 : String,
  arg2 : FindOperationsGlobOptions,
) -> Promise[Array[String]] =
  #| (self, arg0, arg1, arg2) => self.glob(arg0, arg1, arg2)

///|
pub extern "js" fn GrepOperations::isDirectory(
  self : GrepOperations,
  arg0 : String,
) -> Promise[Bool] =
  #| (self, arg0) => self.isDirectory(arg0)

///|
pub extern "js" fn GrepOperations::readFile(
  self : GrepOperations,
  arg0 : String,
) -> Promise[String] =
  #| (self, arg0) => self.readFile(arg0)

///|
extern "js" fn _package_manager_resolve_ret_conv_js(
  this_ : PackageManager,
  arg0 : ((String) -> Promise[MissingSourceAction])?,
) -> Promise[ResolvedPaths] =
  #| (self, arg0) => self.resolve((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn PackageManager::install(
  self : PackageManager,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.install(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn PackageManager::installAndPersist(
  self : PackageManager,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.installAndPersist(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn PackageManager::remove(
  self : PackageManager,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.remove(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn PackageManager::removeAndPersist(
  self : PackageManager,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[Bool] =
  #| (self, arg0, arg1) => self.removeAndPersist(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn PackageManager::update(
  self : PackageManager,
  arg0 : String?,
) -> Promise[Unit] =
  #| (self, arg0) => self.update((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn PackageManager::listConfiguredPackages(
  self : PackageManager,
) -> Array[ConfiguredPackage] =
  #| (self) => self.listConfiguredPackages()

///|
pub extern "js" fn PackageManager::resolveExtensionSources(
  self : PackageManager,
  arg0 : Array[String],
  arg1 : JSValue?,
) -> Promise[ResolvedPaths] =
  #| (self, arg0, arg1) => self.resolveExtensionSources(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn PackageManager::addSourceToSettings(
  self : PackageManager,
  arg0 : String,
  arg1 : JSValue?,
) -> Bool =
  #| (self, arg0, arg1) => self.addSourceToSettings(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn PackageManager::removeSourceFromSettings(
  self : PackageManager,
  arg0 : String,
  arg1 : JSValue?,
) -> Bool =
  #| (self, arg0, arg1) => self.removeSourceFromSettings(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn PackageManager::setProgressCallback(
  self : PackageManager,
  arg0 : ProgressCallback?,
) -> Unit =
  #| (self, arg0) => self.setProgressCallback((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn PackageManager::getInstalledPath(
  self : PackageManager,
  arg0 : String,
  arg1 : String,
) -> String? =
  #| (self, arg0, arg1) => self.getInstalledPath(arg0, arg1)

///|
pub extern "js" fn ReadOperations::readFile(
  self : ReadOperations,
  arg0 : String,
) -> Promise[Buffer] =
  #| (self, arg0) => self.readFile(arg0)

///|
pub extern "js" fn ReadOperations::access(
  self : ReadOperations,
  arg0 : String,
) -> Promise[Unit] =
  #| (self, arg0) => self.access(arg0)

///|
pub extern "js" fn ResourceLoader::getExtensions(
  self : ResourceLoader,
) -> LoadExtensionsResult =
  #| (self) => self.getExtensions()

///|
pub extern "js" fn ResourceLoader::getSkills(
  self : ResourceLoader,
) -> ResourceLoaderGetSkillsResult =
  #| (self) => self.getSkills()

///|
pub extern "js" fn ResourceLoader::getPrompts(
  self : ResourceLoader,
) -> ResourceLoaderGetPromptsResult =
  #| (self) => self.getPrompts()

///|
pub extern "js" fn ResourceLoader::getThemes(
  self : ResourceLoader,
) -> ResourceLoaderGetThemesResult =
  #| (self) => self.getThemes()

///|
pub extern "js" fn ResourceLoader::getAgentsFiles(
  self : ResourceLoader,
) -> ResourceLoaderGetAgentsFilesResult =
  #| (self) => self.getAgentsFiles()

///|
pub extern "js" fn ResourceLoader::getSystemPrompt(
  self : ResourceLoader,
) -> String? =
  #| (self) => self.getSystemPrompt()

///|
extern "js" fn _resource_loader_get_system_prompt_source_ret_conv_js(
  this_ : ResourceLoader,
) -> JSValue =
  #| (self) => self.getSystemPromptSource()

///|
pub extern "js" fn ResourceLoader::getAppendSystemPrompt(
  self : ResourceLoader,
) -> Array[String] =
  #| (self) => self.getAppendSystemPrompt()

///|
pub extern "js" fn ResourceLoader::getAppendSystemPromptSources(
  self : ResourceLoader,
) -> Array[JSValue] =
  #| (self) => self.getAppendSystemPromptSources()

///|
pub extern "js" fn ResourceLoader::extendResources(
  self : ResourceLoader,
  arg0 : ResourceExtensionPaths,
) -> Unit =
  #| (self, arg0) => self.extendResources(arg0)

///|
pub extern "js" fn ResourceLoader::reload(
  self : ResourceLoader,
  arg0 : ResourceLoaderReloadOptions?,
) -> Promise[Unit] =
  #| (self, arg0) => self.reload((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
extern "js" fn _tool_definition_execute_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.execute(...args)

///|
pub extern "js" fn ResolvedCommand::handler(
  self : ResolvedCommand,
  arg0 : String,
  arg1 : ExtensionCommandContext,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.handler(arg0, arg1)

///|
pub extern "js" fn WriteOperations::writeFile(
  self : WriteOperations,
  arg0 : String,
  arg1 : String,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.writeFile(arg0, arg1)

///|
pub extern "js" fn WriteOperations::mkdir(
  self : WriteOperations,
  arg0 : String,
) -> Promise[Unit] =
  #| (self, arg0) => self.mkdir(arg0)

///|
pub extern "js" fn ExtensionContext::isIdle(self : ExtensionContext) -> Bool =
  #| (self) => self.isIdle()

///|
pub extern "js" fn ExtensionContext::isProjectTrusted(
  self : ExtensionContext,
) -> Bool =
  #| (self) => self.isProjectTrusted()

///|
pub extern "js" fn ExtensionContext::abort(self : ExtensionContext) -> Unit =
  #| (self) => self.abort()

///|
pub extern "js" fn ExtensionContext::hasPendingMessages(
  self : ExtensionContext,
) -> Bool =
  #| (self) => self.hasPendingMessages()

///|
pub extern "js" fn ExtensionContext::shutdown(self : ExtensionContext) -> Unit =
  #| (self) => self.shutdown()

///|
pub extern "js" fn ExtensionContext::getContextUsage(
  self : ExtensionContext,
) -> ContextUsage? =
  #| (self) => self.getContextUsage()

///|
pub extern "js" fn ExtensionContext::compact(
  self : ExtensionContext,
  arg0 : CompactOptions?,
) -> Unit =
  #| (self, arg0) => self.compact((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionContext::getSystemPrompt(
  self : ExtensionContext,
) -> String =
  #| (self) => self.getSystemPrompt()

///|
pub extern "js" fn ExtensionRuntime::assertActive(
  self : ExtensionRuntime,
) -> Unit =
  #| (self) => self.assertActive()

///|
pub extern "js" fn ExtensionRuntime::invalidate(
  self : ExtensionRuntime,
  arg0 : String?,
) -> Unit =
  #| (self, arg0) => self.invalidate((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionRuntime::trackEventBusSubscription(
  self : ExtensionRuntime,
  arg0 : () -> Unit,
) -> () -> Unit =
  #| (self, arg0) => self.trackEventBusSubscription(arg0)

///|
pub extern "js" fn ExtensionRuntime::registerProvider(
  self : ExtensionRuntime,
  arg0 : String,
  arg1 : ProviderConfig,
  arg2 : String?,
) -> Unit =
  #| (self, arg0, arg1, arg2) => self.registerProvider(arg0, arg1, (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionRuntime::registerNativeProvider(
  self : ExtensionRuntime,
  arg0 : Provider[JSValue],
  arg1 : String?,
) -> Unit =
  #| (self, arg0, arg1) => self.registerNativeProvider(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionRuntime::unregisterProvider(
  self : ExtensionRuntime,
  arg0 : String,
  arg1 : String?,
) -> Unit =
  #| (self, arg0, arg1) => self.unregisterProvider(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
extern "js" fn _skill_frontmatter_index_get_ret_conv_js(
  this_ : SkillFrontmatter,
  key : String,
) -> JSValue =
  #| (self, key) => self[key]

///|
#alias("_[_]=_")
pub extern "js" fn SkillFrontmatter::index_set(
  self : SkillFrontmatter,
  key : String,
  value : JSValue,
) -> Unit =
  #| (self, key, value) => { self[key] = value; }

///|
pub extern "js" fn ExtensionShortcut::handler(
  self : ExtensionShortcut,
  arg0 : ExtensionContext,
) -> Promise[Unit] =
  #| (self, arg0) => self.handler(arg0)

///|
pub extern "js" fn RegisteredCommand::handler(
  self : RegisteredCommand,
  arg0 : String,
  arg1 : ExtensionCommandContext,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.handler(arg0, arg1)

///|
pub extern "js" fn SettingsCallbacks::onAutoCompactChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onAutoCompactChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onShowImagesChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onShowImagesChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onImageWidthCellsChange(
  self : SettingsCallbacks,
  arg0 : Double,
) -> Unit =
  #| (self, arg0) => self.onImageWidthCellsChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onAutoResizeImagesChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onAutoResizeImagesChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onBlockImagesChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onBlockImagesChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onEnableSkillCommandsChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onEnableSkillCommandsChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onSteeringModeChange(
  self : SettingsCallbacks,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.onSteeringModeChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onFollowUpModeChange(
  self : SettingsCallbacks,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.onFollowUpModeChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onTransportChange(
  self : SettingsCallbacks,
  arg0 : Transport,
) -> Unit =
  #| (self, arg0) => self.onTransportChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onHttpIdleTimeoutMsChange(
  self : SettingsCallbacks,
  arg0 : Double,
) -> Unit =
  #| (self, arg0) => self.onHttpIdleTimeoutMsChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onModelThinkingLevelChange(
  self : SettingsCallbacks,
  arg0 : String,
  arg1 : String,
  arg2 : ThinkingLevel,
) -> Unit =
  #| (self, arg0, arg1, arg2) => self.onModelThinkingLevelChange(arg0, arg1, arg2)

///|
pub extern "js" fn SettingsCallbacks::onModelThinkingLevelRemove(
  self : SettingsCallbacks,
  arg0 : String,
  arg1 : String,
) -> Unit =
  #| (self, arg0, arg1) => self.onModelThinkingLevelRemove(arg0, arg1)

///|
pub extern "js" fn SettingsCallbacks::onThemeChange(
  self : SettingsCallbacks,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.onThemeChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onHideThinkingBlockChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onHideThinkingBlockChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onMermaidRenderingModeChange(
  self : SettingsCallbacks,
  arg0 : MermaidRenderingMode,
) -> Unit =
  #| (self, arg0) => self.onMermaidRenderingModeChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onShowCacheMissNoticesChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onShowCacheMissNoticesChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onCollapseChangelogChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onCollapseChangelogChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onEnableInstallTelemetryChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onEnableInstallTelemetryChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onDoubleEscapeActionChange(
  self : SettingsCallbacks,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.onDoubleEscapeActionChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onTreeFilterModeChange(
  self : SettingsCallbacks,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.onTreeFilterModeChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onShowHardwareCursorChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onShowHardwareCursorChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onEditorPaddingXChange(
  self : SettingsCallbacks,
  arg0 : Double,
) -> Unit =
  #| (self, arg0) => self.onEditorPaddingXChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onOutputPadChange(
  self : SettingsCallbacks,
  arg0 : Int,
) -> Unit =
  #| (self, arg0) => self.onOutputPadChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onAutocompleteMaxVisibleChange(
  self : SettingsCallbacks,
  arg0 : Double,
) -> Unit =
  #| (self, arg0) => self.onAutocompleteMaxVisibleChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onQuietStartupChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onQuietStartupChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onDefaultProjectTrustChange(
  self : SettingsCallbacks,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.onDefaultProjectTrustChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onClearOnShrinkChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onClearOnShrinkChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onShowTerminalProgressChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onShowTerminalProgressChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onTuiModeChange(
  self : SettingsCallbacks,
  arg0 : TuiMode,
) -> Unit =
  #| (self, arg0) => self.onTuiModeChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onFullscreenExitOutputChange(
  self : SettingsCallbacks,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.onFullscreenExitOutputChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onFullscreenScrollbarChange(
  self : SettingsCallbacks,
  arg0 : ScrollViewScrollbar,
) -> Unit =
  #| (self, arg0) => self.onFullscreenScrollbarChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onFullscreenCopyOnSelectChange(
  self : SettingsCallbacks,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.onFullscreenCopyOnSelectChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onWarningsChange(
  self : SettingsCallbacks,
  arg0 : WarningSettings,
) -> Unit =
  #| (self, arg0) => self.onWarningsChange(arg0)

///|
pub extern "js" fn SettingsCallbacks::onCancel(
  self : SettingsCallbacks,
) -> Unit =
  #| (self) => self.onCancel()

///|
pub extern "js" fn EventBusController::clear(self : EventBusController) -> Unit =
  #| (self) => self.clear()

///|
pub extern "js" fn EventBusController::emit(
  self : EventBusController,
  arg0 : String,
  arg1 : JSValue,
) -> Unit =
  #| (self, arg0, arg1) => self.emit(arg0, arg1)

///|
pub extern "js" fn EventBusController::on(
  self : EventBusController,
  arg0 : String,
  arg1 : (JSValue) -> Unit,
) -> () -> Unit =
  #| (self, arg0, arg1) => self.on(arg0, arg1)

///|
pub extern "js" fn ExtensionUIContext::select(
  self : ExtensionUIContext,
  arg0 : String,
  arg1 : Array[String],
  arg2 : ExtensionUIDialogOptions?,
) -> Promise[String?] =
  #| (self, arg0, arg1, arg2) => self.select(arg0, arg1, (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionUIContext::confirm(
  self : ExtensionUIContext,
  arg0 : String,
  arg1 : String,
  arg2 : ExtensionUIDialogOptions?,
) -> Promise[Bool] =
  #| (self, arg0, arg1, arg2) => self.confirm(arg0, arg1, (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionUIContext::input(
  self : ExtensionUIContext,
  arg0 : String,
  arg1 : String?,
  arg2 : ExtensionUIDialogOptions?,
) -> Promise[String?] =
  #| (self, arg0, arg1, arg2) => self.input(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)), (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionUIContext::notify(
  self : ExtensionUIContext,
  arg0 : String,
  arg1 : String?,
) -> Unit =
  #| (self, arg0, arg1) => self.notify(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionUIContext::onTerminalInput(
  self : ExtensionUIContext,
  arg0 : TerminalInputHandler,
) -> () -> Unit =
  #| (self, arg0) => self.onTerminalInput(arg0)

///|
pub extern "js" fn ExtensionUIContext::setStatus(
  self : ExtensionUIContext,
  arg0 : String,
  arg1 : String?,
) -> Unit =
  #| (self, arg0, arg1) => self.setStatus(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionUIContext::setWorkingMessage(
  self : ExtensionUIContext,
  arg0 : String?,
) -> Unit =
  #| (self, arg0) => self.setWorkingMessage((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionUIContext::setWorkingVisible(
  self : ExtensionUIContext,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.setWorkingVisible(arg0)

///|
pub extern "js" fn ExtensionUIContext::setWorkingIndicator(
  self : ExtensionUIContext,
  arg0 : WorkingIndicatorOptions?,
) -> Unit =
  #| (self, arg0) => self.setWorkingIndicator((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionUIContext::setHiddenThinkingLabel(
  self : ExtensionUIContext,
  arg0 : String?,
) -> Unit =
  #| (self, arg0) => self.setHiddenThinkingLabel((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionUIContext::setWidget(
  self : ExtensionUIContext,
  arg0 : String,
  arg1 : Array[String]?,
  arg2 : ExtensionWidgetOptions?,
) -> Unit =
  #| (self, arg0, arg1, arg2) => self.setWidget(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)), (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionUIContext::setFooter(
  self : ExtensionUIContext,
  arg0 : ((TUI, Theme, ReadonlyFooterDataProvider) -> Component)?,
) -> Unit =
  #| (self, arg0) => self.setFooter((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionUIContext::setHeader(
  self : ExtensionUIContext,
  arg0 : ((TUI, Theme) -> Component)?,
) -> Unit =
  #| (self, arg0) => self.setHeader((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionUIContext::setTitle(
  self : ExtensionUIContext,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.setTitle(arg0)

///|
extern "js" fn _extension_uicontext_custom_generic_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.custom(...args)

///|
pub extern "js" fn ExtensionUIContext::pasteToEditor(
  self : ExtensionUIContext,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.pasteToEditor(arg0)

///|
pub extern "js" fn ExtensionUIContext::setEditorText(
  self : ExtensionUIContext,
  arg0 : String,
) -> Unit =
  #| (self, arg0) => self.setEditorText(arg0)

///|
pub extern "js" fn ExtensionUIContext::getEditorText(
  self : ExtensionUIContext,
) -> String =
  #| (self) => self.getEditorText()

///|
pub extern "js" fn ExtensionUIContext::editor(
  self : ExtensionUIContext,
  arg0 : String,
  arg1 : String?,
) -> Promise[String?] =
  #| (self, arg0, arg1) => self.editor(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionUIContext::addAutocompleteProvider(
  self : ExtensionUIContext,
  arg0 : AutocompleteProviderFactory,
) -> Unit =
  #| (self, arg0) => self.addAutocompleteProvider(arg0)

///|
pub extern "js" fn ExtensionUIContext::setEditorComponent(
  self : ExtensionUIContext,
  arg0 : EditorFactory?,
) -> Unit =
  #| (self, arg0) => self.setEditorComponent((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
extern "js" fn _extension_uicontext_get_editor_component_ret_conv_js(
  this_ : ExtensionUIContext,
) -> JSValue =
  #| (self) => self.getEditorComponent()

///|
pub extern "js" fn ExtensionUIContext::getAllThemes(
  self : ExtensionUIContext,
) -> Array[JSValue] =
  #| (self) => self.getAllThemes()

///|
extern "js" fn _extension_uicontext_get_theme_ret_conv_js(
  this_ : ExtensionUIContext,
  arg0 : String,
) -> JSValue =
  #| (self, arg0) => self.getTheme(arg0)

///|
pub extern "js" fn ExtensionUIContext::setTheme(
  self : ExtensionUIContext,
  arg0 : Auto_ThemeValue_or_StringValue,
) -> ExtensionUicontextSetThemeResult =
  #| (self, arg0) => self.setTheme((() => { if (arg0 === null || typeof arg0 !== "object" || !("$tag" in arg0)) return arg0; if (arg0.$tag === 0) return arg0._0; else if (arg0.$tag === 1) return arg0._0; throw new Error("unexpected Auto_ThemeValue_or_StringValue tag: " + arg0.$tag); })())

///|
pub extern "js" fn ExtensionUIContext::getToolsExpanded(
  self : ExtensionUIContext,
) -> Bool =
  #| (self) => self.getToolsExpanded()

///|
pub extern "js" fn ExtensionUIContext::setToolsExpanded(
  self : ExtensionUIContext,
  arg0 : Bool,
) -> Unit =
  #| (self, arg0) => self.setToolsExpanded(arg0)

///|
pub extern "js" fn ExtensionCommandContext::getSystemPromptOptions(
  self : ExtensionCommandContext,
) -> BuildSystemPromptOptions =
  #| (self) => self.getSystemPromptOptions()

///|
pub extern "js" fn ExtensionCommandContext::waitForIdle(
  self : ExtensionCommandContext,
) -> Promise[Unit] =
  #| (self) => self.waitForIdle()

///|
pub extern "js" fn ExtensionCommandContext::newSession(
  self : ExtensionCommandContext,
  arg0 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0) => self.newSession((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionCommandContext::fork(
  self : ExtensionCommandContext,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.fork(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionCommandContext::navigateTree(
  self : ExtensionCommandContext,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.navigateTree(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionCommandContext::switchSession(
  self : ExtensionCommandContext,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.switchSession(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionCommandContext::reload(
  self : ExtensionCommandContext,
) -> Promise[Unit] =
  #| (self) => self.reload()

///|
pub extern "js" fn ExtensionCommandContext::isIdle(
  self : ExtensionCommandContext,
) -> Bool =
  #| (self) => self.isIdle()

///|
pub extern "js" fn ExtensionCommandContext::isProjectTrusted(
  self : ExtensionCommandContext,
) -> Bool =
  #| (self) => self.isProjectTrusted()

///|
pub extern "js" fn ExtensionCommandContext::abort(
  self : ExtensionCommandContext,
) -> Unit =
  #| (self) => self.abort()

///|
pub extern "js" fn ExtensionCommandContext::hasPendingMessages(
  self : ExtensionCommandContext,
) -> Bool =
  #| (self) => self.hasPendingMessages()

///|
pub extern "js" fn ExtensionCommandContext::shutdown(
  self : ExtensionCommandContext,
) -> Unit =
  #| (self) => self.shutdown()

///|
pub extern "js" fn ExtensionCommandContext::getContextUsage(
  self : ExtensionCommandContext,
) -> ContextUsage? =
  #| (self) => self.getContextUsage()

///|
pub extern "js" fn ExtensionCommandContext::compact(
  self : ExtensionCommandContext,
  arg0 : CompactOptions?,
) -> Unit =
  #| (self, arg0) => self.compact((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionCommandContext::getSystemPrompt(
  self : ExtensionCommandContext,
) -> String =
  #| (self) => self.getSystemPrompt()

///|
extern "js" fn _extension_context_actions_get_model_ret_conv_js(
  this_ : ExtensionContextActions,
) -> JSValue =
  #| (self) => self.getModel()

///|
pub extern "js" fn ExtensionContextActions::getScopedModels(
  self : ExtensionContextActions,
) -> Array[ScopedModel] =
  #| (self) => self.getScopedModels()

///|
pub extern "js" fn ExtensionContextActions::isIdle(
  self : ExtensionContextActions,
) -> Bool =
  #| (self) => self.isIdle()

///|
pub extern "js" fn ExtensionContextActions::isProjectTrusted(
  self : ExtensionContextActions,
) -> Bool =
  #| (self) => self.isProjectTrusted()

///|
extern "js" fn _extension_context_actions_get_signal_ret_conv_js(
  this_ : ExtensionContextActions,
) -> JSValue =
  #| (self) => self.getSignal()

///|
pub extern "js" fn ExtensionContextActions::abort(
  self : ExtensionContextActions,
) -> Unit =
  #| (self) => self.abort()

///|
pub extern "js" fn ExtensionContextActions::hasPendingMessages(
  self : ExtensionContextActions,
) -> Bool =
  #| (self) => self.hasPendingMessages()

///|
pub extern "js" fn ExtensionContextActions::shutdown(
  self : ExtensionContextActions,
) -> Unit =
  #| (self) => self.shutdown()

///|
pub extern "js" fn ExtensionContextActions::getContextUsage(
  self : ExtensionContextActions,
) -> ContextUsage? =
  #| (self) => self.getContextUsage()

///|
pub extern "js" fn ExtensionContextActions::compact(
  self : ExtensionContextActions,
  arg0 : CompactOptions?,
) -> Unit =
  #| (self, arg0) => self.compact((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionContextActions::getSystemPrompt(
  self : ExtensionContextActions,
) -> String =
  #| (self) => self.getSystemPrompt()

///|
pub extern "js" fn ExtensionCommandContextActions::waitForIdle(
  self : ExtensionCommandContextActions,
) -> Promise[Unit] =
  #| (self) => self.waitForIdle()

///|
pub extern "js" fn ExtensionCommandContextActions::newSession(
  self : ExtensionCommandContextActions,
  arg0 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0) => self.newSession((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ExtensionCommandContextActions::fork(
  self : ExtensionCommandContextActions,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.fork(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionCommandContextActions::navigateTree(
  self : ExtensionCommandContextActions,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.navigateTree(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionCommandContextActions::switchSession(
  self : ExtensionCommandContextActions,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.switchSession(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ExtensionCommandContextActions::reload(
  self : ExtensionCommandContextActions,
) -> Promise[Unit] =
  #| (self) => self.reload()

///|
pub extern "js" fn RegisteredCommandOmitNameSourceInfo::handler(
  self : RegisteredCommandOmitNameSourceInfo,
  arg0 : String,
  arg1 : ExtensionCommandContext,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.handler(arg0, arg1)

///|
pub extern "js" fn ExtensionUIContextPickSelectConfirmInputNotify::select(
  self : ExtensionUIContextPickSelectConfirmInputNotify,
  arg0 : String,
  arg1 : Array[String],
  arg2 : ExtensionUIDialogOptions?,
) -> Promise[String?] =
  #| (self, arg0, arg1, arg2) => self.select(arg0, arg1, (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionUIContextPickSelectConfirmInputNotify::confirm(
  self : ExtensionUIContextPickSelectConfirmInputNotify,
  arg0 : String,
  arg1 : String,
  arg2 : ExtensionUIDialogOptions?,
) -> Promise[Bool] =
  #| (self, arg0, arg1, arg2) => self.confirm(arg0, arg1, (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionUIContextPickSelectConfirmInputNotify::input(
  self : ExtensionUIContextPickSelectConfirmInputNotify,
  arg0 : String,
  arg1 : String?,
  arg2 : ExtensionUIDialogOptions?,
) -> Promise[String?] =
  #| (self, arg0, arg1, arg2) => self.input(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)), (arg2 == null ? undefined : (typeof arg2 === "object" && "$tag" in arg2 ? (arg2.$tag === 1 ? arg2._0 : undefined) : arg2)))

///|
pub extern "js" fn ExtensionUIContextPickSelectConfirmInputNotify::notify(
  self : ExtensionUIContextPickSelectConfirmInputNotify,
  arg0 : String,
  arg1 : String?,
) -> Unit =
  #| (self, arg0, arg1) => self.notify(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
extern "js" fn _tool_render_context_invalidate_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.invalidate(...args)

///|
extern "js" fn _replaced_session_context_sendMessage_generic_get_extern_js(
  target : JSValue,
) -> JSValue =
  #| (o) => (...args) => o.sendMessage(...args)

///|
pub extern "js" fn ReplacedSessionContext::sendUserMessage(
  self : ReplacedSessionContext,
  arg0 : JSValue,
  arg1 : JSValue?,
) -> Promise[Unit] =
  #| (self, arg0, arg1) => self.sendUserMessage(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ReplacedSessionContext::getSystemPromptOptions(
  self : ReplacedSessionContext,
) -> BuildSystemPromptOptions =
  #| (self) => self.getSystemPromptOptions()

///|
pub extern "js" fn ReplacedSessionContext::waitForIdle(
  self : ReplacedSessionContext,
) -> Promise[Unit] =
  #| (self) => self.waitForIdle()

///|
pub extern "js" fn ReplacedSessionContext::newSession(
  self : ReplacedSessionContext,
  arg0 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0) => self.newSession((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ReplacedSessionContext::fork(
  self : ReplacedSessionContext,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.fork(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ReplacedSessionContext::navigateTree(
  self : ReplacedSessionContext,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.navigateTree(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ReplacedSessionContext::switchSession(
  self : ReplacedSessionContext,
  arg0 : String,
  arg1 : JSValue?,
) -> Promise[JSValue] =
  #| (self, arg0, arg1) => self.switchSession(arg0, (arg1 == null ? undefined : (typeof arg1 === "object" && "$tag" in arg1 ? (arg1.$tag === 1 ? arg1._0 : undefined) : arg1)))

///|
pub extern "js" fn ReplacedSessionContext::reload(
  self : ReplacedSessionContext,
) -> Promise[Unit] =
  #| (self) => self.reload()

///|
pub extern "js" fn ReplacedSessionContext::isIdle(
  self : ReplacedSessionContext,
) -> Bool =
  #| (self) => self.isIdle()

///|
pub extern "js" fn ReplacedSessionContext::isProjectTrusted(
  self : ReplacedSessionContext,
) -> Bool =
  #| (self) => self.isProjectTrusted()

///|
pub extern "js" fn ReplacedSessionContext::abort(
  self : ReplacedSessionContext,
) -> Unit =
  #| (self) => self.abort()

///|
pub extern "js" fn ReplacedSessionContext::hasPendingMessages(
  self : ReplacedSessionContext,
) -> Bool =
  #| (self) => self.hasPendingMessages()

///|
pub extern "js" fn ReplacedSessionContext::shutdown(
  self : ReplacedSessionContext,
) -> Unit =
  #| (self) => self.shutdown()

///|
pub extern "js" fn ReplacedSessionContext::getContextUsage(
  self : ReplacedSessionContext,
) -> ContextUsage? =
  #| (self) => self.getContextUsage()

///|
pub extern "js" fn ReplacedSessionContext::compact(
  self : ReplacedSessionContext,
  arg0 : CompactOptions?,
) -> Unit =
  #| (self, arg0) => self.compact((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn ReplacedSessionContext::getSystemPrompt(
  self : ReplacedSessionContext,
) -> String =
  #| (self) => self.getSystemPrompt()

///|
pub extern "js" fn ExtensionOAuthConfig::login(
  self : ExtensionOAuthConfig,
  arg0 : OAuthLoginCallbacks,
) -> Promise[OAuthCredentials] =
  #| (self, arg0) => self.login(arg0)

///|
pub extern "js" fn ExtensionOAuthConfig::refreshToken(
  self : ExtensionOAuthConfig,
  arg0 : OAuthCredentials,
  arg1 : AbortSignal,
) -> Promise[OAuthCredentials] =
  #| (self, arg0, arg1) => self.refreshToken(arg0, arg1)

///|
pub extern "js" fn ExtensionOAuthConfig::getApiKey(
  self : ExtensionOAuthConfig,
  arg0 : OAuthCredentials,
) -> String =
  #| (self, arg0) => self.getApiKey(arg0)

///|
pub extern "js" fn SettingsStorage::withLock(
  self : SettingsStorage,
  arg0 : SettingsScope,
  arg1 : (String?) -> String?,
) -> Unit =
  #| (self, arg0, arg1) => self.withLock(arg0, arg1)

///|
pub extern "js" fn ExtensionApiRegisterShortcutOptions::handler(
  self : ExtensionApiRegisterShortcutOptions,
  arg0 : ExtensionContext,
) -> Promise[Unit] =
  #| (self, arg0) => self.handler(arg0)

///|
pub extern "js" fn BashOperationsExecOptions::onData(
  self : BashOperationsExecOptions,
  arg0 : Buffer,
) -> Unit =
  #| (self, arg0) => self.onData(arg0)

///|
pub extern "js" fn ProviderConfigOauth::login(
  self : ProviderConfigOauth,
  arg0 : OAuthLoginCallbacks,
) -> Promise[OAuthCredentials] =
  #| (self, arg0) => self.login(arg0)

///|
pub extern "js" fn ProviderConfigOauth::refreshToken(
  self : ProviderConfigOauth,
  arg0 : OAuthCredentials,
  arg1 : AbortSignal,
) -> Promise[OAuthCredentials] =
  #| (self, arg0, arg1) => self.refreshToken(arg0, arg1)

///|
pub extern "js" fn ProviderConfigOauth::getApiKey(
  self : ProviderConfigOauth,
  arg0 : OAuthCredentials,
) -> String =
  #| (self, arg0) => self.getApiKey(arg0)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_theme(
  fgColors : JSValue,
  bgColors : JSValue,
  mode : ColorMode,
  options : JSValue?,
) -> Theme = "__ts_mbt_new_theme"

///|
pub extern "js" fn Theme::get_theme_name(self : Theme) -> String =
  #| (self) => self.name

///|
pub extern "js" fn Theme::get_theme_source_path(self : Theme) -> String =
  #| (self) => self.sourcePath

///|
pub extern "js" fn Theme::get_theme_source_info(self : Theme) -> SourceInfo =
  #| (self) => self.sourceInfo

///|
pub extern "js" fn Theme::set_theme_source_info(
  self : Theme,
  value : SourceInfo,
) -> Unit =
  #| (self, value) => (self.sourceInfo = value)

///|
extern "js" fn _theme_fg_ret_conv_js(
  this_ : Theme,
  color : String,
  text : String,
) -> String =
  #| (self, color, text) => self.fg(color, text)

///|
pub extern "js" fn Theme::bg(
  self : Theme,
  color : ThemeBg,
  text : String,
) -> String =
  #| (self, color, text) => self.bg(color, text)

///|
pub extern "js" fn Theme::bold(self : Theme, text : String) -> String =
  #| (self, text) => self.bold(text)

///|
pub extern "js" fn Theme::italic(self : Theme, text : String) -> String =
  #| (self, text) => self.italic(text)

///|
pub extern "js" fn Theme::underline(self : Theme, text : String) -> String =
  #| (self, text) => self.underline(text)

///|
pub extern "js" fn Theme::inverse(self : Theme, text : String) -> String =
  #| (self, text) => self.inverse(text)

///|
pub extern "js" fn Theme::strikethrough(self : Theme, text : String) -> String =
  #| (self, text) => self.strikethrough(text)

///|
extern "js" fn _theme_get_fg_ansi_ret_conv_js(
  this_ : Theme,
  color : String,
) -> String =
  #| (self, color) => self.getFgAnsi(color)

///|
pub extern "js" fn Theme::get_bg_ansi(self : Theme, color : ThemeBg) -> String =
  #| (self, color) => self.getBgAnsi(color)

///|
pub extern "js" fn Theme::get_color_mode(self : Theme) -> ColorMode =
  #| (self) => self.getColorMode()

///|
pub extern "js" fn Theme::get_thinking_border_color(
  self : Theme,
  level : ThinkingLevel,
) -> (String) -> String =
  #| (self, level) => self.getThinkingBorderColor(level)

///|
pub extern "js" fn Theme::get_bash_mode_border_color(
  self : Theme,
) -> (String) -> String =
  #| (self) => self.getBashModeBorderColor()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_rpc_client(options : RpcClientOptions?) -> RpcClient = "__ts_mbt_new_rpc_client"

///|
pub extern "js" fn RpcClient::start(self : RpcClient) -> Promise[Unit] =
  #| (self) => self.start()

///|
pub extern "js" fn RpcClient::stop(self : RpcClient) -> Promise[Unit] =
  #| (self) => self.stop()

///|
pub extern "js" fn RpcClient::on_event(
  self : RpcClient,
  listener : RpcEventListener,
) -> () -> Unit =
  #| (self, listener) => self.onEvent(listener)

///|
pub extern "js" fn RpcClient::get_stderr(self : RpcClient) -> String =
  #| (self) => self.getStderr()

///|
pub extern "js" fn RpcClient::prompt(
  self : RpcClient,
  message : String,
  images : Array[ImageContent]?,
) -> Promise[Unit] =
  #| (self, message, images) => self.prompt(message, (images == null ? undefined : (typeof images === "object" && "$tag" in images ? (images.$tag === 1 ? images._0 : undefined) : images)))

///|
pub extern "js" fn RpcClient::steer(
  self : RpcClient,
  message : String,
  images : Array[ImageContent]?,
) -> Promise[Unit] =
  #| (self, message, images) => self.steer(message, (images == null ? undefined : (typeof images === "object" && "$tag" in images ? (images.$tag === 1 ? images._0 : undefined) : images)))

///|
pub extern "js" fn RpcClient::follow_up(
  self : RpcClient,
  message : String,
  images : Array[ImageContent]?,
) -> Promise[Unit] =
  #| (self, message, images) => self.followUp(message, (images == null ? undefined : (typeof images === "object" && "$tag" in images ? (images.$tag === 1 ? images._0 : undefined) : images)))

///|
pub extern "js" fn RpcClient::abort(self : RpcClient) -> Promise[Unit] =
  #| (self) => self.abort()

///|
pub extern "js" fn RpcClient::clear_queue(self : RpcClient) -> Promise[JSValue] =
  #| (self) => self.clearQueue()

///|
pub extern "js" fn RpcClient::new_session(
  self : RpcClient,
  parentSession : String?,
) -> Promise[JSValue] =
  #| (self, parentSession) => self.newSession((parentSession == null ? undefined : (typeof parentSession === "object" && "$tag" in parentSession ? (parentSession.$tag === 1 ? parentSession._0 : undefined) : parentSession)))

///|
pub extern "js" fn RpcClient::get_state(
  self : RpcClient,
) -> Promise[RpcSessionState] =
  #| (self) => self.getState()

///|
pub extern "js" fn RpcClient::set_model(
  self : RpcClient,
  provider : String,
  modelId : String,
) -> Promise[JSValue] =
  #| (self, provider, modelId) => self.setModel(provider, modelId)

///|
pub extern "js" fn RpcClient::cycle_model(
  self : RpcClient,
) -> Promise[JSValue?] =
  #| (self) => self.cycleModel()

///|
pub extern "js" fn RpcClient::get_available_models(
  self : RpcClient,
) -> Promise[Array[ModelInfo]] =
  #| (self) => self.getAvailableModels()

///|
pub extern "js" fn RpcClient::set_thinking_level(
  self : RpcClient,
  level : ThinkingLevel,
) -> Promise[Unit] =
  #| (self, level) => self.setThinkingLevel(level)

///|
pub extern "js" fn RpcClient::cycle_thinking_level(
  self : RpcClient,
) -> Promise[JSValue?] =
  #| (self) => self.cycleThinkingLevel()

///|
pub extern "js" fn RpcClient::get_available_thinking_levels(
  self : RpcClient,
) -> Promise[Array[ThinkingLevel]] =
  #| (self) => self.getAvailableThinkingLevels()

///|
extern "js" fn _rpc_client_set_steering_mode_ret_conv_js(
  this_ : RpcClient,
  mode : String,
) -> Promise[Unit] =
  #| (self, mode) => self.setSteeringMode(mode)

///|
extern "js" fn _rpc_client_set_follow_up_mode_ret_conv_js(
  this_ : RpcClient,
  mode : String,
) -> Promise[Unit] =
  #| (self, mode) => self.setFollowUpMode(mode)

///|
pub extern "js" fn RpcClient::compact(
  self : RpcClient,
  customInstructions : String?,
) -> Promise[CompactionResult[JSValue]] =
  #| (self, customInstructions) => self.compact((customInstructions == null ? undefined : (typeof customInstructions === "object" && "$tag" in customInstructions ? (customInstructions.$tag === 1 ? customInstructions._0 : undefined) : customInstructions)))

///|
pub extern "js" fn RpcClient::set_auto_compaction(
  self : RpcClient,
  enabled : Bool,
) -> Promise[Unit] =
  #| (self, enabled) => self.setAutoCompaction(enabled)

///|
pub extern "js" fn RpcClient::set_auto_retry(
  self : RpcClient,
  enabled : Bool,
) -> Promise[Unit] =
  #| (self, enabled) => self.setAutoRetry(enabled)

///|
pub extern "js" fn RpcClient::abort_retry(self : RpcClient) -> Promise[Unit] =
  #| (self) => self.abortRetry()

///|
pub extern "js" fn RpcClient::bash(
  self : RpcClient,
  command : String,
) -> Promise[BashResult] =
  #| (self, command) => self.bash(command)

///|
pub extern "js" fn RpcClient::abort_bash(self : RpcClient) -> Promise[Unit] =
  #| (self) => self.abortBash()

///|
pub extern "js" fn RpcClient::get_session_stats(
  self : RpcClient,
) -> Promise[SessionStats] =
  #| (self) => self.getSessionStats()

///|
pub extern "js" fn RpcClient::export_html(
  self : RpcClient,
  outputPath : String?,
) -> Promise[JSValue] =
  #| (self, outputPath) => self.exportHtml((outputPath == null ? undefined : (typeof outputPath === "object" && "$tag" in outputPath ? (outputPath.$tag === 1 ? outputPath._0 : undefined) : outputPath)))

///|
pub extern "js" fn RpcClient::switch_session(
  self : RpcClient,
  sessionPath : String,
) -> Promise[JSValue] =
  #| (self, sessionPath) => self.switchSession(sessionPath)

///|
pub extern "js" fn RpcClient::fork(
  self : RpcClient,
  entryId : String,
) -> Promise[JSValue] =
  #| (self, entryId) => self.fork(entryId)

///|
pub extern "js" fn RpcClient::clone(self : RpcClient) -> Promise[JSValue] =
  #| (self) => self.clone()

///|
pub extern "js" fn RpcClient::get_fork_messages(
  self : RpcClient,
) -> Promise[Array[JSValue]] =
  #| (self) => self.getForkMessages()

///|
pub extern "js" fn RpcClient::get_entries(
  self : RpcClient,
  since : String?,
) -> Promise[JSValue] =
  #| (self, since) => self.getEntries((since == null ? undefined : (typeof since === "object" && "$tag" in since ? (since.$tag === 1 ? since._0 : undefined) : since)))

///|
pub extern "js" fn RpcClient::get_tree(self : RpcClient) -> Promise[JSValue] =
  #| (self) => self.getTree()

///|
pub extern "js" fn RpcClient::get_last_assistant_text(
  self : RpcClient,
) -> Promise[String?] =
  #| (self) => self.getLastAssistantText()

///|
pub extern "js" fn RpcClient::set_session_name(
  self : RpcClient,
  name : String,
) -> Promise[Unit] =
  #| (self, name) => self.setSessionName(name)

///|
pub extern "js" fn RpcClient::get_messages(
  self : RpcClient,
) -> Promise[Array[AgentMessage]] =
  #| (self) => self.getMessages()

///|
pub extern "js" fn RpcClient::get_commands(
  self : RpcClient,
) -> Promise[Array[RpcSlashCommand]] =
  #| (self) => self.getCommands()

///|
pub extern "js" fn RpcClient::wait_for_idle(
  self : RpcClient,
  timeout : Double?,
) -> Promise[Unit] =
  #| (self, timeout) => self.waitForIdle((timeout == null ? undefined : (typeof timeout === "object" && "$tag" in timeout ? (timeout.$tag === 1 ? timeout._0 : undefined) : timeout)))

///|
pub extern "js" fn RpcClient::collect_events(
  self : RpcClient,
  timeout : Double?,
) -> Promise[Array[JsonAgentSessionEvent]] =
  #| (self, timeout) => self.collectEvents((timeout == null ? undefined : (typeof timeout === "object" && "$tag" in timeout ? (timeout.$tag === 1 ? timeout._0 : undefined) : timeout)))

///|
pub extern "js" fn RpcClient::prompt_and_wait(
  self : RpcClient,
  message : String,
  images : Array[ImageContent]?,
  timeout : Double?,
) -> Promise[Array[JsonAgentSessionEvent]] =
  #| (self, message, images, timeout) => self.promptAndWait(message, (images == null ? undefined : (typeof images === "object" && "$tag" in images ? (images.$tag === 1 ? images._0 : undefined) : images)), (timeout == null ? undefined : (typeof timeout === "object" && "$tag" in timeout ? (timeout.$tag === 1 ? timeout._0 : undefined) : timeout)))

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_agent_session(
  config : AgentSessionConfig,
) -> AgentSession = "__ts_mbt_new_agent_session"

///|
pub extern "js" fn AgentSession::get_agent_session_agent(
  self : AgentSession,
) -> Agent =
  #| (self) => self.agent

///|
pub extern "js" fn AgentSession::get_agent_session_session_manager(
  self : AgentSession,
) -> SessionManager =
  #| (self) => self.sessionManager

///|
pub extern "js" fn AgentSession::get_agent_session_settings_manager(
  self : AgentSession,
) -> SettingsManager =
  #| (self) => self.settingsManager

///|
pub extern "js" fn AgentSession::get_agent_session_model_runtime(
  self : AgentSession,
) -> ModelRuntime =
  #| (self) => self.modelRuntime

///|
pub extern "js" fn AgentSession::get_agent_session_state(
  self : AgentSession,
) -> AgentState =
  #| (self) => self.state

///|
extern "js" fn _get_agent_session_model_ret_conv_js(
  this_ : AgentSession,
) -> JSValue =
  #| (self) => self.model

///|
pub extern "js" fn AgentSession::get_agent_session_thinking_level(
  self : AgentSession,
) -> ThinkingLevel =
  #| (self) => self.thinkingLevel

///|
pub extern "js" fn AgentSession::get_agent_session_is_streaming(
  self : AgentSession,
) -> Bool =
  #| (self) => self.isStreaming

///|
pub extern "js" fn AgentSession::get_agent_session_is_idle(
  self : AgentSession,
) -> Bool =
  #| (self) => self.isIdle

///|
pub extern "js" fn AgentSession::get_agent_session_system_prompt(
  self : AgentSession,
) -> String =
  #| (self) => self.systemPrompt

///|
pub extern "js" fn AgentSession::get_agent_session_retry_attempt(
  self : AgentSession,
) -> Double =
  #| (self) => self.retryAttempt

///|
pub extern "js" fn AgentSession::get_agent_session_is_compacting(
  self : AgentSession,
) -> Bool =
  #| (self) => self.isCompacting

///|
pub extern "js" fn AgentSession::get_agent_session_messages(
  self : AgentSession,
) -> Array[AgentMessage] =
  #| (self) => self.messages

///|
extern "js" fn _get_agent_session_steering_mode_ret_conv_js(
  this_ : AgentSession,
) -> String =
  #| (self) => self.steeringMode

///|
extern "js" fn _get_agent_session_follow_up_mode_ret_conv_js(
  this_ : AgentSession,
) -> String =
  #| (self) => self.followUpMode

///|
pub extern "js" fn AgentSession::get_agent_session_session_file(
  self : AgentSession,
) -> String? =
  #| (self) => self.sessionFile

///|
pub extern "js" fn AgentSession::get_agent_session_session_id(
  self : AgentSession,
) -> String =
  #| (self) => self.sessionId

///|
pub extern "js" fn AgentSession::get_agent_session_session_name(
  self : AgentSession,
) -> String? =
  #| (self) => self.sessionName

///|
pub extern "js" fn AgentSession::get_agent_session_scoped_models(
  self : AgentSession,
) -> Array[JSValue] =
  #| (self) => self.scopedModels

///|
pub extern "js" fn AgentSession::get_agent_session_prompt_templates(
  self : AgentSession,
) -> Array[PromptTemplate] =
  #| (self) => self.promptTemplates

///|
pub extern "js" fn AgentSession::get_agent_session_pending_message_count(
  self : AgentSession,
) -> Double =
  #| (self) => self.pendingMessageCount

///|
pub extern "js" fn AgentSession::get_agent_session_resource_loader(
  self : AgentSession,
) -> ResourceLoader =
  #| (self) => self.resourceLoader

///|
pub extern "js" fn AgentSession::get_agent_session_auto_compaction_enabled(
  self : AgentSession,
) -> Bool =
  #| (self) => self.autoCompactionEnabled

///|
pub extern "js" fn AgentSession::get_agent_session_is_retrying(
  self : AgentSession,
) -> Bool =
  #| (self) => self.isRetrying

///|
pub extern "js" fn AgentSession::get_agent_session_auto_retry_enabled(
  self : AgentSession,
) -> Bool =
  #| (self) => self.autoRetryEnabled

///|
pub extern "js" fn AgentSession::get_agent_session_is_bash_running(
  self : AgentSession,
) -> Bool =
  #| (self) => self.isBashRunning

///|
pub extern "js" fn AgentSession::get_agent_session_has_pending_bash_messages(
  self : AgentSession,
) -> Bool =
  #| (self) => self.hasPendingBashMessages

///|
pub extern "js" fn AgentSession::get_agent_session_extension_runner(
  self : AgentSession,
) -> ExtensionRunner =
  #| (self) => self.extensionRunner

///|
pub extern "js" fn AgentSession::model_runtime(
  self : AgentSession,
) -> ModelRuntime =
  #| (self) => self.modelRuntime()

///|
pub extern "js" fn AgentSession::subscribe(
  self : AgentSession,
  listener : AgentSessionEventListener,
) -> () -> Unit =
  #| (self, listener) => self.subscribe(listener)

///|
pub extern "js" fn AgentSession::dispose(self : AgentSession) -> Unit =
  #| (self) => self.dispose()

///|
pub extern "js" fn AgentSession::state(self : AgentSession) -> AgentState =
  #| (self) => self.state()

///|
extern "js" fn _agent_session_model_ret_conv_js(
  this_ : AgentSession,
) -> JSValue =
  #| (self) => self.model()

///|
pub extern "js" fn AgentSession::thinking_level(
  self : AgentSession,
) -> ThinkingLevel =
  #| (self) => self.thinkingLevel()

///|
pub extern "js" fn AgentSession::is_streaming(self : AgentSession) -> Bool =
  #| (self) => self.isStreaming()

///|
pub extern "js" fn AgentSession::is_idle(self : AgentSession) -> Bool =
  #| (self) => self.isIdle()

///|
pub extern "js" fn AgentSession::system_prompt(self : AgentSession) -> String =
  #| (self) => self.systemPrompt()

///|
pub extern "js" fn AgentSession::retry_attempt(self : AgentSession) -> Double =
  #| (self) => self.retryAttempt()

///|
pub extern "js" fn AgentSession::get_active_tool_names(
  self : AgentSession,
) -> Array[String] =
  #| (self) => self.getActiveToolNames()

///|
pub extern "js" fn AgentSession::get_all_tools(
  self : AgentSession,
) -> Array[ToolInfo] =
  #| (self) => self.getAllTools()

///|
pub extern "js" fn AgentSession::get_tool_definition(
  self : AgentSession,
  name : String,
) -> ToolDefinition[JSValue, JSValue, JSValue]? =
  #| (self, name) => self.getToolDefinition(name)

///|
pub extern "js" fn AgentSession::set_active_tools_by_name(
  self : AgentSession,
  toolNames : Array[String],
) -> Unit =
  #| (self, toolNames) => self.setActiveToolsByName(toolNames)

///|
pub extern "js" fn AgentSession::is_compacting(self : AgentSession) -> Bool =
  #| (self) => self.isCompacting()

///|
pub extern "js" fn AgentSession::messages(
  self : AgentSession,
) -> Array[AgentMessage] =
  #| (self) => self.messages()

///|
extern "js" fn _agent_session_steering_mode_ret_conv_js(
  this_ : AgentSession,
) -> String =
  #| (self) => self.steeringMode()

///|
extern "js" fn _agent_session_follow_up_mode_ret_conv_js(
  this_ : AgentSession,
) -> String =
  #| (self) => self.followUpMode()

///|
pub extern "js" fn AgentSession::session_file(self : AgentSession) -> String? =
  #| (self) => self.sessionFile()

///|
pub extern "js" fn AgentSession::session_id(self : AgentSession) -> String =
  #| (self) => self.sessionId()

///|
pub extern "js" fn AgentSession::session_name(self : AgentSession) -> String? =
  #| (self) => self.sessionName()

///|
pub extern "js" fn AgentSession::scoped_models(
  self : AgentSession,
) -> Array[JSValue] =
  #| (self) => self.scopedModels()

///|
pub extern "js" fn AgentSession::set_scoped_models(
  self : AgentSession,
  scopedModels : Array[JSValue],
) -> Unit =
  #| (self, scopedModels) => self.setScopedModels(scopedModels)

///|
pub extern "js" fn AgentSession::prompt_templates(
  self : AgentSession,
) -> Array[PromptTemplate] =
  #| (self) => self.promptTemplates()

///|
pub extern "js" fn AgentSession::prompt(
  self : AgentSession,
  text : String,
  options : PromptOptions?,
) -> Promise[Unit] =
  #| (self, text, options) => self.prompt(text, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::steer(
  self : AgentSession,
  text : String,
  images : Array[ImageContent]?,
) -> Promise[Unit] =
  #| (self, text, images) => self.steer(text, (images == null ? undefined : (typeof images === "object" && "$tag" in images ? (images.$tag === 1 ? images._0 : undefined) : images)))

///|
pub extern "js" fn AgentSession::follow_up(
  self : AgentSession,
  text : String,
  images : Array[ImageContent]?,
) -> Promise[Unit] =
  #| (self, text, images) => self.followUp(text, (images == null ? undefined : (typeof images === "object" && "$tag" in images ? (images.$tag === 1 ? images._0 : undefined) : images)))

///|
pub extern "js" fn AgentSession::send_custom_message(
  self : AgentSession,
  message : Pick,
  options : AgentSessionSendCustomMessageOptions?,
) -> Promise[Unit] =
  #| (self, message, options) => self.sendCustomMessage(message, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::send_user_message(
  self : AgentSession,
  content : JSValue,
  options : AgentSessionSendUserMessageOptions?,
) -> Promise[Unit] =
  #| (self, content, options) => self.sendUserMessage(content, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::clear_queue(self : AgentSession) -> JSValue =
  #| (self) => self.clearQueue()

///|
pub extern "js" fn AgentSession::pending_message_count(
  self : AgentSession,
) -> Double =
  #| (self) => self.pendingMessageCount()

///|
pub extern "js" fn AgentSession::get_steering_messages(
  self : AgentSession,
) -> Array[String] =
  #| (self) => self.getSteeringMessages()

///|
pub extern "js" fn AgentSession::get_follow_up_messages(
  self : AgentSession,
) -> Array[String] =
  #| (self) => self.getFollowUpMessages()

///|
pub extern "js" fn AgentSession::resource_loader(
  self : AgentSession,
) -> ResourceLoader =
  #| (self) => self.resourceLoader()

///|
pub extern "js" fn AgentSession::abort(self : AgentSession) -> Promise[Unit] =
  #| (self) => self.abort()

///|
pub extern "js" fn AgentSession::wait_for_idle(
  self : AgentSession,
) -> Promise[Unit] =
  #| (self) => self.waitForIdle()

///|
pub extern "js" fn AgentSession::set_model(
  self : AgentSession,
  model : Model[JSValue],
  options : ModelMutationOptions?,
) -> Promise[Unit] =
  #| (self, model, options) => self.setModel(model, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
extern "js" fn _agent_session_cycle_model_ret_conv_js(
  this_ : AgentSession,
  direction : String?,
  options : ModelMutationOptions?,
) -> Promise[ModelCycleResult?] =
  #| (self, direction, options) => self.cycleModel((direction == null ? undefined : (typeof direction === "object" && "$tag" in direction ? (direction.$tag === 1 ? direction._0 : undefined) : direction)), (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::set_thinking_level(
  self : AgentSession,
  level : ThinkingLevel,
  options : ModelMutationOptions?,
) -> Unit =
  #| (self, level, options) => self.setThinkingLevel(level, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
extern "js" fn _agent_session_cycle_thinking_level_ret_conv_js(
  this_ : AgentSession,
  options : ModelMutationOptions?,
) -> JSValue =
  #| (self, options) => self.cycleThinkingLevel((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::get_available_thinking_levels(
  self : AgentSession,
) -> Array[ThinkingLevel] =
  #| (self) => self.getAvailableThinkingLevels()

///|
pub extern "js" fn AgentSession::supports_thinking(self : AgentSession) -> Bool =
  #| (self) => self.supportsThinking()

///|
extern "js" fn _agent_session_set_steering_mode_ret_conv_js(
  this_ : AgentSession,
  mode : String,
) -> Unit =
  #| (self, mode) => self.setSteeringMode(mode)

///|
extern "js" fn _agent_session_set_follow_up_mode_ret_conv_js(
  this_ : AgentSession,
  mode : String,
) -> Unit =
  #| (self, mode) => self.setFollowUpMode(mode)

///|
pub extern "js" fn AgentSession::compact(
  self : AgentSession,
  customInstructions : String?,
) -> Promise[CompactionResult[JSValue]] =
  #| (self, customInstructions) => self.compact((customInstructions == null ? undefined : (typeof customInstructions === "object" && "$tag" in customInstructions ? (customInstructions.$tag === 1 ? customInstructions._0 : undefined) : customInstructions)))

///|
pub extern "js" fn AgentSession::abort_compaction(self : AgentSession) -> Unit =
  #| (self) => self.abortCompaction()

///|
pub extern "js" fn AgentSession::abort_branch_summary(
  self : AgentSession,
) -> Unit =
  #| (self) => self.abortBranchSummary()

///|
pub extern "js" fn AgentSession::set_auto_compaction_enabled(
  self : AgentSession,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setAutoCompactionEnabled(enabled)

///|
pub extern "js" fn AgentSession::auto_compaction_enabled(
  self : AgentSession,
) -> Bool =
  #| (self) => self.autoCompactionEnabled()

///|
pub extern "js" fn AgentSession::bind_extensions(
  self : AgentSession,
  bindings : ExtensionBindings,
) -> Promise[Unit] =
  #| (self, bindings) => self.bindExtensions(bindings)

///|
pub extern "js" fn AgentSession::reload(
  self : AgentSession,
  options : AgentSessionReloadOptions?,
) -> Promise[Unit] =
  #| (self, options) => self.reload((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::abort_retry(self : AgentSession) -> Unit =
  #| (self) => self.abortRetry()

///|
pub extern "js" fn AgentSession::is_retrying(self : AgentSession) -> Bool =
  #| (self) => self.isRetrying()

///|
pub extern "js" fn AgentSession::auto_retry_enabled(
  self : AgentSession,
) -> Bool =
  #| (self) => self.autoRetryEnabled()

///|
pub extern "js" fn AgentSession::set_auto_retry_enabled(
  self : AgentSession,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setAutoRetryEnabled(enabled)

///|
pub extern "js" fn AgentSession::execute_bash(
  self : AgentSession,
  command : String,
  onChunk : ((String) -> Unit)?,
  options : AgentSessionExecuteBashOptions?,
) -> Promise[BashResult] =
  #| (self, command, onChunk, options) => self.executeBash(command, (onChunk == null ? undefined : (typeof onChunk === "object" && "$tag" in onChunk ? (onChunk.$tag === 1 ? onChunk._0 : undefined) : onChunk)), (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::record_bash_result(
  self : AgentSession,
  command : String,
  result : BashResult,
  options : AgentSessionRecordBashResultOptions?,
) -> Unit =
  #| (self, command, result, options) => self.recordBashResult(command, result, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::abort_bash(self : AgentSession) -> Unit =
  #| (self) => self.abortBash()

///|
pub extern "js" fn AgentSession::is_bash_running(self : AgentSession) -> Bool =
  #| (self) => self.isBashRunning()

///|
pub extern "js" fn AgentSession::has_pending_bash_messages(
  self : AgentSession,
) -> Bool =
  #| (self) => self.hasPendingBashMessages()

///|
pub extern "js" fn AgentSession::set_session_name(
  self : AgentSession,
  name : String,
) -> Unit =
  #| (self, name) => self.setSessionName(name)

///|
pub extern "js" fn AgentSession::navigate_tree(
  self : AgentSession,
  targetId : String,
  options : AgentSessionNavigateTreeOptions?,
) -> Promise[JSValue] =
  #| (self, targetId, options) => self.navigateTree(targetId, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::get_user_messages_for_forking(
  self : AgentSession,
) -> Array[JSValue] =
  #| (self) => self.getUserMessagesForForking()

///|
pub extern "js" fn AgentSession::get_session_stats(
  self : AgentSession,
) -> SessionStats =
  #| (self) => self.getSessionStats()

///|
pub extern "js" fn AgentSession::get_context_usage(
  self : AgentSession,
) -> ContextUsage? =
  #| (self) => self.getContextUsage()

///|
pub extern "js" fn AgentSession::export_to_html(
  self : AgentSession,
  outputPath : String?,
  options : AgentSessionExportToHtmlOptions?,
) -> Promise[String] =
  #| (self, outputPath, options) => self.exportToHtml((outputPath == null ? undefined : (typeof outputPath === "object" && "$tag" in outputPath ? (outputPath.$tag === 1 ? outputPath._0 : undefined) : outputPath)), (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSession::export_to_jsonl(
  self : AgentSession,
  outputPath : String?,
) -> String =
  #| (self, outputPath) => self.exportToJsonl((outputPath == null ? undefined : (typeof outputPath === "object" && "$tag" in outputPath ? (outputPath.$tag === 1 ? outputPath._0 : undefined) : outputPath)))

///|
pub extern "js" fn AgentSession::get_last_assistant_text(
  self : AgentSession,
) -> String? =
  #| (self) => self.getLastAssistantText()

///|
pub extern "js" fn AgentSession::create_replaced_session_context(
  self : AgentSession,
) -> ReplacedSessionContext =
  #| (self) => self.createReplacedSessionContext()

///|
pub extern "js" fn AgentSession::has_extension_handlers(
  self : AgentSession,
  eventType : String,
) -> Bool =
  #| (self, eventType) => self.hasExtensionHandlers(eventType)

///|
pub extern "js" fn AgentSession::extension_runner(
  self : AgentSession,
) -> ExtensionRunner =
  #| (self) => self.extensionRunner()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_custom_editor(
  tui : TUI,
  theme : EditorTheme,
  keybindings : KeybindingsManager,
  options : CustomEditorOptions?,
) -> CustomEditor = "__ts_mbt_new_custom_editor"

///|
pub extern "js" fn CustomEditor::get_custom_editor_embed_working_status(
  self : CustomEditor,
) -> Bool =
  #| (self) => self.embedWorkingStatus

///|
pub extern "js" fn CustomEditor::get_custom_editor_action_handlers(
  self : CustomEditor,
) -> Map =
  #| (self) => self.actionHandlers

///|
pub extern "js" fn CustomEditor::set_custom_editor_action_handlers(
  self : CustomEditor,
  value : Map,
) -> Unit =
  #| (self, value) => (self.actionHandlers = value)

///|
pub extern "js" fn CustomEditor::get_custom_editor_on_escape(
  self : CustomEditor,
) -> () -> Unit =
  #| (self) => self.onEscape

///|
pub extern "js" fn CustomEditor::set_custom_editor_on_escape(
  self : CustomEditor,
  value : () -> Unit,
) -> Unit =
  #| (self, value) => (self.onEscape = value)

///|
pub extern "js" fn CustomEditor::get_custom_editor_on_ctrl_d(
  self : CustomEditor,
) -> () -> Unit =
  #| (self) => self.onCtrlD

///|
pub extern "js" fn CustomEditor::set_custom_editor_on_ctrl_d(
  self : CustomEditor,
  value : () -> Unit,
) -> Unit =
  #| (self, value) => (self.onCtrlD = value)

///|
pub extern "js" fn CustomEditor::get_custom_editor_on_paste_image(
  self : CustomEditor,
) -> () -> Unit =
  #| (self) => self.onPasteImage

///|
pub extern "js" fn CustomEditor::set_custom_editor_on_paste_image(
  self : CustomEditor,
  value : () -> Unit,
) -> Unit =
  #| (self, value) => (self.onPasteImage = value)

///|
pub extern "js" fn CustomEditor::get_custom_editor_on_extension_shortcut(
  self : CustomEditor,
) -> (String) -> Bool =
  #| (self) => self.onExtensionShortcut

///|
pub extern "js" fn CustomEditor::set_custom_editor_on_extension_shortcut(
  self : CustomEditor,
  value : (String) -> Bool,
) -> Unit =
  #| (self, value) => (self.onExtensionShortcut = value)

///|
pub extern "js" fn CustomEditor::on_escape(self : CustomEditor) -> Unit =
  #| (self) => self.onEscape()

///|
pub extern "js" fn CustomEditor::on_ctrl_d(self : CustomEditor) -> Unit =
  #| (self) => self.onCtrlD()

///|
pub extern "js" fn CustomEditor::on_paste_image(self : CustomEditor) -> Unit =
  #| (self) => self.onPasteImage()

///|
pub extern "js" fn CustomEditor::on_extension_shortcut(
  self : CustomEditor,
  arg0 : String,
) -> Bool =
  #| (self, arg0) => self.onExtensionShortcut(arg0)

///|
pub extern "js" fn CustomEditor::set_working_status_indicator(
  self : CustomEditor,
  indicator : WorkingStatusIndicator?,
) -> Unit =
  #| (self, indicator) => self.setWorkingStatusIndicator((indicator == null ? undefined : (typeof indicator === "object" && "$tag" in indicator ? (indicator.$tag === 1 ? indicator._0 : undefined) : indicator)))

///|
extern "js" fn _custom_editor_on_action_ret_conv_js(
  this_ : CustomEditor,
  action : String,
  handler : () -> Unit,
) -> Unit =
  #| (self, action, handler) => self.onAction(action, handler)

///|
pub extern "js" fn CustomEditor::handle_input(
  self : CustomEditor,
  data : String,
) -> Unit =
  #| (self, data) => self.handleInput(data)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn model_runtime_create(
  options : CreateModelRuntimeOptions?,
) -> Promise[ModelRuntime] = "__ts_mbt_model_runtime_create"

///|
pub extern "js" fn ModelRuntime::get_providers(
  self : ModelRuntime,
) -> Array[Provider[JSValue]] =
  #| (self) => self.getProviders()

///|
extern "js" fn _model_runtime_get_provider_ret_conv_js(
  this_ : ModelRuntime,
  providerId : String,
) -> JSValue =
  #| (self, providerId) => self.getProvider(providerId)

///|
pub extern "js" fn ModelRuntime::get_models(
  self : ModelRuntime,
  providerId : String?,
) -> Array[Model[Api]] =
  #| (self, providerId) => self.getModels((providerId == null ? undefined : (typeof providerId === "object" && "$tag" in providerId ? (providerId.$tag === 1 ? providerId._0 : undefined) : providerId)))

///|
extern "js" fn _model_runtime_get_model_ret_conv_js(
  this_ : ModelRuntime,
  providerId : String,
  modelId : String,
) -> JSValue =
  #| (self, providerId, modelId) => self.getModel(providerId, modelId)

///|
pub extern "js" fn ModelRuntime::check_auth(
  self : ModelRuntime,
  providerId : String,
  options : AuthOperationOptions?,
) -> Promise[AuthCheck?] =
  #| (self, providerId, options) => self.checkAuth(providerId, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::get_available(
  self : ModelRuntime,
  providerId : String?,
  options : AuthOperationOptions?,
) -> Promise[Array[Model[Api]]] =
  #| (self, providerId, options) => self.getAvailable((providerId == null ? undefined : (typeof providerId === "object" && "$tag" in providerId ? (providerId.$tag === 1 ? providerId._0 : undefined) : providerId)), (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::get_available_snapshot(
  self : ModelRuntime,
) -> Array[Model[Api]] =
  #| (self) => self.getAvailableSnapshot()

///|
pub extern "js" fn ModelRuntime::get_error(self : ModelRuntime) -> String? =
  #| (self) => self.getError()

///|
pub extern "js" fn ModelRuntime::get_registered_provider_config(
  self : ModelRuntime,
  providerId : String,
) -> ProviderConfigInput? =
  #| (self, providerId) => self.getRegisteredProviderConfig(providerId)

///|
pub extern "js" fn ModelRuntime::get_registered_provider_ids(
  self : ModelRuntime,
) -> Array[String] =
  #| (self) => self.getRegisteredProviderIds()

///|
extern "js" fn _model_runtime_get_registered_native_provider_ret_conv_js(
  this_ : ModelRuntime,
  providerId : String,
) -> JSValue =
  #| (self, providerId) => self.getRegisteredNativeProvider(providerId)

///|
pub extern "js" fn ModelRuntime::get_compatibility_request_config(
  self : ModelRuntime,
  model : Model[Api],
) -> CompatibilityRequestConfig =
  #| (self, model) => self.getCompatibilityRequestConfig(model)

///|
pub extern "js" fn ModelRuntime::is_using_oauth(
  self : ModelRuntime,
  providerId : String,
) -> Bool =
  #| (self, providerId) => self.isUsingOAuth(providerId)

///|
pub extern "js" fn ModelRuntime::is_using_subscription(
  self : ModelRuntime,
  providerId : String,
) -> Bool =
  #| (self, providerId) => self.isUsingSubscription(providerId)

///|
pub extern "js" fn ModelRuntime::has_configured_auth(
  self : ModelRuntime,
  providerId : String,
) -> Bool =
  #| (self, providerId) => self.hasConfiguredAuth(providerId)

///|
pub extern "js" fn ModelRuntime::get_auth(
  self : ModelRuntime,
  providerId : String,
  overrides : ModelRuntimeAuthOverrides?,
) -> Promise[AuthResult?] =
  #| (self, providerId, overrides) => self.getAuth(providerId, (overrides == null ? undefined : (typeof overrides === "object" && "$tag" in overrides ? (overrides.$tag === 1 ? overrides._0 : undefined) : overrides)))

///|
pub extern "js" fn ModelRuntime::set_runtime_api_key(
  self : ModelRuntime,
  providerId : String,
  apiKey : String,
  options : AuthOperationOptions?,
) -> Promise[Unit] =
  #| (self, providerId, apiKey, options) => self.setRuntimeApiKey(providerId, apiKey, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::remove_runtime_api_key(
  self : ModelRuntime,
  providerId : String,
  options : AuthOperationOptions?,
) -> Promise[Unit] =
  #| (self, providerId, options) => self.removeRuntimeApiKey(providerId, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::list_credentials(
  self : ModelRuntime,
  options : AuthOperationOptions?,
) -> Promise[Array[CredentialInfo]] =
  #| (self, options) => self.listCredentials((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::get_provider_auth_status(
  self : ModelRuntime,
  providerId : String,
) -> AuthStatus =
  #| (self, providerId) => self.getProviderAuthStatus(providerId)

///|
pub extern "js" fn ModelRuntime::stream(
  self : ModelRuntime,
  model : Model[Api],
  context : Context,
  options : ModelsApiStreamOptions?,
) -> AssistantMessageEventStream =
  #| (self, model, context, options) => self.stream(model, context, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::complete(
  self : ModelRuntime,
  model : Model[Api],
  context : Context,
  options : ModelsApiStreamOptions?,
) -> Promise[AssistantMessage] =
  #| (self, model, context, options) => self.complete(model, context, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::stream_simple(
  self : ModelRuntime,
  model : Model[Api],
  context : Context,
  options : ModelsSimpleStreamOptions?,
) -> AssistantMessageEventStream =
  #| (self, model, context, options) => self.streamSimple(model, context, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::complete_simple(
  self : ModelRuntime,
  model : Model[Api],
  context : Context,
  options : ModelsSimpleStreamOptions?,
) -> Promise[AssistantMessage] =
  #| (self, model, context, options) => self.completeSimple(model, context, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::stream_deferred(
  self : ModelRuntime,
  model : Model[Api],
  handle : DeferredHandle,
  options : ModelsDeferredFetchOptions?,
) -> AssistantMessageEventStream =
  #| (self, model, handle, options) => self.streamDeferred(model, handle, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::fetch_deferred(
  self : ModelRuntime,
  model : Model[Api],
  handle : DeferredHandle,
  options : ModelsDeferredFetchOptions?,
) -> Promise[AssistantMessage] =
  #| (self, model, handle, options) => self.fetchDeferred(model, handle, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::cancel_deferred(
  self : ModelRuntime,
  model : Model[Api],
  handle : DeferredHandle,
  options : ModelsDeferredCancelOptions?,
) -> Promise[Unit] =
  #| (self, model, handle, options) => self.cancelDeferred(model, handle, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::login(
  self : ModelRuntime,
  providerId : String,
  type_ : AuthType,
  interaction : AuthInteraction,
) -> Promise[Credential] =
  #| (self, providerId, type_, interaction) => self.login(providerId, type_, interaction)

///|
pub extern "js" fn ModelRuntime::logout(
  self : ModelRuntime,
  providerId : String,
  options : AuthOperationOptions?,
) -> Promise[Unit] =
  #| (self, providerId, options) => self.logout(providerId, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::refresh(
  self : ModelRuntime,
  options : ModelsRefreshOptions?,
) -> Promise[ModelsRefreshResult] =
  #| (self, options) => self.refresh((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRuntime::register_native_provider(
  self : ModelRuntime,
  provider : Provider[JSValue],
) -> Unit =
  #| (self, provider) => self.registerNativeProvider(provider)

///|
pub extern "js" fn ModelRuntime::register_provider(
  self : ModelRuntime,
  providerId : String,
  config : ProviderConfigInput,
) -> Unit =
  #| (self, providerId, config) => self.registerProvider(providerId, config)

///|
pub extern "js" fn ModelRuntime::unregister_provider(
  self : ModelRuntime,
  providerId : String,
) -> Unit =
  #| (self, providerId) => self.unregisterProvider(providerId)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_dynamic_border(
  color : ((String) -> String)?,
) -> DynamicBorder = "__ts_mbt_new_dynamic_border"

///|
pub extern "js" fn DynamicBorder::invalidate(self : DynamicBorder) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn DynamicBorder::render(
  self : DynamicBorder,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_model_registry(runtime : ModelRuntime) -> ModelRegistry = "__ts_mbt_new_model_registry"

///|
pub extern "js" fn ModelRegistry::refresh(
  self : ModelRegistry,
  options : ModelsRefreshOptions?,
) -> Promise[ModelsRefreshResult] =
  #| (self, options) => self.refresh((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRegistry::get_error(self : ModelRegistry) -> String? =
  #| (self) => self.getError()

///|
pub extern "js" fn ModelRegistry::get_all(
  self : ModelRegistry,
) -> Array[Model[Api]] =
  #| (self) => self.getAll()

///|
pub extern "js" fn ModelRegistry::get_available(
  self : ModelRegistry,
) -> Array[Model[Api]] =
  #| (self) => self.getAvailable()

///|
extern "js" fn _model_registry_find_ret_conv_js(
  this_ : ModelRegistry,
  provider : String,
  modelId : String,
) -> JSValue =
  #| (self, provider, modelId) => self.find(provider, modelId)

///|
pub extern "js" fn ModelRegistry::has_configured_auth(
  self : ModelRegistry,
  model : Model[Api],
) -> Bool =
  #| (self, model) => self.hasConfiguredAuth(model)

///|
pub extern "js" fn ModelRegistry::get_api_key_and_headers(
  self : ModelRegistry,
  model : Model[Api],
) -> Promise[ResolvedRequestAuth] =
  #| (self, model) => self.getApiKeyAndHeaders(model)

///|
pub extern "js" fn ModelRegistry::get_provider_auth_status(
  self : ModelRegistry,
  provider : String,
) -> AuthStatus =
  #| (self, provider) => self.getProviderAuthStatus(provider)

///|
extern "js" fn _model_registry_get_provider_ret_conv_js(
  this_ : ModelRegistry,
  provider : String,
) -> JSValue =
  #| (self, provider) => self.getProvider(provider)

///|
pub extern "js" fn ModelRegistry::complete(
  self : ModelRegistry,
  model : Model[Api],
  context : Context,
  options : ModelsApiStreamOptions?,
) -> Promise[AssistantMessage] =
  #| (self, model, context, options) => self.complete(model, context, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn ModelRegistry::get_provider_display_name(
  self : ModelRegistry,
  provider : String,
) -> String =
  #| (self, provider) => self.getProviderDisplayName(provider)

///|
pub extern "js" fn ModelRegistry::get_provider_auth(
  self : ModelRegistry,
  provider : String,
) -> Promise[AuthResult?] =
  #| (self, provider) => self.getProviderAuth(provider)

///|
pub extern "js" fn ModelRegistry::get_api_key_for_provider(
  self : ModelRegistry,
  provider : String,
) -> Promise[String?] =
  #| (self, provider) => self.getApiKeyForProvider(provider)

///|
pub extern "js" fn ModelRegistry::is_using_oauth(
  self : ModelRegistry,
  model : Model[Api],
) -> Bool =
  #| (self, model) => self.isUsingOAuth(model)

///|
pub extern "js" fn ModelRegistry::register_provider(
  self : ModelRegistry,
  provider : Provider[JSValue],
) -> Unit =
  #| (self, provider) => self.registerProvider(provider)

///|
pub extern "js" fn ModelRegistry::unregister_provider(
  self : ModelRegistry,
  providerName : String,
) -> Unit =
  #| (self, providerName) => self.unregisterProvider(providerName)

///|
pub extern "js" fn ModelRegistry::get_registered_provider_config(
  self : ModelRegistry,
  providerName : String,
) -> ProviderConfigInput? =
  #| (self, providerName) => self.getRegisteredProviderConfig(providerName)

///|
extern "js" fn _model_registry_get_registered_native_provider_ret_conv_js(
  this_ : ModelRegistry,
  providerName : String,
) -> JSValue =
  #| (self, providerName) => self.getRegisteredNativeProvider(providerName)

///|
pub extern "js" fn ModelRegistry::get_registered_provider_ids(
  self : ModelRegistry,
) -> Array[String] =
  #| (self) => self.getRegisteredProviderIds()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_armin_component(ui : TUI) -> ArminComponent = "__ts_mbt_new_armin_component"

///|
pub extern "js" fn ArminComponent::invalidate(self : ArminComponent) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn ArminComponent::render(
  self : ArminComponent,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn ArminComponent::dispose(self : ArminComponent) -> Unit =
  #| (self) => self.dispose()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_bordered_loader(
  tui : TUI,
  theme : Theme,
  message : String,
  options : JSValue?,
) -> BorderedLoader = "__ts_mbt_new_bordered_loader"

///|
pub extern "js" fn BorderedLoader::get_bordered_loader_signal(
  self : BorderedLoader,
) -> AbortSignal =
  #| (self) => self.signal

///|
extern "js" fn _get_bordered_loader_on_abort_ret_conv_js(
  this_ : BorderedLoader,
) -> JSValue =
  #| (self) => self.onAbort

///|
pub extern "js" fn BorderedLoader::set_bordered_loader_on_abort(
  self : BorderedLoader,
  value : (() -> Unit)?,
) -> Unit =
  #| (self, value) => (self.onAbort = (value == null ? undefined : (typeof value === "object" && "$tag" in value ? (value.$tag === 1 ? value._0 : undefined) : value)))

///|
pub extern "js" fn BorderedLoader::signal(self : BorderedLoader) -> AbortSignal =
  #| (self) => self.signal()

///|
pub extern "js" fn BorderedLoader::on_abort(
  self : BorderedLoader,
  fn_ : (() -> Unit)?,
) -> Unit =
  #| (self, fn_) => self.onAbort((fn_ == null ? undefined : (typeof fn_ === "object" && "$tag" in fn_ ? (fn_.$tag === 1 ? fn_._0 : undefined) : fn_)))

///|
pub extern "js" fn BorderedLoader::handle_input(
  self : BorderedLoader,
  data : String,
) -> Unit =
  #| (self, data) => self.handleInput(data)

///|
pub extern "js" fn BorderedLoader::dispose(self : BorderedLoader) -> Unit =
  #| (self) => self.dispose()

///|
pub extern "js" fn SessionManager::set_session_file(
  self : SessionManager,
  sessionFile : String,
) -> Unit =
  #| (self, sessionFile) => self.setSessionFile(sessionFile)

///|
pub extern "js" fn SessionManager::new_session(
  self : SessionManager,
  options : NewSessionOptions?,
) -> String? =
  #| (self, options) => self.newSession((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn SessionManager::is_persisted(self : SessionManager) -> Bool =
  #| (self) => self.isPersisted()

///|
pub extern "js" fn SessionManager::get_cwd(self : SessionManager) -> String =
  #| (self) => self.getCwd()

///|
pub extern "js" fn SessionManager::get_session_dir(
  self : SessionManager,
) -> String =
  #| (self) => self.getSessionDir()

///|
pub extern "js" fn SessionManager::uses_default_session_dir(
  self : SessionManager,
) -> Bool =
  #| (self) => self.usesDefaultSessionDir()

///|
pub extern "js" fn SessionManager::get_session_id(
  self : SessionManager,
) -> String =
  #| (self) => self.getSessionId()

///|
pub extern "js" fn SessionManager::get_session_file(
  self : SessionManager,
) -> String? =
  #| (self) => self.getSessionFile()

///|
pub extern "js" fn SessionManager::persist(
  self : SessionManager,
  entry : SessionEntry,
) -> Unit =
  #| (self, entry) => self._persist((() => { if (entry === null || typeof entry !== "object" || !("$tag" in entry)) return entry; if (entry.$tag === 0) return __ts_mbt_to_js_session_message_entry(entry._0); else if (entry.$tag === 1) return __ts_mbt_to_js_thinking_level_change_entry(entry._0); else if (entry.$tag === 2) return __ts_mbt_to_js_model_change_entry(entry._0); else if (entry.$tag === 3) return __ts_mbt_to_js_compaction_entry(entry._0); else if (entry.$tag === 4) return __ts_mbt_to_js_branch_summary_entry(entry._0); else if (entry.$tag === 5) return __ts_mbt_to_js_custom_entry(entry._0); else if (entry.$tag === 6) return __ts_mbt_to_js_custom_message_entry(entry._0); else if (entry.$tag === 7) return entry._0; else if (entry.$tag === 8) return __ts_mbt_to_js_session_info_entry(entry._0); throw new Error("unexpected SessionEntry tag: " + entry.$tag); })())

///|
pub extern "js" fn SessionManager::append_message(
  self : SessionManager,
  message : Auto_MessageValue_or_CustomMessageValue_or_BashExecutionMessageValue,
) -> String =
  #| (self, message) => self.appendMessage((() => { if (message === null || typeof message !== "object" || !("$tag" in message)) return message; if (message.$tag === 0) return message._0; else if (message.$tag === 1) return __ts_mbt_to_js_custom_message(message._0); else if (message.$tag === 2) return __ts_mbt_to_js_bash_execution_message(message._0); throw new Error("unexpected Auto_MessageValue_or_CustomMessageValue_or_BashExecutionMessageValue tag: " + message.$tag); })())

///|
pub extern "js" fn SessionManager::append_thinking_level_change(
  self : SessionManager,
  thinkingLevel : String,
) -> String =
  #| (self, thinkingLevel) => self.appendThinkingLevelChange(thinkingLevel)

///|
pub extern "js" fn SessionManager::append_model_change(
  self : SessionManager,
  provider : String,
  modelId : String,
) -> String =
  #| (self, provider, modelId) => self.appendModelChange(provider, modelId)

///|
pub extern "js" fn SessionManager::append_compaction(
  self : SessionManager,
  summary : String,
  firstKeptEntryId : String,
  tokensBefore : Double,
  details : JSValue?,
  fromHook : Bool?,
  usage : Usage?,
) -> String =
  #| (self, summary, firstKeptEntryId, tokensBefore, details, fromHook, usage) => self.appendCompaction(summary, firstKeptEntryId, tokensBefore, (details == null ? undefined : (typeof details === "object" && "$tag" in details ? (details.$tag === 1 ? details._0 : undefined) : details)), (fromHook === -1 ? undefined : (fromHook == null ? undefined : (typeof fromHook === "object" && "$tag" in fromHook ? (fromHook.$tag === 1 ? fromHook._0 : undefined) : fromHook))), (usage == null ? undefined : (typeof usage === "object" && "$tag" in usage ? (usage.$tag === 1 ? usage._0 : undefined) : usage)))

///|
pub extern "js" fn SessionManager::append_custom_entry(
  self : SessionManager,
  customType : String,
  data : JSValue?,
) -> String =
  #| (self, customType, data) => self.appendCustomEntry(customType, (data == null ? undefined : (typeof data === "object" && "$tag" in data ? (data.$tag === 1 ? data._0 : undefined) : data)))

///|
pub extern "js" fn SessionManager::append_session_info(
  self : SessionManager,
  name : String,
) -> String =
  #| (self, name) => self.appendSessionInfo(name)

///|
pub extern "js" fn SessionManager::get_session_name(
  self : SessionManager,
) -> String? =
  #| (self) => self.getSessionName()

///|
pub extern "js" fn SessionManager::append_custom_message_entry(
  self : SessionManager,
  customType : String,
  content : JSValue,
  display : Bool,
  details : JSValue?,
) -> String =
  #| (self, customType, content, display, details) => self.appendCustomMessageEntry(customType, content, display, (details == null ? undefined : (typeof details === "object" && "$tag" in details ? (details.$tag === 1 ? details._0 : undefined) : details)))

///|
pub extern "js" fn SessionManager::get_leaf_id(
  self : SessionManager,
) -> String? =
  #| (self) => self.getLeafId()

///|
pub extern "js" fn SessionManager::get_leaf_entry(
  self : SessionManager,
) -> SessionEntry? =
  #| (self) => self.getLeafEntry()

///|
pub extern "js" fn SessionManager::get_entry(
  self : SessionManager,
  id : String,
) -> SessionEntry? =
  #| (self, id) => self.getEntry(id)

///|
pub extern "js" fn SessionManager::get_children(
  self : SessionManager,
  parentId : String,
) -> Array[SessionEntry] =
  #| (self, parentId) => self.getChildren(parentId)

///|
pub extern "js" fn SessionManager::get_label(
  self : SessionManager,
  id : String,
) -> String? =
  #| (self, id) => self.getLabel(id)

///|
pub extern "js" fn SessionManager::append_label_change(
  self : SessionManager,
  targetId : String,
  label : String?,
) -> String =
  #| (self, targetId, label) => self.appendLabelChange(targetId, (label == null ? undefined : (typeof label === "object" && "$tag" in label ? (label.$tag === 1 ? label._0 : undefined) : label)))

///|
pub extern "js" fn SessionManager::get_branch(
  self : SessionManager,
  fromId : String?,
) -> Array[SessionEntry] =
  #| (self, fromId) => self.getBranch((fromId == null ? undefined : (typeof fromId === "object" && "$tag" in fromId ? (fromId.$tag === 1 ? fromId._0 : undefined) : fromId)))

///|
pub extern "js" fn SessionManager::build_context_entries(
  self : SessionManager,
) -> Array[SessionEntry] =
  #| (self) => self.buildContextEntries()

///|
pub extern "js" fn SessionManager::build_session_context(
  self : SessionManager,
) -> SessionContext =
  #| (self) => self.buildSessionContext()

///|
pub extern "js" fn SessionManager::get_header(
  self : SessionManager,
) -> SessionHeader? =
  #| (self) => self.getHeader()

///|
pub extern "js" fn SessionManager::get_entries(
  self : SessionManager,
) -> Array[SessionEntry] =
  #| (self) => self.getEntries()

///|
pub extern "js" fn SessionManager::get_tree(
  self : SessionManager,
) -> Array[SessionTreeNode] =
  #| (self) => self.getTree()

///|
pub extern "js" fn SessionManager::branch(
  self : SessionManager,
  branchFromId : String,
) -> Unit =
  #| (self, branchFromId) => self.branch(branchFromId)

///|
pub extern "js" fn SessionManager::reset_leaf(self : SessionManager) -> Unit =
  #| (self) => self.resetLeaf()

///|
pub extern "js" fn SessionManager::branch_with_summary(
  self : SessionManager,
  branchFromId : String?,
  summary : String,
  details : JSValue?,
  fromHook : Bool?,
  usage : Usage?,
) -> String =
  #| (self, branchFromId, summary, details, fromHook, usage) => self.branchWithSummary((branchFromId == null ? undefined : (typeof branchFromId === "object" && "$tag" in branchFromId ? (branchFromId.$tag === 1 ? branchFromId._0 : undefined) : branchFromId)), summary, (details == null ? undefined : (typeof details === "object" && "$tag" in details ? (details.$tag === 1 ? details._0 : undefined) : details)), (fromHook === -1 ? undefined : (fromHook == null ? undefined : (typeof fromHook === "object" && "$tag" in fromHook ? (fromHook.$tag === 1 ? fromHook._0 : undefined) : fromHook))), (usage == null ? undefined : (typeof usage === "object" && "$tag" in usage ? (usage.$tag === 1 ? usage._0 : undefined) : usage)))

///|
pub extern "js" fn SessionManager::create_branched_session(
  self : SessionManager,
  leafId : String,
) -> String? =
  #| (self, leafId) => self.createBranchedSession(leafId)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_manager_create(
  cwd : String,
  sessionDir : String?,
  options : NewSessionOptions?,
) -> SessionManager = "__ts_mbt_session_manager_create"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_manager_open(
  path : String,
  sessionDir : String?,
  cwdOverride : String?,
) -> SessionManager = "__ts_mbt_session_manager_open"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_manager_continue_recent(
  cwd : String,
  sessionDir : String?,
) -> SessionManager = "__ts_mbt_session_manager_continue_recent"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_manager_in_memory(
  cwd : String?,
  options : NewSessionOptions?,
  entries : Array[FileEntry]?,
) -> SessionManager = "__ts_mbt_session_manager_in_memory"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_manager_fork_from(
  sourcePath : String,
  targetCwd : String,
  sessionDir : String?,
  options : NewSessionOptions?,
) -> SessionManager = "__ts_mbt_session_manager_fork_from"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_manager_list(
  cwd : String,
  sessionDir : String?,
  onProgress : SessionListProgress?,
) -> Promise[Array[SessionInfo]] = "__ts_mbt_session_manager_list"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_manager_list_all(
  onProgress : SessionListProgress?,
) -> Promise[Array[SessionInfo]] = "__ts_mbt_session_manager_list_all"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_extension_runner(
  extensions : Array[Extension],
  runtime : ExtensionRuntime,
  cwd : String,
  sessionManager : SessionManager,
  modelRegistry : ModelRegistry,
) -> ExtensionRunner = "__ts_mbt_new_extension_runner"

///|
pub extern "js" fn ExtensionRunner::bind_core(
  self : ExtensionRunner,
  actions : ExtensionActions,
  contextActions : ExtensionContextActions,
  providerActions : ExtensionRunnerBindCoreProviderActions?,
) -> Unit =
  #| (self, actions, contextActions, providerActions) => self.bindCore(actions, contextActions, (providerActions == null ? undefined : (typeof providerActions === "object" && "$tag" in providerActions ? (providerActions.$tag === 1 ? providerActions._0 : undefined) : providerActions)))

///|
pub extern "js" fn ExtensionRunner::bind_command_context(
  self : ExtensionRunner,
  actions : ExtensionCommandContextActions?,
) -> Unit =
  #| (self, actions) => self.bindCommandContext((actions == null ? undefined : (typeof actions === "object" && "$tag" in actions ? (actions.$tag === 1 ? actions._0 : undefined) : actions)))

///|
pub extern "js" fn ExtensionRunner::set_uicontext(
  self : ExtensionRunner,
  uiContext : ExtensionUIContext?,
  mode : ExtensionMode?,
) -> Unit =
  #| (self, uiContext, mode) => self.setUIContext((uiContext == null ? undefined : (typeof uiContext === "object" && "$tag" in uiContext ? (uiContext.$tag === 1 ? uiContext._0 : undefined) : uiContext)), (mode == null ? undefined : (typeof mode === "object" && "$tag" in mode ? (mode.$tag === 1 ? mode._0 : undefined) : mode)))

///|
pub extern "js" fn ExtensionRunner::get_uicontext(
  self : ExtensionRunner,
) -> ExtensionUIContext =
  #| (self) => self.getUIContext()

///|
pub extern "js" fn ExtensionRunner::has_ui(self : ExtensionRunner) -> Bool =
  #| (self) => self.hasUI()

///|
pub extern "js" fn ExtensionRunner::get_extension_paths(
  self : ExtensionRunner,
) -> Array[String] =
  #| (self) => self.getExtensionPaths()

///|
pub extern "js" fn ExtensionRunner::get_all_registered_tools(
  self : ExtensionRunner,
) -> Array[RegisteredTool] =
  #| (self) => self.getAllRegisteredTools()

///|
pub extern "js" fn ExtensionRunner::get_tool_definition(
  self : ExtensionRunner,
  toolName : String,
) -> ToolDefinition[JSValue, JSValue, JSValue]? =
  #| (self, toolName) => self.getToolDefinition(toolName)

///|
pub extern "js" fn ExtensionRunner::get_flags(self : ExtensionRunner) -> Map =
  #| (self) => self.getFlags()

///|
pub extern "js" fn ExtensionRunner::set_flag_value(
  self : ExtensionRunner,
  name : String,
  value : Auto_BoolValue_or_StringValue,
) -> Unit =
  #| (self, name, value) => self.setFlagValue(name, (() => { if (value === null || typeof value !== "object" || !("$tag" in value)) return value; if (value.$tag === 0) return value._0; else if (value.$tag === 1) return value._0; throw new Error("unexpected Auto_BoolValue_or_StringValue tag: " + value.$tag); })())

///|
pub extern "js" fn ExtensionRunner::get_flag_values(
  self : ExtensionRunner,
) -> Map =
  #| (self) => self.getFlagValues()

///|
pub extern "js" fn ExtensionRunner::get_shortcuts(
  self : ExtensionRunner,
  resolvedKeybindings : KeybindingsConfig,
) -> Map =
  #| (self, resolvedKeybindings) => self.getShortcuts(resolvedKeybindings)

///|
pub extern "js" fn ExtensionRunner::get_shortcut_diagnostics(
  self : ExtensionRunner,
) -> Array[ResourceDiagnostic] =
  #| (self) => self.getShortcutDiagnostics()

///|
pub extern "js" fn ExtensionRunner::invalidate(
  self : ExtensionRunner,
  message : String?,
) -> Unit =
  #| (self, message) => self.invalidate((message == null ? undefined : (typeof message === "object" && "$tag" in message ? (message.$tag === 1 ? message._0 : undefined) : message)))

///|
pub extern "js" fn ExtensionRunner::on_error(
  self : ExtensionRunner,
  listener : ExtensionErrorListener,
) -> () -> Unit =
  #| (self, listener) => self.onError(listener)

///|
pub extern "js" fn ExtensionRunner::emit_error(
  self : ExtensionRunner,
  error : ExtensionError,
) -> Unit =
  #| (self, error) => self.emitError(error)

///|
pub extern "js" fn ExtensionRunner::has_handlers(
  self : ExtensionRunner,
  eventType : String,
) -> Bool =
  #| (self, eventType) => self.hasHandlers(eventType)

///|
extern "js" fn _extension_runner_get_message_renderer_ret_conv_js(
  this_ : ExtensionRunner,
  customType : String,
) -> JSValue =
  #| (self, customType) => self.getMessageRenderer(customType)

///|
pub extern "js" fn ExtensionRunner::get_markdown_transformers(
  self : ExtensionRunner,
) -> Array[MarkdownTransformer] =
  #| (self) => self.getMarkdownTransformers()

///|
extern "js" fn _extension_runner_get_entry_renderer_ret_conv_js(
  this_ : ExtensionRunner,
  customType : String,
) -> JSValue =
  #| (self, customType) => self.getEntryRenderer(customType)

///|
pub extern "js" fn ExtensionRunner::get_model_registry(
  self : ExtensionRunner,
) -> ModelRegistry =
  #| (self) => self.getModelRegistry()

///|
pub extern "js" fn ExtensionRunner::get_registered_commands(
  self : ExtensionRunner,
) -> Array[ResolvedCommand] =
  #| (self) => self.getRegisteredCommands()

///|
pub extern "js" fn ExtensionRunner::get_command_diagnostics(
  self : ExtensionRunner,
) -> Array[ResourceDiagnostic] =
  #| (self) => self.getCommandDiagnostics()

///|
pub extern "js" fn ExtensionRunner::get_command(
  self : ExtensionRunner,
  name : String,
) -> ResolvedCommand? =
  #| (self, name) => self.getCommand(name)

///|
pub extern "js" fn ExtensionRunner::shutdown(self : ExtensionRunner) -> Unit =
  #| (self) => self.shutdown()

///|
pub extern "js" fn ExtensionRunner::get_active_tools(
  self : ExtensionRunner,
) -> Array[String] =
  #| (self) => self.getActiveTools()

///|
pub extern "js" fn ExtensionRunner::create_context(
  self : ExtensionRunner,
) -> ExtensionContext =
  #| (self) => self.createContext()

///|
pub extern "js" fn ExtensionRunner::create_command_context(
  self : ExtensionRunner,
) -> ExtensionCommandContext =
  #| (self) => self.createCommandContext()

///|
pub extern "js" fn ExtensionRunner::emit(
  self : ExtensionRunner,
  event : RunnerEmitEvent,
) -> Promise[JSValue] =
  #| (self, event) => self.emit(event)

///|
pub extern "js" fn ExtensionRunner::emit_message_end(
  self : ExtensionRunner,
  event : MessageEndEvent,
) -> Promise[AgentMessage?] =
  #| (self, event) => self.emitMessageEnd(event)

///|
pub extern "js" fn ExtensionRunner::emit_tool_result(
  self : ExtensionRunner,
  event : ToolResultEvent,
) -> Promise[ToolResultEventResult?] =
  #| (self, event) => self.emitToolResult((() => { if (event === null || typeof event !== "object" || !("$tag" in event)) return event; if (event.$tag === 0) return event._0; else if (event.$tag === 1) return event._0; else if (event.$tag === 2) return event._0; else if (event.$tag === 3) return event._0; else if (event.$tag === 4) return event._0; else if (event.$tag === 5) return event._0; else if (event.$tag === 6) return event._0; else if (event.$tag === 7) return event._0; else if (event.$tag === 8) return event._0; throw new Error("unexpected ToolResultEvent tag: " + event.$tag); })())

///|
pub extern "js" fn ExtensionRunner::emit_tool_call(
  self : ExtensionRunner,
  event : ToolCallEvent,
) -> Promise[ToolCallEventResult?] =
  #| (self, event) => self.emitToolCall((() => { if (event === null || typeof event !== "object" || !("$tag" in event)) return event; if (event.$tag === 0) return __ts_mbt_to_js_bash_tool_call_event(event._0); else if (event.$tag === 1) return __ts_mbt_to_js_power_shell_tool_call_event(event._0); else if (event.$tag === 2) return __ts_mbt_to_js_read_tool_call_event(event._0); else if (event.$tag === 3) return __ts_mbt_to_js_edit_tool_call_event(event._0); else if (event.$tag === 4) return __ts_mbt_to_js_write_tool_call_event(event._0); else if (event.$tag === 5) return __ts_mbt_to_js_grep_tool_call_event(event._0); else if (event.$tag === 6) return __ts_mbt_to_js_find_tool_call_event(event._0); else if (event.$tag === 7) return __ts_mbt_to_js_ls_tool_call_event(event._0); else if (event.$tag === 8) return __ts_mbt_to_js_custom_tool_call_event(event._0); throw new Error("unexpected ToolCallEvent tag: " + event.$tag); })())

///|
pub extern "js" fn ExtensionRunner::emit_user_bash(
  self : ExtensionRunner,
  event : UserBashEvent,
) -> Promise[UserBashEventResult?] =
  #| (self, event) => self.emitUserBash(event)

///|
pub extern "js" fn ExtensionRunner::emit_context(
  self : ExtensionRunner,
  messages : Array[AgentMessage],
) -> Promise[Array[AgentMessage]] =
  #| (self, messages) => self.emitContext(messages)

///|
pub extern "js" fn ExtensionRunner::emit_before_provider_request(
  self : ExtensionRunner,
  payload : JSValue,
) -> Promise[JSValue] =
  #| (self, payload) => self.emitBeforeProviderRequest(payload)

///|
pub extern "js" fn ExtensionRunner::emit_before_provider_headers(
  self : ExtensionRunner,
  headers : ProviderHeaders,
) -> Promise[ProviderHeaders] =
  #| (self, headers) => self.emitBeforeProviderHeaders(headers)

///|
pub extern "js" fn ExtensionRunner::emit_before_agent_start(
  self : ExtensionRunner,
  prompt : String,
  images : Array[ImageContent]?,
  systemPrompt : String,
  systemPromptOptions : BuildSystemPromptOptions,
) -> Promise[BeforeAgentStartCombinedResult?] =
  #| (self, prompt, images, systemPrompt, systemPromptOptions) => self.emitBeforeAgentStart(prompt, (images == null ? undefined : (typeof images === "object" && "$tag" in images ? (images.$tag === 1 ? images._0 : undefined) : images)), systemPrompt, systemPromptOptions)

///|
extern "js" fn _extension_runner_emit_resources_discover_ret_conv_js(
  this_ : ExtensionRunner,
  cwd : String,
  reason : String,
) -> Promise[JSValue] =
  #| (self, cwd, reason) => self.emitResourcesDiscover(cwd, reason)

///|
extern "js" fn _extension_runner_emit_input_ret_conv_js(
  this_ : ExtensionRunner,
  text : String,
  images : Array[ImageContent]?,
  source : String,
  streamingBehavior : String?,
) -> Promise[InputEventResult] =
  #| (self, text, images, source, streamingBehavior) => self.emitInput(text, (images == null ? undefined : (typeof images === "object" && "$tag" in images ? (images.$tag === 1 ? images._0 : undefined) : images)), source, (streamingBehavior == null ? undefined : (typeof streamingBehavior === "object" && "$tag" in streamingBehavior ? (streamingBehavior.$tag === 1 ? streamingBehavior._0 : undefined) : streamingBehavior)))

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_footer_component(
  session : AgentSession,
  footerData : ReadonlyFooterDataProvider,
) -> FooterComponent = "__ts_mbt_new_footer_component"

///|
pub extern "js" fn FooterComponent::set_session(
  self : FooterComponent,
  session : AgentSession,
) -> Unit =
  #| (self, session) => self.setSession(session)

///|
pub extern "js" fn FooterComponent::set_auto_compact_enabled(
  self : FooterComponent,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setAutoCompactEnabled(enabled)

///|
pub extern "js" fn FooterComponent::invalidate(self : FooterComponent) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn FooterComponent::dispose(self : FooterComponent) -> Unit =
  #| (self) => self.dispose()

///|
pub extern "js" fn FooterComponent::render(
  self : FooterComponent,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_interactive_mode(
  runtimeHost : AgentSessionRuntime,
  options : InteractiveModeOptions?,
) -> InteractiveMode = "__ts_mbt_new_interactive_mode"

///|
pub extern "js" fn InteractiveMode::init(
  self : InteractiveMode,
) -> Promise[Unit] =
  #| (self) => self.init()

///|
pub extern "js" fn InteractiveMode::run(
  self : InteractiveMode,
) -> Promise[Unit] =
  #| (self) => self.run()

///|
pub extern "js" fn InteractiveMode::render_initial_messages(
  self : InteractiveMode,
) -> Unit =
  #| (self) => self.renderInitialMessages()

///|
pub extern "js" fn InteractiveMode::get_user_input(
  self : InteractiveMode,
) -> Promise[String] =
  #| (self) => self.getUserInput()

///|
pub extern "js" fn InteractiveMode::clear_editor(
  self : InteractiveMode,
) -> Unit =
  #| (self) => self.clearEditor()

///|
pub extern "js" fn InteractiveMode::show_error(
  self : InteractiveMode,
  errorMessage : String,
) -> Unit =
  #| (self, errorMessage) => self.showError(errorMessage)

///|
pub extern "js" fn InteractiveMode::show_warning(
  self : InteractiveMode,
  warningMessage : String,
) -> Unit =
  #| (self, warningMessage) => self.showWarning(warningMessage)

///|
pub extern "js" fn InteractiveMode::show_new_version_notification(
  self : InteractiveMode,
  release : LatestPiRelease,
) -> Unit =
  #| (self, release) => self.showNewVersionNotification(release)

///|
pub extern "js" fn InteractiveMode::show_package_update_notification(
  self : InteractiveMode,
  packages : Array[String],
) -> Unit =
  #| (self, packages) => self.showPackageUpdateNotification(packages)

///|
extern "js" fn _interactive_mode_stop_ret_conv_js(
  this_ : InteractiveMode,
  fullscreenExitOutput : String?,
) -> Unit =
  #| (self, fullscreenExitOutput) => self.stop((fullscreenExitOutput == null ? undefined : (typeof fullscreenExitOutput === "object" && "$tag" in fullscreenExitOutput ? (fullscreenExitOutput.$tag === 1 ? fullscreenExitOutput._0 : undefined) : fullscreenExitOutput)))

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn settings_manager_create(
  cwd : String,
  agentDir : String?,
  options : SettingsManagerCreateOptions?,
) -> SettingsManager = "__ts_mbt_settings_manager_create"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn settings_manager_from_storage(
  storage : SettingsStorage,
  options : SettingsManagerCreateOptions?,
) -> SettingsManager = "__ts_mbt_settings_manager_from_storage"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn settings_manager_in_memory(
  settings : SettingsPartial?,
  options : SettingsManagerCreateOptions?,
) -> SettingsManager = "__ts_mbt_settings_manager_in_memory"

///|
pub extern "js" fn SettingsManager::get_global_settings(
  self : SettingsManager,
) -> Settings =
  #| (self) => self.getGlobalSettings()

///|
pub extern "js" fn SettingsManager::get_project_settings(
  self : SettingsManager,
) -> Settings =
  #| (self) => self.getProjectSettings()

///|
pub extern "js" fn SettingsManager::is_project_trusted(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.isProjectTrusted()

///|
pub extern "js" fn SettingsManager::set_project_trusted(
  self : SettingsManager,
  trusted : Bool,
) -> Unit =
  #| (self, trusted) => self.setProjectTrusted(trusted)

///|
pub extern "js" fn SettingsManager::reload(
  self : SettingsManager,
) -> Promise[Unit] =
  #| (self) => self.reload()

///|
pub extern "js" fn SettingsManager::apply_overrides(
  self : SettingsManager,
  overrides : SettingsPartial,
) -> Unit =
  #| (self, overrides) => self.applyOverrides(overrides)

///|
pub extern "js" fn SettingsManager::flush(
  self : SettingsManager,
) -> Promise[Unit] =
  #| (self) => self.flush()

///|
pub extern "js" fn SettingsManager::drain_errors(
  self : SettingsManager,
) -> Array[SettingsError] =
  #| (self) => self.drainErrors()

///|
pub extern "js" fn SettingsManager::get_last_changelog_version(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getLastChangelogVersion()

///|
pub extern "js" fn SettingsManager::set_last_changelog_version(
  self : SettingsManager,
  version : String,
) -> Unit =
  #| (self, version) => self.setLastChangelogVersion(version)

///|
pub extern "js" fn SettingsManager::get_session_dir(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getSessionDir()

///|
pub extern "js" fn SettingsManager::get_default_provider(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getDefaultProvider()

///|
pub extern "js" fn SettingsManager::get_default_model(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getDefaultModel()

///|
pub extern "js" fn SettingsManager::set_default_provider(
  self : SettingsManager,
  provider : String,
) -> Unit =
  #| (self, provider) => self.setDefaultProvider(provider)

///|
pub extern "js" fn SettingsManager::set_default_model(
  self : SettingsManager,
  modelId : String,
) -> Unit =
  #| (self, modelId) => self.setDefaultModel(modelId)

///|
pub extern "js" fn SettingsManager::set_default_model_and_provider(
  self : SettingsManager,
  provider : String,
  modelId : String,
) -> Unit =
  #| (self, provider, modelId) => self.setDefaultModelAndProvider(provider, modelId)

///|
extern "js" fn _settings_manager_get_steering_mode_ret_conv_js(
  this_ : SettingsManager,
) -> String =
  #| (self) => self.getSteeringMode()

///|
extern "js" fn _settings_manager_set_steering_mode_ret_conv_js(
  this_ : SettingsManager,
  mode : String,
) -> Unit =
  #| (self, mode) => self.setSteeringMode(mode)

///|
extern "js" fn _settings_manager_get_follow_up_mode_ret_conv_js(
  this_ : SettingsManager,
) -> String =
  #| (self) => self.getFollowUpMode()

///|
extern "js" fn _settings_manager_set_follow_up_mode_ret_conv_js(
  this_ : SettingsManager,
  mode : String,
) -> Unit =
  #| (self, mode) => self.setFollowUpMode(mode)

///|
pub extern "js" fn SettingsManager::get_theme_setting(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getThemeSetting()

///|
pub extern "js" fn SettingsManager::get_theme(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getTheme()

///|
pub extern "js" fn SettingsManager::set_theme(
  self : SettingsManager,
  theme : String,
) -> Unit =
  #| (self, theme) => self.setTheme(theme)

///|
extern "js" fn _settings_manager_get_default_thinking_level_ret_conv_js(
  this_ : SettingsManager,
) -> JSValue =
  #| (self) => self.getDefaultThinkingLevel()

///|
pub extern "js" fn SettingsManager::set_default_thinking_level(
  self : SettingsManager,
  level : ThinkingLevel,
) -> Unit =
  #| (self, level) => self.setDefaultThinkingLevel(level)

///|
extern "js" fn _settings_manager_get_model_thinking_level_ret_conv_js(
  this_ : SettingsManager,
  provider : String,
  modelId : String,
) -> JSValue =
  #| (self, provider, modelId) => self.getModelThinkingLevel(provider, modelId)

///|
pub extern "js" fn SettingsManager::get_all_model_thinking_levels(
  self : SettingsManager,
) -> StringRecordOfThinkingLevel =
  #| (self) => self.getAllModelThinkingLevels()

///|
pub extern "js" fn SettingsManager::set_model_thinking_level(
  self : SettingsManager,
  provider : String,
  modelId : String,
  level : ThinkingLevel,
) -> Unit =
  #| (self, provider, modelId, level) => self.setModelThinkingLevel(provider, modelId, level)

///|
pub extern "js" fn SettingsManager::remove_model_thinking_level(
  self : SettingsManager,
  provider : String,
  modelId : String,
) -> Unit =
  #| (self, provider, modelId) => self.removeModelThinkingLevel(provider, modelId)

///|
pub extern "js" fn SettingsManager::get_transport(
  self : SettingsManager,
) -> TransportSetting =
  #| (self) => self.getTransport()

///|
pub extern "js" fn SettingsManager::set_transport(
  self : SettingsManager,
  transport : TransportSetting,
) -> Unit =
  #| (self, transport) => self.setTransport(transport)

///|
pub extern "js" fn SettingsManager::get_compaction_enabled(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getCompactionEnabled()

///|
pub extern "js" fn SettingsManager::set_compaction_enabled(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setCompactionEnabled(enabled)

///|
pub extern "js" fn SettingsManager::get_compaction_reserve_tokens(
  self : SettingsManager,
) -> Double =
  #| (self) => self.getCompactionReserveTokens()

///|
pub extern "js" fn SettingsManager::get_compaction_keep_recent_tokens(
  self : SettingsManager,
) -> Double =
  #| (self) => self.getCompactionKeepRecentTokens()

///|
pub extern "js" fn SettingsManager::get_compaction_settings(
  self : SettingsManager,
) -> JSValue =
  #| (self) => self.getCompactionSettings()

///|
pub extern "js" fn SettingsManager::get_branch_summary_settings(
  self : SettingsManager,
) -> JSValue =
  #| (self) => self.getBranchSummarySettings()

///|
pub extern "js" fn SettingsManager::get_branch_summary_skip_prompt(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getBranchSummarySkipPrompt()

///|
pub extern "js" fn SettingsManager::get_retry_enabled(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getRetryEnabled()

///|
pub extern "js" fn SettingsManager::set_retry_enabled(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setRetryEnabled(enabled)

///|
pub extern "js" fn SettingsManager::get_retry_settings(
  self : SettingsManager,
) -> JSValue =
  #| (self) => self.getRetrySettings()

///|
pub extern "js" fn SettingsManager::get_http_idle_timeout_ms(
  self : SettingsManager,
) -> Double =
  #| (self) => self.getHttpIdleTimeoutMs()

///|
pub extern "js" fn SettingsManager::set_http_idle_timeout_ms(
  self : SettingsManager,
  timeoutMs : Double,
) -> Unit =
  #| (self, timeoutMs) => self.setHttpIdleTimeoutMs(timeoutMs)

///|
pub extern "js" fn SettingsManager::get_provider_retry_settings(
  self : SettingsManager,
) -> JSValue =
  #| (self) => self.getProviderRetrySettings()

///|
extern "js" fn _settings_manager_get_web_socket_connect_timeout_ms_ret_conv_js(
  this_ : SettingsManager,
) -> JSValue =
  #| (self) => self.getWebSocketConnectTimeoutMs()

///|
pub extern "js" fn SettingsManager::get_hide_thinking_block(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getHideThinkingBlock()

///|
pub extern "js" fn SettingsManager::get_show_cache_miss_notices(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getShowCacheMissNotices()

///|
pub extern "js" fn SettingsManager::get_external_editor_command(
  self : SettingsManager,
) -> String =
  #| (self) => self.getExternalEditorCommand()

///|
pub extern "js" fn SettingsManager::set_hide_thinking_block(
  self : SettingsManager,
  hide : Bool,
) -> Unit =
  #| (self, hide) => self.setHideThinkingBlock(hide)

///|
pub extern "js" fn SettingsManager::set_show_cache_miss_notices(
  self : SettingsManager,
  show : Bool,
) -> Unit =
  #| (self, show) => self.setShowCacheMissNotices(show)

///|
pub extern "js" fn SettingsManager::get_shell_path(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getShellPath()

///|
pub extern "js" fn SettingsManager::set_shell_path(
  self : SettingsManager,
  path : String?,
) -> Unit =
  #| (self, path) => self.setShellPath((path == null ? undefined : (typeof path === "object" && "$tag" in path ? (path.$tag === 1 ? path._0 : undefined) : path)))

///|
pub extern "js" fn SettingsManager::get_quiet_startup(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getQuietStartup()

///|
pub extern "js" fn SettingsManager::set_quiet_startup(
  self : SettingsManager,
  quiet : Bool,
) -> Unit =
  #| (self, quiet) => self.setQuietStartup(quiet)

///|
extern "js" fn _settings_manager_get_default_project_trust_ret_conv_js(
  this_ : SettingsManager,
) -> String =
  #| (self) => self.getDefaultProjectTrust()

///|
extern "js" fn _settings_manager_set_default_project_trust_ret_conv_js(
  this_ : SettingsManager,
  defaultProjectTrust : String,
) -> Unit =
  #| (self, defaultProjectTrust) => self.setDefaultProjectTrust(defaultProjectTrust)

///|
pub extern "js" fn SettingsManager::get_shell_command_prefix(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getShellCommandPrefix()

///|
pub extern "js" fn SettingsManager::set_shell_command_prefix(
  self : SettingsManager,
  prefix : String?,
) -> Unit =
  #| (self, prefix) => self.setShellCommandPrefix((prefix == null ? undefined : (typeof prefix === "object" && "$tag" in prefix ? (prefix.$tag === 1 ? prefix._0 : undefined) : prefix)))

///|
extern "js" fn _settings_manager_get_npm_command_ret_conv_js(
  this_ : SettingsManager,
) -> JSValue =
  #| (self) => self.getNpmCommand()

///|
pub extern "js" fn SettingsManager::set_npm_command(
  self : SettingsManager,
  command : Array[String]?,
) -> Unit =
  #| (self, command) => self.setNpmCommand((command == null ? undefined : (typeof command === "object" && "$tag" in command ? (command.$tag === 1 ? command._0 : undefined) : command)))

///|
pub extern "js" fn SettingsManager::get_collapse_changelog(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getCollapseChangelog()

///|
pub extern "js" fn SettingsManager::set_collapse_changelog(
  self : SettingsManager,
  collapse : Bool,
) -> Unit =
  #| (self, collapse) => self.setCollapseChangelog(collapse)

///|
pub extern "js" fn SettingsManager::get_enable_install_telemetry(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getEnableInstallTelemetry()

///|
pub extern "js" fn SettingsManager::set_enable_install_telemetry(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setEnableInstallTelemetry(enabled)

///|
pub extern "js" fn SettingsManager::get_enable_analytics(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getEnableAnalytics()

///|
pub extern "js" fn SettingsManager::get_tracking_id(
  self : SettingsManager,
) -> String? =
  #| (self) => self.getTrackingId()

///|
pub extern "js" fn SettingsManager::set_enable_analytics(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setEnableAnalytics(enabled)

///|
pub extern "js" fn SettingsManager::get_packages(
  self : SettingsManager,
) -> Array[PackageSource] =
  #| (self) => self.getPackages()

///|
pub extern "js" fn SettingsManager::set_packages(
  self : SettingsManager,
  packages : Array[PackageSource],
) -> Unit =
  #| (self, packages) => self.setPackages(packages)

///|
pub extern "js" fn SettingsManager::set_project_packages(
  self : SettingsManager,
  packages : Array[PackageSource],
) -> Unit =
  #| (self, packages) => self.setProjectPackages(packages)

///|
pub extern "js" fn SettingsManager::get_extension_paths(
  self : SettingsManager,
) -> Array[String] =
  #| (self) => self.getExtensionPaths()

///|
pub extern "js" fn SettingsManager::set_extension_paths(
  self : SettingsManager,
  paths : Array[String],
) -> Unit =
  #| (self, paths) => self.setExtensionPaths(paths)

///|
pub extern "js" fn SettingsManager::set_project_extension_paths(
  self : SettingsManager,
  paths : Array[String],
) -> Unit =
  #| (self, paths) => self.setProjectExtensionPaths(paths)

///|
pub extern "js" fn SettingsManager::get_skill_paths(
  self : SettingsManager,
) -> Array[String] =
  #| (self) => self.getSkillPaths()

///|
pub extern "js" fn SettingsManager::set_skill_paths(
  self : SettingsManager,
  paths : Array[String],
) -> Unit =
  #| (self, paths) => self.setSkillPaths(paths)

///|
pub extern "js" fn SettingsManager::set_project_skill_paths(
  self : SettingsManager,
  paths : Array[String],
) -> Unit =
  #| (self, paths) => self.setProjectSkillPaths(paths)

///|
pub extern "js" fn SettingsManager::get_prompt_template_paths(
  self : SettingsManager,
) -> Array[String] =
  #| (self) => self.getPromptTemplatePaths()

///|
pub extern "js" fn SettingsManager::set_prompt_template_paths(
  self : SettingsManager,
  paths : Array[String],
) -> Unit =
  #| (self, paths) => self.setPromptTemplatePaths(paths)

///|
pub extern "js" fn SettingsManager::set_project_prompt_template_paths(
  self : SettingsManager,
  paths : Array[String],
) -> Unit =
  #| (self, paths) => self.setProjectPromptTemplatePaths(paths)

///|
pub extern "js" fn SettingsManager::get_theme_paths(
  self : SettingsManager,
) -> Array[String] =
  #| (self) => self.getThemePaths()

///|
pub extern "js" fn SettingsManager::set_theme_paths(
  self : SettingsManager,
  paths : Array[String],
) -> Unit =
  #| (self, paths) => self.setThemePaths(paths)

///|
pub extern "js" fn SettingsManager::set_project_theme_paths(
  self : SettingsManager,
  paths : Array[String],
) -> Unit =
  #| (self, paths) => self.setProjectThemePaths(paths)

///|
pub extern "js" fn SettingsManager::get_enable_skill_commands(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getEnableSkillCommands()

///|
pub extern "js" fn SettingsManager::set_enable_skill_commands(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setEnableSkillCommands(enabled)

///|
pub extern "js" fn SettingsManager::get_thinking_budgets(
  self : SettingsManager,
) -> ThinkingBudgetsSettings? =
  #| (self) => self.getThinkingBudgets()

///|
pub extern "js" fn SettingsManager::get_terminal_capability_overrides(
  self : SettingsManager,
) -> Partial =
  #| (self) => self.getTerminalCapabilityOverrides()

///|
pub extern "js" fn SettingsManager::get_show_images(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getShowImages()

///|
pub extern "js" fn SettingsManager::set_show_images(
  self : SettingsManager,
  show : Bool,
) -> Unit =
  #| (self, show) => self.setShowImages(show)

///|
pub extern "js" fn SettingsManager::get_image_width_cells(
  self : SettingsManager,
) -> Double =
  #| (self) => self.getImageWidthCells()

///|
pub extern "js" fn SettingsManager::set_image_width_cells(
  self : SettingsManager,
  width : Double,
) -> Unit =
  #| (self, width) => self.setImageWidthCells(width)

///|
pub extern "js" fn SettingsManager::get_clear_on_shrink(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getClearOnShrink()

///|
pub extern "js" fn SettingsManager::set_clear_on_shrink(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setClearOnShrink(enabled)

///|
pub extern "js" fn SettingsManager::get_show_terminal_progress(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getShowTerminalProgress()

///|
pub extern "js" fn SettingsManager::set_show_terminal_progress(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setShowTerminalProgress(enabled)

///|
pub extern "js" fn SettingsManager::get_tui_mode(
  self : SettingsManager,
) -> TuiMode =
  #| (self) => self.getTuiMode()

///|
pub extern "js" fn SettingsManager::set_tui_mode(
  self : SettingsManager,
  mode : TuiMode,
) -> Unit =
  #| (self, mode) => self.setTuiMode(mode)

///|
extern "js" fn _settings_manager_get_fullscreen_exit_output_ret_conv_js(
  this_ : SettingsManager,
) -> String =
  #| (self) => self.getFullscreenExitOutput()

///|
extern "js" fn _settings_manager_set_fullscreen_exit_output_ret_conv_js(
  this_ : SettingsManager,
  output : String,
) -> Unit =
  #| (self, output) => self.setFullscreenExitOutput(output)

///|
pub extern "js" fn SettingsManager::get_fullscreen_scrollbar(
  self : SettingsManager,
) -> ScrollViewScrollbar =
  #| (self) => self.getFullscreenScrollbar()

///|
pub extern "js" fn SettingsManager::set_fullscreen_scrollbar(
  self : SettingsManager,
  mode : ScrollViewScrollbar,
) -> Unit =
  #| (self, mode) => self.setFullscreenScrollbar(mode)

///|
pub extern "js" fn SettingsManager::get_fullscreen_copy_on_select(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getFullscreenCopyOnSelect()

///|
pub extern "js" fn SettingsManager::set_fullscreen_copy_on_select(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setFullscreenCopyOnSelect(enabled)

///|
pub extern "js" fn SettingsManager::get_image_auto_resize(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getImageAutoResize()

///|
pub extern "js" fn SettingsManager::set_image_auto_resize(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setImageAutoResize(enabled)

///|
pub extern "js" fn SettingsManager::get_block_images(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getBlockImages()

///|
pub extern "js" fn SettingsManager::set_block_images(
  self : SettingsManager,
  blocked : Bool,
) -> Unit =
  #| (self, blocked) => self.setBlockImages(blocked)

///|
extern "js" fn _settings_manager_get_enabled_models_ret_conv_js(
  this_ : SettingsManager,
) -> JSValue =
  #| (self) => self.getEnabledModels()

///|
extern "js" fn _settings_manager_get_default_tools_ret_conv_js(
  this_ : SettingsManager,
) -> JSValue =
  #| (self) => self.getDefaultTools()

///|
pub extern "js" fn SettingsManager::set_enabled_models(
  self : SettingsManager,
  patterns : Array[String]?,
) -> Unit =
  #| (self, patterns) => self.setEnabledModels((patterns == null ? undefined : (typeof patterns === "object" && "$tag" in patterns ? (patterns.$tag === 1 ? patterns._0 : undefined) : patterns)))

///|
extern "js" fn _settings_manager_get_double_escape_action_ret_conv_js(
  this_ : SettingsManager,
) -> String =
  #| (self) => self.getDoubleEscapeAction()

///|
extern "js" fn _settings_manager_set_double_escape_action_ret_conv_js(
  this_ : SettingsManager,
  action : String,
) -> Unit =
  #| (self, action) => self.setDoubleEscapeAction(action)

///|
extern "js" fn _settings_manager_get_tree_filter_mode_ret_conv_js(
  this_ : SettingsManager,
) -> String =
  #| (self) => self.getTreeFilterMode()

///|
extern "js" fn _settings_manager_set_tree_filter_mode_ret_conv_js(
  this_ : SettingsManager,
  mode : String,
) -> Unit =
  #| (self, mode) => self.setTreeFilterMode(mode)

///|
pub extern "js" fn SettingsManager::get_show_hardware_cursor(
  self : SettingsManager,
) -> Bool =
  #| (self) => self.getShowHardwareCursor()

///|
pub extern "js" fn SettingsManager::set_show_hardware_cursor(
  self : SettingsManager,
  enabled : Bool,
) -> Unit =
  #| (self, enabled) => self.setShowHardwareCursor(enabled)

///|
pub extern "js" fn SettingsManager::get_editor_padding_x(
  self : SettingsManager,
) -> Double =
  #| (self) => self.getEditorPaddingX()

///|
pub extern "js" fn SettingsManager::set_editor_padding_x(
  self : SettingsManager,
  padding : Double,
) -> Unit =
  #| (self, padding) => self.setEditorPaddingX(padding)

///|
extern "js" fn _settings_manager_get_output_pad_ret_conv_js(
  this_ : SettingsManager,
) -> Int =
  #| (self) => self.getOutputPad()

///|
extern "js" fn _settings_manager_set_output_pad_ret_conv_js(
  this_ : SettingsManager,
  padding : Int,
) -> Unit =
  #| (self, padding) => self.setOutputPad(padding)

///|
pub extern "js" fn SettingsManager::get_autocomplete_max_visible(
  self : SettingsManager,
) -> Double =
  #| (self) => self.getAutocompleteMaxVisible()

///|
pub extern "js" fn SettingsManager::set_autocomplete_max_visible(
  self : SettingsManager,
  maxVisible : Double,
) -> Unit =
  #| (self, maxVisible) => self.setAutocompleteMaxVisible(maxVisible)

///|
pub extern "js" fn SettingsManager::get_code_block_indent(
  self : SettingsManager,
) -> String =
  #| (self) => self.getCodeBlockIndent()

///|
pub extern "js" fn SettingsManager::get_mermaid_rendering_mode(
  self : SettingsManager,
) -> MermaidRenderingMode =
  #| (self) => self.getMermaidRenderingMode()

///|
pub extern "js" fn SettingsManager::set_mermaid_rendering_mode(
  self : SettingsManager,
  mode : MermaidRenderingMode,
) -> Unit =
  #| (self, mode) => self.setMermaidRenderingMode(mode)

///|
pub extern "js" fn SettingsManager::get_warnings(
  self : SettingsManager,
) -> WarningSettings =
  #| (self) => self.getWarnings()

///|
pub extern "js" fn SettingsManager::set_warnings(
  self : SettingsManager,
  warnings : WarningSettings,
) -> Unit =
  #| (self, warnings) => self.setWarnings(warnings)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_project_trust_store(
  agentDir : String,
) -> ProjectTrustStore = "__ts_mbt_new_project_trust_store"

///|
pub extern "js" fn ProjectTrustStore::get(
  self : ProjectTrustStore,
  cwd : String,
) -> ProjectTrustDecision =
  #| (self, cwd) => self.get(cwd)

///|
extern "js" fn _project_trust_store_get_entry_ret_conv_js(
  this_ : ProjectTrustStore,
  cwd : String,
) -> JSValue =
  #| (self, cwd) => self.getEntry(cwd)

///|
pub extern "js" fn ProjectTrustStore::set(
  self : ProjectTrustStore,
  cwd : String,
  decision : ProjectTrustDecision,
) -> Unit =
  #| (self, cwd, decision) => self.set(cwd, decision)

///|
pub extern "js" fn ProjectTrustStore::set_many(
  self : ProjectTrustStore,
  decisions : Array[ProjectTrustUpdate],
) -> Unit =
  #| (self, decisions) => self.setMany(decisions)

///|
pub extern "js" fn KeybindingsManager::matches(
  self : KeybindingsManager,
  data : String,
  keybinding : Keybinding,
) -> Bool =
  #| (self, data, keybinding) => self.matches(data, keybinding)

///|
pub extern "js" fn KeybindingsManager::get_keys(
  self : KeybindingsManager,
  keybinding : Keybinding,
) -> Array[KeyId] =
  #| (self, keybinding) => self.getKeys(keybinding)

///|
pub extern "js" fn KeybindingsManager::get_definition(
  self : KeybindingsManager,
  keybinding : Keybinding,
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
pub extern "js" fn KeybindingsManager::reload(
  self : KeybindingsManager,
) -> Unit =
  #| (self) => self.reload()

///|
pub extern "js" fn KeybindingsManager::get_effective_config(
  self : KeybindingsManager,
) -> KeybindingsConfig =
  #| (self) => self.getEffectiveConfig()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_agent_session_runtime(
  _session : AgentSession,
  _services : AgentSessionServices,
  createRuntime : CreateAgentSessionRuntimeFactory,
  _diagnostics : Array[AgentSessionRuntimeDiagnostic]?,
  _modelFallbackMessage : String?,
) -> AgentSessionRuntime = "__ts_mbt_new_agent_session_runtime"

///|
pub extern "js" fn AgentSessionRuntime::get_agent_session_runtime_services(
  self : AgentSessionRuntime,
) -> AgentSessionServices =
  #| (self) => self.services

///|
pub extern "js" fn AgentSessionRuntime::get_agent_session_runtime_session(
  self : AgentSessionRuntime,
) -> AgentSession =
  #| (self) => self.session

///|
pub extern "js" fn AgentSessionRuntime::get_agent_session_runtime_cwd(
  self : AgentSessionRuntime,
) -> String =
  #| (self) => self.cwd

///|
pub extern "js" fn AgentSessionRuntime::get_agent_session_runtime_diagnostics(
  self : AgentSessionRuntime,
) -> Array[AgentSessionRuntimeDiagnostic] =
  #| (self) => self.diagnostics

///|
pub extern "js" fn AgentSessionRuntime::get_agent_session_runtime_model_fallback_message(
  self : AgentSessionRuntime,
) -> String? =
  #| (self) => self.modelFallbackMessage

///|
pub extern "js" fn AgentSessionRuntime::services(
  self : AgentSessionRuntime,
) -> AgentSessionServices =
  #| (self) => self.services()

///|
pub extern "js" fn AgentSessionRuntime::session(
  self : AgentSessionRuntime,
) -> AgentSession =
  #| (self) => self.session()

///|
pub extern "js" fn AgentSessionRuntime::cwd(
  self : AgentSessionRuntime,
) -> String =
  #| (self) => self.cwd()

///|
pub extern "js" fn AgentSessionRuntime::diagnostics(
  self : AgentSessionRuntime,
) -> Array[AgentSessionRuntimeDiagnostic] =
  #| (self) => self.diagnostics()

///|
pub extern "js" fn AgentSessionRuntime::model_fallback_message(
  self : AgentSessionRuntime,
) -> String? =
  #| (self) => self.modelFallbackMessage()

///|
extern "js" fn _agent_session_runtime_set_rebind_session_ret_conv_js(
  this_ : AgentSessionRuntime,
  rebindSession : ((AgentSession) -> Promise[Unit])?,
) -> Unit =
  #| (self, rebindSession) => self.setRebindSession((rebindSession == null ? undefined : (typeof rebindSession === "object" && "$tag" in rebindSession ? (rebindSession.$tag === 1 ? rebindSession._0 : undefined) : rebindSession)))

///|
pub extern "js" fn AgentSessionRuntime::set_before_session_invalidate(
  self : AgentSessionRuntime,
  beforeSessionInvalidate : (() -> Unit)?,
) -> Unit =
  #| (self, beforeSessionInvalidate) => self.setBeforeSessionInvalidate((beforeSessionInvalidate == null ? undefined : (typeof beforeSessionInvalidate === "object" && "$tag" in beforeSessionInvalidate ? (beforeSessionInvalidate.$tag === 1 ? beforeSessionInvalidate._0 : undefined) : beforeSessionInvalidate)))

///|
pub extern "js" fn AgentSessionRuntime::switch_session(
  self : AgentSessionRuntime,
  sessionPath : String,
  options : AgentSessionRuntimeSwitchSessionOptions?,
) -> Promise[JSValue] =
  #| (self, sessionPath, options) => self.switchSession(sessionPath, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSessionRuntime::new_session(
  self : AgentSessionRuntime,
  options : AgentSessionRuntimeNewSessionOptions?,
) -> Promise[JSValue] =
  #| (self, options) => self.newSession((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSessionRuntime::fork(
  self : AgentSessionRuntime,
  entryId : String,
  options : AgentSessionRuntimeForkOptions?,
) -> Promise[JSValue] =
  #| (self, entryId, options) => self.fork(entryId, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn AgentSessionRuntime::import_from_jsonl(
  self : AgentSessionRuntime,
  inputPath : String,
  cwdOverride : String?,
) -> Promise[JSValue] =
  #| (self, inputPath, cwdOverride) => self.importFromJsonl(inputPath, (cwdOverride == null ? undefined : (typeof cwdOverride === "object" && "$tag" in cwdOverride ? (cwdOverride.$tag === 1 ? cwdOverride._0 : undefined) : cwdOverride)))

///|
pub extern "js" fn AgentSessionRuntime::dispose(
  self : AgentSessionRuntime,
) -> Promise[Unit] =
  #| (self) => self.dispose()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_login_dialog_component(
  tui : TUI,
  providerId : String,
  onComplete : (Bool, String?) -> Unit,
  providerNameOverride : String?,
  titleOverride : String?,
) -> LoginDialogComponent = "__ts_mbt_new_login_dialog_component"

///|
pub extern "js" fn LoginDialogComponent::get_login_dialog_component_focused(
  self : LoginDialogComponent,
) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn LoginDialogComponent::set_login_dialog_component_focused(
  self : LoginDialogComponent,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn LoginDialogComponent::get_login_dialog_component_signal(
  self : LoginDialogComponent,
) -> AbortSignal =
  #| (self) => self.signal

///|
pub extern "js" fn LoginDialogComponent::focused(
  self : LoginDialogComponent,
) -> Bool =
  #| (self) => self.focused()

///|
pub extern "js" fn LoginDialogComponent::signal(
  self : LoginDialogComponent,
) -> AbortSignal =
  #| (self) => self.signal()

///|
pub extern "js" fn LoginDialogComponent::show_auth(
  self : LoginDialogComponent,
  url : String,
  instructions : String?,
) -> Unit =
  #| (self, url, instructions) => self.showAuth(url, (instructions == null ? undefined : (typeof instructions === "object" && "$tag" in instructions ? (instructions.$tag === 1 ? instructions._0 : undefined) : instructions)))

///|
pub extern "js" fn LoginDialogComponent::show_device_code(
  self : LoginDialogComponent,
  info : OAuthDeviceCodeInfo,
) -> Unit =
  #| (self, info) => self.showDeviceCode(info)

///|
pub extern "js" fn LoginDialogComponent::show_manual_input(
  self : LoginDialogComponent,
  prompt : String,
) -> Promise[String] =
  #| (self, prompt) => self.showManualInput(prompt)

///|
pub extern "js" fn LoginDialogComponent::show_prompt(
  self : LoginDialogComponent,
  message : String,
  placeholder : String?,
) -> Promise[String] =
  #| (self, message, placeholder) => self.showPrompt(message, (placeholder == null ? undefined : (typeof placeholder === "object" && "$tag" in placeholder ? (placeholder.$tag === 1 ? placeholder._0 : undefined) : placeholder)))

///|
pub extern "js" fn LoginDialogComponent::show_details(
  self : LoginDialogComponent,
  lines : Array[String],
) -> Unit =
  #| (self, lines) => self.showDetails(lines)

///|
pub extern "js" fn LoginDialogComponent::show_info(
  self : LoginDialogComponent,
  message : String,
  links : Array[AuthInfoLink]?,
  showCloseHint : Bool?,
) -> Unit =
  #| (self, message, links, showCloseHint) => self.showInfo(message, (links == null ? undefined : (typeof links === "object" && "$tag" in links ? (links.$tag === 1 ? links._0 : undefined) : links)), (showCloseHint === -1 ? undefined : (showCloseHint == null ? undefined : (typeof showCloseHint === "object" && "$tag" in showCloseHint ? (showCloseHint.$tag === 1 ? showCloseHint._0 : undefined) : showCloseHint))))

///|
pub extern "js" fn LoginDialogComponent::show_waiting(
  self : LoginDialogComponent,
  message : String,
) -> Unit =
  #| (self, message) => self.showWaiting(message)

///|
pub extern "js" fn LoginDialogComponent::show_progress(
  self : LoginDialogComponent,
  message : String,
) -> Unit =
  #| (self, message) => self.showProgress(message)

///|
pub extern "js" fn LoginDialogComponent::handle_input(
  self : LoginDialogComponent,
  data : String,
) -> Unit =
  #| (self, data) => self.handleInput(data)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_user_message_component(
  text : String,
  markdownTheme : MarkdownTheme?,
  outputPad : Double?,
  markdownTransformers : Array[MarkdownTransformer]?,
) -> UserMessageComponent = "__ts_mbt_new_user_message_component"

///|
pub extern "js" fn UserMessageComponent::set_output_pad(
  self : UserMessageComponent,
  padding : Double,
) -> Unit =
  #| (self, padding) => self.setOutputPad(padding)

///|
pub extern "js" fn UserMessageComponent::render(
  self : UserMessageComponent,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_default_package_manager(
  options : PackageManagerOptions,
) -> DefaultPackageManager = "__ts_mbt_new_default_package_manager"

///|
pub extern "js" fn DefaultPackageManager::set_progress_callback(
  self : DefaultPackageManager,
  callback : ProgressCallback?,
) -> Unit =
  #| (self, callback) => self.setProgressCallback((callback == null ? undefined : (typeof callback === "object" && "$tag" in callback ? (callback.$tag === 1 ? callback._0 : undefined) : callback)))

///|
pub extern "js" fn DefaultPackageManager::add_source_to_settings(
  self : DefaultPackageManager,
  source : String,
  options : DefaultPackageManagerAddSourceToSettingsOptions?,
) -> Bool =
  #| (self, source, options) => self.addSourceToSettings(source, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn DefaultPackageManager::remove_source_from_settings(
  self : DefaultPackageManager,
  source : String,
  options : DefaultPackageManagerRemoveSourceFromSettingsOptions?,
) -> Bool =
  #| (self, source, options) => self.removeSourceFromSettings(source, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
extern "js" fn _default_package_manager_get_installed_path_ret_conv_js(
  this_ : DefaultPackageManager,
  source : String,
  scope : String,
) -> String? =
  #| (self, source, scope) => self.getInstalledPath(source, scope)

///|
extern "js" fn _default_package_manager_resolve_ret_conv_js(
  this_ : DefaultPackageManager,
  onMissing : ((String) -> Promise[MissingSourceAction])?,
) -> Promise[ResolvedPaths] =
  #| (self, onMissing) => self.resolve((onMissing == null ? undefined : (typeof onMissing === "object" && "$tag" in onMissing ? (onMissing.$tag === 1 ? onMissing._0 : undefined) : onMissing)))

///|
pub extern "js" fn DefaultPackageManager::resolve_extension_sources(
  self : DefaultPackageManager,
  sources : Array[String],
  options : DefaultPackageManagerResolveExtensionSourcesOptions?,
) -> Promise[ResolvedPaths] =
  #| (self, sources, options) => self.resolveExtensionSources(sources, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn DefaultPackageManager::list_configured_packages(
  self : DefaultPackageManager,
) -> Array[ConfiguredPackage] =
  #| (self) => self.listConfiguredPackages()

///|
pub extern "js" fn DefaultPackageManager::install(
  self : DefaultPackageManager,
  source : String,
  options : DefaultPackageManagerInstallOptions?,
) -> Promise[Unit] =
  #| (self, source, options) => self.install(source, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn DefaultPackageManager::install_and_persist(
  self : DefaultPackageManager,
  source : String,
  options : DefaultPackageManagerInstallAndPersistOptions?,
) -> Promise[Unit] =
  #| (self, source, options) => self.installAndPersist(source, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn DefaultPackageManager::remove(
  self : DefaultPackageManager,
  source : String,
  options : DefaultPackageManagerRemoveOptions?,
) -> Promise[Unit] =
  #| (self, source, options) => self.remove(source, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn DefaultPackageManager::remove_and_persist(
  self : DefaultPackageManager,
  source : String,
  options : DefaultPackageManagerRemoveAndPersistOptions?,
) -> Promise[Bool] =
  #| (self, source, options) => self.removeAndPersist(source, (options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
pub extern "js" fn DefaultPackageManager::update(
  self : DefaultPackageManager,
  source : String?,
) -> Promise[Unit] =
  #| (self, source) => self.update((source == null ? undefined : (typeof source === "object" && "$tag" in source ? (source.$tag === 1 ? source._0 : undefined) : source)))

///|
pub extern "js" fn DefaultPackageManager::check_for_available_updates(
  self : DefaultPackageManager,
) -> Promise[Array[PackageUpdate]] =
  #| (self) => self.checkForAvailableUpdates()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_default_resource_loader(
  options : DefaultResourceLoaderOptions,
) -> DefaultResourceLoader = "__ts_mbt_new_default_resource_loader"

///|
pub extern "js" fn DefaultResourceLoader::get_extensions(
  self : DefaultResourceLoader,
) -> LoadExtensionsResult =
  #| (self) => self.getExtensions()

///|
pub extern "js" fn DefaultResourceLoader::get_skills(
  self : DefaultResourceLoader,
) -> JSValue =
  #| (self) => self.getSkills()

///|
pub extern "js" fn DefaultResourceLoader::get_prompts(
  self : DefaultResourceLoader,
) -> JSValue =
  #| (self) => self.getPrompts()

///|
pub extern "js" fn DefaultResourceLoader::get_themes(
  self : DefaultResourceLoader,
) -> JSValue =
  #| (self) => self.getThemes()

///|
pub extern "js" fn DefaultResourceLoader::get_agents_files(
  self : DefaultResourceLoader,
) -> JSValue =
  #| (self) => self.getAgentsFiles()

///|
pub extern "js" fn DefaultResourceLoader::get_system_prompt(
  self : DefaultResourceLoader,
) -> String? =
  #| (self) => self.getSystemPrompt()

///|
extern "js" fn _default_resource_loader_get_system_prompt_source_ret_conv_js(
  this_ : DefaultResourceLoader,
) -> JSValue =
  #| (self) => self.getSystemPromptSource()

///|
pub extern "js" fn DefaultResourceLoader::get_append_system_prompt(
  self : DefaultResourceLoader,
) -> Array[String] =
  #| (self) => self.getAppendSystemPrompt()

///|
pub extern "js" fn DefaultResourceLoader::get_append_system_prompt_sources(
  self : DefaultResourceLoader,
) -> Array[JSValue] =
  #| (self) => self.getAppendSystemPromptSources()

///|
pub extern "js" fn DefaultResourceLoader::extend_resources(
  self : DefaultResourceLoader,
  paths : ResourceExtensionPaths,
) -> Unit =
  #| (self, paths) => self.extendResources(paths)

///|
pub extern "js" fn DefaultResourceLoader::load_project_trust_extensions(
  self : DefaultResourceLoader,
) -> Promise[LoadExtensionsResult] =
  #| (self) => self.loadProjectTrustExtensions()

///|
pub extern "js" fn DefaultResourceLoader::reload(
  self : DefaultResourceLoader,
  options : ResourceLoaderReloadOptions?,
) -> Promise[Unit] =
  #| (self, options) => self.reload((options == null ? undefined : (typeof options === "object" && "$tag" in options ? (options.$tag === 1 ? options._0 : undefined) : options)))

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_tree_selector_component(
  tree : Array[SessionTreeNode],
  currentLeafId : String?,
  terminalHeight : Double,
  onSelect : (String) -> Unit,
  onCancel : () -> Unit,
  onLabelChange : ((String, String?) -> Unit)?,
  initialSelectedId : String?,
  initialFilterMode : FilterMode?,
) -> TreeSelectorComponent = "__ts_mbt_new_tree_selector_component"

///|
pub extern "js" fn TreeSelectorComponent::get_tree_selector_component_on_copy(
  self : TreeSelectorComponent,
) -> (String?) -> Unit =
  #| (self) => self.onCopy

///|
pub extern "js" fn TreeSelectorComponent::set_tree_selector_component_on_copy(
  self : TreeSelectorComponent,
  value : (String?) -> Unit,
) -> Unit =
  #| (self, value) => (self.onCopy = value)

///|
pub extern "js" fn TreeSelectorComponent::get_tree_selector_component_focused(
  self : TreeSelectorComponent,
) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn TreeSelectorComponent::set_tree_selector_component_focused(
  self : TreeSelectorComponent,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn TreeSelectorComponent::on_copy(
  self : TreeSelectorComponent,
  arg0 : String?,
) -> Unit =
  #| (self, arg0) => self.onCopy((arg0 == null ? undefined : (typeof arg0 === "object" && "$tag" in arg0 ? (arg0.$tag === 1 ? arg0._0 : undefined) : arg0)))

///|
pub extern "js" fn TreeSelectorComponent::focused(
  self : TreeSelectorComponent,
) -> Bool =
  #| (self) => self.focused()

///|
pub extern "js" fn TreeSelectorComponent::handle_input(
  self : TreeSelectorComponent,
  keyData : String,
) -> Unit =
  #| (self, keyData) => self.handleInput(keyData)

///|
pub extern "js" fn TreeSelectorComponent::get_tree_list(
  self : TreeSelectorComponent,
) -> TreeList =
  #| (self) => self.getTreeList()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_bash_execution_component(
  command : String,
  ui : TUI,
  excludeFromContext : Bool?,
) -> BashExecutionComponent = "__ts_mbt_new_bash_execution_component"

///|
pub extern "js" fn BashExecutionComponent::set_expanded(
  self : BashExecutionComponent,
  expanded : Bool,
) -> Unit =
  #| (self, expanded) => self.setExpanded(expanded)

///|
pub extern "js" fn BashExecutionComponent::invalidate(
  self : BashExecutionComponent,
) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn BashExecutionComponent::append_output(
  self : BashExecutionComponent,
  chunk : String,
) -> Unit =
  #| (self, chunk) => self.appendOutput(chunk)

///|
pub extern "js" fn BashExecutionComponent::set_complete(
  self : BashExecutionComponent,
  exitCode : Double?,
  cancelled : Bool,
  truncationResult : TruncationResult?,
  fullOutputPath : String?,
) -> Unit =
  #| (self, exitCode, cancelled, truncationResult, fullOutputPath) => self.setComplete((exitCode == null ? undefined : (typeof exitCode === "object" && "$tag" in exitCode ? (exitCode.$tag === 1 ? exitCode._0 : undefined) : exitCode)), cancelled, (truncationResult == null ? undefined : (typeof truncationResult === "object" && "$tag" in truncationResult ? (truncationResult.$tag === 1 ? truncationResult._0 : undefined) : truncationResult)), (fullOutputPath == null ? undefined : (typeof fullOutputPath === "object" && "$tag" in fullOutputPath ? (fullOutputPath.$tag === 1 ? fullOutputPath._0 : undefined) : fullOutputPath)))

///|
pub extern "js" fn BashExecutionComponent::get_output(
  self : BashExecutionComponent,
) -> String =
  #| (self) => self.getOutput()

///|
pub extern "js" fn BashExecutionComponent::get_command(
  self : BashExecutionComponent,
) -> String =
  #| (self) => self.getCommand()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_custom_message_component(
  message : CustomMessage[JSValue],
  customRenderer : MessageRenderer?,
  markdownTheme : MarkdownTheme?,
  outputPad : Double?,
) -> CustomMessageComponent = "__ts_mbt_new_custom_message_component"

///|
pub extern "js" fn CustomMessageComponent::set_expanded(
  self : CustomMessageComponent,
  expanded : Bool,
) -> Unit =
  #| (self, expanded) => self.setExpanded(expanded)

///|
pub extern "js" fn CustomMessageComponent::set_output_pad(
  self : CustomMessageComponent,
  outputPad : Double,
) -> Unit =
  #| (self, outputPad) => self.setOutputPad(outputPad)

///|
pub extern "js" fn CustomMessageComponent::invalidate(
  self : CustomMessageComponent,
) -> Unit =
  #| (self) => self.invalidate()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_model_selector_component(
  tui : TUI,
  currentModel : Model[JSValue]?,
  modelRuntime : ModelRuntime,
  scopedModels : Array[ScopedModelItem],
  onSelect : (Model[JSValue]) -> Unit,
  onCancel : () -> Unit,
  initialSearchInput : String?,
  onSelectAsDefault : ((Model[JSValue]) -> Unit)?,
  defaultModel : DefaultModelReference?,
) -> ModelSelectorComponent = "__ts_mbt_new_model_selector_component"

///|
pub extern "js" fn ModelSelectorComponent::get_model_selector_component_focused(
  self : ModelSelectorComponent,
) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn ModelSelectorComponent::set_model_selector_component_focused(
  self : ModelSelectorComponent,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn ModelSelectorComponent::focused(
  self : ModelSelectorComponent,
) -> Bool =
  #| (self) => self.focused()

///|
pub extern "js" fn ModelSelectorComponent::dispose(
  self : ModelSelectorComponent,
) -> Unit =
  #| (self) => self.dispose()

///|
pub extern "js" fn ModelSelectorComponent::handle_input(
  self : ModelSelectorComponent,
  keyData : String,
) -> Unit =
  #| (self, keyData) => self.handleInput(keyData)

///|
pub extern "js" fn ModelSelectorComponent::get_search_input(
  self : ModelSelectorComponent,
) -> Input =
  #| (self) => self.getSearchInput()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn new_oauth_selector_component_raw(
  mode : String,
  providers : Array[AuthSelectorProvider],
  onSelect : (String, String) -> Unit,
  onCancel : () -> Unit,
  initialSearchInput : String?,
) -> OAuthSelectorComponent = "__ts_mbt_new_oauth_selector_component"

///|
pub extern "js" fn OAuthSelectorComponent::get_oauth_selector_component_focused(
  self : OAuthSelectorComponent,
) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn OAuthSelectorComponent::set_oauth_selector_component_focused(
  self : OAuthSelectorComponent,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn OAuthSelectorComponent::focused(
  self : OAuthSelectorComponent,
) -> Bool =
  #| (self) => self.focused()

///|
pub extern "js" fn OAuthSelectorComponent::handle_input(
  self : OAuthSelectorComponent,
  keyData : String,
) -> Unit =
  #| (self, keyData) => self.handleInput(keyData)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_theme_selector_component(
  currentTheme : String,
  onSelect : (String) -> Unit,
  onCancel : () -> Unit,
  onPreview : (String) -> Unit,
) -> ThemeSelectorComponent = "__ts_mbt_new_theme_selector_component"

///|
pub extern "js" fn ThemeSelectorComponent::get_select_list(
  self : ThemeSelectorComponent,
) -> SelectList =
  #| (self) => self.getSelectList()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_tool_execution_component(
  toolName : String,
  toolCallId : String,
  args : JSValue,
  options : ToolExecutionOptions?,
  toolDefinition : JSValue?,
  ui : TUI,
  cwd : String,
) -> ToolExecutionComponent = "__ts_mbt_new_tool_execution_component"

///|
pub extern "js" fn ToolExecutionComponent::update_args(
  self : ToolExecutionComponent,
  args : JSValue,
) -> Unit =
  #| (self, args) => self.updateArgs(args)

///|
pub extern "js" fn ToolExecutionComponent::mark_execution_started(
  self : ToolExecutionComponent,
) -> Unit =
  #| (self) => self.markExecutionStarted()

///|
pub extern "js" fn ToolExecutionComponent::set_args_complete(
  self : ToolExecutionComponent,
) -> Unit =
  #| (self) => self.setArgsComplete()

///|
pub extern "js" fn ToolExecutionComponent::update_result(
  self : ToolExecutionComponent,
  result : ToolExecutionComponentUpdateResultResult,
  isPartial : Bool?,
) -> Unit =
  #| (self, result, isPartial) => self.updateResult(result, (isPartial === -1 ? undefined : (isPartial == null ? undefined : (typeof isPartial === "object" && "$tag" in isPartial ? (isPartial.$tag === 1 ? isPartial._0 : undefined) : isPartial))))

///|
pub extern "js" fn ToolExecutionComponent::set_expanded(
  self : ToolExecutionComponent,
  expanded : Bool,
) -> Unit =
  #| (self, expanded) => self.setExpanded(expanded)

///|
pub extern "js" fn ToolExecutionComponent::set_show_images(
  self : ToolExecutionComponent,
  show : Bool,
) -> Unit =
  #| (self, show) => self.setShowImages(show)

///|
pub extern "js" fn ToolExecutionComponent::set_image_width_cells(
  self : ToolExecutionComponent,
  width : Double,
) -> Unit =
  #| (self, width) => self.setImageWidthCells(width)

///|
pub extern "js" fn ToolExecutionComponent::invalidate(
  self : ToolExecutionComponent,
) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn ToolExecutionComponent::render(
  self : ToolExecutionComponent,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn ToolExecutionComponent::handle_mouse(
  self : ToolExecutionComponent,
  event : TuiMouseEvent,
) -> ReturnType =
  #| (self, event) => self.handleMouse(event)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_extension_input_component(
  title : String,
  _placeholder : String?,
  onSubmit : (String) -> Unit,
  onCancel : () -> Unit,
  opts : ExtensionInputOptions?,
) -> ExtensionInputComponent = "__ts_mbt_new_extension_input_component"

///|
pub extern "js" fn ExtensionInputComponent::get_extension_input_component_focused(
  self : ExtensionInputComponent,
) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn ExtensionInputComponent::set_extension_input_component_focused(
  self : ExtensionInputComponent,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn ExtensionInputComponent::focused(
  self : ExtensionInputComponent,
) -> Bool =
  #| (self) => self.focused()

///|
pub extern "js" fn ExtensionInputComponent::handle_input(
  self : ExtensionInputComponent,
  keyData : String,
) -> Unit =
  #| (self, keyData) => self.handleInput(keyData)

///|
pub extern "js" fn ExtensionInputComponent::dispose(
  self : ExtensionInputComponent,
) -> Unit =
  #| (self) => self.dispose()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_extension_editor_component(
  tui : TUI,
  keybindings : KeybindingsManager,
  title : String,
  prefill : String?,
  onSubmit : (String) -> Unit,
  onCancel : () -> Unit,
  options : EditorOptions?,
  externalEditorCommand : String?,
) -> ExtensionEditorComponent = "__ts_mbt_new_extension_editor_component"

///|
pub extern "js" fn ExtensionEditorComponent::get_extension_editor_component_focused(
  self : ExtensionEditorComponent,
) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn ExtensionEditorComponent::set_extension_editor_component_focused(
  self : ExtensionEditorComponent,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn ExtensionEditorComponent::focused(
  self : ExtensionEditorComponent,
) -> Bool =
  #| (self) => self.focused()

///|
pub extern "js" fn ExtensionEditorComponent::handle_input(
  self : ExtensionEditorComponent,
  keyData : String,
) -> Unit =
  #| (self, keyData) => self.handleInput(keyData)

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_session_selector_component(
  currentSessionsLoader : SessionsLoader,
  allSessionsLoader : SessionsLoader,
  onSelect : (String) -> Unit,
  onCancel : () -> Unit,
  onExit : () -> Unit,
  requestRender : () -> Unit,
  options : JSValue?,
  currentSessionFilePath : String?,
) -> SessionSelectorComponent = "__ts_mbt_new_session_selector_component"

///|
pub extern "js" fn SessionSelectorComponent::get_session_selector_component_focused(
  self : SessionSelectorComponent,
) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn SessionSelectorComponent::set_session_selector_component_focused(
  self : SessionSelectorComponent,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn SessionSelectorComponent::handle_input(
  self : SessionSelectorComponent,
  data : String,
) -> Unit =
  #| (self, data) => self.handleInput(data)

///|
pub extern "js" fn SessionSelectorComponent::focused(
  self : SessionSelectorComponent,
) -> Bool =
  #| (self) => self.focused()

///|
pub extern "js" fn SessionSelectorComponent::get_session_list(
  self : SessionSelectorComponent,
) -> SessionList =
  #| (self) => self.getSessionList()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_assistant_message_component(
  message : AssistantMessage?,
  hideThinkingBlock : Bool?,
  markdownTheme : MarkdownTheme?,
  hiddenThinkingLabel : String?,
  outputPad : Double?,
  markdownTransformers : Array[MarkdownTransformer]?,
) -> AssistantMessageComponent = "__ts_mbt_new_assistant_message_component"

///|
pub extern "js" fn AssistantMessageComponent::invalidate(
  self : AssistantMessageComponent,
) -> Unit =
  #| (self) => self.invalidate()

///|
pub extern "js" fn AssistantMessageComponent::set_hide_thinking_block(
  self : AssistantMessageComponent,
  hide : Bool,
) -> Unit =
  #| (self, hide) => self.setHideThinkingBlock(hide)

///|
pub extern "js" fn AssistantMessageComponent::set_hidden_thinking_label(
  self : AssistantMessageComponent,
  label : String,
) -> Unit =
  #| (self, label) => self.setHiddenThinkingLabel(label)

///|
pub extern "js" fn AssistantMessageComponent::set_output_pad(
  self : AssistantMessageComponent,
  padding : Double,
) -> Unit =
  #| (self, padding) => self.setOutputPad(padding)

///|
pub extern "js" fn AssistantMessageComponent::render(
  self : AssistantMessageComponent,
  width : Double,
) -> Array[String] =
  #| (self, width) => self.render(width)

///|
pub extern "js" fn AssistantMessageComponent::update_content(
  self : AssistantMessageComponent,
  message : AssistantMessage,
  isStreaming : Bool?,
) -> Unit =
  #| (self, message, isStreaming) => self.updateContent(message, (isStreaming === -1 ? undefined : (isStreaming == null ? undefined : (typeof isStreaming === "object" && "$tag" in isStreaming ? (isStreaming.$tag === 1 ? isStreaming._0 : undefined) : isStreaming))))

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_settings_selector_component(
  config : SettingsConfig,
  callbacks : SettingsCallbacks,
) -> SettingsSelectorComponent = "__ts_mbt_new_settings_selector_component"

///|
pub extern "js" fn SettingsSelectorComponent::get_settings_list(
  self : SettingsSelectorComponent,
) -> SettingsList =
  #| (self) => self.getSettingsList()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_thinking_selector_component(
  currentLevel : ThinkingLevel,
  availableLevels : Array[ThinkingLevel],
  onSelect : (ThinkingLevel) -> Unit,
  onCancel : () -> Unit,
  onSelectAsDefault : ((ThinkingLevel) -> Unit)?,
  defaultThinkingLevel : ThinkingLevel?,
) -> ThinkingSelectorComponent = "__ts_mbt_new_thinking_selector_component"

///|
pub extern "js" fn ThinkingSelectorComponent::get_thinking_selector_component_focused(
  self : ThinkingSelectorComponent,
) -> Bool =
  #| (self) => self.focused

///|
pub extern "js" fn ThinkingSelectorComponent::set_thinking_selector_component_focused(
  self : ThinkingSelectorComponent,
  value : Bool,
) -> Unit =
  #| (self, value) => (self.focused = value)

///|
pub extern "js" fn ThinkingSelectorComponent::focused(
  self : ThinkingSelectorComponent,
) -> Bool =
  #| (self) => self.focused()

///|
pub extern "js" fn ThinkingSelectorComponent::handle_input(
  self : ThinkingSelectorComponent,
  keyData : String,
) -> Unit =
  #| (self, keyData) => self.handleInput(keyData)

///|
pub extern "js" fn ThinkingSelectorComponent::get_select_list(
  self : ThinkingSelectorComponent,
) -> SelectList =
  #| (self) => self.getSelectList()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_extension_selector_component(
  title : String,
  options : Array[String],
  onSelect : (String) -> Unit,
  onCancel : () -> Unit,
  opts : ExtensionSelectorOptions?,
) -> ExtensionSelectorComponent = "__ts_mbt_new_extension_selector_component"

///|
pub extern "js" fn ExtensionSelectorComponent::handle_input(
  self : ExtensionSelectorComponent,
  keyData : String,
) -> Unit =
  #| (self, keyData) => self.handleInput(keyData)

///|
pub extern "js" fn ExtensionSelectorComponent::dispose(
  self : ExtensionSelectorComponent,
) -> Unit =
  #| (self) => self.dispose()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_show_images_selector_component(
  currentValue : Bool,
  onSelect : (Bool) -> Unit,
  onCancel : () -> Unit,
) -> ShowImagesSelectorComponent = "__ts_mbt_new_show_images_selector_component"

///|
pub extern "js" fn ShowImagesSelectorComponent::get_select_list(
  self : ShowImagesSelectorComponent,
) -> SelectList =
  #| (self) => self.getSelectList()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_user_message_selector_component(
  messages : Array[UserMessageItem],
  onSelect : (String) -> Unit,
  onCancel : () -> Unit,
  initialSelectedId : String?,
) -> UserMessageSelectorComponent = "__ts_mbt_new_user_message_selector_component"

///|
pub extern "js" fn UserMessageSelectorComponent::get_message_list(
  self : UserMessageSelectorComponent,
) -> UserMessageList =
  #| (self) => self.getMessageList()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_branch_summary_message_component(
  message : BranchSummaryMessage,
  markdownTheme : MarkdownTheme?,
) -> BranchSummaryMessageComponent = "__ts_mbt_new_branch_summary_message_component"

///|
pub extern "js" fn BranchSummaryMessageComponent::set_expanded(
  self : BranchSummaryMessageComponent,
  expanded : Bool,
) -> Unit =
  #| (self, expanded) => self.setExpanded(expanded)

///|
pub extern "js" fn BranchSummaryMessageComponent::invalidate(
  self : BranchSummaryMessageComponent,
) -> Unit =
  #| (self) => self.invalidate()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn new_credential_synchronization_error_raw(
  providerId : String,
  operation : String,
  credential : Credential?,
  options : ErrorOptions,
) -> CredentialSynchronizationError = "__ts_mbt_new_credential_synchronization_error"

///|
pub extern "js" fn CredentialSynchronizationError::get_credential_synchronization_error_provider_id(
  self : CredentialSynchronizationError,
) -> String =
  #| (self) => self.providerId

///|
extern "js" fn _get_credential_synchronization_error_operation_ret_conv_js(
  this_ : CredentialSynchronizationError,
) -> String =
  #| (self) => self.operation

///|
extern "js" fn _get_credential_synchronization_error_credential_ret_conv_js(
  this_ : CredentialSynchronizationError,
) -> JSValue =
  #| (self) => self.credential

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_skill_invocation_message_component(
  skillBlock : ParsedSkillBlock,
  markdownTheme : MarkdownTheme?,
) -> SkillInvocationMessageComponent = "__ts_mbt_new_skill_invocation_message_component"

///|
pub extern "js" fn SkillInvocationMessageComponent::set_expanded(
  self : SkillInvocationMessageComponent,
  expanded : Bool,
) -> Unit =
  #| (self, expanded) => self.setExpanded(expanded)

///|
pub extern "js" fn SkillInvocationMessageComponent::invalidate(
  self : SkillInvocationMessageComponent,
) -> Unit =
  #| (self) => self.invalidate()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn new_compaction_summary_message_component(
  message : CompactionSummaryMessage,
  markdownTheme : MarkdownTheme?,
) -> CompactionSummaryMessageComponent = "__ts_mbt_new_compaction_summary_message_component"

///|
pub extern "js" fn CompactionSummaryMessageComponent::set_expanded(
  self : CompactionSummaryMessageComponent,
  expanded : Bool,
) -> Unit =
  #| (self, expanded) => self.setExpanded(expanded)

///|
pub extern "js" fn CompactionSummaryMessageComponent::invalidate(
  self : CompactionSummaryMessageComponent,
) -> Unit =
  #| (self) => self.invalidate()

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn main_(
  args : Array[String],
  options : MainOptions?,
) -> Promise[Unit] = "__ts_mbt_main"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn compact(
  preparation : CompactionPreparation,
  model : Model[JSValue],
  apiKey : String?,
  headers : StringRecordOfString?,
  customInstructions : String?,
  signal : AbortSignal?,
  thinkingLevel : ThinkingLevel?,
  streamFn : StreamFn?,
  env : StringRecordOfString?,
  retry : RetryPolicy?,
  callbacks : RetryCallbacks?,
  sessionId : String?,
) -> Promise[CompactionResult[JSValue]] = "__ts_mbt_compact"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn key_hint(
  keybinding : Keybinding,
  description : String,
) -> String = "keyHint"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn key_text(keybinding : Keybinding) -> String = "keyText"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn init_theme(themeName : String?, enableWatcher : Bool?) -> Unit = "__ts_mbt_init_theme"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn parse_args(args : Array[String]) -> Args = "parseArgs"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn define_tool(
  tool : ToolDefinition[TSchema, TDetails, TState[JSValue, JSValue]],
) -> JSValue = "__ts_mbt_define_tool"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn format_size(bytes : Double) -> String = "formatSize"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn load_skills(options : LoadSkillsOptions) -> LoadSkillsResult = "loadSkills"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn raw_key_hint(key : String, description : String) -> String = "rawKeyHint"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn render_diff(
  diffText : String,
  _options : RenderDiffOptions?,
) -> String = "__ts_mbt_render_diff"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn run_rpc_mode(
  runtimeHost : AgentSessionRuntime,
) -> Promise[JSValue] = "runRpcMode"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_agent_dir() -> String = "getAgentDir"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_docs_path() -> String = "getDocsPath"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn resize_image(
  inputBytes : Uint8Array,
  mimeType : String,
  options : ImageResizeOptions?,
) -> Promise[ResizedImage?] = "__ts_mbt_resize_image"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn convert_to_llm(messages : Array[AgentMessage]) -> Array[Message] = "convertToLlm"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn convert_to_png(
  base64Data : String,
  mimeType : String,
) -> Promise[JSValue?] = "convertToPng"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_ls_tool(
  cwd : String,
  options : LsToolOptions?,
) -> AgentTool[JSValue, JSValue] = "__ts_mbt_create_ls_tool"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn find_cut_point(
  entries : Array[SessionEntry],
  startIndex : Double,
  endIndex : Double,
  keepRecentTokens : Double,
) -> CutPointResult = "__ts_mbt_find_cut_point"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn run_print_mode(
  runtimeHost : AgentSessionRuntime,
  options : PrintModeOptions,
) -> Promise[Double] = "__ts_mbt_run_print_mode"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn truncate_head(
  content : String,
  options : TruncationOptions?,
) -> TruncationResult = "__ts_mbt_truncate_head"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn truncate_line(
  line : String,
  maxChars : Double?,
) -> TruncateLineResult = "__ts_mbt_truncate_line"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn truncate_tail(
  content : String,
  options : TruncationOptions?,
) -> TruncationResult = "__ts_mbt_truncate_tail"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_package_dir() -> String = "getPackageDir"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_readme_path() -> String = "getReadmePath"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn highlight_code(code : String, lang : String?) -> Array[String] = "__ts_mbt_highlight_code"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn should_compact(
  contextTokens : Double,
  contextWindow : Double,
  settings : CompactionSettings,
) -> Bool = "__ts_mbt_should_compact"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_bash_tool(
  cwd : String,
  options : BashToolOptions?,
) -> AgentTool[JSValue, JSValue] = "__ts_mbt_create_bash_tool"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_edit_tool(
  cwd : String,
  options : EditToolOptions?,
) -> AgentTool[JSValue, JSValue] = "__ts_mbt_create_edit_tool"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn create_event_bus() -> EventBusController = "createEventBus"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_find_tool(
  cwd : String,
  options : FindToolOptions?,
) -> AgentTool[JSValue, JSValue] = "__ts_mbt_create_find_tool"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_grep_tool(
  cwd : String,
  options : GrepToolOptions?,
) -> AgentTool[JSValue, JSValue] = "__ts_mbt_create_grep_tool"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_read_tool(
  cwd : String,
  options : ReadToolOptions?,
) -> AgentTool[JSValue, JSValue] = "__ts_mbt_create_read_tool"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn estimate_tokens(message : AgentMessage) -> Double = "estimateTokens"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn get_shell_config(customShellPath : String?) -> ShellConfig = "__ts_mbt_get_shell_config"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_ls_tool_result(e : ToolResultEvent) -> Bool = "__ts_mbt_is_ls_tool_result"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn copy_to_clipboard(text : String) -> Promise[Unit] = "copyToClipboard"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_write_tool(
  cwd : String,
  options : WriteToolOptions?,
) -> AgentTool[JSValue, JSValue] = "__ts_mbt_create_write_tool"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn generate_summary(
  currentMessages : Array[AgentMessage],
  model : Model[JSValue],
  reserveTokens : Double,
  apiKey : String?,
  headers : StringRecordOfString?,
  signal : AbortSignal?,
  customInstructions : String?,
  previousSummary : String?,
  thinkingLevel : ThinkingLevel?,
  streamFn : StreamFn?,
  env : StringRecordOfString?,
  retry : RetryPolicy?,
  callbacks : RetryCallbacks?,
  sessionId : String?,
) -> Promise[String] = "__ts_mbt_generate_summary"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_examples_path() -> String = "getExamplesPath"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn parse_skill_block(text : String) -> ParsedSkillBlock? = "parseSkillBlock"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn resolve_cli_model(options : JSValue) -> ResolveCliModelResult = "resolveCliModel"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_markdown_theme() -> MarkdownTheme = "getMarkdownTheme"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_bash_tool_result(e : ToolResultEvent) -> Bool = "__ts_mbt_is_bash_tool_result"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_edit_tool_result(e : ToolResultEvent) -> Bool = "__ts_mbt_is_edit_tool_result"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_find_tool_result(e : ToolResultEvent) -> Bool = "__ts_mbt_is_find_tool_result"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_grep_tool_result(e : ToolResultEvent) -> Bool = "__ts_mbt_is_grep_tool_result"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_read_tool_result(e : ToolResultEvent) -> Bool = "__ts_mbt_is_read_tool_result"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_coding_tools(
  cwd : String,
  options : ToolsOptions?,
) -> Array[Tool[JSValue]] = "__ts_mbt_create_coding_tools"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_write_tool_result(e : ToolResultEvent) -> Bool = "__ts_mbt_is_write_tool_result"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn load_skills_from_dir(
  options : LoadSkillsFromDirOptions,
) -> LoadSkillsResult = "loadSkillsFromDir"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_agent_session(
  options : CreateAgentSessionOptions?,
) -> Promise[CreateAgentSessionResult] = "__ts_mbt_create_agent_session"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn find_turn_start_index(
  entries : Array[SessionEntry],
  entryIndex : Double,
  startIndex : Double,
) -> Double = "__ts_mbt_find_turn_start_index"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn generate_diff_string(
  oldContent : String,
  newContent : String,
  contextLines : Double?,
) -> GenerateDiffStringResult = "__ts_mbt_generate_diff_string"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_select_list_theme() -> SelectListTheme = "getSelectListTheme"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn wrap_registered_tool(
  registeredTool : RegisteredTool,
  runner : ExtensionRunner,
) -> AgentTool[JSValue, JSValue] = "wrapRegisteredTool"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn build_context_entries(
  entries : Array[SessionEntry],
  leafId : String?,
  byId : Map?,
) -> Array[SessionEntry] = "__ts_mbt_build_context_entries"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn build_session_context(
  entries : Array[SessionEntry],
  leafId : String?,
  byId : Map?,
) -> SessionContext = "__ts_mbt_build_session_context"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_read_only_tools(
  cwd : String,
  options : ToolsOptions?,
) -> Array[Tool[JSValue]] = "__ts_mbt_create_read_only_tools"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn format_dimension_note(result : ResizedImage) -> String? = "formatDimensionNote"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_language_from_path(filePath : String) -> String? = "getLanguageFromPath"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_power_shell_config() -> ShellConfig = "getPowerShellConfig"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_tool_call_event_type(
  toolName : String,
  event : ToolCallEvent,
) -> Bool = "__ts_mbt_is_tool_call_event_type"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn parse_session_entries(content : String) -> Array[FileEntry] = "parseSessionEntries"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn wrap_registered_tools(
  registeredTools : Array[RegisteredTool],
  runner : ExtensionRunner,
) -> Array[AgentTool[JSValue, JSValue]] = "wrapRegisteredTools"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_power_shell_tool(
  cwd : String,
  options : PowerShellToolOptions?,
) -> ReturnType = "__ts_mbt_create_power_shell_tool"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn generate_unified_patch(
  path : String,
  oldContent : String,
  newContent : String,
  contextLines : Double?,
) -> String = "__ts_mbt_generate_unified_patch"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn get_settings_list_theme() -> SettingsListTheme = "getSettingsListTheme"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn prepare_branch_entries(
  entries : Array[SessionEntry],
  tokenBudget : Double?,
) -> BranchPreparation = "__ts_mbt_prepare_branch_entries"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn read_stored_credential(
  providerId : String,
  authPath : String?,
) -> Credential? = "__ts_mbt_read_stored_credential"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn format_skills_for_prompt(
  skills : Array[Skill],
  fileReadTool : String?,
) -> String = "__ts_mbt_format_skills_for_prompt"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn generate_branch_summary(
  entries : Array[SessionEntry],
  options : GenerateBranchSummaryOptions,
) -> Promise[BranchSummaryResult] = "__ts_mbt_generate_branch_summary"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn get_last_assistant_usage(
  entries : Array[SessionEntry],
) -> Usage? = "__ts_mbt_get_last_assistant_usage"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn migrate_session_entries(entries : Array[FileEntry]) -> Unit = "__ts_mbt_migrate_session_entries"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn serialize_conversation(messages : Array[Message]) -> String = "serializeConversation"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn truncate_to_visual_lines(
  text : String,
  maxVisualLines : Double,
  width : Double,
  paddingX : Double?,
) -> VisualTruncateResult = "__ts_mbt_truncate_to_visual_lines"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn with_file_mutation_queue(
  filePath : String,
  fn_ : () -> Promise[JSValue],
) -> Promise[JSValue] = "withFileMutationQueue"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn calculate_context_tokens(usage : Usage) -> Double = "calculateContextTokens"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn create_extension_runtime() -> ExtensionRuntime = "createExtensionRuntime"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_ls_tool_definition(
  cwd : String,
  options : LsToolOptions?,
) -> ToolDefinition[JSValue, JSValue, JSValue] = "__ts_mbt_create_ls_tool_definition"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_power_shell_tool_result(e : ToolResultEvent) -> Bool = "__ts_mbt_is_power_shell_tool_result"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn load_project_context_files(options : JSValue) -> Array[JSValue] = "loadProjectContextFiles"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_bash_tool_definition(
  cwd : String,
  options : BashToolOptions?,
) -> ToolDefinition[JSValue, BashToolDetails?, BashRenderState] = "__ts_mbt_create_bash_tool_definition"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_edit_tool_definition(
  cwd : String,
  options : EditToolOptions?,
) -> ToolDefinition[JSValue, EditToolDetails?, EditRenderState] = "__ts_mbt_create_edit_tool_definition"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_find_tool_definition(
  cwd : String,
  options : FindToolOptions?,
) -> ToolDefinition[JSValue, JSValue, JSValue] = "__ts_mbt_create_find_tool_definition"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_grep_tool_definition(
  cwd : String,
  options : GrepToolOptions?,
) -> ToolDefinition[JSValue, JSValue, JSValue] = "__ts_mbt_create_grep_tool_definition"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_read_tool_definition(
  cwd : String,
  options : ReadToolOptions?,
) -> ToolDefinition[JSValue, JSValue, JSValue] = "__ts_mbt_create_read_tool_definition"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn generate_summary_with_usage(
  currentMessages : Array[AgentMessage],
  model : Model[JSValue],
  reserveTokens : Double,
  apiKey : String?,
  headers : StringRecordOfString?,
  signal : AbortSignal?,
  customInstructions : String?,
  previousSummary : String?,
  thinkingLevel : ThinkingLevel?,
  streamFn : StreamFn?,
  env : StringRecordOfString?,
  retry : RetryPolicy?,
  callbacks : RetryCallbacks?,
  sessionId : String?,
) -> Promise[GenerateSummaryWithUsageResult] = "__ts_mbt_generate_summary_with_usage"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn get_latest_compaction_entry(
  entries : Array[SessionEntry],
) -> CompactionEntry[JSValue]? = "__ts_mbt_get_latest_compaction_entry"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn create_agent_session_runtime(
  createRuntime : CreateAgentSessionRuntimeFactory,
  options : JSValue,
) -> Promise[AgentSessionRuntime] = "createAgentSessionRuntime"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_local_bash_operations(
  options : JSValue?,
) -> BashOperations = "__ts_mbt_create_local_bash_operations"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn create_synthetic_source_info(
  path : String,
  options : JSValue,
) -> SourceInfo = "createSyntheticSourceInfo"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_write_tool_definition(
  cwd : String,
  options : WriteToolOptions?,
) -> ToolDefinition[JSValue, JSValue, JSValue] = "__ts_mbt_create_write_tool_definition"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn discover_and_load_extensions(
  configuredPaths : Array[String],
  cwd : String,
  agentDir : String?,
  eventBus : EventBus?,
) -> Promise[LoadExtensionsResult] = "__ts_mbt_discover_and_load_extensions"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_agent_session_services(
  options : CreateAgentSessionServicesOptions,
) -> Promise[AgentSessionServices] = "__ts_mbt_create_agent_session_services"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn session_entry_to_context_messages(
  entry : SessionEntry,
) -> Array[AgentMessage] = "__ts_mbt_session_entry_to_context_messages"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn collect_entries_for_branch_summary(
  session : ReadonlySessionManager,
  oldLeafId : String?,
  targetId : String,
) -> CollectEntriesResult = "__ts_mbt_collect_entries_for_branch_summary"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_agent_session_from_services(
  options : CreateAgentSessionFromServicesOptions,
) -> Promise[CreateAgentSessionResult] = "__ts_mbt_create_agent_session_from_services"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn create_power_shell_tool_definition(
  cwd : String,
  options : PowerShellToolOptions?,
) -> ReturnType = "__ts_mbt_create_power_shell_tool_definition"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn create_local_power_shell_operations() -> PowerShellOperations = "createLocalPowerShellOperations"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn resolve_model_scope_with_diagnostics(
  patterns : Array[String],
  modelRuntime : ModelRuntime,
  options : AuthOperationOptions?,
) -> Promise[ResolveModelScopeResult] = "__ts_mbt_resolve_model_scope_with_diagnostics"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn has_trust_requiring_project_resources(cwd : String) -> Bool = "hasTrustRequiringProjectResources"

///|
#module("@earendil-works/pi-coding-agent")
extern "js" fn detect_supported_image_mime_type_from_file(
  filePath : String,
) -> Promise[String?] = "detectSupportedImageMimeTypeFromFile"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn is_tool_call_event_type_string_tool_call_event(
  toolName : String,
  event : ToolCallEvent,
) -> Bool = "__ts_mbt_is_tool_call_event_type_string_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn _promise_then_extern_js(
  p : JSValue,
  on_ok : (JSValue) -> Unit,
) -> Unit = "__ts_mbt_promise_then"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
extern "js" fn _promise_then_catch_extern_js(
  p : JSValue,
  on_ok : (JSValue) -> Unit,
  on_err : (JSValue) -> Unit,
) -> Unit = "__ts_mbt_promise_then_catch"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
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
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn get_version() -> String = "__ts_mbt_get_version"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn get_config_dir_name() -> String = "__ts_mbt_get_config_dir_name"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn get_parse_frontmatter() -> JSValue = "__ts_mbt_get_parse_frontmatter"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn get_strip_frontmatter() -> (String) -> String = "__ts_mbt_get_strip_frontmatter"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn strip_frontmatter(arg0 : String) -> String = "__ts_mbt_strip_frontmatter"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn get_default_max_bytes() -> Double = "__ts_mbt_get_default_max_bytes"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn get_default_max_lines() -> JSValue = "__ts_mbt_get_default_max_lines"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn get_current_session_version() -> JSValue = "__ts_mbt_get_current_session_version"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn get_default_compaction_settings() -> CompactionSettings = "__ts_mbt_get_default_compaction_settings"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn bash_tool_input_from_static(value : Static) -> BashToolInput = "__ts_mbt_bash_tool_input_from_static"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn agent_session_event_from_exclude(
  value : Exclude,
) -> AgentSessionEvent = "__ts_mbt_agent_session_event_from_exclude"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_start_event(
  value : SessionStartEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_start_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_info_changed_event(
  value : SessionInfoChangedEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_info_changed_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_before_switch_event(
  value : SessionBeforeSwitchEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_before_switch_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_before_fork_event(
  value : SessionBeforeForkEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_before_fork_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_before_compact_event(
  value : SessionBeforeCompactEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_before_compact_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_compact_event(
  value : SessionCompactEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_compact_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_compact_failed_event(
  value : SessionCompactFailedEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_compact_failed_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_shutdown_event(
  value : SessionShutdownEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_shutdown_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_before_tree_event(
  value : SessionBeforeTreeEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_before_tree_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_event_from_session_tree_event(
  value : SessionTreeEvent,
) -> SessionEvent = "__ts_mbt_session_event_from_session_tree_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn thinking_level_from_string(value : String) -> ThinkingLevel = "__ts_mbt_thinking_level_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn mode_from_string(value : String) -> Mode = "__ts_mbt_mode_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn source_scope_from_string(value : String) -> SourceScope = "__ts_mbt_source_scope_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn source_origin_from_string(value : String) -> SourceOrigin = "__ts_mbt_source_origin_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn inline_extension_from_extension_factory(
  value : ExtensionFactory,
) -> InlineExtension = "__ts_mbt_inline_extension_from_extension_factory"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn api_from_known_api(value : KnownApi) -> Api = "__ts_mbt_api_from_known_api"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn api_from_string(value : String) -> Api = "__ts_mbt_api_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn agent_message_from_message(value : Message) -> AgentMessage = "__ts_mbt_agent_message_from_message"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn key_id_from_base_key(value : BaseKey) -> KeyId = "__ts_mbt_key_id_from_base_key"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn key_id_from_modified_key_id(value : ModifiedKeyId) -> KeyId = "__ts_mbt_key_id_from_modified_key_id"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn missing_source_action_from_string(
  value : String,
) -> MissingSourceAction = "__ts_mbt_missing_source_action_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn transport_from_string(value : String) -> Transport = "__ts_mbt_transport_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn terminal_theme_from_string(value : String) -> TerminalTheme = "__ts_mbt_terminal_theme_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn mermaid_rendering_mode_from_string(
  value : String,
) -> MermaidRenderingMode = "__ts_mbt_mermaid_rendering_mode_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn scroll_view_scrollbar_from_string(
  value : String,
) -> ScrollViewScrollbar = "__ts_mbt_scroll_view_scrollbar_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn ls_tool_input_from_static(value : Static) -> LsToolInput = "__ts_mbt_ls_tool_input_from_static"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_mode_from_string(value : String) -> ExtensionMode = "__ts_mbt_extension_mode_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn readonly_session_manager_from_pick(
  value : Pick,
) -> ReadonlySessionManager = "__ts_mbt_readonly_session_manager_from_pick"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn edit_tool_input_from_static(value : Static) -> EditToolInput = "__ts_mbt_edit_tool_input_from_static"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn find_tool_input_from_static(value : Static) -> FindToolInput = "__ts_mbt_find_tool_input_from_static"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn grep_tool_input_from_static(value : Static) -> GrepToolInput = "__ts_mbt_grep_tool_input_from_static"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn read_tool_input_from_static(value : Static) -> ReadToolInput = "__ts_mbt_read_tool_input_from_static"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn write_tool_input_from_static(
  value : Static,
) -> WriteToolInput = "__ts_mbt_write_tool_input_from_static"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn provider_headers_from_record(
  value : Record,
) -> ProviderHeaders = "__ts_mbt_provider_headers_from_record"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn transport_setting_from_transport(
  value : Transport,
) -> TransportSetting = "__ts_mbt_transport_setting_from_transport"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn package_source_from_string(value : String) -> PackageSource = "__ts_mbt_package_source_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn model_select_source_from_string(
  value : String,
) -> ModelSelectSource = "__ts_mbt_model_select_source_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn settings_scope_from_string(value : String) -> SettingsScope = "__ts_mbt_settings_scope_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn color_mode_from_string(value : String) -> ColorMode = "__ts_mbt_color_mode_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn theme_bg_from_string(value : String) -> ThemeBg = "__ts_mbt_theme_bg_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn auth_type_from_string(value : String) -> AuthType = "__ts_mbt_auth_type_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn credential_from_api_key_credential(
  value : ApiKeyCredential,
) -> Credential = "__ts_mbt_credential_from_api_key_credential"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn credential_from_oauth_credential(
  value : OAuthCredential,
) -> Credential = "__ts_mbt_credential_from_oauth_credential"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn keybindings_config_from_record(
  value : Record,
) -> KeybindingsConfig = "__ts_mbt_keybindings_config_from_record"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn runner_emit_event_from_exclude(
  value : Exclude,
) -> RunnerEmitEvent = "__ts_mbt_runner_emit_event_from_exclude"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn filter_mode_from_string(value : String) -> FilterMode = "__ts_mbt_filter_mode_from_string"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn message_from_user_message(value : UserMessage) -> Message = "__ts_mbt_message_from_user_message"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn message_from_assistant_message(
  value : AssistantMessage,
) -> Message = "__ts_mbt_message_from_assistant_message"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn message_from_tool_result_message(
  value : ToolResultMessage[JSValue],
) -> Message = "__ts_mbt_message_from_tool_result_message"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_from_agent_tool(
  value : AgentTool[JSValue, JSValue],
) -> Tool[JSValue] = "__ts_mbt_tool_from_agent_tool"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn file_entry_from_session_header(
  value : SessionHeader,
) -> FileEntry = "__ts_mbt_file_entry_from_session_header"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn file_entry_from_session_entry(
  value : SessionEntry,
) -> FileEntry = "__ts_mbt_file_entry_from_session_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_session_message_entry(
  value : SessionMessageEntry,
) -> SessionEntry = "__ts_mbt_session_entry_from_session_message_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_thinking_level_change_entry(
  value : ThinkingLevelChangeEntry,
) -> SessionEntry = "__ts_mbt_session_entry_from_thinking_level_change_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_model_change_entry(
  value : ModelChangeEntry,
) -> SessionEntry = "__ts_mbt_session_entry_from_model_change_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_compaction_entry(
  value : CompactionEntry[JSValue],
) -> SessionEntry = "__ts_mbt_session_entry_from_compaction_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_branch_summary_entry(
  value : BranchSummaryEntry[JSValue],
) -> SessionEntry = "__ts_mbt_session_entry_from_branch_summary_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_custom_entry(
  value : CustomEntry[JSValue],
) -> SessionEntry = "__ts_mbt_session_entry_from_custom_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_custom_message_entry(
  value : CustomMessageEntry[JSValue],
) -> SessionEntry = "__ts_mbt_session_entry_from_custom_message_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_label_entry(
  value : LabelEntry,
) -> SessionEntry = "__ts_mbt_session_entry_from_label_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn session_entry_from_session_info_entry(
  value : SessionInfoEntry,
) -> SessionEntry = "__ts_mbt_session_entry_from_session_info_entry"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_bash_tool_call_event(
  value : BashToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_bash_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_power_shell_tool_call_event(
  value : PowerShellToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_power_shell_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_read_tool_call_event(
  value : ReadToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_read_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_edit_tool_call_event(
  value : EditToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_edit_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_write_tool_call_event(
  value : WriteToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_write_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_grep_tool_call_event(
  value : GrepToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_grep_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_find_tool_call_event(
  value : FindToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_find_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_ls_tool_call_event(
  value : LsToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_ls_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_call_event_from_custom_tool_call_event(
  value : CustomToolCallEvent,
) -> ToolCallEvent = "__ts_mbt_tool_call_event_from_custom_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_project_trust_event(
  value : ProjectTrustEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_project_trust_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_resources_discover_event(
  value : ResourcesDiscoverEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_resources_discover_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_session_event(
  value : SessionEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_session_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_context_event(
  value : ContextEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_context_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_before_provider_request_event(
  value : BeforeProviderRequestEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_before_provider_request_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_before_provider_headers_event(
  value : BeforeProviderHeadersEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_before_provider_headers_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_after_provider_response_event(
  value : AfterProviderResponseEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_after_provider_response_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_before_agent_start_event(
  value : BeforeAgentStartEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_before_agent_start_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_agent_start_event(
  value : AgentStartEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_agent_start_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_agent_end_event(
  value : AgentEndEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_agent_end_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_agent_settled_event(
  value : AgentSettledEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_agent_settled_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_uiprompt_start_event(
  value : UIPromptStartEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_uiprompt_start_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_uiprompt_end_event(
  value : UIPromptEndEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_uiprompt_end_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_turn_start_event(
  value : TurnStartEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_turn_start_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_turn_end_event(
  value : TurnEndEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_turn_end_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_message_start_event(
  value : MessageStartEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_message_start_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_message_update_event(
  value : MessageUpdateEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_message_update_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_message_end_event(
  value : MessageEndEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_message_end_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_tool_execution_start_event(
  value : ToolExecutionStartEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_tool_execution_start_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_tool_execution_update_event(
  value : ToolExecutionUpdateEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_tool_execution_update_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_tool_execution_end_event(
  value : ToolExecutionEndEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_tool_execution_end_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_model_select_event(
  value : ModelSelectEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_model_select_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_thinking_level_select_event(
  value : ThinkingLevelSelectEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_thinking_level_select_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_user_bash_event(
  value : UserBashEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_user_bash_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_input_event(
  value : InputEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_input_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_tool_call_event(
  value : ToolCallEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_tool_call_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn extension_event_from_tool_result_event(
  value : ToolResultEvent,
) -> ExtensionEvent = "__ts_mbt_extension_event_from_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_bash_tool_result_event(
  value : BashToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_bash_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_power_shell_tool_result_event(
  value : PowerShellToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_power_shell_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_read_tool_result_event(
  value : ReadToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_read_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_edit_tool_result_event(
  value : EditToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_edit_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_write_tool_result_event(
  value : WriteToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_write_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_grep_tool_result_event(
  value : GrepToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_grep_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_find_tool_result_event(
  value : FindToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_find_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_ls_tool_result_event(
  value : LsToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_ls_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn tool_result_event_from_custom_tool_result_event(
  value : CustomToolResultEvent,
) -> ToolResultEvent = "__ts_mbt_tool_result_event_from_custom_tool_result_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn json_agent_session_event_from_agent_session_event(
  value : AgentSessionEvent,
) -> JsonAgentSessionEvent = "__ts_mbt_json_agent_session_event_from_agent_session_event"

///|
#module("@tsmbt-bridge/earendil_works__pi_coding_agent")
pub extern "js" fn json_agent_session_event_from_json_message_update_event(
  value : JsonMessageUpdateEvent,
) -> JsonAgentSessionEvent = "__ts_mbt_json_agent_session_event_from_json_message_update_event"

///|
extern "js" fn __ts_mbt_option_return_is_absent(value : JSValue) -> Bool =
  #| (value) => value === undefined || value === null
