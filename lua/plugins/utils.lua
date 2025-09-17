return {
  -- asynchronous lib
  { "nvim-neotest/nvim-nio" },

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    -- stylua: ignore
    keys = {
      { "<leader>qS", function() require("persistence").select() end,              desc = "Select Session" },
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat",      event = "VeryLazy" },

  {
    "folke/neoconf.nvim",
    config = function()
      require("neoconf").setup({

        -- name of the local settings files
        local_settings = ".neoconf.json",
        -- name of the global settings file in your Neovim config directory
        global_settings = "neoconf.json",
        -- import existing settings from other plugins
        import = {
          vscode = true, -- local .vscode/settings.json
          coc = true,    -- global/local coc-settings.json
          nlsp = true,   -- global/local nlsp-settings.nvim json settings
        },
        -- send new configuration to lsp clients when changing json settings
        live_reload = true,
        -- set the filetype to jsonc for settings files, so you can use comments
        -- make sure you have the jsonc treesitter parser installed!
        filetype_jsonc = true,
        plugins = {
          -- configures lsp clients with settings in the following order:
          -- - lua settings passed in lspconfig setup
          -- - global json settings
          -- - local json settings
          lspconfig = {
            enabled = true,
          },
          -- configures jsonls to get completion in .nvim.settings.json files
          jsonls = {
            enabled = true,
            -- only show completion in json settings for configured lsp servers
            configured_servers_only = true,
          },
          -- configures lua_ls to get completion of lspconfig server settings
          lua_ls = {
            -- by default, lua_ls annotations are only enabled in your neovim config directory
            enabled_for_neovim_config = true,
            -- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file
            enabled = false,
          },
        },
      })
    end,
  },
}
