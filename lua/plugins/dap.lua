return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {
        "mfussenegger/nvim-dap",
      },
      {
        "nvim-neotest/nvim-nio",
      },
      { "jbyuki/one-small-step-for-vimkind" },
    },
    keys = {
      {
        mode = "n",
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },

      {
        mode = "n",
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue debug",
      },
      {
        mode = "n",
        "<leader>dl",
        function()
          -- Manually load launch.json (clears and reloads)
          local dap = require("dap")
          local root = require("util").get_root()
          local launch_json = root .. "/.vscode/launch.json"

          if vim.fn.filereadable(launch_json) == 1 then
            -- Clear ALL configurations to prevent duplicates
            for ft, _ in pairs(dap.configurations) do
              dap.configurations[ft] = nil
            end

            require("dap.ext.vscode").load_launchjs(launch_json, {
              cppdbg = { "c", "cpp" },
              codelldb = { "c", "cpp", "rust" },
              lldb = { "c", "cpp", "rust" },
              coreclr = { "cs", "fsharp" },
              debugpy = { "python" },
              python = { "python" },
            })
            vim.notify("Loaded " .. launch_json, vim.log.levels.INFO)
          else
            vim.notify("No launch.json found at " .. launch_json, vim.log.levels.WARN)
          end
        end,
        desc = "Load launch.json",
      },

      {
        mode = "n",
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },

      {
        mode = "n",
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },

      {
        mode = "n",
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },

      {
        mode = "n",
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Repl",
      },
      {
        mode = "n",
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
    },
    opts = {},
    config = function()
      -- vim.api.nvim_create_autocmd("VimEnter", {
      --   callback = function()
      --     dapui.setup()
      --   end,
      -- })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = {},
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("debugpy-adapter")
        end,
      },
    },
    config = function(_)
      require("dapui").setup()

      local dap = require("dap")

      -- Adapter definitions (required for VS Code launch.json compatibility)

      -- Neovim Lua debugging
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end

      -- .NET (F#/C#) - coreclr is VS Code compatible
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/netcoredbg"),
        args = { "--interpreter=vscode" },
      }

      -- C/C++ via cpptools (VS Code compatible type: cppdbg)
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/OpenDebugAD7"),
      }

      -- C/C++/Rust via codelldb (VS Code compatible type: codelldb)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/codelldb"),
          args = { "--port", "${port}" },
        },
      }

      -- Fallback lldb adapter (for direct lldb-dap usage)
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-dap",
        name = "lldb",
      }

      -- Python debugpy alias (nvim-dap-python creates dap.adapters.python)
      -- This allows VS Code's "debugpy" type to work
      vim.api.nvim_create_autocmd("User", {
        pattern = "DapConfigLoaded",
        once = true,
        callback = function()
          if dap.adapters.python then
            dap.adapters.debugpy = dap.adapters.python
          end
        end,
      })

      -- DAP UI listeners
      local dapui = require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
  },
}
