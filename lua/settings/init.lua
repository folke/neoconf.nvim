local M = {}

function M.setup(opts)
  require("settings.config").setup(opts)
  require("settings.commands").setup()
  require("settings.plugins").setup()
end

---@generic T : table
---@param key string|nil
---@param defaults T|nil
---@param opts WorkspaceOptions|nil
---@return T
function M.get(key, defaults, opts)
  return require("settings.workspace").get(opts).settings:get(key, { defaults = defaults })
end

return M
