local Util = require("nvim-settings.util")
local Config = require("nvim-settings.config")
local Schema = require("nvim-settings.schema")

local M = {}

function M.setup()
  Util.on_config({
    name = "settings/plugins/jsonls",
    on_config = M.on_new_config,
  })
end

function M.on_new_config(config, root_dir)
  if config.name == "jsonls" then
    local options = Config.get({ file = root_dir })

    if not options.plugins.jsonls.enabled then
      return
    end

    local schemas = config.settings.json and config.settings.json.schemas or {}

    local properties = {}
    for name, schema in pairs(Schema.get_lsp_schemas()) do
      if options.plugins.jsonls.configured_servers_only == false or Util.has_lspconfig(name) then
        properties[name] = {
          ["$ref"] = "file://" .. schema.settings_file,
        }
      end
    end

    local schema = {
      name = "nvim settings",
      description = "Settings for Neovim",
      schema = {
        properties = {
          lspconfig = {
            description = "lsp server settings for lspconfig",
            type = "object",
            properties = properties,
          },
        },
        type = "object",
      },
      fileMatch = Util.file_patterns(),
    }

    for _, plugin in ipairs(require("nvim-settings.plugins").plugins) do
      if type(plugin.get_schema) == "function" then
        local ok, s = pcall(plugin.get_schema)
        if not ok then
          Util.error("Could not configure schema for a plugin\n\n" .. s)
        elseif s then
          schema.schema.properties = Util.merge({}, schema.schema.properties, s.properties)
        end
      end
    end

    table.insert(schemas, schema)

    config.settings = Util.merge({}, config.settings, {
      json = {
        schemas = schemas,
        validate = {
          enable = true,
        },
      },
    })
  end
end

return M
