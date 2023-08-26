# 💼 neoconf.nvim

**neoconf.nvim** is a Neovim plugin to manage global and project-local settings.

![image](https://user-images.githubusercontent.com/292349/202160538-3711693c-14fd-4e8b-a9d1-ceda88bae00c.png)

## ✨ Features

- configure Neovim using **JSON** files (can have comments)
  - global settings: `~/.config/nvim/neoconf.json`
  - local settings: `~/projects/foobar/.neoconf.json`
- live reload of your lsp settings
- import existing settings from [vscode](https://github.com/microsoft/vscode),
  [coc.nvim](https://github.com/neoclide/coc.nvim) and
  [nlsp-settings.nvim](https://github.com/tamago324/nlsp-settings.nvim)
- auto-completion of all the settings in the **Json config files**
- auto-completion of all LSP settings in your **Neovim Lua config files**
- integrates with [neodev.nvim](https://github.com/folke/neodev.nvim).
  See [.neoconf.json](https://github.com/folke/neoconf.nvim/blob/main/.neoconf.json) in this repo.

## ⚡️ Requirements

- Neovim >= 0.7.2

## 📦 Installation

Install the plugin with your preferred package manager:

### [packer](https://github.com/wbthomason/packer.nvim)

```lua
-- Lua
use({
  "folke/neoconf.nvim",
})
```

## 🚀 Setup

It's important that you set up `neoconf.nvim` **BEFORE** `nvim-lspconfig`.

```lua
require("neoconf").setup({
  -- override any of the default settings here
})

-- setup your lsp servers as usual
require("lspconfig").lua_ls.setup(...)
```

## ⚙️ Configuration

**neoconf.nvim** comes with the following defaults:

```lua
{

  -- name of the local settings files
  local_settings = ".neoconf.json",
  -- name of the global settings file in your Neovim config directory
  global_settings = "neoconf.json",
  -- import existing settings from other plugins
  import = {
    vscode = true, -- local .vscode/settings.json
    coc = true, -- global/local coc-settings.json
    nlsp = true, -- global/local nlsp-settings.nvim json settings
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
    -- configures lua_ls to get completion of lspconfig server settings
    lua_ls = {
      -- by default, lua_ls annotations are only enabled in your neovim config directory
      enabled_for_neovim_config = true,
      -- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file
      enabled = false,
    },
  },

}
```

## 🚀 Usage

### The `:Neoconf` Command

- `:Neoconf`: will show a ui to select one of the local/global json config files to edit
- `:Neoconf local`: will show a ui to select one of the local json config files to edit
- `:Neoconf global`: will show a ui to select one of the global json config files to edit
- `:Neoconf show`: opens a floating window with the merged config
- `:Neoconf lsp`: opens a floating window with your merged lsp config

![image](https://user-images.githubusercontent.com/292349/202161064-16789740-f094-4729-97c2-b6509148a7fd.png)

### Completion and Validation for your `Json` Settings Files

![image](https://user-images.githubusercontent.com/292349/202160792-f956e3af-535f-4ad6-8de4-d89854072f91.png)

### Completion and Validation for your `Lua` Settings Files

Completion of your lua settings should work out of the box.

![image](https://user-images.githubusercontent.com/292349/202160675-ea9a62b4-7084-40a3-966e-e9d5f0fb70ec.png)

You can additionally use the exported types in other places.

<details>
<summary>Example with a table containing LSP server settings</summary>

```lua
  ---@type lspconfig.options
  local servers = {
    ansiblels = {},
    bashls = {},
    clangd = {},
    cssls = {},
    dockerls = {},
    tsserver = {},
    svelte = {},
    eslint = {},
    html = {},
    jsonls = {
      settings = {
        json = {
          format = {
            enable = true,
          },
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
  }
```

</details>

## 📦 API

**Neodev** comes with an API that can be used by plugin developers to load global/local settings for their plugin.

```lua
---@class SettingsPlugin
---@field name string
---@field setup fun()|nil
---@field on_update fun(event)|nil
---@field on_schema fun(schema: Schema)

-- Registers a plugin. Biggest use-case is to get auto-completion for your plugin in the json settings files
---@param plugin SettingsPlugin
function Neodev.register(plugin) end

---@class WorkspaceOptions
---@field file? string File will be used to determine the root_dir
---@field buffer? buffer Buffer will be used to find the root_dir
---@field lsp? boolean LSP root_dir will be used to determine the root_dir
---@field local? boolean defaults to true. Merge local settings
---@field global? boolean defaults to true. Merge global settings

-- Returns the requested settings
---@generic T : table
---@param key? string Optional key to get settings for
---@param defaults? T Optional table of defaults that will be merged in the result
---@param opts? WorkspaceOptions options to determine the root_dir and what settings to merge
---@return T
function Neoconf.get(key, defaults, opts) end
```

<details>
<summary>API Example</summary>

```lua
-- default config for your plugin
local defaults = {
  doit = true,
  count = 1,
  array = {},
}

-- register your settings schema with Neodev, so auto-completion will work in the json files
require("neoconf.plugins").register({
    on_schema = function(schema)
    -- this call will create a json schema based on the lua types of your default settings
    schema:import("myplugin", defaults)
    -- Optionally update some of the json schema
    schema:set("myplugin.array", {
        description = "Special array containg booleans or numbers",
        anyOf = {
        { type = "boolean" },
        { type = "integer" },
        },
        })
    end,
    })

local my_settings = Neoconf.get("neodev", defaults)
```

</details>

## ⭐ Acknowledgment

- [json.lua](https://github.com/actboy168/json.lua) a pure-lua JSON library for parsing `jsonc` files

## 💻 Supported Language Servers

<!-- GENERATED -->
- [x] [als](https://github.com/AdaCore/ada_language_server/tree/master/integration/vscode/ada/package.json)
- [x] [astro](https://github.com/withastro/language-tools/tree/main/packages/vscode/package.json)
- [x] [awkls](https://github.com/Beaglefoot/awk-language-server/tree/master/client/package.json)
- [x] [bashls](https://github.com/bash-lsp/bash-language-server/tree/master/vscode-client/package.json)
- [x] [clangd](https://github.com/clangd/vscode-clangd/tree/master/package.json)
- [x] [cssls](https://github.com/microsoft/vscode/tree/main/extensions/css-language-features/package.json)
- [x] [dartls](https://github.com/Dart-Code/Dart-Code/tree/master/package.json)
- [x] [denols](https://github.com/denoland/vscode_deno/tree/main/package.json)
- [x] [elixirls](https://github.com/elixir-lsp/vscode-elixir-ls/tree/master/package.json)
- [x] [elmls](https://github.com/elm-tooling/elm-language-client-vscode/tree/master/package.json)
- [x] [eslint](https://github.com/microsoft/vscode-eslint/tree/main/package.json)
- [x] [flow](https://github.com/flowtype/flow-for-vscode/tree/master/package.json)
- [x] [fsautocomplete](https://github.com/ionide/ionide-vscode-fsharp/tree/main/release/package.json)
- [x] [grammarly](https://github.com/znck/grammarly/tree/main/extension/package.json)
- [x] [haxe_language_server](https://github.com/vshaxe/vshaxe/tree/master/package.json)
- [x] [hhvm](https://github.com/slackhq/vscode-hack/tree/master/package.json)
- [x] [hie](https://github.com/alanz/vscode-hie-server/tree/master/package.json)
- [x] [html](https://github.com/microsoft/vscode/tree/main/extensions/html-language-features/package.json)
- [x] [intelephense](https://github.com/bmewburn/vscode-intelephense/tree/master/package.json)
- [x] [java_language_server](https://github.com/georgewfraser/java-language-server/tree/master/package.json)
- [x] [jdtls](https://github.com/redhat-developer/vscode-java/tree/master/package.json)
- [x] [jsonls](https://github.com/microsoft/vscode/tree/master/extensions/json-language-features/package.json)
- [x] [julials](https://github.com/julia-vscode/julia-vscode/tree/master/package.json)
- [x] [kotlin_language_server](https://github.com/fwcd/vscode-kotlin/tree/master/package.json)
- [x] [ltex](https://github.com/valentjn/vscode-ltex/tree/develop/package.json)
- [x] [lua_ls](https://github.com/LuaLS/vscode-lua/tree/master/package.json)
- [x] [luau_lsp](https://github.com/JohnnyMorganz/luau-lsp/tree/main/editors/code/package.json)
- [x] [omnisharp](https://github.com/OmniSharp/omnisharp-vscode/tree/master/package.json)
- [x] [perlls](https://github.com/richterger/Perl-LanguageServer/tree/master/clients/vscode/perl/package.json)
- [x] [perlnavigator](https://github.com/bscan/PerlNavigator/tree/main/package.json)
- [x] [perlpls](https://github.com/FractalBoy/perl-language-server/tree/master/client/package.json)
- [x] [powershell_es](https://github.com/PowerShell/vscode-powershell/tree/main/package.json)
- [x] [psalm](https://github.com/psalm/psalm-vscode-plugin/tree/master/package.json)
- [x] [puppet](https://github.com/puppetlabs/puppet-vscode/tree/main/package.json)
- [x] [purescriptls](https://github.com/nwolverson/vscode-ide-purescript/tree/master/package.json)
- [x] [pylsp](https://github.com/python-lsp/python-lsp-server/tree/develop/pylsp/config/schema.json)
- [x] [pyright](https://github.com/microsoft/pyright/tree/master/packages/vscode-pyright/package.json)
- [x] [r_language_server](https://github.com/REditorSupport/vscode-r-lsp/tree/master/package.json)
- [x] [rescriptls](https://github.com/rescript-lang/rescript-vscode/tree/master/package.json)
- [x] [rls](https://github.com/rust-lang/vscode-rust/tree/master/package.json)
- [x] [rome](https://github.com/rome/tools/tree/main/editors/vscode/package.json)
- [x] [rust_analyzer](https://github.com/rust-analyzer/rust-analyzer/tree/master/editors/code/package.json)
- [x] [solargraph](https://github.com/castwide/vscode-solargraph/tree/master/package.json)
- [x] [solidity_ls](https://github.com/juanfranblanco/vscode-solidity/tree/master/package.json)
- [x] [sorbet](https://github.com/sorbet/sorbet/tree/master/vscode_extension/package.json)
- [x] [sourcekit](https://github.com/swift-server/vscode-swift/tree/main/package.json)
- [x] [spectral](https://github.com/stoplightio/vscode-spectral/tree/master/package.json)
- [x] [stylelint_lsp](https://github.com/bmatcuk/coc-stylelintplus/tree/master/package.json)
- [x] [svelte](https://github.com/sveltejs/language-tools/tree/master/packages/svelte-vscode/package.json)
- [x] [svlangserver](https://github.com/eirikpre/VSCode-SystemVerilog/tree/master/package.json)
- [x] [tailwindcss](https://github.com/tailwindlabs/tailwindcss-intellisense/tree/master/packages/vscode-tailwindcss/package.json)
- [x] [terraformls](https://github.com/hashicorp/vscode-terraform/tree/master/package.json)
- [x] [tsserver](https://github.com/microsoft/vscode/tree/main/extensions/typescript-language-features/package.json)
- [x] [volar](https://github.com/vuejs/language-tools/tree/master/packages/vscode-vue/package.json)
- [x] [vtsls](https://github.com/yioneko/vtsls/tree/main/packages/service/configuration.schema.json)
- [x] [vuels](https://github.com/vuejs/vetur/tree/master/package.json)
- [x] [wgls_analyzer](https://github.com/wgsl-analyzer/wgsl-analyzer/tree/main/editors/code/package.json)
- [x] [yamlls](https://github.com/redhat-developer/vscode-yaml/tree/master/package.json)
- [x] [zeta_note](https://github.com/artempyanykh/zeta-note-vscode/tree/main/package.json)
- [x] [zls](https://github.com/zigtools/zls-vscode/tree/master/package.json)
