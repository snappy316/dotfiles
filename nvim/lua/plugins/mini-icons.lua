return {
  -- Mini.icons icon support
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup({
        -- Icon style
        style = "glyph",

        -- Default icon fallbacks
        default = {
          file = "󰈔",
          extension = "󰈔",
          directory = "󰉋",
          lsp = {
            array = "󰅪",
            boolean = "󰨙",
            class = "󰌗",
            constant = "󰏿",
            constructor = "",
            enum = "",
            enummember = "",
            event = "",
            field = "󰜢",
            file = "󰈙",
            folder = "󰉋",
            ["function"] = "󰊕",
            interface = "",
            key = "󰌋",
            keyword = "󰌋",
            method = "󰆧",
            module = "",
            namespace = "󰦮",
            ["nil"] = "󰟢",
            number = "󰎠",
            object = "󰅩",
            operator = "󰆕",
            package = "",
            property = "󰜢",
            reference = "󰈇",
            snippet = "",
            string = "󰀬",
            struct = "󰌗",
            text = "󰉿",
            typeparameter = "󰊄",
            unit = "󰑭",
            value = "󰎠",
            variable = "󰀫",
          },
        },

        -- Custom overrides for specific files/extensions
        filetype = {
          -- Lua files
          lua = { glyph = "", hl = "MiniIconsBlue" },

          -- Ruby files
          ruby = { glyph = "", hl = "MiniIconsRed" },

          -- JavaScript/TypeScript
          javascript = { glyph = "", hl = "MiniIconsYellow" },
          typescript = { glyph = "", hl = "MiniIconsBlue" },

          -- Web files
          html = { glyph = "", hl = "MiniIconsOrange" },
          css = { glyph = "", hl = "MiniIconsBlue" },
          scss = { glyph = "", hl = "MiniIconsPurple" },

          -- Config files
          json = { glyph = "", hl = "MiniIconsYellow" },
          yaml = { glyph = "", hl = "MiniIconsOrange" },
          toml = { glyph = "", hl = "MiniIconsOrange" },

          -- Git files
          gitcommit = { glyph = "", hl = "MiniIconsRed" },
          gitrebase = { glyph = "", hl = "MiniIconsRed" },

          -- Shell files
          sh = { glyph = "", hl = "MiniIconsGreen" },
          zsh = { glyph = "", hl = "MiniIconsGreen" },
          fish = { glyph = "", hl = "MiniIconsGreen" },

          -- Documentation
          markdown = { glyph = "", hl = "MiniIconsBlue" },
          text = { glyph = "󰈙", hl = "MiniIconsGrey" },

          -- Neovim
          vim = { glyph = "", hl = "MiniIconsGreen" },
        },

        -- Custom file name overrides
        file = {
          [".gitignore"] = { glyph = "", hl = "MiniIconsRed" },
          [".gitattributes"] = { glyph = "", hl = "MiniIconsRed" },
          ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
          ["package-lock.json"] = { glyph = "", hl = "MiniIconsRed" },
          ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
          ["Gemfile"] = { glyph = "", hl = "MiniIconsRed" },
          ["Gemfile.lock"] = { glyph = "", hl = "MiniIconsRed" },
          ["README.md"] = { glyph = "", hl = "MiniIconsBlue" },
          ["LICENSE"] = { glyph = "", hl = "MiniIconsYellow" },
          ["Dockerfile"] = { glyph = "", hl = "MiniIconsBlue" },
          ["docker-compose.yml"] = { glyph = "", hl = "MiniIconsBlue" },
          ["docker-compose.yaml"] = { glyph = "", hl = "MiniIconsBlue" },
          [".env"] = { glyph = "", hl = "MiniIconsYellow" },
          [".env.local"] = { glyph = "", hl = "MiniIconsYellow" },
          [".env.example"] = { glyph = "", hl = "MiniIconsYellow" },
          ["init.lua"] = { glyph = "", hl = "MiniIconsBlue" },
        },

        -- Custom extension overrides
        extension = {
          -- Source code
          rb = { glyph = "", hl = "MiniIconsRed" },
          js = { glyph = "", hl = "MiniIconsYellow" },
          ts = { glyph = "", hl = "MiniIconsBlue" },
          jsx = { glyph = "", hl = "MiniIconsCyan" },
          tsx = { glyph = "", hl = "MiniIconsCyan" },
          py = { glyph = "", hl = "MiniIconsBlue" },
          go = { glyph = "", hl = "MiniIconsCyan" },
          rs = { glyph = "", hl = "MiniIconsOrange" },

          -- Web
          html = { glyph = "", hl = "MiniIconsOrange" },
          css = { glyph = "", hl = "MiniIconsBlue" },
          scss = { glyph = "", hl = "MiniIconsPurple" },
          sass = { glyph = "", hl = "MiniIconsPurple" },

          -- Config
          json = { glyph = "", hl = "MiniIconsYellow" },
          yml = { glyph = "", hl = "MiniIconsOrange" },
          yaml = { glyph = "", hl = "MiniIconsOrange" },
          toml = { glyph = "", hl = "MiniIconsOrange" },
          xml = { glyph = "", hl = "MiniIconsOrange" },

          -- Documentation
          md = { glyph = "", hl = "MiniIconsBlue" },
          txt = { glyph = "󰈙", hl = "MiniIconsGrey" },

          -- Images
          png = { glyph = "", hl = "MiniIconsPurple" },
          jpg = { glyph = "", hl = "MiniIconsPurple" },
          jpeg = { glyph = "", hl = "MiniIconsPurple" },
          gif = { glyph = "", hl = "MiniIconsPurple" },
          svg = { glyph = "", hl = "MiniIconsYellow" },

          -- Archives
          zip = { glyph = "", hl = "MiniIconsYellow" },
          tar = { glyph = "", hl = "MiniIconsYellow" },
          gz = { glyph = "", hl = "MiniIconsYellow" },

          -- Executables
          exe = { glyph = "", hl = "MiniIconsRed" },
          app = { glyph = "", hl = "MiniIconsRed" },
        },
      })
    end,
  },
}

