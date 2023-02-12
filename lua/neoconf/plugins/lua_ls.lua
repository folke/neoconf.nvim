local Util = require("neoconf.util")
local Config = require("neoconf.config")

local M = {}

function M.setup()
  Util.on_config({
    name = "settings/plugins/lua_ls",
    on_config = M.on_new_config,
  })
end

function M.on_new_config(config, root_dir)
  if config.name == "lua_ls" then
    local settings = Config.get({ file = root_dir })

    local enabled = settings.plugins.lua_ls.enabled
    if not enabled and settings.plugins.lua_ls.enabled_for_neovim_config then
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

      vim.list_extend(config.settings.Lua.workspace.library, { Util.path("types"), Util.path("types") .. "/lua" })
    end
  end
end

return M
