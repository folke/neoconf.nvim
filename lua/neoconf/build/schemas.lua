local Util = require("neoconf.util")
local Schema = require("neoconf.schema")

local M = {}

---@class LspSchema
---@field package_url string url of the package.json of the LSP server
---@field settings_file string file of the settings json schema of the LSP server
---@field build fun(props: table)

--- @type table<string, LspSchema>
M.overrides = {
  sumneko_lua = {
    build = function(props)
      M.translate(props, "https://raw.githubusercontent.com/sumneko/vscode-lua/master/package.nls.json")
    end,
  },
  jsonls = {
    build = function(props)
      M.translate(
        props,
        "https://raw.githubusercontent.com/microsoft/vscode/main/extensions/json-language-features/package.nls.json"
      )
    end,
  },
}

---@return table<string, LspSchema>
function M.index()
  ---@type table<string, LspSchema>
  local ret = {}
  for server, package_json in pairs(vim.json.decode(Util.read_file(Util.path("schemas/index.json")))) do
    ret[server] = { package_url = package_json }
  end
  ret = vim.tbl_deep_extend("force", ret, M.overrides)

  for name, schema in pairs(ret) do
    schema.settings_file = Util.path("schemas/" .. name .. ".json")
  end

  return ret
end

function M.translate(props, nls_url)
  local nls = Util.json_decode(Util.fetch(nls_url)) or {}

  local function translate(desc)
    return nls[desc:gsub("%%", "")] or desc
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
end

---@param schema LspSchema
function M.get_schema(schema)
  local json = vim.json.decode(Util.fetch(schema.package_url)) or {}
  local config = json.contributes and json.contributes.configuration or json.properties and json

  local properties = {}

  if vim.tbl_islist(config) then
    for _, c in pairs(config) do
      vim.list_extend(properties, c.properties)
    end
  elseif config.properties then
    properties = config.properties
  end

  if schema.build then
    schema.build(properties)
  end

  return {
    ["$schema"] = "http://json-schema.org/draft-07/schema#",
    description = json.description,
    properties = properties,
  }
end

function M.clean()
  ---@diagnostic disable-next-line: param-type-mismatch
  for _, f in pairs(vim.fn.expand("schemas/*.json", false, true)) do
    vim.loop.fs_unlink(f)
  end
end

function M.update_index()
  local url = "https://gist.githubusercontent.com/williamboman/a01c3ce1884d4b57cc93422e7eae7702/raw/lsp-packages.json"
  local index = Util.fetch(url)
  Util.write_file("schemas/index.json", index)
end

function M.update_schemas()
  for name, s in pairs(require("neoconf.build.schemas").index()) do
    print(("Generating schema for %s"):format(name))

    if not Util.exists(s.settings_file) then
      local schema = M.get_schema(s)
      Util.write_file(s.settings_file, Util.json_format(schema))
    end
  end
end

function M.build()
  M.clean()
  M.update_index()
  M.update_schemas()
end

return M
