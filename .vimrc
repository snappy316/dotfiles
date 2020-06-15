so ~/.vim/plugins.vim
so ~/.vim/key_mappings.vim
so ~/.dotfiles/.vim/functions.vim

" Colorscheme
colorscheme nord      " note: for solarized8, look at commit history to bring back other settings

" General
set nocompatible
syntax enable         " enable syntax processing
let mapleader = "\<Space>"
set mouse=a
set updatetime=100
set clipboard=unnamedplus,unnamed,autoselect

" Spaces & Tabs
filetype plugin indent on
set tabstop=2         " number of visual spaces per TAB
set softtabstop=2     " number of spaces in tab when editing
set shiftwidth=2      " when indenting with `>`, use two spaces
set expandtab         " tabs are spaces
autocmd BufWritePre *.rb,*.erb :TrimWhitespace    " remove trailing whitespace on *.rb file save

" UI Config
set number            " show absolute line number for current line
set relativenumber    " show relative line numbers from current line
set showcmd           " show command in bottom bar
set splitbelow        " split new buffers below the current
set splitright        " vsplit new buffers to the right of current
set noshowmode        " don't show the mode, since the lightline plugin shows it in status bar
set shortmess+=F      " to get rid of the file name displayed in the command line bar
set wildmode=longest,list,full    " tab completion
set wildmenu                      " tab completion
autocmd VimResized * :wincmd =    " automatically rebalance windows on vim resize

" Statusline Config
let g:lightline = {
  \   'colorscheme': 'nord',
  \   'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \   'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ],
  \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \   },
  \   'component_function': {
  \     'gitbranch': 'FugitiveHead'
  \   },
  \ }

let g:lightline.enable = {
  \   'statusline': 1,
  \   'tabline': 1
  \ }

" Git Config
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=+1

" NERDTree config
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter config
let g:NERDSpaceDelims = 1       " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1   " Use compact syntax for prettified multi-line comments

" vim-test
let g:test#strategy = "vtr"
