---@type { vim : table}

local util = require("util")

-- Move to window using the movement keys
vim.keymap.set("n", "<left>", "<C-w>h")
vim.keymap.set("n", "<down>", "<C-w>j")
vim.keymap.set("n", "<up>", "<C-w>k")
vim.keymap.set("n", "<right>", "<C-w>l")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-j>", "<C-w>k")
vim.keymap.set("n", "<C-k>", "<C-w>l")

--- Switch buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>")
--vim.keymap.set("n", "<up>", "<cmd>bprevious<CR>")
--vim.keymap.set("n", "<down>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>")

-- change word with <c-c>
vim.keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")
