return {
  { "shaunsingh/oxocarbon.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        style = "night",
        transparent = false,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        sidebars = {
          "qf",
          "vista_kind",
          "terminal",
          "spectre_panel",
          "startuptime",
          "Outline",
        },
        on_highlights = function(hl, c)
          local deepDark = "#17171f"
          local deepNavy = "#2d3149"

          hl.Normal = { bg = deepDark }

          hl.CursorLineNr = { fg = c.orange, bold = true }

          hl.LineNr = { fg = c.orange, bold = true }

          hl.LineNrAbove = { fg = c.fg_gutter }
          hl.LineNrBelow = { fg = c.fg_gutter }

          hl.NotifyBackground = { bg = deepNavy }
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = deepNavy }
          hl.TelescopePromptBorder = { bg = deepNavy, fg = deepNavy }
          hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        end,
      }
    end,
  },
}
