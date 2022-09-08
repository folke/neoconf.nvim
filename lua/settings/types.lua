---@meta
--# selene: allow(unused_variable)

---@class SettingsPlugin
---@field name string
---@field setup fun()|nil
---@field on_update fun(event)|nil
---@field get_schema fun(): table|nil
local Plugin = {}
