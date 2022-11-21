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

" Line Length Color Config
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=+1
autocmd FileType rb set colorcolumn=120

" NERDTree config
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-test
let g:test#strategy = "vtr"

" ALE linter config
let g:ale_linters = {
  \   'css': ['prettier'],
  \   'javascript': ['eslint'],
  \   'javascriptreact': ['eslint'],
  \   'ruby': ['rubocop'],
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ }

let g:ale_fixers = {
  \   'css': ['prettier'],
  \   'javascript': ['eslint'],
  \   'javascriptreact': ['eslint'],
  \   'ruby': ['rubocop'],
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ }

let g:ale_ruby_rubocop_executable = 'bundle'  " Use the local/bundle version of rubocop, instead of system

let g:ale_sign_error = '❌'       " Prettify the error sign
let g:ale_sign_warning = '⚠️'      " Prettify the warning sign

let g:ale_fix_on_save = 1         " Automatically fix files when saved
let g:ale_linters_explicit = 1    " Only run linters named in ale_linters settings.

" fzf
set rtp+=/usr/local/opt/fzf

" ack.vim config
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  " let g:ackprg = 'ag --nogroup --nocolor --column'
endif

so ~/.vim/key_mappings.vim
so ~/.dotfiles/.vim/functions.vim
