local M = {}

function M.setup(opts)
  require("lsp-settings.config").setup(opts)
  require("lsp-settings.commands").setup()
  require("lsp-settings.plugins").setup()
end

return M
