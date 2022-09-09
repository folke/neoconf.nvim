local Util = require("settings.util")

local M = {}

--- @type table<string, LspSchema>
M.overrides = {
  sumneko_lua = {
    build = function(props)
      local lns = Util.json_decode(
        Util.fetch("https://raw.githubusercontent.com/sumneko/vscode-lua/master/package.nls.json")
      ) or {}

      local function translate(desc)
        return lns[desc:gsub("%%", "")] or desc
      end

      local function fixdoc(node)
        if type(node) == "table" then
          for k, v in pairs(node) do
            if k == "description" or k == "markdownDescription" then
              node[k] = translate(v)
            end
            if k == "markdownEnumDescriptions" then
              for i, d in ipairs(v) do
                v[i] = translate(d)
              end
            end
            fixdoc(v)
          end
        end
      end
      fixdoc(props)
    end,
  },
}

---@return table<string, LspSchema>
function M.get_lsp_schemas()
  ---@type table<string, LspSchema>
  local ret = {}
  for server, package_json in pairs(require("settings.build.lsp")) do
    ret[server] = { package_url = package_json }
  end
  ret = vim.tbl_deep_extend("force", ret, M.overrides)

  for name, schema in pairs(ret) do
    schema.settings_file = Util.path("schemas/" .. name .. ".json")
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
