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
  local servers = {}
  local any_lsp = {
    anyOf = {},
  }

  for name, s in pairs(require("neoconf.build.schemas").index()) do
    if Config.options.plugins.jsonls.configured_servers_only == false or Util.has_lspconfig(name) then
      table.insert(servers, name)
      table.insert(any_lsp.anyOf, {
        ["$ref"] = "file://" .. s.settings_file,
      })
    end
  end

  if Config.options.import.vscode then
    table.insert(schemas, {
      fileMatch = { ".vscode/settings.json" },
      schema = any_lsp,
    })
  end

  if Config.options.import.coc then
    table.insert(schemas, {
      fileMatch = { "coc-settings.json" },
      schema = any_lsp,
    })
  end

  if Config.options.import.nlsp then
    for _, server in ipairs(servers) do
      table.insert(schemas, {
        fileMatch = { ("nlsp-settings/%s.json"):format(server), (".nlsp-settings/%s.json"):format(server) },
        schema = schema:get("lspconfig." .. server),
      })
    end
  end
end

return M
