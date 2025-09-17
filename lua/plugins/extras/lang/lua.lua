return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "$VIMRUNTIME",
        "$XDG_DATA_HOME/nvim/lazy",
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
