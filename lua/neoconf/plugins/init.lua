local M = {}

---@class SettingsPlugin
---@field name string
---@field setup fun()|nil
---@field on_update fun(event)|nil
---@field on_schema fun(schema: Schema)

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
      local defaults = require("neoconf.config").defaults
      return require("neoconf.schema").plugin_schema("settings", defaults, "Settings for settings.nvim")
    end,
  })
  M.register(require("neoconf.plugins.lspconfig"))
  M.register(require("neoconf.plugins.jsonls"))
  M.register(require("neoconf.plugins.sumneko"))
end

return M
