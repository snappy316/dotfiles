return {
  -- Lualine.nvim status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local lualine = require("lualine")

      -- Custom components
      local function lsp_status()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end

        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return " " .. table.concat(names, ", ")
      end

      local function search_count()
        if vim.v.hlsearch == 0 then
          return ""
        end

        local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
        if not ok or vim.tbl_isempty(result) then
          return ""
        end

        if result.incomplete == 1 then
          return "?/?"
        elseif result.total > 0 then
          return string.format("%d/%d", result.current, result.total)
        else
          return ""
        end
      end

      local function macro_recording()
        local register = vim.fn.reg_recording()
        if register == "" then
          return ""
        else
          return "recording @" .. register
        end
      end

      lualine.setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            "diff",
            {
              "diagnostics",
              sources = { "nvim_diagnostic", "nvim_lsp" },
              symbols = { error = " ", warn = " ", info = " " },
              diagnostics_color = {
                color_error = { fg = "#ff6c6b" },
                color_warn = { fg = "#ECBE7B" },
                color_info = { fg = "#008080" },
              },
            },
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              newfile_status = false,
              path = 1,
              shorting_target = 40,
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
            {
              macro_recording,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_x = {
            {
              search_count,
              color = { fg = "#ff9e64" },
            },
            "encoding",
            "fileformat",
            "filetype",
            {
              lsp_status,
              color = { fg = "#98be65" },
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { "neo-tree", "lazy", "mason", "trouble" },
      })
    end,
  },
}

