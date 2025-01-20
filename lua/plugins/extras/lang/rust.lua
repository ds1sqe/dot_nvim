return {

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    lazy = false,
    config = function(_, opts)
      vim.g.rustaceanvim = function()
        -- Update this path
        local extension_path = "/usr/lib/codelldb/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb"
        local this_os = vim.uv.os_uname().sysname

        -- The path is different on Windows
        if this_os:find("Windows") then
          codelldb_path = extension_path .. "adapter\\codelldb.exe"
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        else
          -- The liblldb extension is .so for Linux and .dylib for MacOS
          liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        end

        local cfg = require("rustaceanvim.config")

        return {
          -- Plugin configuration
          tools = {},
          -- LSP configuration
          server = {
            on_attach = function(client, bufnr)
              vim.keymap.set("n", "<leader>a", function()
                vim.cmd.RustLsp("codeAction")
              end
              , {
                buffer = bufnr,
                desc = "RustTools CodeActionGroup",
              })
            end,
            default_settings = {
              -- rust-analyzer language server configuration
              ["rust-analyzer"] = {
                rustc = {
                  source = 'discover'
                }
              },
            },
          },
          -- DAP configuration
          dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
          },
        }
      end
    end,
  },
}
