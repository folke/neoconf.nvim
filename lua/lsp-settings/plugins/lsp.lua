local Util = require("lsp-settings.util")
local Config = require("lsp-settings.config")
local Settings = require("lsp-settings.settings")

local M = {}

function M.setup()
  local lsputil = require("lspconfig.util")
  local hook = lsputil.add_hook_before

  local settings_root = lsputil.root_pattern(unpack(vim.tbl_values(Config.options.local_settings)))

  lsputil.on_setup = hook(lsputil.on_setup, function(config)
    config.on_new_config = hook(config.on_new_config, M.on_new_config)
    local root_dir = config.root_dir
    config.root_dir = function(...)
      return settings_root(...) or root_dir(...)
    end
  end)
end

local function merge_config(config, root_dir)
  if config._lsp_settings then
    config.settings = vim.deepcopy(config._lsp_settings)
  else
    config._lsp_settings = vim.deepcopy(config.settings)
  end

  config.settings = Util.merge(
    config.settings,
    Settings.get_global():get("lspconfig." .. config.name, { expand = true }) or {},
    Settings.get_local(root_dir):get("vscode", { expand = true }),
    Settings.get_local(root_dir):get("lspconfig." .. config.name, { expand = true }) or {}
  )
end

function M.on_new_config(config, root_dir)
  merge_config(config, root_dir)
end

-- TODO: add check if config changed
function M.on_update(fname)
  fname = Util.fqn(fname)

  -- clear cached settings for this file
  Settings.clear(fname)

  local root_dir = Util.fqn(vim.fn.fnamemodify(fname, ":h"))

  local is_global = Util.is_global(fname)

  local clients = vim.lsp.get_active_clients()

  for _, client in ipairs(clients) do
    -- reload this client if the global file changed, or its root dir equals the local one
    if is_global or client.config.root_dir == root_dir then
      -- re-apply config from any other plugins that were overriding on_new_config
      if client.config.on_new_config then
        pcall(client.config.on_new_config, client.config, client.config.root_dir)
      end

      -- notify the lsp server of thr new config
      local ok = pcall(client.notify, "workspace/didChangeConfiguration", {
        settings = client.config.settings,
      })

      if ok then
        Util.info("Reloaded settings for " .. client.name)
      else
        Util.error("Reloading settings failed for " .. client.name)
      end
    end
  end
end

return M
