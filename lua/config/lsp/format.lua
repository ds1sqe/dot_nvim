local Util = require("lazy.core.util")

local M = {}

M.autoformat = false

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.autoformat = true
  else
    M.autoformat = not M.autoformat
  end
  if M.autoformat then
    Util.info("Enabled format on save", { title = "Format" })
  else
    Util.warn("Disabled format on save", { title = "Format" })
  end
end

function M.format()
  local buf = vim.api.nvim_get_current_buf()

  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = buf,

  }, require("util").opts("nvim-lspconfig").format or {}))
end

function M.on_attach(client, buf)
  -- dont format if client disabled it
  if
      client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
      buffer = buf,
      callback = function()
        if M.autoformat then
          M.format()
        end
      end,
    })
  end
end

return M
