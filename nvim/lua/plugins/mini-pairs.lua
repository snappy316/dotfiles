return {
  -- Mini.pairs auto-close brackets/quotes
  {
    "echasnovski/mini.pairs",
    version = false,
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup({
        -- In which modes mappings from this `config` should be created
        modes = { insert = true, command = false, terminal = false },

        -- Global mappings. Each right hand side should be a pair information, a
        -- table with at least these fields (see more in |MiniPairs.map|):
        -- - <action> - one of 'open', 'close', 'closeopen'.
        -- - <pair> - two character string for pair to be used.
        -- By default pair is not inserted after `\`, quotes are not recognized by
        -- `<CR>` (so cursor is not pushed down), `'` does not insert pair after a
        -- letter.
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

          [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        },

        -- Which filetypes to disable
        disable_in = {
          "TelescopePrompt",
          "neo-tree-popup",
          "trouble",
        },

        -- Pattern to recognize 'balanced' text (pairs are balanced if this pattern
        -- matches after cursor in insert mode). See |MiniPairs-algorithm|.
        balance_pattern = "[^\\].",

        -- Configuration for various algorithms used for pairs
        -- More information at |MiniPairs.config.algorithms|
        algorithms = {
          -- Controls when pair is inserted after opening bracket
          open = {
            -- Don't add pair after unbalanced quote
            unbalanced_quote = true,
          },

          -- Controls when pair is auto-closed
          close = {
            -- Don't close pair if cursor is followed by closing bracket
            bracket_line = true,
          },

          -- Controls when both characters of pair are added/removed
          closeopen = {
            -- Balance pairs when adding/removing
            balance = true,
          },
        },
      })
    end,
  },
}

