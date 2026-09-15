-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Naviagate buffers
keymap("n", "gt", ":bnext<CR>", opts)
keymap("n", "gT", ":bprevious<CR>", opts)

-- nvim-ufo
-- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- gitsigns: toggle inline blame (mirrors LazyVim's <leader>u* UI toggle convention,
-- since gitsigns.toggle_current_line_blame() doesn't notify on its own)
local blame_enabled = true
Snacks.toggle
  .new({
    name = "Git Blame",
    get = function() return blame_enabled end,
    set = function(state)
      blame_enabled = state
      require("gitsigns").toggle_current_line_blame(state)
    end,
  })
  :map("<leader>uB")

-- no-neck-pain: off by default, toggle on when you want centered/capped-width reading
Snacks.toggle
  .new({
    name = "No Neck Pain",
    get = function() return _G.NoNeckPain and _G.NoNeckPain.state and _G.NoNeckPain.state.enabled or false end,
    set = function() require("no-neck-pain").toggle() end,
  })
  :map("<leader>uN")
