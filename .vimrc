so ~/.vim/plugins.vim
so ~/.vim/key_mappings.vim

" Colorscheme
colorscheme nord      " note: for solarized8, look at commit history to bring back other settings

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
set noshowmode        " don't show the mode, since the lightline plugin shows it in status bar
set shortmess+=F      " to get rid of the file name displayed in the command line bar

" Keybindings
map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>
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

