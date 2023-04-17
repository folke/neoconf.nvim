local Util = require("neoconf.util")
local Settings = require("neoconf.settings")
local Config = require("neoconf.config")

local M = {}

function M.setup()
  local commands = {
    lsp = function()
      require("neoconf.view").show_lsp_settings()
    end,
    show = function()
      require("neoconf.view").show_settings()
    end,
    ["local"] = function()
      M.edit({ ["global"] = false })
    end,
    global = function()
      M.edit({ ["local"] = false })
    end,
    checkhealth = function()
      vim.cmd([[checkhealth settings]])
    end,
  }

  vim.api.nvim_create_user_command("Neoconf", function(args)
    local cmd = vim.trim(args.args or "")
    if commands[cmd] then
      commands[cmd]()
    else
      M.edit()
    end
  end, {
    nargs = "?",
    desc = "Neovim Settings",
    complete = function(f, line, ...)
      if line:match("^%s*Neoconf %w+ ") then
        return {}
      end
      local prefix = line:match("^%s*Neoconf (%w*)")
      return vim.tbl_filter(function(key)
        return key:find(prefix) == 1
      end, vim.tbl_keys(commands))
    end,
  })

  local group = vim.api.nvim_create_augroup("Neoconf", { clear = true })

  if Config.options.live_reload then
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = Util.file_patterns({ autocmd = true }),
      group = group,
      callback = function(event)
        local fname = Util.fqn(event.match)
        -- clear cached settings for this file
        Settings.clear(fname)
        require("neoconf.plugins").fire("on_update", fname)
      end,
    })
  end

  if Config.options.filetype_jsonc then
    if vim.g.do_legacy_filetype then
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = Util.file_patterns({ autocmd = true }),
        group = group,
        callback = function(event)
          vim.api.nvim_buf_set_option(event.buf, "filetype", "jsonc")
        end,
      })
    else
      vim.filetype.add(Util.filetype_patterns())
    end
  end
end

function M.get_files(opts)
  opts = opts or {}
  opts["local"] = opts["local"] == nil and true or opts["local"]
  opts["global"] = opts["global"] == nil and true or opts["global"]

  local items = {}

  if opts["global"] then
    Util.for_each_global(function(file)
      table.insert(items, { file = file, is_global = true })
    end)
  end

  if opts["local"] then
    local root_dir = require("neoconf.workspace").find_root({ lsp = true, file = opts.file })
    Util.for_each_local(function(f)
      table.insert(items, { file = f })
    end, root_dir)
  end

  -- return files that exist or the default files.
  -- never return imported file patterms that don't exist
  return vim.tbl_filter(function(item)
    if Util.exists(item.file) then
      return true
    end
    if not item.is_global and item.file:find("/" .. Config.options.local_settings) then
      return true
    end
    if item.is_global and item.file:find("/" .. Config.options.global_settings) then
      return true
    end
  end, items)
end

function M.edit(opts)
  opts = opts or {}

  local files = M.get_files(opts)

  if #files == 1 then
    vim.cmd("edit " .. files[1].file)
    return
  end

  local edit = {}
  local create = {}
  for _, item in ipairs(files) do
    local l = Util.exists(item.file) and edit or create
    table.insert(l, 1, item)
  end
  files = vim.list_extend(edit, create)

  vim.ui.select(files, {
    prompt = "Select the settings file to create/edit",
    format_item = function(item)
      local line = Util.exists(item.file) and "  edit " or "  create "
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
