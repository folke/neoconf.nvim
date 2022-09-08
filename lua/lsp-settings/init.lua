local M = {}

function M.setup(opts)
  require("lsp-settings.config").setup(opts)
  require("lsp-settings.commands").setup()
  require("lsp-settings.plugins").setup()
end

M.get_settings = require("lsp-settings.settings").get_settings

return M
