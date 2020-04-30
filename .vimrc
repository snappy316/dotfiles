so ~/.vim/plugins.vim
so ~/.vim/key_mappings.vim

" set Vim-specific sequences for RGB colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
 
" set background=light
" colorscheme solarized8

" General
syntax enable         " enable syntax processing

" Spaces & Tabs
set tabstop=2         " number of visual spaces per TAB
set softtabstop=2     " number of spaces in tab when editing
set expandtab         " tabs are spaces

" UI Config
set number            " show absolute line number for current line
set relativenumber    " show relative line numbers from current line
set showcmd           " show command in bottom bar
set splitbelow        " split new buffers below the current
set splitright        " vsplit new buffers to the right of current

" Git Config
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=+1
