local Util = require("nvim-settings.util")
local Settings = require("nvim-settings.settings")

local M = {}

local function _sub_schema(schema, key)
  if schema.properties[key] then
    return schema.properties[key]
  end

  for _, of in pairs({ "anyOf", "oneOf", "allOf" }) do
    if schema[of] then
      for _, o in pairs(schema[of]) do
        local ret = M.get_sub_schema(o, key)
        if ret then
          return ret
        end
      end
    end
  end
end

-- get a subschema based on a dotted key like `lspconfig.clangd`
function M.get_sub_schema(schema, key)
  local path = Settings.path(key)
  local ret = schema
  for _, p in pairs(path) do
    ret = _sub_schema(ret, p)
    if not ret then
      return
    end
  end
  return ret
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

function M.plugin_schema(name, obj, description)
  local schema = M.to_schema(obj)
  schema.description = description
  return {
    type = "object",
    properties = {
      [name] = schema,
    },
  }
end

return M
