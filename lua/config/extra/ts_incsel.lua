local M = {}

local stack = {}

local function select_node(node)
  local s_row, s_col, e_row, e_col = node:range()
  if e_col == 0 and e_row > s_row then
    e_row = e_row - 1
    e_col = math.max(vim.fn.col({ e_row + 1, "$" }) - 1, 0)
  else
    e_col = math.max(e_col - 1, 0)
  end
  vim.api.nvim_buf_set_mark(0, "<", s_row + 1, s_col, {})
  vim.api.nvim_buf_set_mark(0, ">", e_row + 1, e_col, {})
  vim.cmd("normal! gv")
end

function M.init()
  local node = vim.treesitter.get_node()
  if not node then
    return
  end
  stack = { node }
  select_node(node)
end

function M.expand()
  if #stack == 0 then
    return M.init()
  end
  local parent = stack[#stack]:parent()
  if not parent then
    return
  end
  stack[#stack + 1] = parent
  select_node(parent)
end

function M.shrink()
  if #stack <= 1 then
    return
  end
  stack[#stack] = nil
  select_node(stack[#stack])
end

return M
