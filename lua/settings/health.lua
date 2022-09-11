package.loaded["settings.health"] = nil

local M = {}

function M.check()
  vim.fn["health#report_start"]("Settings.nvim")

  local function info(msg, ...)
    vim.fn["health#report_info"](msg:format(...))
  end

  local function ok(msg, ...)
    vim.fn["health#report_ok"](msg:format(...))
  end

  local function warn(msg, ...)
    vim.fn["health#report_warn"](msg:format(...))
  end

  local function error(msg, ...)
    vim.fn["health#report_error"](msg:format(...))
  end

  local _, ts = pcall(require, "nvim-treesitter.parsers")

  if ts then
    ok("**treesitter-nvim** is installed")
    if ts.has_parser("jsonc") then
      ok("**TreeSitter jsonc** parser is installed")
    else
      warn("**TreeSitter jsonc** parser is not installed. Highlighting of jsonc files might be broken")
    end
  else
    warn("**treesitter-nvim** not installed. Highlighting of jsonc files might be broken")
  end

  local _, lspconfig = pcall(require, "lspconfig.util")

  if lspconfig then
    ok("**lspconfig** is installed")
    local available = lspconfig.available_servers()
    if vim.tbl_contains(available, "jsonls") then
      ok("**lspconfig jsonls** is installed")
    else
      warn("**lspconfig jsonls** is not installed? You won't get any auto completion in your settings files")
    end
    if vim.tbl_contains(available, "sumneko_lua") then
      ok("**lspconfig sumneko_lua** is installed")
    else
      warn("**lspconfig sumneko_lua** is not installed? You won't get any auto completion in your lua settings files")
    end
  else
    error("**lspconfig** not installed?")
  end
end

return M
