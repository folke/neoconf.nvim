local M = {}

function M.setup(opts)
  if M.check() then
    require("nvim-settings.util").try(function()
      require("nvim-settings.config").setup(opts)
      require("nvim-settings.commands").setup()
      require("nvim-settings.plugins").setup()
    end)
  end
end

function M.check()
  local util = require("nvim-settings.util")
  if vim.fn.has("nvim-0.7.2") == 0 then
    util.error("**settings.nvim** requires Neovim >= 0.7.2")
  end
  local ok, lsputil = pcall(require, "lspconfig.util")
  if ok then
    if #lsputil.available_servers() == 0 then
      return true
    else
      util.error(
        [[Setup `require("nvim-settings").setup()` should be run **BEFORE** setting up any lsp server with lspconfig]]
      )
    end
  else
    util.error("**nvim-lspconfig** not installed?")
  end
end

---@generic T : table
---@param key string|nil
---@param defaults T|nil
---@param opts WorkspaceOptions|nil
---@return T
function M.get(key, defaults, opts)
  return require("nvim-settings.workspace").get(opts).settings:get(key, { defaults = defaults })
end

return M
