local Util = require("neoconf.util")
local Config = require("neoconf.config")
local Schema = require("neoconf.schema")

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

    local schema = Schema.get()
    local schemas = config.settings.json and config.settings.json.schemas or {}

    table.insert(schemas, {
      schema = schema:get(),
      fileMatch = {
        Util.fqn(vim.fn.stdpath("config") .. "/" .. options.global_settings),
        options.local_settings,
      },
    })

    require("neoconf.import").on_schemas(schema, schemas)

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
