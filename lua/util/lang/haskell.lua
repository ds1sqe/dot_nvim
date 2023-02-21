local M = {}

local root_pattern = require("lspconfig.util").root_pattern

local root_files = {
  "root.hs",
  "hie.yaml",
  "stack.yaml",
  "cabal.project",
  "*.cabal",
  "package.yaml",
}

M.rootdir = function()
  return root_pattern(unpack(root_files))
end

return M
