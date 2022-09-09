---@meta
--# selene: allow(unused_variable)

---@class SettingsPlugin
---@field name string
---@field setup fun()|nil
---@field on_update fun(event)|nil
---@field get_schema fun(): table|nil

---@class LspSchema
---@field package_url string url of the package.json of the LSP server
---@field settings_url string url of the settings json schema of the LSP server
---@field settings_file string file of the settings json schema of the LSP server
---@field settings_prefix string|nil
