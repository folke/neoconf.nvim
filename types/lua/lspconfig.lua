---@meta

---@class _.lspconfig.options
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


---@class lspconfig.options.grammarly: _.lspconfig.options
---@field settings lspconfig.settings.grammarly

lspconfig.grammarly = {
  ---@param options lspconfig.options.grammarly
  setup = function(options) end,
}

---@class lspconfig.options.flow: _.lspconfig.options
---@field settings lspconfig.settings.flow

lspconfig.flow = {
  ---@param options lspconfig.options.flow
  setup = function(options) end,
}

---@class lspconfig.options.haxe_language_server: _.lspconfig.options
---@field settings lspconfig.settings.haxe_language_server

lspconfig.haxe_language_server = {
  ---@param options lspconfig.options.haxe_language_server
  setup = function(options) end,
}

---@class lspconfig.options.astro: _.lspconfig.options
---@field settings lspconfig.settings.astro

lspconfig.astro = {
  ---@param options lspconfig.options.astro
  setup = function(options) end,
}

---@class lspconfig.options.psalm: _.lspconfig.options
---@field settings lspconfig.settings.psalm

lspconfig.psalm = {
  ---@param options lspconfig.options.psalm
  setup = function(options) end,
}

---@class lspconfig.options.hhvm: _.lspconfig.options
---@field settings lspconfig.settings.hhvm

lspconfig.hhvm = {
  ---@param options lspconfig.options.hhvm
  setup = function(options) end,
}

---@class lspconfig.options.kotlin_language_server: _.lspconfig.options
---@field settings lspconfig.settings.kotlin_language_server

lspconfig.kotlin_language_server = {
  ---@param options lspconfig.options.kotlin_language_server
  setup = function(options) end,
}

---@class lspconfig.options.hie: _.lspconfig.options
---@field settings lspconfig.settings.hie

lspconfig.hie = {
  ---@param options lspconfig.options.hie
  setup = function(options) end,
}

---@class lspconfig.options.ltex: _.lspconfig.options
---@field settings lspconfig.settings.ltex

lspconfig.ltex = {
  ---@param options lspconfig.options.ltex
  setup = function(options) end,
}

---@class lspconfig.options.java_language_server: _.lspconfig.options
---@field settings lspconfig.settings.java_language_server

lspconfig.java_language_server = {
  ---@param options lspconfig.options.java_language_server
  setup = function(options) end,
}

---@class lspconfig.options.fsautocomplete: _.lspconfig.options
---@field settings lspconfig.settings.fsautocomplete

lspconfig.fsautocomplete = {
  ---@param options lspconfig.options.fsautocomplete
  setup = function(options) end,
}

---@class lspconfig.options.powershell_es: _.lspconfig.options
---@field settings lspconfig.settings.powershell_es

lspconfig.powershell_es = {
  ---@param options lspconfig.options.powershell_es
  setup = function(options) end,
}

---@class lspconfig.options.zls: _.lspconfig.options
---@field settings lspconfig.settings.zls

lspconfig.zls = {
  ---@param options lspconfig.options.zls
  setup = function(options) end,
}

---@class lspconfig.options.julials: _.lspconfig.options
---@field settings lspconfig.settings.julials

lspconfig.julials = {
  ---@param options lspconfig.options.julials
  setup = function(options) end,
}

---@class lspconfig.options.cssls: _.lspconfig.options
---@field settings lspconfig.settings.cssls

lspconfig.cssls = {
  ---@param options lspconfig.options.cssls
  setup = function(options) end,
}

---@class lspconfig.options.purescriptls: _.lspconfig.options
---@field settings lspconfig.settings.purescriptls

lspconfig.purescriptls = {
  ---@param options lspconfig.options.purescriptls
  setup = function(options) end,
}

---@class lspconfig.options.svlangserver: _.lspconfig.options
---@field settings lspconfig.settings.svlangserver

lspconfig.svlangserver = {
  ---@param options lspconfig.options.svlangserver
  setup = function(options) end,
}

