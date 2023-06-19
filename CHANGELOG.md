# Changelog

## [1.2.2](https://github.com/folke/neoconf.nvim/compare/v1.2.1...v1.2.2) (2023-06-19)


### Bug Fixes

* **init:** only check for available servers if lspconfig is loaded ([cfec478](https://github.com/folke/neoconf.nvim/commit/cfec478a530d4dbda0dbd0f9d3678460d1aae735))
* **jsonls:** use `vim.filetype.add()` to set the filetype for neoconf.json ([#25](https://github.com/folke/neoconf.nvim/issues/25)) ([ea175a5](https://github.com/folke/neoconf.nvim/commit/ea175a511d9b899a0dc8b19829ae169e11d9b1d4))

## [1.2.1](https://github.com/folke/neoconf.nvim/compare/v1.2.0...v1.2.1) (2023-03-26)


### Bug Fixes

* **icons:** fixed obsolete icons with nerdfix ([5feed54](https://github.com/folke/neoconf.nvim/commit/5feed54641f169b9fd1c8cd89cc9227237136ee7))

## [1.2.0](https://github.com/folke/neoconf.nvim/compare/v1.1.1...v1.2.0) (2023-03-23)


### Features

* better support for root_dir in monorepos. Always return longest. Fixes [#14](https://github.com/folke/neoconf.nvim/issues/14) Fixes [#10](https://github.com/folke/neoconf.nvim/issues/10) ([9214879](https://github.com/folke/neoconf.nvim/commit/9214879f83ad407988871e43e0697cff2b721f2b))

## [1.1.1](https://github.com/folke/neoconf.nvim/compare/v1.1.0...v1.1.1) (2023-03-16)


### Bug Fixes

* **lspconfig:** replace backslashes on windows. Fixes [#18](https://github.com/folke/neoconf.nvim/issues/18) ([7297592](https://github.com/folke/neoconf.nvim/commit/72975929074d663a46854422252b6bb099ae56ba))
* **schema:** correctly format uri. Fixes [#18](https://github.com/folke/neoconf.nvim/issues/18) ([67acada](https://github.com/folke/neoconf.nvim/commit/67acada4ed1d1386373f9a325acd95b315ac827c))

## [1.1.0](https://github.com/folke/neoconf.nvim/compare/v1.0.3...v1.1.0) (2023-03-08)


### Features

* **lspconfig:** allow setting the lsp server to false to disable it in your project. Fixes [#1](https://github.com/folke/neoconf.nvim/issues/1) ([835da21](https://github.com/folke/neoconf.nvim/commit/835da21fd71c9e91248b00b5066dc2d1306f4d6b))

## [1.0.3](https://github.com/folke/neoconf.nvim/compare/v1.0.2...v1.0.3) (2023-02-12)


### Bug Fixes

* lua_ls schema ([8b3f2b5](https://github.com/folke/neoconf.nvim/commit/8b3f2b56e6760a92b5df97b0b182d31405f7458e))
* rename sumneko_lua -&gt; lua_ls ([#12](https://github.com/folke/neoconf.nvim/issues/12)) ([156a3ee](https://github.com/folke/neoconf.nvim/commit/156a3eed89ffef5f926102e1bc9e372946385074))
* temp fix for sumneok_lua -&gt; lua_ls rename ([e3479df](https://github.com/folke/neoconf.nvim/commit/e3479df94d63b3f29481278cc8527e1ded902aaf))

## [1.0.2](https://github.com/folke/neoconf.nvim/compare/v1.0.1...v1.0.2) (2023-02-07)


### Bug Fixes

* **annotations:** fixed comment parsing ([4f8916d](https://github.com/folke/neoconf.nvim/commit/4f8916d22081b76ee5931155adedf55d0c9f645b))
* only expand top-level and lspconfig settings. Fixes [#11](https://github.com/folke/neoconf.nvim/issues/11) ([274c770](https://github.com/folke/neoconf.nvim/commit/274c7700d911b6d0b5e01b9b8b8ef765c5d726d3))

## [1.0.1](https://github.com/folke/neoconf.nvim/compare/v1.0.0...v1.0.1) (2023-01-22)


### Bug Fixes

* add types/lua to workspace ([8a4e133](https://github.com/folke/neoconf.nvim/commit/8a4e1336f156ca2f66849725199b05d3150d869c))
* **health:** settings.nvim -&gt; neoconf.nvim ([52df9fc](https://github.com/folke/neoconf.nvim/commit/52df9fcd2aec9caf2918062df7b6f11b2afd2443))

## 1.0.0 (2023-01-04)


### Features

* add plugin generated json schemas to jsonls ([f51b7aa](https://github.com/folke/neoconf.nvim/commit/f51b7aac58a4032042938e45cd1b598c6f8f27ce))
* added `util.has_lspconfig(server)` ([b7b2e62](https://github.com/folke/neoconf.nvim/commit/b7b2e626e5f6dc806996debdbeb0cb964167dd00))
* added autocmd to trigger reload and user command Settings ([0f14609](https://github.com/folke/neoconf.nvim/commit/0f14609af5e0f5db34694a316ea8ea6fada0cd98))
* added check for loading order of lspconfig during setup ([04b31c7](https://github.com/folke/neoconf.nvim/commit/04b31c79941cc133c30ee46f585e78171408c67b))
* added check for lua-dev to checkhealth ([d93f9bc](https://github.com/folke/neoconf.nvim/commit/d93f9bcab207b0cf173478541200ba45408df1f3))
* added checkhealth for settings.nvim ([c2f6a81](https://github.com/folke/neoconf.nvim/commit/c2f6a8107112f9517d85390b53cb2784c3160a59))
* added config options for all plugins ([944333c](https://github.com/folke/neoconf.nvim/commit/944333cda4894e9378bf822d966ff8f9debb8676))
* added float to see merged settings ([1097809](https://github.com/folke/neoconf.nvim/commit/1097809894c4c48df256990dd18523264b755876))
* added generic return for settings.get ([4c01527](https://github.com/folke/neoconf.nvim/commit/4c01527b7dd17f6aed3d9d7b140b7a117a22249d))
* added importers for vscode, nlsp-settings and coc-settings ([f683564](https://github.com/folke/neoconf.nvim/commit/f6835648d89f233ce98db71ff3e0532b1e6eb7a9))
* added json_format using jq, when building files ([62e9b4f](https://github.com/folke/neoconf.nvim/commit/62e9b4ffe8a5d56797bd7d4b903ed7e50544446e))
* added live-reloading of LSP server configs ([b808c26](https://github.com/folke/neoconf.nvim/commit/b808c26eaf4814bf50ad8b324d82b2544025071b))
* added LspSettings command to show lsp settings for the current buffer ([6e3ed46](https://github.com/folke/neoconf.nvim/commit/6e3ed46b11f529afe46fa34c23c08a82128dabdc))
* added markdown support to logging methods ([6e4d994](https://github.com/folke/neoconf.nvim/commit/6e4d9944555f141676b8dc8c7d289653ec5d7a3d))
* added method to clear cached settings for a given file ([eff7473](https://github.com/folke/neoconf.nvim/commit/eff7473db4630031bd3dd60c41deaafd0c92a7df))
* added proper jsonc parser, with relaxed error handling of comments and extra commas ([2bc84de](https://github.com/folke/neoconf.nvim/commit/2bc84de7f2dee7469ddde066bf34d2647734e451))
* added proper Settings command ([7aa4048](https://github.com/folke/neoconf.nvim/commit/7aa4048ed7dd3685c4a5f1e263ce94d898b435c1))
* added settings files to lsp settings view ([580c644](https://github.com/folke/neoconf.nvim/commit/580c644c378e29a9a1ca46468058c3aaee82c0d4))
* added settings.nvim config schema ([c6f7578](https://github.com/folke/neoconf.nvim/commit/c6f75787e7870d295b12cebf83e5b9f197f3e037))
* added sumneko annotations for lsp server settings! ([d824aff](https://github.com/folke/neoconf.nvim/commit/d824affc44d23ae20e5c52c377349150f51caaa2))
* added translations for cssls, html, jsonls, ltex, rust_analyzer & tsserver ([c085805](https://github.com/folke/neoconf.nvim/commit/c085805a1cce432bb161264cda8b8e044fd614de))
* added translations for jsonls schema ([f5400aa](https://github.com/folke/neoconf.nvim/commit/f5400aa8188aa08f56747716a23e52e88697664d))
* always recursively expand keys in when loading settings ([16a44b9](https://github.com/folke/neoconf.nvim/commit/16a44b95755c548c2c89c1165426e88537b43e86))
* apply filetype jsonc instead of json for settings files, to allow comments ([2cc0287](https://github.com/folke/neoconf.nvim/commit/2cc0287ec54d46f0c857bd697f101dc276e0b5a6))
* build class to generate json schemas ([d9b25d6](https://github.com/folke/neoconf.nvim/commit/d9b25d6bf6209ffc9f3367ee23b6025680cf56f5))
* build import schemas based on main schema ([69cba88](https://github.com/folke/neoconf.nvim/commit/69cba885e17d1bef0131ff9e78981227bf802f4d))
* check if we're running 0.7.2 ([4700af9](https://github.com/folke/neoconf.nvim/commit/4700af98c69a02dfa0ea7ecd5700d2190a440cd7))
* class to work with settings ([f8721c8](https://github.com/folke/neoconf.nvim/commit/f8721c851f1941f5635653caed8de6247b6e5eeb))
* custom build for sumneko schema to include language translations for descriptions ([045585e](https://github.com/folke/neoconf.nvim/commit/045585e102ba97d98dd970dab6a0cfa228fa51c9))
* dont show imported files that dont exist for commands and views ([5afbede](https://github.com/folke/neoconf.nvim/commit/5afbede9ba58e63bcceae0680c9f4975ee663a3c))
* easier way to work with setting patterns ([a8e496f](https://github.com/folke/neoconf.nvim/commit/a8e496f73e48b4830be19a8f686ec18535dbd885))
* easy getter to get settings ([d71e54e](https://github.com/folke/neoconf.nvim/commit/d71e54e9cbc5ae59d50d6fc2fc327a782c404011))
* helper method to detect root_dir for buffers without attached lsp clients ([689dafa](https://github.com/folke/neoconf.nvim/commit/689dafa90dfe584661419064069a36de12e9766a))
* helper method to log errors with pcall ([f068039](https://github.com/folke/neoconf.nvim/commit/f0680397aca5c781b4c43625ab568033b2bdafa3))
* hooks for lspconfig and jsonls ([a92f091](https://github.com/folke/neoconf.nvim/commit/a92f091809caaa2de12b977cf56deb628f26106a))
* improved lsp schema building and loading ([16d8f90](https://github.com/folke/neoconf.nvim/commit/16d8f906dd0afe9b88bcd0ef69d8b84c0d0cd917))
* improved sorting of json files for Settings command ([7737061](https://github.com/folke/neoconf.nvim/commit/7737061dabfa3cd40fe01ef2dee478e4e843eceb))
* initial commit ([cbc7f88](https://github.com/folke/neoconf.nvim/commit/cbc7f8836f45a3f4a874b25bf4a7c68921e5b832))
* json strip comments ([567f664](https://github.com/folke/neoconf.nvim/commit/567f664ed69902135b509ab43e722cc9d00014d7))
* make it all work without an active lsp client ([ce69f90](https://github.com/folke/neoconf.nvim/commit/ce69f90b6a5bb7df1aa939f7fa0598a4d0712ee0))
* move imported schema defs for jsonls to separate file ([efa5046](https://github.com/folke/neoconf.nvim/commit/efa50461a551b9ff6d4475f64a7a419b85b586e0))
* moved jsonls and lsp to its own plugin ([24637dd](https://github.com/folke/neoconf.nvim/commit/24637ddc0e57676648c0664606fe73f3b225c81e))
* only apply configuration when it actually changed ([200c6fa](https://github.com/folke/neoconf.nvim/commit/200c6fa9362cdab97177a0e6b2e3068586c8a65d))
* properly setup sumenko to include generated lsp server settings ([5842294](https://github.com/folke/neoconf.nvim/commit/58422942eb9d32a47f7f1aef631f0aec167081f9))
* read schemas from json file instead of generated lua packages ([c67efcf](https://github.com/folke/neoconf.nvim/commit/c67efcf2054bcf32e4d00b555f7539e40543eda8))
* simple method to generate a json schema based on a lua table ([89f459f](https://github.com/folke/neoconf.nvim/commit/89f459fc2e4653683b18388c21b74af89f2219ae))
* top-level config and api ([3a19ef1](https://github.com/folke/neoconf.nvim/commit/3a19ef12c5484e72bba11c2d7d8bc431fac3a924))
* use global/local settings for all plugins ([4d72d21](https://github.com/folke/neoconf.nvim/commit/4d72d213c76fd3482e08a17c2e8213c3c8733a77))
* util class ([bc65c64](https://github.com/folke/neoconf.nvim/commit/bc65c64ceb305e4398e4d05551d9e4895087b989))
* util.on_config ([b19a634](https://github.com/folke/neoconf.nvim/commit/b19a63488e220edb53a9e1d66755b9f87e14d12c))
* wrap pcall in try util method to show error on error ([c6f9621](https://github.com/folke/neoconf.nvim/commit/c6f962183b0a5e1f3dbcbbd27940c90180a57f9d))


### Bug Fixes

* better options for the float window ([8e9e52d](https://github.com/folke/neoconf.nvim/commit/8e9e52d2310e967473583d4f118db48ccb206157))
* better way to reload lsp configs ([85cad63](https://github.com/folke/neoconf.nvim/commit/85cad63cda4bdc8dd658257ea664f869231c489b))
* check on jq format error ([5a291f8](https://github.com/folke/neoconf.nvim/commit/5a291f89ae610eacf99d80ea925d4a642ac5b2f2))
* clear settings on update ([2d205f4](https://github.com/folke/neoconf.nvim/commit/2d205f44194008b05fd5154b3ee7f861d74864a3))
* commands ([97e73e0](https://github.com/folke/neoconf.nvim/commit/97e73e017aa4f6358b1405f5d1fc81058363836e))
* don't use filetype API. Use autocmd instead to make it work on 0.7.2 as well ([a2f83e4](https://github.com/folke/neoconf.nvim/commit/a2f83e40a94ae3844642faa04160e24d38035abc))
* fix file_patterns for autocmd BufWritePost ([eb2bdbf](https://github.com/folke/neoconf.nvim/commit/eb2bdbf10f456e9aa18029919c990dede24edd10))
* fixed health text ([68ea264](https://github.com/folke/neoconf.nvim/commit/68ea26422a59a10fb241904b9fa271fab3b66f47))
* fixed some type annotations ([33a3431](https://github.com/folke/neoconf.nvim/commit/33a34317689b706de44ee54a21f78b77055e79b6))
* flatten translation lines before concatenating ([67eb986](https://github.com/folke/neoconf.nvim/commit/67eb9862cfc9d7dda72c7bc3715440db8339e811))
* load settings from "settings" instead of "settings.nvim" ([675bdd9](https://github.com/folke/neoconf.nvim/commit/675bdd9a80efc8c74e15fa032c557cc0e75c22c5))
* make translations deterministic ([0214d1a](https://github.com/folke/neoconf.nvim/commit/0214d1a854ded6a3fe9a610958a7ee595a9dfd89))
* move neoconf settings to `neoconf` in json instead of `settings` ([7d00bbf](https://github.com/folke/neoconf.nvim/commit/7d00bbffb50bed2541690bbbbd414b932d101454))
* no health checks are automatically detected ([e09ff78](https://github.com/folke/neoconf.nvim/commit/e09ff78639b3c2068d331d1bcbcaa6938fafe955))
* only reload lsp when settings file is part of settings root for root_dir ([8c4868e](https://github.com/folke/neoconf.nvim/commit/8c4868e87efc8551547e5b83e6f607814598de17))
* pass fully qualified fname to on_update instead of event.match ([2d0bda5](https://github.com/folke/neoconf.nvim/commit/2d0bda545003b11bad794a8979d2527427041e7b))
* properly check if given server is part of lspconfig ([d970db0](https://github.com/folke/neoconf.nvim/commit/d970db012f35cecea3d615d4d1df4fb23f762161))
* removed get_schema code. No longer needed. ([79133ab](https://github.com/folke/neoconf.nvim/commit/79133ab99e7cdabf4bdc2c1db2f28a75f2936b54))
* renamed command from Settings to Neoconf ([139cbbf](https://github.com/folke/neoconf.nvim/commit/139cbbfc49aac3ece83986f0b15f789247e19851))
* return deepcopy of defaults when key value is nil ([3bc55ea](https://github.com/folke/neoconf.nvim/commit/3bc55eac7357f6e7ca93f2f847fed6fb52b3bd6a))
* return root_dir when found instead of fallbacks ([334ae33](https://github.com/folke/neoconf.nvim/commit/334ae339d717885049264f9d3a48ec13443293e1))
* show list when multiple local/global files exist instead of jumping to the first one ([cebd05b](https://github.com/folke/neoconf.nvim/commit/cebd05b30e79087dbe211c8cc6fe265eab3a7371))
* sort annotations ([b580be8](https://github.com/folke/neoconf.nvim/commit/b580be8e450a0e2b59611c85337b1deaa33d743a))
* use { ... } and unpack instead of table.pack and table.unpack ([2b3ea38](https://github.com/folke/neoconf.nvim/commit/2b3ea3867a99de8eee8c1ce256bf1a8913dc95a3))
