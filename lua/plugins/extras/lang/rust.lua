return {
  {
    "simrat39/rust-tools.nvim",
    lazy = false,
    opts = function(_, opts)
      local rt = require("rust-tools")
      rt.setup({
        hover_actions = {
          auto_focus = true,
        },
        dap = {
          adapter = {
            type = "executable",
            command = "codelldb",
            name = "rt_lldb",
          },
        },
      })
      require("util").on_attach(function(client, bufnr)
        if client.name == "rust_analyzer" then
          vim.keymap.set("n", "<leader>k", require("rust-tools").hover_actions.hover_actions, {
            buffer = bufnr,
            desc = "RustTools HoverActions",
          })
          -- vim.keymap.set("n", "<leader>a", require("rust-tools").code_action_group.code_action_group, {
          --   buffer = bufnr,
          --   desc = "RustTools CodeActionGroup",
          -- })
        end
      end)
    end,
  },
}
