return
  {

    -- add folding range to capabilities
    {
      "neovim/nvim-lspconfig",
      opts = {
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
      },
    },

    -- add nvim-ufo
    {
      "kevinhwang91/nvim-ufo",
      dependencies = "kevinhwang91/promise-async",
      event = "BufReadPost",
      opts = {},

      init = function()
        vim.keymap.set("n", "zR", function()
          require("ufo").openAllFolds()
        end)
        vim.keymap.set("n", "zM", function()
          require("ufo").closeAllFolds()
        end)
      end,
    },
  }
