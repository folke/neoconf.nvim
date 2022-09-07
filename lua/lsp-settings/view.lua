local M = {}

---@param str string
function M.show(str)
  local buf = vim.api.nvim_create_buf(false, false)
  local vpad = 4
  local hpad = 10

  local lines = {}
  for s in str:gmatch("([^\n]*)\n?") do
    table.insert(lines, s)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns - hpad * 2,
    height = vim.o.lines - vpad * 2,
    row = vpad,
    col = hpad,
    style = "minimal",
    border = "single",
  })

  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  vim.api.nvim_win_set_option(win, "conceallevel", 3)
  vim.api.nvim_win_set_option(win, "spell", false)
  vim.api.nvim_win_set_option(win, "wrap", true)

  local function close()
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  vim.keymap.set("n", "<ESC>", close, { buffer = buf, nowait = true })
  vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
  vim.api.nvim_create_autocmd({ "BufDelete", "BufLeave", "BufHidden" }, {
    once = true,
    buffer = buf,
    callback = close,
  })
end

function M.show_settings()
  local content = {
    "# Lsp Settings\n",
  }
  local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
  for _, client in ipairs(clients) do
    table.insert(content, "## " .. client.name .. "\n```lua\n" .. vim.inspect(client.config.settings) .. "\n```\n")
  end
  M.show(table.concat(content, "\n"))
end

return M
