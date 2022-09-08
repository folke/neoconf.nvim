local Config = require("lsp-settings.config")

local M = {}

function M.merge(...)
  local function can_merge(v)
    return type(v) == "table" and (vim.tbl_isempty(v) or not vim.tbl_islist(v))
  end

  local values = { ... }
  local ret = values[1]
  for i = 2, #values, 1 do
    local value = values[i]
    if can_merge(ret) and can_merge(value) then
      for k, v in pairs(value) do
        ret[k] = M.merge(ret[k], v)
      end
    else
      ret = value
    end
  end
  return ret
end

function M.path(str)
  local f = debug.getinfo(1, "S").source:sub(2)
  return M.fqn(vim.fn.fnamemodify(f, ":h:h:h") .. "/" .. (str or ""))
end

function M.index()
  return M.json_decode(M.read_file(M.schema("index")))
end

function M.get_root(fname)
  local util = require("lspconfig.util")
  fname = M.fqn(fname)
  return util.root_pattern(unpack(vim.tbl_values(Config.options.local_settings)))(fname)
    or util.find_git_ancestor(fname)
    or vim.fn.getcwd()
end

function M.schema(name)
  return M.path("schemas/" .. name .. ".json")
end

function M.read_file(file)
  local fd = io.open(file)
  if not fd then
    error(("Could not open file %s for writing"):format(file))
  end
  local data = fd:read("*a")
  fd:close()
  return data
end

function M.write_file(file, data)
  local fd = io.open(file, "w+")
  if not fd then
    error(("Could not open file %s for writing"):format(file))
  end
  fd:write(data)
  fd:close()
end

function M.json_decode(json)
  json = vim.trim(json)
  if json == "" then
    json = "{}"
  end
  ---@diagnostic disable-next-line: missing-parameter
  json = require("lsp-settings.json").json_strip_comments(json)
  return vim.fn.json_decode(json)
end

function M.fqn(fname)
  fname = vim.fn.fnamemodify(fname, ":p")
  return vim.loop.fs_realpath(fname) or fname
end

---@param patterns table
---@param fn fun(file: string|nil, key:string|nil, pattern:string)
function M.for_each(patterns, fn, root_dir)
  for key, pattern in pairs(patterns) do
    if type(key) == "number" then
      key = nil
    end
    local file = root_dir and root_dir .. "/" .. pattern
    fn(file, key, pattern)
  end
end

function M.for_each_local(fn, root_dir)
  M.for_each(Config.options.local_settings, fn, root_dir)
end

function M.for_each_global(fn)
  M.for_each(Config.options.global_settings, fn, vim.fn.stdpath("config"))
end

function M.is_global(file)
  local ret = false
  M.for_each_global(function(f)
    if file == f then
      ret = true
    end
  end)
  return ret
end

function M.fetch(url)
  local fd = io.popen(string.format("curl -s -k %q", url))
  if not fd then
    error(("Could not download %s"):format(url))
  end
  local ret = fd:read("*a")
  fd:close()
  return ret
end

function M.mtime(fname)
  local stat = vim.loop.fs_stat(fname)
  return (stat and stat.type) and stat.mtime.sec or 0
end

function M.exists(fname)
  local stat = vim.loop.fs_stat(fname)
  return (stat and stat.type) or false
end

function M.notify(msg, level)
  vim.notify(msg, level, {
    title = "Lsp Settings",
    on_open = function(win)
      vim.api.nvim_win_set_option(win, "conceallevel", 3)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
      vim.api.nvim_win_set_option(win, "spell", false)
    end,
  })
end

function M.warn(msg)
  M.notify(msg, vim.log.levels.WARN)
end

function M.error(msg)
  M.notify(msg, vim.log.levels.ERROR)
end

function M.info(msg)
  M.notify(msg, vim.log.levels.INFO)
end

return M
