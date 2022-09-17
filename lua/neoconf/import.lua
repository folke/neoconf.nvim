local Config = require("neoconf.config")
local Util = require("neoconf.util")

local M = {}

function M.setup()
  if Config.options.import.vscode then
    table.insert(Config.local_patterns, {
      pattern = ".vscode/settings.json",
      key = "vscode",
      schema_key = "lspconfig.*",
    })
  end
  if Config.options.import.coc then
    table.insert(Config.local_patterns, {
      pattern = "coc-settings.json",
      key = "coc",
      schema_key = "lspconfig.*",
    })
    table.insert(Config.global_patterns, {
      pattern = "coc-settings.json",
      key = "coc",
      schema_key = "lspconfig.*",
    })
  end
  if Config.options.import.nlsp then
    local function nlsp_key(file)
      return "nlsp." .. vim.fn.fnamemodify(file, ":t:r")
    end

    table.insert(Config.local_patterns, {
      pattern = ".nlsp-settings/*.json",
      key = nlsp_key,
    })
    table.insert(Config.global_patterns, {
      pattern = "nlsp-settings/*.json",
      key = nlsp_key,
    })
  end
end

---@param schema Schema
---@param schemas table
function M.on_schemas(schema, schemas)
  local servers = schema:get("lspconfig").properties

  local patterns = {}
  if Config.options.import.vscode then
    table.insert(patterns, ".vscode/settings.json")
  end
  if Config.options.import.coc then
    table.insert(patterns, "coc-settings.json")
  end

  if #patterns > 0 then
    table.insert(schemas, {
      fileMatch = patterns,
      schema = {
        anyOf = vim.tbl_values(servers),
      },
    })
  end

  if Config.options.import.nlsp then
    for server, _ in pairs(servers) do
      table.insert(schemas, {
        fileMatch = { ("nlsp-settings/%s.json"):format(server), (".nlsp-settings/%s.json"):format(server) },
        schema = schema:get("lspconfig." .. server),
      })
    end
  end
end

return M
