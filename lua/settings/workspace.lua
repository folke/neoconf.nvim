local Util = require("settings.util")
local Config = require("settings.config")
local Settings = require("settings.settings")

local M = {}

---@class WorkspaceFindOptions
---@field file string
---@field buffer buffer
---@field lsp boolean

---@param opts WorkspaceFindOptions
function M.find_root(opts)
  opts = opts or {}

  local buf = opts.buffer ~= 0 and opts.buffer or vim.api.nvim_get_current_buf()

  local fname = Util.fqn(opts.file or vim.api.nvim_buf_get_name(buf))

  local util = require("lspconfig.util")

  -- find the root dir that contains a local settings file
  local root_dir = util.root_pattern(unpack(vim.tbl_values(Config.options.local_settings)))(fname)

  -- fallback to lsp root_dir detection if in options
  if not root_dir and opts.lsp then
    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = buf })) do
      root_dir = client.config.root_dir
      break
    end
  end

  -- fallback to git ancestor or cwd
  return util.find_git_ancestor(fname) or vim.fn.getcwd()
end

---@class WorkspaceOptions: WorkspaceFindOptions
---@field local boolean
---@field global boolean

---@param opts WorkspaceOptions
---@return { root_dir: string, settings: Settings }
function M.get(opts)
  opts = Util.merge({
    ["local"] = true,
    global = true,
  }, opts)

  local ret = Settings.new()
  if opts.global then
    ret:merge(Settings.get_global())
  end

  local root_dir = M.find_root(opts)
  if root_dir and opts["local"] then
    ret:merge(Settings.get_local(root_dir))
  end

  return { root_dir = root_dir, settings = ret }
end

return M
