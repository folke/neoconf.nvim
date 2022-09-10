local M = {}

---@class Config
M.defaults = {
  local_settings = ".nvim.settings.json",
  global_settings = "nvim.settings.json",
  import = {
    vscode = true,
    coc = true,
    nlsp = true,
  },
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
      -- by default, sumneko_lua annotations are only enabled in your neovim config directory
      enabled_for_neovim_config = true,
      -- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file
      enabled = false,
    },
  },
}

--- @type Config
M.options = {}

---@class SettingsPattern
---@field pattern string
---@field key string|nil|fun(string):string

---@type SettingsPattern[]
M.local_patterns = {}

---@type SettingsPattern[]
M.global_patterns = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})

  local util = require("settings.util")

  M.local_patterns = {}
  M.global_patterns = {}

  if M.options.import.vscode then
    table.insert(M.local_patterns, { pattern = ".vscode/settings.json", key = "vscode" })
  end
  if M.options.import.coc then
    table.insert(M.local_patterns, { pattern = "coc-settings.json", key = "coc" })
    table.insert(M.global_patterns, { pattern = "coc-settings.json", key = "coc" })
  end
  if M.options.import.nlsp then
    local function nlsp_key(file)
      return "nlsp." .. vim.fn.fnamemodify(file, ":t:r")
    end
    table.insert(M.local_patterns, { pattern = ".nlsp-settings/*.json", key = nlsp_key })
    table.insert(M.global_patterns, { pattern = "nlsp-settings/*.json", key = nlsp_key })
  end

  vim.list_extend(M.local_patterns, util.expand(M.options.local_settings))
  vim.list_extend(M.global_patterns, util.expand(M.options.global_settings))
end

---@return Config
function M.merge(options)
  return vim.tbl_deep_extend("force", {}, M.options, options or {})
end

function M.get(opts)
  return require("settings").get("settings", M.options, opts)
end

return M
