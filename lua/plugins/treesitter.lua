local PARSERS = {
  "bash",
  "c",
  "cmake",
  "c_sharp",
  "cpp",
  "css",
  "diff",
  "fish",
  "gitignore",
  "go",
  "graphql",
  "html",
  "http",
  "java",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "jsonc",
  "latex",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "meson",
  "ninja",
  "nix",
  "php",
  "python",
  "query",
  "regex",
  "rust",
  "scss",
  "sql",
  "svelte",
  "teal",
  "toml",
  "tsx",
  "typescript",
  "vhs",
  "vim",
  "vue",
  "wgsl",
  "yaml",
}

local INDENT_DISABLED = { python = true }

return {
  {
    "mfussenegger/nvim-treehopper",
    keys = { { "m", mode = { "o", "x" } } },
    config = function()
      vim.cmd([[
        omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
        xnoremap <silent> m :lua require('tsht').nodes()<CR>
      ]])
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    keys = {
      { "<C-space>", function() require("config.extra.ts_incsel").init() end,   mode = "n", desc = "Init selection" },
      { "<C-space>", function() require("config.extra.ts_incsel").expand() end, mode = "x", desc = "Expand selection" },
      { "<bs>",      function() require("config.extra.ts_incsel").shrink() end, mode = "x", desc = "Shrink selection" },
    },
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({})

      local installed = {}
      for _, name in ipairs(ts.get_installed and ts.get_installed("parsers") or {}) do
        installed[name] = true
      end
      local missing = {}
      for _, name in ipairs(PARSERS) do
        if not installed[name] then
          table.insert(missing, name)
        end
      end
      if #missing > 0 then
        ts.install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(ev)
          local ft = vim.bo[ev.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft
          if not pcall(vim.treesitter.start, ev.buf, lang) then
            return
          end
          if not INDENT_DISABLED[lang] then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
