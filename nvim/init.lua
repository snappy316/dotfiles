-- Custom Neovim Configuration
-- Built from scratch to work with devbox workflow

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load basic Vim options
require("config.options")

-- Load keymaps
require("config.keymaps")

-- Set up plugins
require("lazy").setup({
  spec = {
    -- Start with empty spec, we'll add plugins gradually
  },
  defaults = {
    lazy = false, -- Don't lazy load by default
  },
  performance = {
    rtp = {
      -- Disable some unused built-in plugins
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})