---@type { vim : table}

vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gO")
vim.keymap.del("n", "gcc")
vim.keymap.del("n", "gc")

vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "<C-q>", "<nop>")

--- Switch buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>")

-- change word with <c-c>
vim.keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")

vim.keymap.set("n", "<leader>qa", "<cmd>qa<CR>")
