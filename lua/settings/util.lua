local Config = require("settings.config")

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

function M.file_patterns(opts)
  opts = M.merge({ ["local"] = true, ["global"] = true }, opts)
  local ret = {}

  if opts["local"] then
    for _, p in ipairs(Config.local_patterns) do
      table.insert(ret, p.pattern)
    end
  end

  if opts["global"] then
    for _, p in ipairs(Config.global_patterns) do
      table.insert(ret, p.pattern)
    end
  end

  return ret
end

function M.path(str)
  local f = debug.getinfo(1, "S").source:sub(2)
  return M.fqn(vim.fn.fnamemodify(f, ":h:h:h") .. "/" .. (str or ""))
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
  json = require("settings.json").json_strip_comments(json)
  return vim.fn.json_decode(json)
end

function M.fqn(fname)
  fname = vim.fn.fnamemodify(fname, ":p")
  return vim.loop.fs_realpath(fname) or fname
end

---@param root_dir string
---@param file string
function M.has_file(root_dir, file)
  root_dir = M.fqn(root_dir)
  file = M.fqn(file)
  return M.exists(file) and file:find(root_dir, 1, true) == 1
end

function M.protect(fn, msg)
  return function(...)
    local args = table.pack(...)

    return xpcall(function()
      return fn(table.unpack(args))
    end, function(err)
      local lines = {}
      if msg then
        table.insert(lines, msg)
      end
      table.insert(lines, err)
      table.insert(lines, debug.traceback("", 3))

      M.error(table.concat(lines, "\n"))
      return err
    end)
  end
end

function M.try(fn, msg)
  M.protect(fn, msg)()
end

function M.config_path()
  return vim.loop.fs_realpath(vim.fn.stdpath("config"))
end

function M.is_nvim_config(path)
  return M.has_file(M.fqn(path), M.config_path())
end

---@param patterns SettingsPattern[]
---@param fn fun(file: string, key:string|nil, pattern:string)
---@param root_dir string
function M.for_each(patterns, fn, root_dir)
  for _, p in ipairs(patterns) do
    local file = root_dir .. "/" .. p.pattern
    ---@diagnostic disable-next-line: param-type-mismatch
    for _, f in pairs(vim.fn.expand(file, false, true)) do
      ---@diagnostic disable-next-line: param-type-mismatch
      fn(f, type(p.key) == "function" and p.key(f) or p.key, p.pattern)
    end
  end
end

---@param patterns string|(string|SettingsPattern)[]
---@return SettingsPattern[]
function M.expand(patterns)
  return vim.tbl_map(function(p)
    return type(p) == "string" and { pattern = p } or p
  end, type(patterns) == "table" and patterns or { patterns })
end

---@param root_dir string
---@param fn fun(file: string, key:string|nil, pattern:string)
function M.for_each_local(fn, root_dir)
  M.for_each(Config.local_patterns, fn, root_dir)
end

---@param fn fun(file: string, key:string|nil, pattern:string)
function M.for_each_global(fn)
  M.for_each(Config.global_patterns, fn, vim.fn.stdpath("config"))
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
