#!/bin/zsh

# nvm
if [ ! -d ~/.nvm ] ; then
  echo "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

  echo "Installing latest version of node"
  nvm install node
else
  echo "nvm already installed"
fi

# node
echo "Versions of node already installed:"
nvm ls
echo

if read -q "choice?Would you like to install a new version of node?? (y/N): "; then
  echo

  echo "Available versions:"
  nvm ls-remote --lts
  echo
  vared -p "Which version to install? " -c ans

  if [ -z "$ans" ]; then
    echo "Aborting"
    return 1
  fi

  echo "Installing ${ans}..."
  nvm install ${ans}

  # Set as global
  if read -q "choice?Set ${ans} as global default? (y/N): "; then
    nvm use ${ans}
    echo
    echo "Set ${ans} as global default"
  fi
