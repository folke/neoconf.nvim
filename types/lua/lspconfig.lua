---@meta

---@class LspConfigOptions
---@field root_dir fun(filename, bufnr): string|nil
---@field name string
---@field filetypes string[] | nil
---@field autostart boolean
---@field single_file_support boolean
---@field on_new_config fun(new_config, new_root_dir)
---@field capabilities table
---@field cmd string[]
---@field handlers table<string, fun()>
---@field init_options table
---@field on_attach fun(client, bufnr)

---@module 'lspconfig'
local lspconfig


---@class LspConfigOptions.elmls: LspConfigOptions
---@field settings Settings.elmls

lspconfig.elmls = {
  ---@param options LspConfigOptions.elmls
  setup = function(options) end,
}

---@class LspConfigOptions.sumneko_lua: LspConfigOptions
---@field settings Settings.sumneko_lua

lspconfig.sumneko_lua = {
  ---@param options LspConfigOptions.sumneko_lua
  setup = function(options) end,
}

---@class LspConfigOptions.fsautocomplete: LspConfigOptions
---@field settings Settings.fsautocomplete

lspconfig.fsautocomplete = {
  ---@param options LspConfigOptions.fsautocomplete
  setup = function(options) end,
}

---@class LspConfigOptions.grammarly: LspConfigOptions
---@field settings Settings.grammarly

lspconfig.grammarly = {
  ---@param options LspConfigOptions.grammarly
  setup = function(options) end,
}

---@class LspConfigOptions.haxe_language_server: LspConfigOptions
---@field settings Settings.haxe_language_server

lspconfig.haxe_language_server = {
  ---@param options LspConfigOptions.haxe_language_server
  setup = function(options) end,
}

---@class LspConfigOptions.wgls_analyzer: LspConfigOptions
---@field settings Settings.wgls_analyzer

lspconfig.wgls_analyzer = {
  ---@param options LspConfigOptions.wgls_analyzer
  setup = function(options) end,
}

---@class LspConfigOptions.astro: LspConfigOptions
---@field settings Settings.astro

lspconfig.astro = {
  ---@param options LspConfigOptions.astro
  setup = function(options) end,
}

---@class LspConfigOptions.spectral: LspConfigOptions
---@field settings Settings.spectral

lspconfig.spectral = {
  ---@param options LspConfigOptions.spectral
  setup = function(options) end,
}

---@class LspConfigOptions.julials: LspConfigOptions
---@field settings Settings.julials

lspconfig.julials = {
  ---@param options LspConfigOptions.julials
  setup = function(options) end,
}

---@class LspConfigOptions.kotlin_language_server: LspConfigOptions
---@field settings Settings.kotlin_language_server

lspconfig.kotlin_language_server = {
  ---@param options LspConfigOptions.kotlin_language_server
  setup = function(options) end,
}

---@class LspConfigOptions.zls: LspConfigOptions
---@field settings Settings.zls

lspconfig.zls = {
  ---@param options LspConfigOptions.zls
  setup = function(options) end,
}

---@class LspConfigOptions.ltex: LspConfigOptions
---@field settings Settings.ltex

lspconfig.ltex = {
  ---@param options LspConfigOptions.ltex
  setup = function(options) end,
}

---@class LspConfigOptions.svelte: LspConfigOptions
---@field settings Settings.svelte

lspconfig.svelte = {
  ---@param options LspConfigOptions.svelte
  setup = function(options) end,
}

---@class LspConfigOptions.zeta_note: LspConfigOptions
---@field settings Settings.zeta_note

lspconfig.zeta_note = {
  ---@param options LspConfigOptions.zeta_note
  setup = function(options) end,
}

---@class LspConfigOptions.nickel_ls: LspConfigOptions
---@field settings Settings.nickel_ls

lspconfig.nickel_ls = {
  ---@param options LspConfigOptions.nickel_ls
  setup = function(options) end,
}

---@class LspConfigOptions.flow: LspConfigOptions
---@field settings Settings.flow

lspconfig.flow = {
  ---@param options LspConfigOptions.flow
  setup = function(options) end,
}

