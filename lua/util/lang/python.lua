local M = {}

local path = require("util.lang.common").path
local root_pattern = require("util.lang.common").root_pattern

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  "venv",
  ".gitignore",
  "manage.py",
}

M.get_python_path = function(workspace)
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
  end

  -- Find and activate virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      vim.notify("Python venv found but not activated", vim.log.levels.WARN)
      --vim.fn.system("source " .. path.join(path.dirname(match), "bin", "activate"))
      return path.join(path.dirname(match), "bin", "python3")
    else
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or "python"
end

M.rootdir = function()
  return root_pattern(unpack(root_files))
end

-- M.get_venv_path = function(workspace)
--   -- Use activated virtualenv.
--   if vim.env.VIRTUAL_ENV then
--     return vim.env.VIRTUAL_ENV
--   end
--
--   -- Find and use virtualenv in workspace directory.
--   for _, pattern in ipairs({ "*", ".*" }) do
--     local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
--     if match ~= "" then
--       return path.join(path.dirname(match))
--     end
--   end
--
--   -- Fallback to nullstring
--   return ""
-- end
--
return M
