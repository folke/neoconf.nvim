local Util = require("nvim-settings.util")
local Config = require("nvim-settings.config")

local M = {}

function M.setup()
  Util.on_config({
    name = "settings/plugins/sumneko",
    on_config = M.on_new_config,
  })
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
