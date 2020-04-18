#!/bin/bash

if [ ! -d ~/.dotfiles ] ; then
  echo "Downloading dotfiles"
  git clone https://gitlab.com/snappy316/dotfiles.git ~/.dotfiles
else
  echo "Updating dotfiles"
  cd ~/.dotfiles
  git pull origin master
fi
