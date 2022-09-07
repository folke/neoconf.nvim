local M = {}

function M.setup(opts)
  require("lsp-settings.config").setup(opts)

  vim.api.nvim_create_user_command("LspSettings", function()
    require("lsp-settings.view").show_settings()
  end, { desc = "Show the settings of the attached lsp servers" })

  require("lsp-settings.lsp").setup()
end

return M
