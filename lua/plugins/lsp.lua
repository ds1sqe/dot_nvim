return {
  -- neodev
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- tools
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        -- "prettierd",
        -- "stylua",
        -- "selene",
        -- "luacheck",
        -- "eslint_d",
        -- "shellcheck",
        -- "shfmt",
        -- "black",
        -- "isort",
        -- "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(plugin, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
      },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = require("config.lsp.servers"),

      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      -- setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
      -- clangd = function(_, opts)
      --   opts.capabilities.offsetEncoding = { "utf-16" }
      -- end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
      -- }
      setup = require("config.lsp.setups")
    },
    ---@param opts PluginLspOpts
    config = function(plugin, opts)
      -- setup autoformat
      require("config.lsp.format").autoformat = opts.autoformat
      -- setup formatting and keymaps
      require("util").on_attach(function(client, buffer)
        require("config.lsp.format").on_attach(client, buffer)
        require("config.lsp.keymaps").on_attach(client, buffer)
        require("config.lsp.capabilities").on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(require("config.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()

      local ensure_installed = {} ---@type string[]
      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      for server, server_opts in pairs(servers) do
        setup(server)
        -- if server_opts then
        --   server_opts = server_opts == true and {} or server_opts
        --   -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        --   if server_opts.mason == false or not vim.tbl_contains(available, server) then
        --     setup(server)
        --   else
        --     ensure_installed[#ensure_installed + 1] = server
        --   end
        -- end
      end
    end,
  },
}