---@class LspConfigOptions.tailwindcss: LspConfigOptions
---@field settings Settings.tailwindcss

lspconfig.tailwindcss = {
  ---@param options LspConfigOptions.tailwindcss
  setup = function(options) end,
}

---@class LspConfigOptions.hie: LspConfigOptions
---@field settings Settings.hie

lspconfig.hie = {
  ---@param options LspConfigOptions.hie
  setup = function(options) end,
}

---@class LspConfigOptions.dartls: LspConfigOptions
---@field settings Settings.dartls

lspconfig.dartls = {
  ---@param options LspConfigOptions.dartls
  setup = function(options) end,
}

---@class LspConfigOptions.powershell_es: LspConfigOptions
---@field settings Settings.powershell_es

lspconfig.powershell_es = {
  ---@param options LspConfigOptions.powershell_es
  setup = function(options) end,
}

---@class LspConfigOptions.hhvm: LspConfigOptions
---@field settings Settings.hhvm

lspconfig.hhvm = {
  ---@param options LspConfigOptions.hhvm
  setup = function(options) end,
}

---@class LspConfigOptions.tsserver: LspConfigOptions
---@field settings Settings.tsserver

lspconfig.tsserver = {
  ---@param options LspConfigOptions.tsserver
  setup = function(options) end,
}

---@class LspConfigOptions.purescriptls: LspConfigOptions
---@field settings Settings.purescriptls

lspconfig.purescriptls = {
  ---@param options LspConfigOptions.purescriptls
  setup = function(options) end,
}

---@class LspConfigOptions.pylsp: LspConfigOptions
---@field settings Settings.pylsp

lspconfig.pylsp = {
  ---@param options LspConfigOptions.pylsp
  setup = function(options) end,
}

---@class LspConfigOptions.awkls: LspConfigOptions
---@field settings Settings.awkls

lspconfig.awkls = {
  ---@param options LspConfigOptions.awkls
  setup = function(options) end,
}

---@class LspConfigOptions.r_language_server: LspConfigOptions
---@field settings Settings.r_language_server

lspconfig.r_language_server = {
  ---@param options LspConfigOptions.r_language_server
  setup = function(options) end,
}

---@class LspConfigOptions.java_language_server: LspConfigOptions
---@field settings Settings.java_language_server

lspconfig.java_language_server = {
  ---@param options LspConfigOptions.java_language_server
  setup = function(options) end,
}

---@class LspConfigOptions.perlls: LspConfigOptions
---@field settings Settings.perlls

lspconfig.perlls = {
  ---@param options LspConfigOptions.perlls
  setup = function(options) end,
}

---@class LspConfigOptions.rescriptls: LspConfigOptions
---@field settings Settings.rescriptls

lspconfig.rescriptls = {
  ---@param options LspConfigOptions.rescriptls
  setup = function(options) end,
}

---@class LspConfigOptions.sorbet: LspConfigOptions
---@field settings Settings.sorbet

lspconfig.sorbet = {
  ---@param options LspConfigOptions.sorbet
  setup = function(options) end,
}

---@class LspConfigOptions.eslint: LspConfigOptions
---@field settings Settings.eslint

lspconfig.eslint = {
  ---@param options LspConfigOptions.eslint
  setup = function(options) end,
}

---@class LspConfigOptions.omnisharp: LspConfigOptions
---@field settings Settings.omnisharp

lspconfig.omnisharp = {
  ---@param options LspConfigOptions.omnisharp
  setup = function(options) end,
}

---@class LspConfigOptions.volar: LspConfigOptions
---@field settings Settings.volar

lspconfig.volar = {
  ---@param options LspConfigOptions.volar
  setup = function(options) end,
}

---@class LspConfigOptions.puppet: LspConfigOptions
---@field settings Settings.puppet

lspconfig.puppet = {
  ---@param options LspConfigOptions.puppet
  setup = function(options) end,
}

---@class LspConfigOptions.clangd: LspConfigOptions
---@field settings Settings.clangd

lspconfig.clangd = {
  ---@param options LspConfigOptions.clangd
  setup = function(options) end,
}

---@class LspConfigOptions.stylelint_lsp: LspConfigOptions
---@field settings Settings.stylelint_lsp

