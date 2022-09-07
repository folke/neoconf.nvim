local util = require("lsp-settings.util")

local M = {}

function M.get_schema(package_json)
  local json = util.json_decode(util.fetch(package_json)) or {}
  local config = json.contributes and json.contributes.configuration or json.properties and json

  local properties = {}

  if vim.tbl_islist(config) then
    for _, c in pairs(config) do
      vim.list_extend(properties, c.properties)
    end
  elseif config.properties then
    properties = config.properties
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
  local index = util.fetch(url)
  util.write_file("schemas/index.json", index)
end

function M.update_schemas()
  for name, url in pairs(util.index()) do
    print(("Generating schema for %s"):format(name))
    local schema_file = ("schemas/%s.json"):format(name)

    if not (util.exists(schema_file) and os.time() - util.mtime(schema_file) < 3600) then
      local schema = M.get_schema(url)
      util.write_file(schema_file, vim.fn.json_encode(schema))
    end
  end
end

function M.build()
  -- M.clean()
  M.update_index()
  M.update_schemas()
end

M.build()

return M
