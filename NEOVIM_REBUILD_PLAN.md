# Neovim Config Rebuild Plan

## Background
Moving from LazyVim to a custom Neovim configuration to resolve plugin conflicts and better integrate with devbox workflow.

## Current Issues Being Solved
- Telescope `ft_to_lang` errors
- LSP server crashes with devbox environment
- Mason conflicts with devbox language tools
- Complex LazyVim overhead

## Strategy
**Keep:**
- `lazy.nvim` plugin manager (just the manager, not LazyVim framework)
- All existing keymaps (user is used to them)
- Essential plugin functionality

**Remove:**
- LazyVim framework overhead
- Mason (replaced with devbox tooling)
- Complex LSP setup conflicts

## Target Plugin List

### Core Functionality
- **telescope.nvim** - File finder with proper treesitter support
- **nvim-treesitter** - Syntax highlighting
- **nvim-lspconfig** - Language server setup
- **nvim-lint** - Linting support
- **nvim-cmp** - Completion with LSP/buffer/path sources

### UI/UX Plugins
- **neo-tree.nvim** - File explorer
- **whichkey.nvim** - Keymap discovery
- **trouble.nvim** - Diagnostics panel
- **bufferline.nvim** - Tab-like buffer display
- **lualine.nvim** - Status line
- **mini.icons** - Icon support
- **noice.nvim** - UI improvements

### Editor Features
- **mini.pairs** - Auto-close brackets/quotes
- **conform.nvim** - Code formatting

### Navigation
- **vim-tmux-navigator** - Seamless tmux/vim pane navigation

### Theme
- **tokyonight.nvim** - Color scheme (moon variant)

## LSP & Tooling Strategy

### Updated Language Server Approach
- **Mason for LSP servers** - Automatic installation and management of language servers
- **Devbox for language runtimes** - Project-specific language versions (Ruby, Node, Python)
- **Clean separation** - Mason handles LSP tools, devbox handles language runtimes
- **Simple configuration** - Direct mason + mason-lspconfig + lspconfig (no LazyVim complexity)

### Why This Approach Works
- **Convenience**: Mason auto-installs/updates LSP servers
- **Consistency**: Same LSP server versions across team members
- **Flexibility**: Language runtimes still managed per-project via devbox
- **No conflicts**: Clean setup avoids LazyVim's complex mason integration

## Keymaps to Preserve
From current config (`/Users/davidker/.dotfiles/nvim/lua/config/keymaps.lua`):
- `gt` / `gT` - Buffer navigation
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags

## Implementation Steps

### Phase 1: Backup & Foundation
1. Create backup of current config
2. Create minimal `init.lua` with lazy.nvim
3. Set up basic Vim options
4. Configure tokyonight theme

### Phase 2: Core Plugins
1. Add telescope (with treesitter support)
2. Add nvim-treesitter
3. Test telescope functionality

### Phase 3: LSP Setup
1. Add nvim-lspconfig
2. Configure Ruby LSP with bundle exec
3. Test LSP functionality in Rails project

### Phase 4: Additional Features
1. Add nvim-cmp completion
2. Add nvim-lint
3. Add conform.nvim formatting

### Phase 5: UI Plugins
1. Add neo-tree, whichkey, trouble
2. Add bufferline, lualine
3. Add mini.icons, noice, mini.pairs

### Phase 6: Testing & Refinement
1. Test all functionality in Rails project
2. Verify keymaps work as expected
3. Add any missing plugins as discovered

## Rollback Plan
- Current config backed up as `nvim.backup.YYYYMMDD_HHMMSS`
- Can restore by copying backup back to `nvim/`
- Git history available for incremental rollback

## Success Criteria
- ✅ Telescope file finder works without errors
- ✅ Syntax highlighting works immediately
- ✅ LSP servers start successfully in Rails projects
- ✅ All familiar keymaps continue working
- ✅ Completion and formatting work as expected
- ✅ No plugin conflicts or startup errors

## Progress Checkpoint

### ✅ Phase 1 Complete: Foundation
- [x] Created clean `init.lua` without LazyVim framework 
- [x] Set up lazy.nvim plugin manager (without LazyVim)
- [x] Preserved essential keymaps (gt/gT for buffers)
- [x] Commented out telescope keymaps until plugin is added
- [x] Cleared plugins directory for fresh start
- [x] Verified minimal setup works without errors

### ✅ Phase 2 Complete: First Plugin
- [x] Added tokyonight.nvim theme with moon variant
- [x] Configured proper plugin loading priority
- [x] Verified theme loads correctly without errors
- [x] Re-enabled plugin importing in init.lua

### ✅ Phase 3 Complete: Treesitter
- [x] Discovered nvim-treesitter `main` branch has breaking changes
- [x] Temporarily installed `tree-sitter-cli` via `devbox global add tree-sitter` (needed for main branch)
- [x] Switched to stable `master` branch to avoid API issues
- [x] Removed `tree-sitter-cli` with `devbox global rm tree-sitter` (not needed for master branch)
- [x] Cleaned plugin cache and reinstalled from scratch
- [x] Verified `:TSInstallInfo`, `:TSBufToggle highlight` commands work
- [x] Confirmed rich syntax highlighting works for Ruby and Lua

**Key Learning:** nvim-treesitter `main` branch is unstable - stick with `master` branch for reliability

### ✅ Phase 4 Complete: Telescope
- [x] Added telescope.nvim with stable treesitter integration
- [x] Configured proper telescope keymaps within plugin config (not global keymaps)
- [x] Verified file finder works with preview window and syntax highlighting
- [x] Confirmed no ft_to_lang errors with stable treesitter master branch
- [x] All telescope commands working: `<leader>ff`, `<leader>fg`, `<leader>fb`, `<leader>fh`
- [x] Cleaned up keymaps.lua to avoid confusion

**Key Learning:** Load plugin keymaps within plugin config to avoid load order issues

### ✅ Phase 5 Complete: Tmux Navigation
- [x] Added vim-tmux-navigator plugin
- [x] Used original configuration from backup for familiarity
- [x] Verified seamless navigation between Neovim and tmux panes
- [x] All navigation keys working: `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`, `<C-\>`

### ✅ Phase 6 Complete: LSP Setup Working
- [x] Implemented clean mason + mason-lspconfig + lspconfig setup
- [x] **Lua LSP**: Working with optimized workspace settings (30s load time vs 2min)
- [x] **TypeScript LSP**: Working via Mason installation
- [x] **Ruby LSP**: Working via bundle exec + project Gemfile approach
- [x] Used modern vim.lsp.config API (no deprecation warnings)
- [x] Verified no LazyVim-style conflicts

**Key Breakthrough**: Ruby LSP success via adding `ruby-lsp` to project Gemfile and using `bundle exec ruby-lsp` command. This resolves all devbox environment issues.

### 🔄 Phase 7 In Progress: Additional Plugins & Polish
- [ ] Add nvim-cmp completion
- [ ] Add nvim-lint linting support  
- [ ] Add conform.nvim formatting
- [ ] Add neo-tree file explorer
- [ ] Add whichkey keymap discovery
- [ ] Add trouble.nvim diagnostics panel
- [ ] Add bufferline.nvim tab-like buffer display
- [ ] Add lualine.nvim status line
- [ ] Add mini.icons icon support
- [ ] Add mini.pairs auto-close brackets/quotes
- [ ] Test complete workflow in Rails project

---
Created: 2025-12-19
Updated: 2025-12-22  
Status: Phase 6 Complete - All Core LSP Working ✅