lspconfig.stylelint_lsp = {
  ---@param options LspConfigOptions.stylelint_lsp
  setup = function(options) end,
}

---@class LspConfigOptions.solargraph: LspConfigOptions
---@field settings Settings.solargraph

lspconfig.solargraph = {
  ---@param options LspConfigOptions.solargraph
  setup = function(options) end,
}

---@class LspConfigOptions.terraformls: LspConfigOptions
---@field settings Settings.terraformls

lspconfig.terraformls = {
  ---@param options LspConfigOptions.terraformls
  setup = function(options) end,
}

---@class LspConfigOptions.perlpls: LspConfigOptions
---@field settings Settings.perlpls

lspconfig.perlpls = {
  ---@param options LspConfigOptions.perlpls
  setup = function(options) end,
}

---@class LspConfigOptions.vuels: LspConfigOptions
---@field settings Settings.vuels

lspconfig.vuels = {
  ---@param options LspConfigOptions.vuels
  setup = function(options) end,
}

---@class LspConfigOptions.als: LspConfigOptions
---@field settings Settings.als

lspconfig.als = {
  ---@param options LspConfigOptions.als
  setup = function(options) end,
}

---@class LspConfigOptions.intelephense: LspConfigOptions
---@field settings Settings.intelephense

lspconfig.intelephense = {
  ---@param options LspConfigOptions.intelephense
  setup = function(options) end,
}

---@class LspConfigOptions.html: LspConfigOptions
---@field settings Settings.html

lspconfig.html = {
  ---@param options LspConfigOptions.html
  setup = function(options) end,
}

---@class LspConfigOptions.yamlls: LspConfigOptions
---@field settings Settings.yamlls

lspconfig.yamlls = {
  ---@param options LspConfigOptions.yamlls
  setup = function(options) end,
}

---@class LspConfigOptions.bashls: LspConfigOptions
---@field settings Settings.bashls

lspconfig.bashls = {
  ---@param options LspConfigOptions.bashls
  setup = function(options) end,
}

---@class LspConfigOptions.jdtls: LspConfigOptions
---@field settings Settings.jdtls

lspconfig.jdtls = {
  ---@param options LspConfigOptions.jdtls
  setup = function(options) end,
}

---@class LspConfigOptions.cssls: LspConfigOptions
---@field settings Settings.cssls

lspconfig.cssls = {
  ---@param options LspConfigOptions.cssls
  setup = function(options) end,
}

---@class LspConfigOptions.perlnavigator: LspConfigOptions
---@field settings Settings.perlnavigator

lspconfig.perlnavigator = {
  ---@param options LspConfigOptions.perlnavigator
  setup = function(options) end,
}

---@class LspConfigOptions.rls: LspConfigOptions
---@field settings Settings.rls

lspconfig.rls = {
  ---@param options LspConfigOptions.rls
  setup = function(options) end,
}

---@class LspConfigOptions.jsonls: LspConfigOptions
---@field settings Settings.jsonls

lspconfig.jsonls = {
  ---@param options LspConfigOptions.jsonls
  setup = function(options) end,
}

---@class LspConfigOptions.psalm: LspConfigOptions
---@field settings Settings.psalm

lspconfig.psalm = {
  ---@param options LspConfigOptions.psalm
  setup = function(options) end,
}

---@class LspConfigOptions.pyright: LspConfigOptions
---@field settings Settings.pyright

lspconfig.pyright = {
  ---@param options LspConfigOptions.pyright
  setup = function(options) end,
}

---@class LspConfigOptions.rust_analyzer: LspConfigOptions
---@field settings Settings.rust_analyzer

lspconfig.rust_analyzer = {
  ---@param options LspConfigOptions.rust_analyzer
  setup = function(options) end,
}

---@class LspConfigOptions.solidity_ls: LspConfigOptions
---@field settings Settings.solidity_ls

lspconfig.solidity_ls = {
  ---@param options LspConfigOptions.solidity_ls
  setup = function(options) end,
}

---@class LspConfigOptions.denols: LspConfigOptions
---@field settings Settings.denols