---@class lspconfig.options.bashls: _.lspconfig.options
---@field settings lspconfig.settings.bashls

lspconfig.bashls = {
  ---@param options lspconfig.options.bashls
  setup = function(options) end,
}

---@class lspconfig.options.r_language_server: _.lspconfig.options
---@field settings lspconfig.settings.r_language_server

lspconfig.r_language_server = {
  ---@param options lspconfig.options.r_language_server
  setup = function(options) end,
}

---@class lspconfig.options.perlpls: _.lspconfig.options
---@field settings lspconfig.settings.perlpls

lspconfig.perlpls = {
  ---@param options lspconfig.options.perlpls
  setup = function(options) end,
}

---@class lspconfig.options.tailwindcss: _.lspconfig.options
---@field settings lspconfig.settings.tailwindcss

lspconfig.tailwindcss = {
  ---@param options lspconfig.options.tailwindcss
  setup = function(options) end,
}

---@class lspconfig.options.rescriptls: _.lspconfig.options
---@field settings lspconfig.settings.rescriptls

lspconfig.rescriptls = {
  ---@param options lspconfig.options.rescriptls
  setup = function(options) end,
}

---@class lspconfig.options.eslint: _.lspconfig.options
---@field settings lspconfig.settings.eslint

lspconfig.eslint = {
  ---@param options lspconfig.options.eslint
  setup = function(options) end,
}

---@class lspconfig.options.jsonls: _.lspconfig.options
---@field settings lspconfig.settings.jsonls

lspconfig.jsonls = {
  ---@param options lspconfig.options.jsonls
  setup = function(options) end,
}

---@class lspconfig.options.dartls: _.lspconfig.options
---@field settings lspconfig.settings.dartls

lspconfig.dartls = {
  ---@param options lspconfig.options.dartls
  setup = function(options) end,
}

---@class lspconfig.options.pyright: _.lspconfig.options
---@field settings lspconfig.settings.pyright

lspconfig.pyright = {
  ---@param options lspconfig.options.pyright
  setup = function(options) end,
}

---@class lspconfig.options.rust_analyzer: _.lspconfig.options
---@field settings lspconfig.settings.rust_analyzer

lspconfig.rust_analyzer = {
  ---@param options lspconfig.options.rust_analyzer
  setup = function(options) end,
}

---@class lspconfig.options.perlls: _.lspconfig.options
---@field settings lspconfig.settings.perlls

lspconfig.perlls = {
  ---@param options lspconfig.options.perlls
  setup = function(options) end,
}

---@class lspconfig.options.stylelint_lsp: _.lspconfig.options
---@field settings lspconfig.settings.stylelint_lsp

lspconfig.stylelint_lsp = {
  ---@param options lspconfig.options.stylelint_lsp
  setup = function(options) end,
}

---@class lspconfig.options.rls: _.lspconfig.options
---@field settings lspconfig.settings.rls

lspconfig.rls = {
  ---@param options lspconfig.options.rls
  setup = function(options) end,
}

---@class lspconfig.options.rome: _.lspconfig.options
---@field settings lspconfig.settings.rome

lspconfig.rome = {
  ---@param options lspconfig.options.rome
  setup = function(options) end,
}

---@class lspconfig.options.solargraph: _.lspconfig.options
---@field settings lspconfig.settings.solargraph

lspconfig.solargraph = {
  ---@param options lspconfig.options.solargraph
  setup = function(options) end,
}

---@class lspconfig.options.volar: _.lspconfig.options
---@field settings lspconfig.settings.volar

lspconfig.volar = {
  ---@param options lspconfig.options.volar
  setup = function(options) end,
}

---@class lspconfig.options.als: _.lspconfig.options
---@field settings lspconfig.settings.als

lspconfig.als = {
  ---@param options lspconfig.options.als
  setup = function(options) end,
}

---@class lspconfig.options.sumneko_lua: _.lspconfig.options
---@field settings lspconfig.settings.sumneko_lua

