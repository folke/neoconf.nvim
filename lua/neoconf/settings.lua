local util = require("neoconf.util")

local M = {}

---@class Settings
---@field _settings table
---@field file string
local Settings = {}
Settings.__index = Settings

function M.new(settings)
  local ret = setmetatable({ _settings = {} }, Settings)
  for k, v in pairs(settings or {}) do
    ret:set(k, v)
  end
  return ret
end

function M.expand(tbl)
  if type(tbl) ~= "table" then
    return tbl
  end
  local ret = M.new()
  for key, value in pairs(tbl) do
    ret:set(key, value)
  end
  return ret:get()
end

function M.path(key)
  if not key or key == "" then
    return {}
  end
  if type(key) ~= "string" then
    return { key }
  end
  local parts = {}
  for part in string.gmatch(key, "[^.]+") do
    table.insert(parts, part)
  end
  return parts
end

function Settings:clear()
  self._settings = {}
end

function Settings:set(key, value)
  local parts = M.path(key)

  if #parts == 0 then
    self._settings = value
    return
  end

  local node = self._settings
  for i = 1, #parts - 1, 1 do
    local part = parts[i]
    if type(node[part]) ~= "table" then
      node[part] = {}
    end
    node = node[part]
  end
  node[parts[#parts]] = value
end

---@param opts? {defaults?:table, expand?:boolean}
function Settings:get(key, opts)
  ---@type table|nil
  local node = self._settings

  for _, part in ipairs(M.path(key)) do
    if type(node) ~= "table" then
      node = nil
      break
    end
    node = node[part]
  end

  if opts and opts.expand and type(node) == "table" then
    node = M.expand(node)
  end

  if opts and opts.defaults then
    if node == nil then
      return vim.deepcopy(opts.defaults)
    end
    if type(node) ~= "table" then
      return node
    end
    node = util.merge({}, opts.defaults, node)
  end

  return node
end

function Settings:load(file)
  self:clear()
  if util.exists(file) then
    local data = util.read_file(file)
    local ok, json = pcall(util.json_decode, data)
    if ok then
      for k, v in pairs(M.expand(json)) do
        self:set(k, v)
      end
    else
      util.error(("failed to load json settings from %s"):format(file))
    end
  end
  return self
end

---@param settings Settings
---@return Settings
function Settings:merge(settings, key)
  if not settings then
    return M.new()
  end
  if settings.__index ~= Settings then
    settings = M.new(settings)
  end
  if key then
    local value = util.merge({}, self:get(key) or {}, settings._settings)
    self:set(key, value)
  else
    self._settings = util.merge(self._settings, settings._settings)
  end
  return self
end

M._cache = {}

function M.clear(fname)
  M._cache[fname] = nil
end

function M.get(fname, opts)
  opts = opts or {}
  fname = util.fqn(fname)
  if not M._cache[fname] and util.exists(fname) then
    M._cache[fname] = M.new():load(fname)
  end
  return M._cache[fname]
end

function M.get_local(root_dir)
  local settings = M.new()

  util.for_each_local(function(file, key)
    settings:merge(M.get(file), key)
  end, root_dir)

  return settings
end

function M.get_global()
  local settings = M.new()

  util.for_each_global(function(file, key)
    settings:merge(M.get(file), key)
  end)

  return settings
end

return M
