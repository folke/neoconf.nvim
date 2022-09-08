local M = {}

--- @class Config
M.defaults = {
  local_settings = { ".nvim.settings.json", vscode = ".vscode/settings.json" },
  global_settings = { "nvim.settings.json" },
  jsonls = {
    configured_servers_only = true, -- only show completion in json settings for configured lsp servers
  },
}

--- @type Config
M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

---@return Config
function M.merge(options)
  return vim.tbl_deep_extend("force", {}, M.options, options or {})
end

return M
