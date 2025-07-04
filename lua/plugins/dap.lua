local M = {
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
}

function M.init()
  vim.keymap.set("n", "<leader>db", function()
    require("dap").toggle_breakpoint()
  end, { desc = "Toggle Breakpoint" })

  vim.keymap.set("n", "<leader>dc", function()
    require("dap").continue()
  end, { desc = "Continue" })

  vim.keymap.set("n", "<leader>do", function()
    require("dap").step_over()
  end, { desc = "Step Over" })

  vim.keymap.set("n", "<leader>di", function()
    require("dap").step_into()
  end, { desc = "Step Into" })

  vim.keymap.set("n", "<leader>dw", function()
    require("dap.ui.widgets").hover()
  end, { desc = "Widgets" })

  vim.keymap.set("n", "<leader>dr", function()
    require("dap").repl.open()
  end, { desc = "Repl" })

  vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle({})
  end, { desc = "Dap UI" })
end

function M.config()
  require("dapui").setup()

  local dap = require("dap")

  dap.configurations.lua = {
    {

      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }
  dap.configurations.c = {
    {
      name = "Launch file",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
  dap.configurations.cpp = dap.configurations.c
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      initCommands = function()
        -- Find out where to look for the pretty printer Python module
        local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

        local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
        local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

        local commands = {}
        local file = io.open(commands_file, "r")
        if file then
          for line in file:lines() do
            table.insert(commands, line)
          end
          file:close()
        end
        table.insert(commands, 1, script_import)

        return commands
      end,
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  end


  dap.adapters.coreclr = {
    type = 'executable',
    command = vim.fn.expand('$HOME/.local/share/nvim/mason/bin/netcoredbg'),
    args = { '--interpreter=vscode' }
  }

  dap.configurations.fsharp = {
    {
      type = "coreclr",
      name = "launch - Netcoredbg",
      request = "launch",
      program = function()
        local conf = vim.fn.json_decode(vim.fn.readfile(".dap.conf.json"))
        local path_to_dll =
            function()
              if conf and conf.path then
                return require("util").get_root() .. "/" .. conf.path
              else
                return vim.fn.input('Path to dll', vim.fn.getcwd(), 'file')
              end
            end
        return path_to_dll()
      end,
      args = function()
        local conf = vim.fn.json_decode(vim.fn.readfile(".dap.conf.json"))
        local get_args =
            function()
              if conf and conf.args then
                return vim.split(conf.args, " ")
              else
                local args_string = vim.fn.input("Input arguments: ")
                return vim.split(args_string, " ")
              end
            end
        return get_args()
      end,
      cwd = function()
        local conf = vim.fn.json_decode(vim.fn.readfile(".dap.conf.json"))
        local get_cwd =
            function()
              if conf and conf.cwd then
                return vim.fn.expand(conf.cwd)
              else
                return vim.fn.input("Target cwd:", vim.fn.getcwd())
              end
            end
        return get_cwd()
      end,
      sync_with_nvim_tree = true,
      env = { "VSTEST_HOST_DEBUG=1" }
    },
    {
      type = "coreclr",
      name = "ATTACH - Netcoredbg",
      request = "attach",
      processId = require('dap.utils').pick_process
    },
  }
  dap.configurations.cs = dap.configurations.fsharp

  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
    name = "lldb",
  }

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
end

-- - `DapBreakpoint` for breakpoints (default: `B`)
-- - `DapBreakpointCondition` for conditional breakpoints (default: `C`)
-- - `DapLogPoint` for log points (default: `L`)
-- - `DapStopped` to indicate where the debugee is stopped (default: `→`)
-- - `DapBreakpointRejected` to indicate breakpoints rejected by the debug
--   adapter (default: `R`)
--
-- You can customize the signs by setting them with the |sign_define()| function.
-- For example:
--
-- >
--     lua << EOF
--     vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
--     EOF
-- <

return M
