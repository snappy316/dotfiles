return {
  -- Bufferline.nvim tab-like buffer display
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          style_preset = require('bufferline').style_preset.default,
          themable = true,
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            icon = "▎",
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 30,
          max_prefix_length = 30,
          truncate_names = true,
          tab_size = 21,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_update_on_event = true,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            if context.buffer:current() then
              return ''
            end
            return ''
          end,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          duplicates_across_groups = true,
          persist_buffer_sort = true,
          move_wraps_at_ends = false,
          separator_style = "slant",
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
          },
          sort_by = 'insert_after_current',
          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              text_align = "left",
              separator = true
            }
          },
          custom_filter = function(buf_number, buf_numbers)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "qf" and vim.bo[buf_number].filetype ~= "fugitive" then
              return true
            end
          end,
          groups = {
            options = {
              toggle_hidden_on_enter = true
            },
            items = {
              {
                name = "Tests",
                highlight = {bg = "#a7c080", fg = "#2d353b"},
                priority = 2,
                icon = "",
                matcher = function(buf)
                  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf.id), ':t')
                  return name:match('test') or name:match('spec')
                end,
              },
              {
                name = "Docs",
                highlight = {bg = "#7fbbb3", fg = "#2d353b"},
                priority = 2,
                icon = "",
                matcher = function(buf)
                  local name = vim.api.nvim_buf_get_name(buf.id)
                  return name:match('%.md$') or name:match('%.txt$')
                end,
              },
            }
          }
        },
        highlights = {
          buffer_selected = {
            bold = true,
            italic = false,
          },
          indicator_selected = {
            fg = {attribute = "fg", highlight = "LspDiagnosticsDefaultHint"},
            bg = {attribute = "bg", highlight = "Normal"},
          }
        }
      })
      
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}