local M = {}

--- @class Config
M.defaults = {
  local_settings = { ".nvim.settings.json", vscode = ".vscode/settings.json" },
  global_settings = { "nvim.settings.json" },
  plugins = {
    lspconfig = {
      enabled = true,
    },
    -- configures jsonls to get completion in .nvim.settings files
    jsonls = {
      enabled = true,
      configured_servers_only = true, -- only show completion in json settings for configured lsp servers
    },
    -- configures sumneko_lua to get completion of lspconfig server settings
    sumneko_lua = {
      -- nil: by default, this is only enabled in your neovim config directory
      -- true/false: you can explicitely enable/disable this by settings the property below
      enabled = nil,
    },
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

function M.get(opts)
  return require("settings").get("settings.nvim", M.options, opts)
end

return M
