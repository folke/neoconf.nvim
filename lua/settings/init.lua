local M = {}

function M.setup(opts)
  require("settings.config").setup(opts)
  require("settings.commands").setup()
  require("settings.plugins").setup()
end

---@class SettingsOptions: WorkspaceOptions
---@field key string|nil

---@param opts SettingsOptions
---@return table
function M.get_settings(opts)
  return require("settings.workspace").get(opts).settings:get(opts.key)
end

return M
