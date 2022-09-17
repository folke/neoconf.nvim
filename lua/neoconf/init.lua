local M = {}

function M.setup(opts)
  if require("neoconf.health").check_setup() then
    require("neoconf.util").try(function()
      require("neoconf.config").setup(opts)
      require("neoconf.commands").setup()
      require("neoconf.plugins").setup()
    end)
  end
end

---@generic T : table
---@param key string|nil
---@param defaults T|nil
---@param opts WorkspaceOptions|nil
---@return T
function M.get(key, defaults, opts)
  return require("neoconf.workspace").get(opts).settings:get(key, { defaults = defaults })
end

return M
