local M = {}

----@diagnostic disable-next-line
function M.on_attach(client, bufnr)
  local sc = client.server_capabilities

  if client.name == "pyright" then
    --sc.completionProvider = false
    --sc.signatureHelpProvider = false
    -- sc.hoverProvider = false
    sc.definitionProvider = false
    -- sc.workspaceSymbolProvider = false
    --sc.documentHighlightProvider = false

    -- callHierarchyProvider = true,
    -- codeActionProvider = {
    --   codeActionKinds = { "quickfix", "source.organizeImports" },
    --   workDoneProgress = true
    -- },
    -- completionProvider = {
    --   completionItem = {
    --     labelDetailsSupport = true
    --   },
    --   resolveProvider = true,
    --   triggerCharacters = { ".", "[" },
    --   workDoneProgress = true
    -- },
    -- declarationProvider = {
    --   workDoneProgress = true
    -- },
    -- definitionProvider = false,
    -- documentHighlightProvider = {
    --   workDoneProgress = true
    -- },
    -- documentSymbolProvider = {
    --   workDoneProgress = true
    -- },
    -- executeCommandProvider = {
    --   commands = {},
    --   workDoneProgress = true
    -- },
    -- hoverProvider = false,
    -- referencesProvider = {
    --   workDoneProgress = true
    -- },
    -- renameProvider = {
    --   prepareProvider = true,
    --   workDoneProgress = true
    -- },
    -- signatureHelpProvider = {
    --   triggerCharacters = { "(", ",", ")" },
    --   workDoneProgress = true
    -- },
    -- textDocumentSync = {
    --   change = 2,
    --   openClose = true,
    --   save = {
    --     includeText = false
    --   },
    --   willSave = false,
    --   willSaveWaitUntil = false
    -- },
    -- typeDefinitionProvider = {
    --   workDoneProgress = true
    -- },
    -- workspaceSymbolProvider = {
    --   workDoneProgress = true
    -- }
  end

  if client.name == "jedi_language_server" then
    -- sc.signatureHelpProvider = false
    -- sc.renameProvider = false

    --sc.documentHighlightProvider = false

    -- codeActionProvider = {
    --   codeActionKinds = { "refactor.inline", "refactor.extract" }
    -- },
    -- completionProvider = {
    --   resolveProvider = true,
    --   triggerCharacters = { ".", "'", '"' }
    -- },
    -- definitionProvider = true,
    -- documentHighlightProvider = true,
    -- documentSymbolProvider = true,
    -- executeCommandProvider = {
    --   commands = {}
    -- },
    -- hoverProvider = true,
    -- referencesProvider = true,
    -- renameProvider = true,
    -- signatureHelpProvider = false,
    -- textDocumentSync = {
    --   change = 2,
    --   openClose = true,
    --   save = true,
    --   willSave = false,
    --   willSaveWaitUntil = false
    -- },
    -- typeDefinitionProvider = vim.empty_dict(),
    -- workspace = {
    --   fileOperations = vim.empty_dict(),
    --   workspaceFolders = {
    --     changeNotifications = true,
    --     supported = true
    --   }
    -- },
    -- workspaceSymbolProvider = true
  end
end

return M
