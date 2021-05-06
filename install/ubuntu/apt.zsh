#!/bin/zsh

sudo apt-get update
sudo apt-get install jq
sudo apt-get install fd-find
ln -s $(which fdfind) ~/.dotfiles/bin/fd
sudo apt-get install silversearcher-ag
