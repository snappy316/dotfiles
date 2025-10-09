return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      -- svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      astro = { "prettier" },
      -- graphql = { "prettier" },
      lua = { "stylua" },
      -- python = { "isort", "black" },
    },
    formatters = {
      --injected = { options = { ignore_errors = true } },
      eslint_d = {
        condition = function(self, ctx)
          local b = vim.b[vim.api.nvim_get_current_buf()]
          if b.eslint_has_prettier ~= nil then
            return b.eslint_has_prettier
          end

          b.eslint_has_prettier = false
          local path = vim.fs.find(
            { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" },
            { path = ctx.filename, upward = true }
          )[1]
          if path then
            local file = io.open(path, "r")
            if file then
              local content = file:read("*a") -- *a or *all reads the whole file
              if string.find(content, "prettier/prettier") then
                b.eslint_has_prettier = true
              end
              file:close()
            end
          end

          return b.eslint_has_prettier
        end,
      },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    --   timeout_ms = 500,
    -- },
  },

  -- vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  --   conform.format({
  --     lsp_fallback = true,
  --     async = false,
  --     timeout_ms = 1000,
  --   })
  -- end, { desc = "Format file or range (in visual mode)" })
}