lspconfig.sumneko_lua = {
  ---@param options lspconfig.options.sumneko_lua
  setup = function(options) end,
}

---@class lspconfig.options.vuels: _.lspconfig.options
---@field settings lspconfig.settings.vuels

lspconfig.vuels = {
  ---@param options lspconfig.options.vuels
  setup = function(options) end,
}

---@class lspconfig.options.yamlls: _.lspconfig.options
---@field settings lspconfig.settings.yamlls

lspconfig.yamlls = {
  ---@param options lspconfig.options.yamlls
  setup = function(options) end,
}

---@class lspconfig.options.sourcekit: _.lspconfig.options
---@field settings lspconfig.settings.sourcekit

lspconfig.sourcekit = {
  ---@param options lspconfig.options.sourcekit
  setup = function(options) end,
}

---@class lspconfig.options.wgls_analyzer: _.lspconfig.options
---@field settings lspconfig.settings.wgls_analyzer

lspconfig.wgls_analyzer = {
  ---@param options lspconfig.options.wgls_analyzer
  setup = function(options) end,
}

---@class lspconfig.options.spectral: _.lspconfig.options
---@field settings lspconfig.settings.spectral

lspconfig.spectral = {
  ---@param options lspconfig.options.spectral
  setup = function(options) end,
}

---@class lspconfig.options.solidity_ls: _.lspconfig.options
---@field settings lspconfig.settings.solidity_ls

lspconfig.solidity_ls = {
  ---@param options lspconfig.options.solidity_ls
  setup = function(options) end,
}

---@class lspconfig.options.perlnavigator: _.lspconfig.options
---@field settings lspconfig.settings.perlnavigator

lspconfig.perlnavigator = {
  ---@param options lspconfig.options.perlnavigator
  setup = function(options) end,
}

---@class lspconfig.options.svelte: _.lspconfig.options
---@field settings lspconfig.settings.svelte

lspconfig.svelte = {
  ---@param options lspconfig.options.svelte
  setup = function(options) end,
}

---@class lspconfig.options.tsserver: _.lspconfig.options
---@field settings lspconfig.settings.tsserver

lspconfig.tsserver = {
  ---@param options lspconfig.options.tsserver
  setup = function(options) end,
}

---@class lspconfig.options.html: _.lspconfig.options
---@field settings lspconfig.settings.html

lspconfig.html = {
  ---@param options lspconfig.options.html
  setup = function(options) end,
}

---@class lspconfig.options.pylsp: _.lspconfig.options
---@field settings lspconfig.settings.pylsp

lspconfig.pylsp = {
  ---@param options lspconfig.options.pylsp
  setup = function(options) end,
}

---@class lspconfig.options.puppet: _.lspconfig.options
---@field settings lspconfig.settings.puppet

lspconfig.puppet = {
  ---@param options lspconfig.options.puppet
  setup = function(options) end,
}

---@class lspconfig.options.denols: _.lspconfig.options
---@field settings lspconfig.settings.denols

lspconfig.denols = {
  ---@param options lspconfig.options.denols
  setup = function(options) end,
}

---@class lspconfig.options.omnisharp: _.lspconfig.options
---@field settings lspconfig.settings.omnisharp

lspconfig.omnisharp = {
  ---@param options lspconfig.options.omnisharp
  setup = function(options) end,
}

---@class lspconfig.options.awkls: _.lspconfig.options
---@field settings lspconfig.settings.awkls

lspconfig.awkls = {
  ---@param options lspconfig.options.awkls
  setup = function(options) end,
}

---@class lspconfig.options.intelephense: _.lspconfig.options
---@field settings lspconfig.settings.intelephense

lspconfig.intelephense = {
  ---@param options lspconfig.options.intelephense
  setup = function(options) end,
}

---@class lspconfig.options.elixirls: _.lspconfig.options
---@field settings lspconfig.settings.elixirls

