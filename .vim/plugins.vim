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
Plugin 'tpope/vim-rhubarb'          " GitHub extension for fugitive.vim
Plugin 'tpope/vim-obsession'        " continuously updated session files
Plugin 'tpope/vim-rails'            " Ruby on Rails power tools
Plugin 'tpope/vim-sensible'         " defaults everyone can agree on
Plugin 'tpope/vim-eunuch'           " helpers for Unix
Plugin 'tpope/vim-surround'         " quoting/parenthesizing made simple
Plugin 'tpope/vim-commentary'       " comment stuff out

" christoomey
Plugin 'christoomey/vim-tmux-navigator'   " Seamless navigation between tmux panes and vim splits
Plugin 'christoomey/vim-tmux-runner'      " A simple, vimscript only, command runner for sending commands from vim to tmux

" tmux-plugins
Plugin 'tmux-plugins/vim-tmux-focus-events'   " Make terminal vim and tmux work better together

" others
Plugin 'arcticicestudio/nord-vim'   " color scheme
Plugin 'itchyny/lightline.vim'      " status line
Plugin 'airblade/vim-gitgutter'     " git diff markers in the sign column
Plugin 'preservim/nerdtree'         " tree explorer
Plugin 'junegunn/fzf'               " fuzzy file finder
Plugin 'junegunn/fzf.vim'           " fuzzy file finder
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

Plugin 'janko-m/vim-test'           " Run your tests at the speed of thought (paired with vim-tmux-runner)
Plugin 'dense-analysis/ale'         " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plugin 'yuezk/vim-js'               " The most accurate syntax highlighting plugin for JavaScript and Flow.js
Plugin 'maxmellon/vim-jsx-pretty'   " JSX and TSX syntax pretty highlighting for vim.
Plugin 'mileszs/ack.vim'            " Run your favorite search tool from Vim, with an enhanced results list.
Plugin 'chrisbra/Colorizer'         " color hex codes and color names
Plugin 'mattn/emmet-vim'            " emmet for vim
""""" Vundle Config """""
call vundle#end()            " required
filetype plugin indent on    " required
