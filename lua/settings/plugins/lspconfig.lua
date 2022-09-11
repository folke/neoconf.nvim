local Util = require("settings.util")
local Config = require("settings.config")
local Settings = require("settings.settings")

local M = {}

function M.setup()
  local settings_root = Util.root_pattern(unpack(Util.file_patterns({ global = false })))

  Util.on_config({
    name = "settings/plugins/lspconfig",
    on_config = M.on_new_config,
    root_dir = settings_root
  })
end

function M.on_new_config(config, root_dir)
  local options = Config.get({ file = root_dir })
  if not options.plugins.lspconfig.enabled then
    return
  end

  -- restore/backup current lsp settings
  if config._lsp_settings then
    config.settings = vim.deepcopy(config._lsp_settings)
  else
    config._lsp_settings = vim.deepcopy(config.settings)
  end

  root_dir = require("settings.workspace").find_root({ file = root_dir })

  config.settings = Util.merge(
    config.settings,
    -- merge in global lsp settings
    Settings.get_global():get("lspconfig." .. config.name) or {},
    options.import.coc and Settings.get_global():get("coc") or {},
    options.import.nlsp and Settings.get_global():get("nlsp." .. config.name) or {},
    -- merge in local lsp settings
    options.import.vscode and Settings.get_local(root_dir):get("vscode") or {},
    options.import.coc and Settings.get_local(root_dir):get("coc") or {},
    options.import.nlsp and Settings.get_local(root_dir):get("nlsp." .. config.name) or {},
    Settings.get_local(root_dir):get("lspconfig." .. config.name) or {}
  )
end

function M.on_update(fname)
  local is_global = Util.is_global(fname)

  local clients = vim.lsp.get_active_clients()

  for _, client in ipairs(clients) do
    local settings_root = require("settings.workspace").find_root({ file = client.config.root_dir })

    -- reload this client if the global file changed, or its root dir equals the local one
    if is_global or Util.has_file(settings_root, client.config.root_dir) then
      local old = vim.deepcopy(client.config.settings)

      -- re-apply config from any other plugins that were overriding on_new_config
      if client.config.on_new_config then
        pcall(client.config.on_new_config, client.config, client.config.root_dir)
      end

      -- only send update when confiuration actually changed
      if not vim.deep_equal(old, client.config.settings) then
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
end

return M
