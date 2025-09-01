local M = {}

----@diagnostic disable-next-line
function M.on_attach(client, bufnr)
  local sc = client.server_capabilities

  if client.name == "pyright" then
    sc.signatureHelpProvider = false
    sc.hoverProvider = false
    sc.definitionProvider = false
  end
  if client.name == "fsautocomplete" then
    sc.documentFormattingProvider = false
  end
end

return M
