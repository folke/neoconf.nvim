local Settings = require("neoconf.settings")

local M = {}

---@class Schema
---@field _schema Settings
---@field file string
local Schema = {}
Schema.__index = function(table, key)
  return Schema[key] or table._schema:get(key)
end

---@return Schema
function M.new(schema)
  return setmetatable({ _schema = Settings.new(schema) }, Schema)
end

local function schema_key(key)
  return table.concat(
    vim.tbl_map(function(k)
      return "properties." .. k
    end, Settings.path(key)),
    "."
  )
end

function Schema:set(key, value)
  return self._schema:set(schema_key(key), value)
end

function Schema:get(key)
  return self._schema:get(schema_key(key))
end

function Schema:import(key, value)
  return self:set(key, M.to_schema(value))
end

function M.get()
  local schema = M.new()

  schema:import("neoconf", require("neoconf.config").defaults)

  require("neoconf.plugins").fire("on_schema", schema)
  return schema
end

-- try to create a simple schema from a given value
function M.to_schema(value)
  if value == nil then
    return { type = "null" }
  elseif type(value) == "boolean" then
    return { type = "boolean", default = value, description = "boolean" }
  elseif type(value) == "string" then
    return { type = "string", default = value, description = "string" }
  elseif type(value) == "number" then
    return { type = "number", default = value, description = "number" }
  end

  if vim.tbl_islist(value) then
    return { type = "array", default = value, description = "array" }
  end

  if type(value) == "table" then
    local obj = { type = "object", properties = {} }
    for k, v in pairs(value) do
      obj.properties[k] = M.to_schema(v)
    end
    return obj
  end
  return { type = "null" }
end

return M
