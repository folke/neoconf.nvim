local Util = require("settings.util")
local Config = require("settings.config")

local M = {}

function M.setup()
  local lsputil = require("lspconfig.util")
  local hook = lsputil.add_hook_after

  lsputil.on_setup = hook(lsputil.on_setup, function(config)
    config.on_new_config = hook(config.on_new_config, M.on_new_config)
  end)
end

function M.on_new_config(config, root_dir)
  if config.name == "jsonls" then
    local options = require("settings.config").options
    local schemas = config.settings.json and config.settings.json.schemas or {}

    local properties = {}
    for name, _ in pairs(Util.index()) do
      if options.jsonls.configured_servers_only == false or require("lspconfig.configs")[name] then
        properties[name] = {
          ["$ref"] = "file://" .. Util.schema(name),
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
      fileMatch = { table.unpack(Config.options.global_settings), table.unpack(Config.options.local_settings) },
    }

    for _, plugin in ipairs(require("settings.plugins").plugins) do
      if type(plugin.get_schema) == "function" then
        local s = plugin.get_schema()
        if s then
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
