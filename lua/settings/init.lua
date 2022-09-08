local M = {}

function M.setup(opts)
  require("settings.config").setup(opts)
  require("settings.commands").setup()
  require("settings.plugins").setup()
end

M.get_settings = require("settings.settings").get_settings

return M
