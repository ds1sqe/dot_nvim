---@type { vim : table}

local util = require("util")

vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gO")
vim.keymap.del("n", "gcc")
vim.keymap.del("n", "gc")

vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "<C-q>", "<nop>")

--- Switch buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>")

-- float term
vim.keymap.set("n", "<leader>oft",
  function()
    util.float_term("zsh", { interactive = true })
  end,
  { desc = "Float Term" }
)
vim.keymap.set("n", "<leader>ot", "<cmd>term<CR>")

-- change word with <c-c>
vim.keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")

-- Window split
vim.keymap.set("n", "<leader>w|", "<cmd>vsplit<CR>")

-- exit term mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>qa", "<cmd>qa<CR>")
