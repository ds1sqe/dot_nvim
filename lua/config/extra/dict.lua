local M = {}
M.setup = function()
  -- code
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
    --filepath = {},
    --filename = {},
    spelllang = {
      en = "~/.config/nvim/dict/en.dict",
    },
  })
  dict.update()
end
return M
