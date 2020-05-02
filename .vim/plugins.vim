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
Plugin 'tpope/vim-fugitive'         " git wrapper
Plugin 'tpope/vim-obsession'        " continuously updated session files
Plugin 'tpope/vim-rails'            " Ruby on Rails power tools
Plugin 'tpope/vim-sensible'         " defaults everyone can agree on
Plugin 'tpope/vim-eunuch'           " helpers for Unix
Plugin 'tpope/vim-surround'         " quoting/parenthesizing made simple

Plugin 'arcticicestudio/nord-vim'   " color scheme
Plugin 'itchyny/lightline.vim'      " status line
Plugin 'airblade/vim-gitgutter'     " git diff markers in the sign column
Plugin 'preservim/nerdtree'         " tree explorer
Plugin 'junegunn/fzf'               " fuzzy file finder
Plugin 'junegunn/fzf.vim'           " fuzzy file finder

""""" Vundle Config """""
call vundle#end()            " required
filetype plugin indent on    " required
