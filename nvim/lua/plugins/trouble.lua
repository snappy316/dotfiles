return {
  -- Trouble.nvim diagnostics panel
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    config = function()
      require("trouble").setup({
        modes = {
          -- Sources of problems
          diagnostics = {
            mode = "diagnostics",
            preview = {
              type = "split",
              relative = "win",
              position = "right",
              size = 0.3,
            },
          },
          symbols = {
            desc = "document symbols",
            mode = "lsp_document_symbols",
            focus = false,
            win = { position = "right" },
            filter = {
              -- remove Package since luals uses it for control flow structures
              ["not"] = { ft = "lua", kind = "Package" },
              any = {
                ft = { "help", "markdown" },
                kind = {
                  "Class",
                  "Constructor",
                  "Enum",
                  "Field",
                  "Function",
                  "Interface",
                  "Method",
                  "Module",
                  "Namespace",
                  "Package",
                  "Property",
                  "Struct",
                  "Trait",
                },
              },
            },
          },
        },
        -- Auto open trouble when there are diagnostics
        auto = {
          open = false,
          close = false,
        },
        -- Set icon and sign configuration
        icons = {
          indent = {
            top         = "│ ",
            middle      = "├╴",
            last        = "└╴",
            fold_open   = " ",
            fold_closed = " ",
            ws          = "  ",
          },
          folder_closed   = " ",
          folder_open     = " ",
          kinds = {
            Array         = " ",
            Boolean       = "󰨙 ",
            Class         = " ",
            Constant      = "󰏿 ",
            Constructor   = " ",
            Enum          = " ",
            EnumMember    = " ",
            Event         = " ",
            Field         = " ",
            File          = " ",
            Function      = "󰊕 ",
            Interface     = " ",
            Key           = " ",
            Method        = "󰊕 ",
            Module        = " ",
            Namespace     = "󰦮 ",
            Null          = " ",
            Number        = "󰎠 ",
            Object        = " ",
            Operator      = " ",
            Package       = " ",
            Property      = " ",
            String        = " ",
            Struct        = "󰆼 ",
            TypeParameter = " ",
            Variable      = "󰀫 ",
          },
        },
        -- Window configuration
        win = {
          type = "split",
          relative = "editor",
          size = 0.25,
          position = "bottom",
          padding = { top = 0, bottom = 0, left = 1, right = 1 },
          title = true,
          title_pos = "center",
          border = "rounded",
          zindex = 200,
          wo = {
            wrap = false,
            signcolumn = "no",
            number = false,
            relativenumber = false,
            foldcolumn = "0",
            foldenable = false,
          },
        },
        -- Key mappings inside trouble window
        keys = {
          ["?"] = "help",
          r = "refresh",
          R = "toggle_refresh",
          q = "close",
          o = "jump_close",
          ["<esc>"] = "cancel",
          ["<cr>"] = "jump",
          ["<2-leftmouse>"] = "jump",
          ["<c-s>"] = "jump_split",
          ["<c-v>"] = "jump_vsplit",
          ["}"] = "next",
          ["]]"] = "next",
          ["{"] = "prev",
          ["[["] = "prev",
          i = "inspect",
          p = "preview",
          P = "toggle_preview",
          zo = "fold_open",
          zO = "fold_open_recursive",
          zc = "fold_close",
          zC = "fold_close_recursive",
          za = "fold_toggle",
          zA = "fold_toggle_recursive",
          zm = "fold_more",
          zM = "fold_close_all",
          zr = "fold_reduce",
          zR = "fold_open_all",
          zx = "fold_update",
          zX = "fold_update_all",
          zn = "fold_disable",
          zN = "fold_enable",
          zi = "fold_toggle_enable",
        },
        -- Follow cursor for auto-focus
        follow = true,
        -- Focus new trouble windows
        focus = false,
        -- Restore cursor position when closing trouble
        restore = true,
        -- Format function for trouble items
        formatters = {
          file_icon = {
            filename_only = true,
          },
        },
        -- Throttle refresh time
        throttle = {
          refresh = 20,
          update = 10,
        },
      })
    end,
  },
}