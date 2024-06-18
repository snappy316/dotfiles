return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    local colorizer = require("colorizer")

    colorizer.setup({
      "*", -- Highlight all files, but customize some others.
      javascript = { css = true }, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    })
  end,
}
