local Util = require("neoconf.util")
local Settings = require("neoconf.settings")

local M = {}

---@class WorkspaceFindOptions
---@field file? string
---@field buffer? buffer
---@field lsp? boolean

---@param opts WorkspaceFindOptions
function M.find_root(opts)
  opts = opts or {}

  local buf = opts.buffer ~= 0 and opts.buffer or vim.api.nvim_get_current_buf()
  local fname = Util.fqn(opts.file or vim.api.nvim_buf_get_name(buf))

  -- find the root dir that contains a local settings file
  local root_dir = Util.root_pattern(unpack(Util.file_patterns({ global = false })))(fname)

  -- fallback to lsp root_dir detection if in options
  if not root_dir and opts.lsp then
    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = buf })) do
      root_dir = client.config.root_dir
      break
    end
  end

  -- fallback to git ancestor or cwd
  return root_dir or Util.find_git_ancestor(fname) or vim.fn.getcwd()
end

---@class WorkspaceOptions: WorkspaceFindOptions
---@field local? boolean defaults to true
---@field global? boolean defaults to true

---@param opts WorkspaceOptions|nil
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
