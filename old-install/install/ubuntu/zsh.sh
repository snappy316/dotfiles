#!/bin/bash

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
  # assume zsh - don't install zsh
  echo "ZSH already installed"
else
  # assume bash - install zsh
  echo "Installing and configuring ZSH..."
  sudo apt install zsh
fi
