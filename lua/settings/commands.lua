local Util = require("settings.util")
local Config = require("settings.config")
local Settings = require("settings.settings")

local M = {}

function M.setup()
  local commands = {
    lsp = function()
      require("settings.view").show_lsp_settings()
    end,
    ["local"] = function()
      M.edit({ ["local"] = true })
    end,
    global = function()
      M.edit({ global = true })
    end,
  }

  vim.api.nvim_create_user_command("Settings", function(args)
    local cmd = vim.trim(args.args or "")
    if commands[cmd] then
      commands[cmd]()
    else
      M.edit()
    end
  end, {
    nargs = "?",
    desc = "Neovim Settings",
    complete = function(_, line)
      if line:match("^Settings %w+ ") then
        return {}
      end
      return vim.tbl_keys(commands)
    end,
  })

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

function M.get_files(opts)
  opts = opts or {}
  local items = {}

  if not opts["local"] then
    Util.for_each_global(function(file)
      table.insert(items, { file = file, is_global = true })
    end)
  end

  if not opts.global then
    local root_dir = require("settings.workspace").find_root({ lsp = true })
    Util.for_each_local(function(f)
      items[f] = { file = f }
    end, root_dir)
  end

  return vim.tbl_values(items)
end

function M.edit(opts)
  opts = opts or {}

  local files = M.get_files(opts)

  for _, item in ipairs(files) do
    if opts["local"] and not item.is_global and Util.exists(item.file) then
      vim.cmd("edit " .. item.file)
      return
    end
    if opts["global"] and item.is_global and Util.exists(item.file) then
      vim.cmd("edit " .. item.file)
      return
    end
  end

  table.sort(files, function(a, b)
    local aa = Util.exists(a.file) and 100 or 0
    local bb = Util.exists(b.file) and 100 or 0

    if not a.is_global then
      aa = aa + 10
    end
    if not b.is_global then
      bb = bb + 10
    end
    return aa > bb
  end)

  vim.ui.select(files, {
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
