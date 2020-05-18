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

if ! [ -L ~/.p10k.zsh ]; then
  echo "Symlinking p10k"
  ln -svf ~/.dotfiles/zsh/.p10k.zsh ~
fi

if ! [ -L ~/.fzf.zsh ]; then
  echo "Symlinking .fzf.zsh"
  ln -svf ~/.dotfiles/zsh/.fzf.zsh ~
fi

# vim
if ! [ -L ~/.vimrc ]; then
  echo "Symlinking Vim dotfiles"
  ln -sfv ~/.dotfiles/.vimrc ~
  ln -sfv ~/.dotfiles/.vim/key_mappings.vim ~/.vim
  ln -sfv ~/.dotfiles/.vim/plugins.vim ~/.vim
fi

# tmux
if ! [ -L ~/.tmux.conf ]; then
  echo "Symlinking Tmux dotfiles"
  ln -sfv ~/.dotfiles/.tmux.conf ~
fi

# rubocop
if ! [ -L ~/.rubocop.yml ]; then
  echo "Symlinking rubocop"
  ln -sfv ~/.dotfiles/.rubocop.yml ~
fi
