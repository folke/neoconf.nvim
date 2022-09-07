local Util = require("lsp-settings.util")
local Config = require("lsp-settings.config")
local Settings = require("lsp-settings.settings")

local M = {}

function M.setup()
  local lsputil = require("lspconfig.util")
  local hook = lsputil.add_hook_before

  local settings_root = lsputil.root_pattern(unpack(vim.tbl_values(Config.options.local_settings)))

  lsputil.on_setup = hook(lsputil.on_setup, function(config)
    config.on_new_config = hook(config.on_new_config, M.on_new_config)
    local root_dir = config.root_dir
    config.root_dir = function(...)
      return settings_root(...) or root_dir(...)
    end
  end)
end

function M.on_new_config(config, root_dir)
  M.setup_server_config(config, root_dir)
  if config.name == "jsonls" then
    M.setup_jsonls(config)
  end
end

function M.setup_server_config(config, root_dir)
  local settings = Settings.new()

  settings:merge(config.settings)

  Util.for_each_global(function(_, file)
    settings:merge(Settings.get(file))
  end)

  Util.for_each_local(function(_, file)
    settings:merge(Settings.get(file))
  end, root_dir)

  config.settings = settings:get()
end

function M.setup_jsonls(config)
  local options = require("lsp-settings.config").options
  local schemas = config.settings.json and config.settings.json.schemas or {}

  for name, _ in pairs(require("lsp-settings.schemas")) do
    if options.jsonls.configured_servers_only == false or require("lspconfig.configs")[name] then
      table.insert(schemas, {
        name = name,
        description = "Schema for " .. name,
        fileMatch = { ".lsp-settings.json" },
        url = Util.schema(name),
      })
    end
  end

  config.settings = Util.merge({}, config.settings, {
    json = {
      schemas = schemas,
      validate = {
        enable = true,
      },
    },
  })
end

return M
