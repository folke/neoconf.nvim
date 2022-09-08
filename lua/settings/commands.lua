local Util = require("settings.util")
local Config = require("settings.config")
local Settings = require("settings.settings")

local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Settings", function(args)
    if args.args == "show" then
      require("settings.view").show_settings()
    else
      M.edit()
    end
  end, { nargs = "?", desc = "Show the settings of the attached lsp servers" })

  local group = vim.api.nvim_create_augroup("Settings", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = Util.merge({}, Config.options.global_settings, vim.tbl_values(Config.options.local_settings)),
    group = group,
    callback = function(event)
      local fname = Util.fqn(event.match)
      -- clear cached settings for this file
      Settings.clear(fname)
      require("settings.plugins").fire("on_update", event.match)
    end,
  })
end

function M.edit()
  local buf = vim.api.nvim_get_current_buf()

  local items = {}

  Util.for_each_global(function(file)
    table.insert(items, { file = file, is_global = true })
  end)

  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = buf })) do
    Util.for_each_local(function(f)
      items[f] = { file = f }
    end, client.config.root_dir)
  end

  items = vim.tbl_values(items)

  vim.ui.select(items, {
    prompt = "Select settings file to create/edit",
    format_item = function(item)
      local line = Util.exists(item.file) and "  edit " or "  create "
      line = line .. vim.fn.fnamemodify(item.file, ":~")
      if item.is_global then
        line = line .. "  "
      end
      return line
    end,
  }, function(choice)
    if choice then
      vim.cmd("edit " .. choice.file)
    end
  end)
end

return M
