local Util = require("neoconf.util")
local Config = require("neoconf.config")
local Settings = require("neoconf.settings")

---@type SettingsPlugin
local M = {}

function M.on_schema(schema)
  schema:set("lspconfig", {
    description = "lsp server settings for lspconfig",
  })

  for name, s in pairs(require("neoconf.build.schemas").index()) do
    if Config.options.plugins.jsonls.configured_servers_only == false or Util.has_lspconfig(name) then
      schema:set("lspconfig." .. name, {
        anyOf = {
          { const = "false", description = "Set to false to disable this lsp server" },
          {
            ["$ref"] = vim.uri_from_fname(s.settings_file),
          },
        },
      })
    end
  end
end

function M.setup()
  local settings_root = Util.root_pattern(unpack(Util.file_patterns({ global = false })))

  Util.on_config({
    name = "settings/plugins/lspconfig",
    on_config = M.on_new_config,
    root_dir = settings_root,
  })
end

function M.on_new_config(config, root_dir, original_config)
  local options = Config.get({ file = root_dir })
  if not options.plugins.lspconfig.enabled then
    return
  end

  -- backup original lsp config
  config.original_settings = vim.deepcopy(original_config.settings or {})

  root_dir = require("neoconf.workspace").find_root({ file = root_dir })
  local enabled = Settings.get_local(root_dir):get("lspconfig." .. config.name, { expand = true })
  if enabled == false then
    config.enabled = false
    return
  end

  config.settings = Util.merge(
    config.settings,
    -- merge in global lsp settings
    Settings.get_global():get("lspconfig." .. config.name, { expand = true }) or {},
    options.import.coc and Settings.get_global():get("coc") or {},
    options.import.nlsp and Settings.get_global():get("nlsp." .. config.name) or {},
    -- merge in local lsp settings
    options.import.vscode and Settings.get_local(root_dir):get("vscode") or {},
    options.import.coc and Settings.get_local(root_dir):get("coc") or {},
    options.import.nlsp and Settings.get_local(root_dir):get("nlsp." .. config.name) or {},
    Settings.get_local(root_dir):get("lspconfig." .. config.name, { expand = true }) or {}
  )
end

function M.on_update(fname)
  local is_global = Util.is_global(fname)

  local clients = vim.lsp.get_active_clients()

  for _, client in ipairs(clients) do
    local settings_root = require("neoconf.workspace").find_root({ file = client.config.root_dir })

    -- reload this client if the global file changed, or its root dir equals the local one
    if is_global or Util.has_file(settings_root, client.config.root_dir) then
      local old_settings = vim.deepcopy(client.config.settings)

      -- retrieve new settings only
      client.config.settings = vim.deepcopy(client.config.original_settings or {})

      local document_config = Util.has_lspconfig(client.name) and require("lspconfig")[client.name].document_config

      -- re-apply config from any other plugins that were overriding on_new_config
      if document_config and document_config.on_new_config then
        pcall(document_config.on_new_config, client.config, client.config.root_dir)
      end
      if client.config.on_new_config then
        pcall(client.config.on_new_config, client.config, client.config.root_dir)
      end

      -- only send update when confiuration actually changed
      if not vim.deep_equal(old_settings, client.config.settings) then
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