lspconfig.elixirls = {
  ---@param options lspconfig.options.elixirls
  setup = function(options) end,
}

---@class lspconfig.options.elmls: _.lspconfig.options
---@field settings lspconfig.settings.elmls

lspconfig.elmls = {
  ---@param options lspconfig.options.elmls
  setup = function(options) end,
}

---@class lspconfig.options.zeta_note: _.lspconfig.options
---@field settings lspconfig.settings.zeta_note

lspconfig.zeta_note = {
  ---@param options lspconfig.options.zeta_note
  setup = function(options) end,
}

---@class lspconfig.options.jdtls: _.lspconfig.options
---@field settings lspconfig.settings.jdtls

lspconfig.jdtls = {
  ---@param options lspconfig.options.jdtls
  setup = function(options) end,
}

---@class lspconfig.options.clangd: _.lspconfig.options
---@field settings lspconfig.settings.clangd

lspconfig.clangd = {
  ---@param options lspconfig.options.clangd
  setup = function(options) end,
}

---@class lspconfig.options.nickel_ls: _.lspconfig.options
---@field settings lspconfig.settings.nickel_ls

lspconfig.nickel_ls = {
  ---@param options lspconfig.options.nickel_ls
  setup = function(options) end,
}

---@class lspconfig.options.sorbet: _.lspconfig.options
---@field settings lspconfig.settings.sorbet

lspconfig.sorbet = {
  ---@param options lspconfig.options.sorbet
  setup = function(options) end,
}

---@class lspconfig.options.terraformls: _.lspconfig.options
---@field settings lspconfig.settings.terraformls

lspconfig.terraformls = {
  ---@param options lspconfig.options.terraformls
  setup = function(options) end,
}

---@class lspconfig.options
---@field grammarly lspconfig.options.grammarly
---@field flow lspconfig.options.flow
---@field haxe_language_server lspconfig.options.haxe_language_server
---@field astro lspconfig.options.astro
---@field psalm lspconfig.options.psalm
---@field hhvm lspconfig.options.hhvm
---@field kotlin_language_server lspconfig.options.kotlin_language_server
---@field hie lspconfig.options.hie
---@field ltex lspconfig.options.ltex
---@field java_language_server lspconfig.options.java_language_server
---@field fsautocomplete lspconfig.options.fsautocomplete
---@field powershell_es lspconfig.options.powershell_es
---@field zls lspconfig.options.zls
---@field julials lspconfig.options.julials
---@field cssls lspconfig.options.cssls
---@field purescriptls lspconfig.options.purescriptls
---@field svlangserver lspconfig.options.svlangserver
---@field bashls lspconfig.options.bashls
---@field r_language_server lspconfig.options.r_language_server
---@field perlpls lspconfig.options.perlpls
---@field tailwindcss lspconfig.options.tailwindcss
---@field rescriptls lspconfig.options.rescriptls
---@field eslint lspconfig.options.eslint
---@field jsonls lspconfig.options.jsonls
---@field dartls lspconfig.options.dartls
---@field pyright lspconfig.options.pyright
---@field rust_analyzer lspconfig.options.rust_analyzer
---@field perlls lspconfig.options.perlls
---@field stylelint_lsp lspconfig.options.stylelint_lsp
---@field rls lspconfig.options.rls
---@field rome lspconfig.options.rome
---@field solargraph lspconfig.options.solargraph
---@field volar lspconfig.options.volar
---@field als lspconfig.options.als
---@field sumneko_lua lspconfig.options.sumneko_lua
---@field vuels lspconfig.options.vuels
---@field yamlls lspconfig.options.yamlls
---@field sourcekit lspconfig.options.sourcekit
---@field wgls_analyzer lspconfig.options.wgls_analyzer
---@field spectral lspconfig.options.spectral
---@field solidity_ls lspconfig.options.solidity_ls
---@field perlnavigator lspconfig.options.perlnavigator
---@field svelte lspconfig.options.svelte
---@field tsserver lspconfig.options.tsserver
---@field html lspconfig.options.html
---@field pylsp lspconfig.options.pylsp
---@field puppet lspconfig.options.puppet
---@field denols lspconfig.options.denols
---@field omnisharp lspconfig.options.omnisharp
---@field awkls lspconfig.options.awkls
---@field intelephense lspconfig.options.intelephense
---@field elixirls lspconfig.options.elixirls
---@field elmls lspconfig.options.elmls
---@field zeta_note lspconfig.options.zeta_note
---@field jdtls lspconfig.options.jdtls
---@field clangd lspconfig.options.clangd
---@field nickel_ls lspconfig.options.nickel_ls
---@field sorbet lspconfig.options.sorbet
---@field terraformls lspconfig.options.terraformls

