#!/bin/zsh

if [ ! -d ~/.nvm ] ; then
  echo "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

  echo "Installing latest version of node"
  nvm install node
else
  echo "nvm already installed"
fi
