return {
  -- Which-key keymap discovery
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")
      
      wk.setup({
        preset = "modern",
        delay = 500,
        filter = function(mapping)
          return true
        end,
        spec = {},
        notify = true,
        triggers = {
          { "<auto>", mode = "nxsot" },
        },
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        win = {
          border = "rounded",
          padding = { 1, 2 },
          title = true,
          title_pos = "center",
          zindex = 1000,
          bo = {},
          wo = {
            winblend = 0,
          },
        },
        layout = {
          width = { min = 20 },
          spacing = 3,
        },
        keys = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        sort = { "local", "order", "group", "alphanum", "mod" },
        expand = 0,
        replace = {
          key = {
            function(key)
              return require("which-key.view").format(key)
            end,
          },
          desc = {
            { "<Plug>%(.*)%)", "%1" },
            { "^%+", "" },
            { "<[cC]md>", "" },
            { "<[cC][rR]>", "" },
            { "<[sS]ilent>", "" },
            { "^lua%s+", "" },
            { "^call%s+", "" },
            { "^:%s*", "" },
          },
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
          ellipsis = "…",
          mappings = true,
          rules = {},
          colors = true,
          keys = {
            Up = " ",
            Down = " ",
            Left = " ",
            Right = " ",
            C = "󰘴 ",
            M = "󰘵 ",
            D = "󰘳 ",
            S = "󰘴 ",
            CR = "󰌑 ",
            Esc = "󱊷 ",
            ScrollWheelDown = "󱕐 ",
            ScrollWheelUp = "󱕑 ",
            NL = "󰌑 ",
            BS = "󰁮",
            Space = "󱁐 ",
            Tab = "󰌒 ",
            F1 = "󱊫",
            F2 = "󱊬",
            F3 = "󱊭",
            F4 = "󱊮",
            F5 = "󱊯",
            F6 = "󱊰",
            F7 = "󱊱",
            F8 = "󱊲",
            F9 = "󱊳",
            F10 = "󱊴",
            F11 = "󱊵",
            F12 = "󱊶",
          },
        },
        show_help = true,
        show_keys = true,
        disable = {
          buftypes = {},
          filetypes = {},
        },
      })

      -- Register key group descriptions
      wk.add({
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "File/Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP/Lint" },
        { "<leader>m", group = "Format" },
        { "<leader>r", group = "Rename" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle" },
        { "<leader>w", group = "Workspace" },
        { "<leader>x", group = "Diagnostics/Trouble" },
        { "g", group = "Go to" },
        { "z", group = "Fold" },
        { "]", group = "Next" },
        { "[", group = "Prev" },
      })
    end,
  },
}