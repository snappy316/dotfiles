return {
  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",      -- Lua LSP
          "ts_ls",       -- TypeScript/JavaScript LSP
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig", 
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim" 
    },
    config = function()
      -- Use modern vim.lsp.config API (Neovim 0.11+)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      
      -- Add completion capabilities
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      
      -- Lua LSP (optimized for faster loading)
      vim.lsp.config.lua_ls = {
        cmd = { vim.fn.exepath('lua-language-server') },
        capabilities = capabilities,
        filetypes = { 'lua' },
        settings = {
          Lua = {
            diagnostics = { 
              globals = { 'vim' },
              disable = { 'missing-fields', 'incomplete-signature-doc' },
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
                -- Only load essential Neovim runtime, not ALL files
                "${3rd}/luv/library",
              },
              checkThirdParty = false,
              maxPreload = 100,  -- Limit preloaded files
              preloadFileSize = 10000,  -- Limit file size for preloading
            },
            telemetry = { enable = false },
            completion = {
              callSnippet = "Replace",
            },
            hint = {
              enable = true,
            },
          },
        },
      }
      
      -- TypeScript LSP
      vim.lsp.config.ts_ls = {
        cmd = { vim.fn.exepath('typescript-language-server'), '--stdio' },
        capabilities = capabilities,
        filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      }
      
      -- Ruby LSP (use bundle exec for project-specific gems)
      vim.lsp.config.ruby_lsp = {
        cmd = { "bundle", "exec", "ruby-lsp" },
        capabilities = capabilities,
        filetypes = { 'ruby' },
        root_dir = vim.fn.getcwd(),
      }
      
      -- Start LSP servers for current buffer
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "ruby", "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function()
          local ft = vim.bo.filetype
          if ft == "lua" and vim.lsp.config.lua_ls then
            vim.lsp.start(vim.lsp.config.lua_ls)
          elseif ft == "ruby" and vim.lsp.config.ruby_lsp then
            vim.lsp.start(vim.lsp.config.ruby_lsp)
          elseif (ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact") and vim.lsp.config.ts_ls then
            vim.lsp.start(vim.lsp.config.ts_ls)
          end
        end,
      })
      
      -- LSP keymaps (works with both APIs)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format { async = true }
          end, opts)
          vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end,
      })
      
      -- Configure diagnostic display
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      
      -- Show line diagnostics automatically in hover window
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })
    end,
  },
}