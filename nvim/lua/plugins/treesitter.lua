return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- Use stable master branch - main branch has breaking changes
  build = ":TSUpdate",
  lazy = false,
  priority = 1000,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "css", 
        "html",
        "javascript",
        "json",
        "lua",
        "markdown", 
        "python",
        "ruby",
        "typescript",
        "vim",
        "yaml",
      },
      
      auto_install = true,
      
      highlight = {
        enable = true,
      },
      
      indent = {
        enable = true,
        disable = { "ruby" },
      },
    })
  end,
}