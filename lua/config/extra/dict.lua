local M = {}
M.setup = function()
  local dict = require("cmp_dictionary")
  dict.setup({
    paths = {
      "/usr/share/dict/words",
    },
    exact_length = 2,
    first_case_insensitive = true,
    document = {
      enable = true,
      command = { "wn", "${label}", "-over" },
    },
  })
end
return M
