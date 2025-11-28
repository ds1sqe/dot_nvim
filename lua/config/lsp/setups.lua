return {
  clangd = function(_, opts)
    local clangd_ext_opts = require("plugins.extras.lang.clang")[1].opts
    require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
    return false
  end,
  fsautocomplete  = function (_, opts)
    vim.cmd('let g:fsharp#exclude_project_directories = [\'paket-files\', \'tests\']')
  end,
}
