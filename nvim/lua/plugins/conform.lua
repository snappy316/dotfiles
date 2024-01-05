return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Use a sub-list to run only the first available formatter
      cpp = { "clang_format" },
      javascript = { { "eslint_d", "prettier" } },
      javascriptreact = { { "eslint_d", "prettier" } },
      typescript = { { "eslint_d", "prettier" } },
      typescriptreact = { { "eslint_d", "prettier" } },
      ruby = { "stree" },
    },
    formatters = {
      --injected = { options = { ignore_errors = true } },
      eslint_d = {
        condition = function(ctx)
          local b = vim.b[vim.api.nvim_get_current_buf()]
          if b.eslint_has_prettier ~= nil then
            return b.eslint_has_prettier
          end

          b.eslint_has_prettier = false
          local path =
            vim.fs.find({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" }, { path = ctx.filename, upward = true })[1]
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
  },
}
