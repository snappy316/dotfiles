""""" Vundle Config """""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

""""" Custom Plugins """""
" tpope
Plugin 'tpope/vim-sensible'

" Nord
Plugin 'arcticicestudio/nord-vim'

""""" Vundle Config """""
call vundle#end()            " required
filetype plugin indent on    " required