---@class lspconfig.settings
---@field grammarly lspconfig.settings.grammarly
---@field flow lspconfig.settings.flow
---@field haxe_language_server lspconfig.settings.haxe_language_server
---@field astro lspconfig.settings.astro
---@field psalm lspconfig.settings.psalm
---@field hhvm lspconfig.settings.hhvm
---@field kotlin_language_server lspconfig.settings.kotlin_language_server
---@field hie lspconfig.settings.hie
---@field ltex lspconfig.settings.ltex
---@field java_language_server lspconfig.settings.java_language_server
---@field fsautocomplete lspconfig.settings.fsautocomplete
---@field powershell_es lspconfig.settings.powershell_es
---@field zls lspconfig.settings.zls
---@field julials lspconfig.settings.julials
---@field cssls lspconfig.settings.cssls
---@field purescriptls lspconfig.settings.purescriptls
---@field svlangserver lspconfig.settings.svlangserver
---@field bashls lspconfig.settings.bashls
---@field r_language_server lspconfig.settings.r_language_server
---@field perlpls lspconfig.settings.perlpls
---@field tailwindcss lspconfig.settings.tailwindcss
---@field rescriptls lspconfig.settings.rescriptls
---@field eslint lspconfig.settings.eslint
---@field jsonls lspconfig.settings.jsonls
---@field dartls lspconfig.settings.dartls
---@field pyright lspconfig.settings.pyright
---@field rust_analyzer lspconfig.settings.rust_analyzer
---@field perlls lspconfig.settings.perlls
---@field stylelint_lsp lspconfig.settings.stylelint_lsp
---@field rls lspconfig.settings.rls
---@field rome lspconfig.settings.rome
---@field solargraph lspconfig.settings.solargraph
---@field volar lspconfig.settings.volar
---@field als lspconfig.settings.als
---@field sumneko_lua lspconfig.settings.sumneko_lua
---@field vuels lspconfig.settings.vuels
---@field yamlls lspconfig.settings.yamlls
---@field sourcekit lspconfig.settings.sourcekit
---@field wgls_analyzer lspconfig.settings.wgls_analyzer
---@field spectral lspconfig.settings.spectral
---@field solidity_ls lspconfig.settings.solidity_ls
---@field perlnavigator lspconfig.settings.perlnavigator
---@field svelte lspconfig.settings.svelte
---@field tsserver lspconfig.settings.tsserver
---@field html lspconfig.settings.html
---@field pylsp lspconfig.settings.pylsp
---@field puppet lspconfig.settings.puppet
---@field denols lspconfig.settings.denols
---@field omnisharp lspconfig.settings.omnisharp
---@field awkls lspconfig.settings.awkls
---@field intelephense lspconfig.settings.intelephense
---@field elixirls lspconfig.settings.elixirls
---@field elmls lspconfig.settings.elmls
---@field zeta_note lspconfig.settings.zeta_note
---@field jdtls lspconfig.settings.jdtls
---@field clangd lspconfig.settings.clangd
---@field nickel_ls lspconfig.settings.nickel_ls
---@field sorbet lspconfig.settings.sorbet
---@field terraformls lspconfig.settings.terraformls


 return lspconfig