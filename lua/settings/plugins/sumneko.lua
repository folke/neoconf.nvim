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
  if config.name == "sumneko_lua" then
    config.settings = Util.merge({
      Lua = {
        workspace = {
          library = {},
        },
      },
    }, config.settings)

    table.insert(config.settings.Lua.workspace.library, Util.path("types"))
  end
end

return M