lspconfig.denols = {
  ---@param options LspConfigOptions.denols
  setup = function(options) end,
}

---@class LspConfigOptions.rome: LspConfigOptions
---@field settings Settings.rome

lspconfig.rome = {
  ---@param options LspConfigOptions.rome
  setup = function(options) end,
}

---@class LspConfigOptions.sourcekit: LspConfigOptions
---@field settings Settings.sourcekit

lspconfig.sourcekit = {
  ---@param options LspConfigOptions.sourcekit
  setup = function(options) end,
}

---@class LspConfigOptions.svlangserver: LspConfigOptions
---@field settings Settings.svlangserver

lspconfig.svlangserver = {
  ---@param options LspConfigOptions.svlangserver
  setup = function(options) end,
}

---@class LspConfigOptions.elixirls: LspConfigOptions
---@field settings Settings.elixirls

lspconfig.elixirls = {
  ---@param options LspConfigOptions.elixirls
  setup = function(options) end,
}

---@class LspConfigSettings
---@field elmls LspConfigOptions.elmls
---@field sumneko_lua LspConfigOptions.sumneko_lua
---@field fsautocomplete LspConfigOptions.fsautocomplete
---@field grammarly LspConfigOptions.grammarly
---@field haxe_language_server LspConfigOptions.haxe_language_server
---@field wgls_analyzer LspConfigOptions.wgls_analyzer
---@field astro LspConfigOptions.astro
---@field spectral LspConfigOptions.spectral
---@field julials LspConfigOptions.julials
---@field kotlin_language_server LspConfigOptions.kotlin_language_server
---@field zls LspConfigOptions.zls
---@field ltex LspConfigOptions.ltex
---@field svelte LspConfigOptions.svelte
---@field zeta_note LspConfigOptions.zeta_note
---@field nickel_ls LspConfigOptions.nickel_ls
---@field flow LspConfigOptions.flow
---@field tailwindcss LspConfigOptions.tailwindcss
---@field hie LspConfigOptions.hie
---@field dartls LspConfigOptions.dartls
---@field powershell_es LspConfigOptions.powershell_es
---@field hhvm LspConfigOptions.hhvm
---@field tsserver LspConfigOptions.tsserver
---@field purescriptls LspConfigOptions.purescriptls
---@field pylsp LspConfigOptions.pylsp
---@field awkls LspConfigOptions.awkls
---@field r_language_server LspConfigOptions.r_language_server
---@field java_language_server LspConfigOptions.java_language_server
---@field perlls LspConfigOptions.perlls
---@field rescriptls LspConfigOptions.rescriptls
---@field sorbet LspConfigOptions.sorbet
---@field eslint LspConfigOptions.eslint
---@field omnisharp LspConfigOptions.omnisharp
---@field volar LspConfigOptions.volar
---@field puppet LspConfigOptions.puppet
---@field clangd LspConfigOptions.clangd
---@field stylelint_lsp LspConfigOptions.stylelint_lsp
---@field solargraph LspConfigOptions.solargraph
---@field terraformls LspConfigOptions.terraformls
---@field perlpls LspConfigOptions.perlpls
---@field vuels LspConfigOptions.vuels
---@field als LspConfigOptions.als
---@field intelephense LspConfigOptions.intelephense
---@field html LspConfigOptions.html
---@field yamlls LspConfigOptions.yamlls
---@field bashls LspConfigOptions.bashls
---@field jdtls LspConfigOptions.jdtls
---@field cssls LspConfigOptions.cssls
---@field perlnavigator LspConfigOptions.perlnavigator
---@field rls LspConfigOptions.rls
---@field jsonls LspConfigOptions.jsonls
---@field psalm LspConfigOptions.psalm
---@field pyright LspConfigOptions.pyright
---@field rust_analyzer LspConfigOptions.rust_analyzer
---@field solidity_ls LspConfigOptions.solidity_ls
---@field denols LspConfigOptions.denols
---@field rome LspConfigOptions.rome
---@field sourcekit LspConfigOptions.sourcekit
---@field svlangserver LspConfigOptions.svlangserver
---@field elixirls LspConfigOptions.elixirls


 return lspconfig