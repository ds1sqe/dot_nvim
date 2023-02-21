local debug = require("util.debug")

require("config.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("util").version()
  end,
})
