# 🗃️ Lsp Settings

**Workspace** is a lua plugin to manage global and workspace-local Neovim
settings.

## ✅ Todo

- [x] naming for generated emmylua
- [ ] generate list of supported lsp servers
- [x] name of plugin??
- [x] importers?

- [x] keymaps
- [x] json => jsonc for settings files
- [x] commands to edit json settings files
- [x] less magic for patterns (use {name = .., key = .., ...})
- [x] rename to settings.nvim??
- [x] check vscode config api
- [x] support lazy-loading of workspace.nvim and register plugins
- [x] path.join (workspace.has_file)

## ✨ Features

- configure Neovim using **JSON** files
  - global settings: `~/.config/nvim/settings.json`
  - local settings: `~/projects/foobar/.nvim.settings.json`
- live reload of your settings
- extensible plugin architecture
- built-in plugins:
  - **options:** configure global (`vim.opt`) and local (`vim.opt_local`)
    options.
  - **lsp**: configure the LSP clients using workspace settings.
- some workspace plugins support existing vscode settings read from
  `.vscode/settings.json`. For LSP for example, this means that existing
  configuration for LSP servers work out of the box.
- live-reload of your settings: whenever you change a local or global JSON
  settings file, the changes are applied immediately

## ⚡️ Requirements

- Neovim >= 0.7.2

## 📦 Installation

Install the plugin with your preferred package manager:

### [packer](https://github.com/wbthomason/packer.nvim)

```lua
-- Lua
use({
  "folke/settings.nvim",
  module = "settings",
  config = function()
    require("settings").setup()
  end,
})
```

## 🚀 Setup

It's important that you set up `settings.nvim` **BEFORE** `nvim-lspconfig`.

```lua
require("settings").setup({
  -- override any of the default settings here
})
require("lspconfig").sumneko_lua.setup(...)
```

## ⚙️ Configuration

**settings.nvim** comes with the following defaults:

```lua
{
  -- name of the local settings files
  local_settings = ".nvim.settings.json",
  -- name of the global settings file in your Neovim config directory
  global_settings = "settings.json",
  -- import existing settinsg from other plugins
  import = {
    vscode = true, -- local .vscode/settings.json
    coc = true, -- global/local coc-settings.json
    nlsp = true, -- nlsp-settings.nvim json settings
  },
  -- send new configuration to lsp clients when changing json settings
  live_reload = true,
  -- set the filetype to jsonc for settings files, so you can use comments
  -- make sure you have the jsonc treesitter parser installed!
  filetype_jsonc = true,
  plugins = {
    -- configures lsp clients with settings in the following order:
    -- - lua settings passed in lspconfig setup
    -- - global json settings
    -- - local json settings
    lspconfig = {
      enabled = true,
    },
    -- configures jsonls to get completion in .nvim.settings.json files
    jsonls = {
      enabled = true,
      -- only show completion in json settings for configured lsp servers
      configured_servers_only = true,
    },
    -- configures sumneko_lua to get completion of lspconfig server settings
    sumneko_lua = {
      -- by default, sumneko_lua annotations are only enabled in your neovim config directory
      enabled_for_neovim_config = true,
      -- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file
      enabled = false,
    },
  },
}
```

## 🚀 Usage

### The `:Settings` Command

### Completion and Validation for your `Json` Settings Files

### Completion and Validation for your `Lua` Settings Files

### Importing Your Existing Settings

## ⭐ Acknowledgment

- [json.lua](https://github.com/actboy168/json.lua) a pure-lua JSON library for parsing `jsonc` files

## Supported Language Servers

<!-- GENERATED -->

