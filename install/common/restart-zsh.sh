#!/bin/bash

cd ~
echo "All done! Restarting zsh"
touch ~/.dotfiles/zsh/zshrc.local
exec /bin/zsh
