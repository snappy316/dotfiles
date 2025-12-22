-- Neovim Options Configuration

-- Line Numbers
vim.opt.number = true           -- Show absolute line numbers
vim.opt.relativenumber = true   -- Show relative line numbers

-- Editor Settings
vim.opt.tabstop = 2            -- Number of spaces tabs count for
vim.opt.shiftwidth = 2         -- Size of an indent
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.smartindent = true     -- Smart autoindenting

-- Search Settings
vim.opt.ignorecase = true      -- Ignore case in search patterns
vim.opt.smartcase = true       -- Override ignorecase if search contains uppercase
vim.opt.hlsearch = true        -- Highlight search results
vim.opt.incsearch = true       -- Show search matches as you type

-- UI Settings
vim.opt.cursorline = true      -- Highlight current line
vim.opt.wrap = false           -- Don't wrap lines
vim.opt.scrolloff = 8          -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8      -- Keep 8 columns left/right of cursor
vim.opt.signcolumn = "yes"     -- Always show sign column

-- Performance
vim.opt.updatetime = 250       -- Faster completion
vim.opt.timeoutlen = 300       -- Faster which-key trigger

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

