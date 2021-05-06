#!/bin/bash

sudo apt-get install build-essential
echo 'eval $(~/.linuxbrew/bin/brew shellenv)' >> ~/.zprofile
echo '# Add linuxbrew to path' >> ~/.dotfiles/zsh/zshrc.local
echo 'path+=("$HOME/.linuxbrew/bin")' >> ~/.dotfiles/zsh/zshrc.local
eval $(~/.linuxbrew/bin/brew shellenv)
