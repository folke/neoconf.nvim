local Util = require("settings.util")
local Config = require("settings.config")

local M = {}

function M.setup()
  local lsputil = require("lspconfig.util")
  local hook = lsputil.add_hook_after

  lsputil.on_setup = hook(lsputil.on_setup, function(config)
    config.on_new_config = hook(config.on_new_config, Util.protect(M.on_new_config, "Failed to setup sumneko_lua"))
  end)
end

function M.on_new_config(config, root_dir)
  if config.name == "sumneko_lua" then
    local settings = Config.get({ file = root_dir })

    local enabled = settings.plugins.sumneko_lua.enabled
    if not enabled and settings.plugins.sumneko_lua.enabled_for_neovim_config then
      enabled = Util.is_nvim_config(root_dir)
    end

    if enabled then
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
end

return M
