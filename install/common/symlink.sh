#!/bin/bash

# git
if ! [ -L ~/.gitconfig ]; then
  echo "Symlinking gitconfig"
  ln -svf ~/.dotfiles/git/.gitconfig ~
fi
if ! [ -L ~/.gitignore_global ]; then
  echo "Symlinking global gitignore"
  ln -svf ~/.dotfiles/git/.gitignore_global ~
fi

# zsh
if ! [ -L ~/.zshrc ]; then
  echo "Symlinking zshrc"
  ln -svf ~/.dotfiles/zsh/.zshrc ~
fi

# vim
if ! [ -L ~/.zshrc ]; then
  echo "Symlinking Vim dotfiles"
  ln -sfv ~/.dotfiles/.vimrc ~
  ln -sfv ~/.dotfiles/.vim ~
fi
