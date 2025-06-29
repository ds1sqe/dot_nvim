---@type { vim : table}

local util = require("util")

vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gO")
vim.keymap.del("n", "gcc")
vim.keymap.del("n", "gc")

-- Move to window using the movement keys
vim.keymap.set("n", "<left>", "<C-w>h")
vim.keymap.set("n", "<down>", "<C-w>j")
vim.keymap.set("n", "<up>", "<C-w>k")
vim.keymap.set("n", "<right>", "<C-w>l")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

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

-- open term
