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

  M.create_auto_commands()
end

function M.on_new_config(config, root_dir)
  M.merge_config(config, root_dir)
  if config.name == "jsonls" then
    M.setup_jsonls(config)
  end
end

function M.merge_config(config, root_dir)
  local settings = Settings.new()

  if config._lsp_settings then
    config.settings = vim.deepcopy(config._lsp_settings)
  else
    config._lsp_settings = vim.deepcopy(config.settings)
  end

  settings:merge(config.settings)

  settings:merge(Settings.get(Util.global_settings_file()))

  Util.for_each_local(function(_, file)
    settings:merge(Settings.get(file))
  end, root_dir)

  config.settings = settings:get()
end

function M.reload_settings(fname)
  fname = Util.fqn(fname)

  -- clear cached settings for this file
  Settings.clear(fname)

  local root_dir = Util.fqn(vim.fn.fnamemodify(fname, ":h"))

  local is_global = fname == Util.global_settings_file()

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

function M.setup_jsonls(config)
  local options = require("lsp-settings.config").options
  local schemas = config.settings.json and config.settings.json.schemas or {}

  for name, _ in pairs(Util.index()) do
    if options.jsonls.configured_servers_only == false or require("lspconfig.configs")[name] then
      table.insert(schemas, {
        name = name,
        description = "Schema for " .. name,
        fileMatch = { ".lsp-settings.json" },
        url = Util.schema(name),
      })
    end
  end

  config.settings = Util.merge({}, config.settings, {
    json = {
      schemas = schemas,
      validate = {
        enable = true,
      },
    },
  })
end

function M.create_auto_commands()
  local group = vim.api.nvim_create_augroup("LspSettings", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = Util.merge({}, Config.options.global_settings, Config.options.local_settings),
    group = group,
    callback = function(event)
      M.reload_settings(event.match)
    end,
  })
end

return M
