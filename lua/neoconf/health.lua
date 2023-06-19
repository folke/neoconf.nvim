local M = {}

local health_start = vim.health.start or vim.health.report_start
local health_ok = vim.health.ok or vim.health.report_ok
local health_warn = vim.health.warn or vim.health.report_warn
local health_error = vim.health.error or vim.health.report_error
local health_info = vim.health.info or vim.health.report_info

function M.check()
  health_start("neoconf.nvim")

  local function info(msg, ...)
    health_info(msg:format(...))
  end

  local function ok(msg, ...)
    health_ok(msg:format(...))
  end

  local function warn(msg, ...)
    health_warn(msg:format(...))
  end

  local function error(msg, ...)
    health_warn(msg:format(...))
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

  if pcall(require, "neodev") then
    ok("**neodev.nvim** is installed")
  else
    warn("**neodev.nvim** is not installed. You won't get any proper completion for your Neovim config.")
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
    if vim.tbl_contains(available, "lua_ls") then
      ok("**lspconfig lua_ls** is installed")
    else
      warn("**lspconfig lua_ls** is not installed? You won't get any auto completion in your lua settings files")
    end
  else
    error("**lspconfig** not installed?")
  end
end

function M.check_setup()
  local util = require("neoconf.util")
  if vim.fn.has("nvim-0.7.2") == 0 then
    util.error("**neoconf.nvim** requires Neovim >= 0.7.2")
  end
  local lsputil = package.loaded["lspconfig.util"]
  if lsputil then
    if #lsputil.available_servers() == 0 then
      return true
    else
      util.error(
        [[Setup `require("neoconf").setup()` should be run **BEFORE** setting up any lsp server with lspconfig]]
      )
    end
  else
    -- lspconfig has not ben loaded yet
    -- so all is good
    return true
  end
end

return M
