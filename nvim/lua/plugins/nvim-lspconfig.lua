return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
    config = function()
      require("mason-lspconfig").setup()

      require("mason-lspconfig").setup_handlers({
        -- Automatically set up LSP servers installed via Mason
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({})
        end,
      })

      -- This config sets up ruby-lsp properly
      -- https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md#Neovim-LSP
      -- --
      -- textDocument/diagnostic support until 0.10.0 is released
      _timers = {}
      local function setup_diagnostics(client, buffer)
        if require("vim.lsp.diagnostic")._enable then
          return
        end

        local diagnostic_handler = function()
          local params = vim.lsp.util.make_text_document_params(buffer)
          client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
            if err then
              local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
              vim.lsp.log.error(err_msg)
            end
            local diagnostic_items = {}
            if result then
              diagnostic_items = result.items
            end
            vim.lsp.diagnostic.on_publish_diagnostics(
              nil,
              vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
              { client_id = client.id }
            )
          end)
        end

        diagnostic_handler() -- to request diagnostics on buffer when first attaching

        vim.api.nvim_buf_attach(buffer, false, {
          on_lines = function()
            if _timers[buffer] then
              vim.fn.timer_stop(_timers[buffer])
            end
            _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
          end,
          on_detach = function()
            if _timers[buffer] then
              vim.fn.timer_stop(_timers[buffer])
            end
          end,
        })
      end

      require("lspconfig").ruby_ls.setup({
        on_attach = function(client, buffer)
          setup_diagnostics(client, buffer)
        end,
      })

      require("lspconfig").syntax_tree.setup({
        cmd = { "bundle", "exec", "stree", "lsp" },
      })
    end,
  },
}
