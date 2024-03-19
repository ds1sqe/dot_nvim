local function augroup(name)
  return vim.api.nvim_create_augroup("user_augroup_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufLeave", {
  group = augroup("noLineNumber"),
  callback = function()
    vim.cmd("hi LineNr guifg=#3b4261")
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("setLineNumber"),
  callback = function()
    vim.opt.nu = true
  end,
})

--- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- disable line number when terminal opend
vim.api.nvim_create_autocmd("TermEnter", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})
vim.api.nvim_create_autocmd("TermLeave", {
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})
