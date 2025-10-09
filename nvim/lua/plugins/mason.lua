return {
  "mason-org/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint-lsp", -- js/ts formatter
        -- "eslint_d", --js linter
        "ruby-lsp",
        "rubocop",
      },
    })
  end,
}
