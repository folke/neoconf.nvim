local Util = require("neoconf.util")
local Schema = require("neoconf.schema")

local M = {}

---@class LspSchema
---@field package_url string url of the package.json of the LSP server
---@field settings_file string file of the settings json schema of the LSP server
---@field translate? boolean

--- @type table<string, LspSchema>
M.overrides = {
  lua_ls = {
    translate = true,
  },
  jsonls = {
    translate = true,
  },
  tsserver = {
    translate = true,
  },
  ltex = {
    translate = true,
  },
  html = {
    translate = true,
  },
  cssls = {
    translate = true,
  },
}

---@return table<string, LspSchema>
function M.index()
  ---@type table<string, LspSchema>
  local ret = {}
  local packages = vim.json.decode(Util.read_file(Util.path("schemas/index.json")))

  packages["lua_ls"] = "https://raw.githubusercontent.com/LuaLS/vscode-lua/master/package.json"
  packages["sumneko_lua"] = nil
  packages["nickel_ls"] = nil

  for server, package_json in pairs(packages) do
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
    desc = nls[desc:gsub("%%", "")] or desc
    if type(desc) == "table" then
      local lines = vim.tbl_values(desc)
      lines = vim.tbl_flatten(lines)
      table.sort(lines)
      desc = table.concat(lines, "\n\n")
    end
    return desc
  end

  local function fixdoc(node)
    if type(node) == "table" then
      for k, v in pairs(node) do
        if
          k == "description"
          or k == "markdownDescription"
          or k == "markdownDeprecationMessage"
          or k == "deprecationMessage"
        then
          node[k] = translate(v)
        end
        if k == "enumDescriptions" or k == "markdownEnumDescriptions" then
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

  local ret = {
    ["$schema"] = "http://json-schema.org/draft-07/schema#",
    description = json.description,
    properties = properties,
  }

  if schema.translate then
    M.translate(ret, schema.package_url:gsub("package%.json$", "package.nls.json"))
  end

  return ret
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
