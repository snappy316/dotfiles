return {
  "folke/tokyonight.nvim",
  lazy = false, -- Load immediately for colorscheme
  priority = 1000, -- Load before other plugins
  config = function()
    require("tokyonight").setup({
      style = "moon", -- Use moon variant
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
    })

    -- Set colorscheme
    vim.cmd([[colorscheme tokyonight-moon]])
  end,
}
