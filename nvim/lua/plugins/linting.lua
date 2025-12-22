return {
  -- Linting support
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Configure linters by filetype
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "pylint" },
        ruby = { "rubocop" },
        lua = { "luacheck" },
        markdown = { "markdownlint" },
        yaml = { "yamllint" },
        json = { "jsonlint" },
      }

      -- Create autocommand to run linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Only run linters that are available
          local names = lint._resolve_linter_by_ft(vim.bo.filetype)

          -- Filter out linters that don't exist
          names = vim.tbl_filter(function(name)
            local linter = lint.linters[name]
            if not linter then
              return false
            end

            local cmd = linter.cmd
            if type(cmd) == "string" then
              return vim.fn.executable(cmd) == 1
            elseif type(cmd) == "table" then
              return vim.fn.executable(cmd[1]) == 1
            end
            return false
          end, names)

          if #names > 0 then
            lint.try_lint(names)
          end
        end,
      })

      -- Manual lint command
      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
