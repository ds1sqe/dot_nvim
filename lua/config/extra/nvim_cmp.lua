local M = function()
  local cmp = require("cmp")
  return {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-u>"] = cmp.mapping.scroll_docs(5),
      ["<C-d>"] = cmp.mapping.scroll_docs(-5),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "emoji" },
      { name = "neorg" },
      { name = "nvim_lsp_signature_help" },
      { name = "dictionary", keyword_length = 2 },
    }),

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, item)
        local icons = require("config.icons").kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. ">" .. item.kind
        end

        if entry.source.name == "nvim_lsp" then
          item.menu = entry.source.source.client.name
        else
          item.menu = entry.source.name
        end

        if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
          item.menu = item.menu .. ">>" .. entry.completion_item.detail
        end
        return item
      end,
    },

    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
    },
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
  }
end
return M
