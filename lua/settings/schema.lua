local M = {}

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
