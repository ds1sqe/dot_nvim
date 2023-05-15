local M = {}
M.setup = function()
  local dict = require("cmp_dictionary")
  dict.setup({
    exact = 2,
    first_case_insensitive = true,
    document = true,
    document_command = "wn %s -over",
    async = true,
    max_items = -1,
    capacity = 5,
    debug = false,
  })
  dict.switcher({
    filepath = { ["*"] = "~/.config/nvim/dict/en.dict" },
    spelllang = {
      en = "~/.config/nvim/dict/en.dict",
    },
  })
  dict.update()
end
return M
