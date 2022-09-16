local M = {}

---@class SettingsPlugin
---@field name string
---@field setup fun()|nil
---@field on_update fun(event)|nil
---@field get_schema fun(): table|nil

---@type SettingsPlugin[]
M.plugins = {}

local function fire(plugin, method, ...)
  if type(plugin[method]) == "function" then
    plugin[method](...)
  end
end

function M.fire(method, ...)
  for _, plugin in pairs(M.plugins) do
    fire(plugin, method, ...)
  end
end

---@param plugin SettingsPlugin
function M.register(plugin)
  table.insert(M.plugins, plugin)
  fire(plugin, "setup")
end

function M.setup()
  M.register({
    get_schema = function()
      local defaults = require("nvim-settings.config").defaults
      return require("nvim-settings.schema").plugin_schema("settings", defaults, "Settings for settings.nvim")
    end,
  })
  M.register(require("nvim-settings.plugins.lspconfig"))
  M.register(require("nvim-settings.plugins.jsonls"))
  M.register(require("nvim-settings.plugins.sumneko"))
end

return M
