#!/bin/bash

which brew
if [[ $? != 0 ]] ; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Installing Brewfile..."
  brew bundle --no-upgrade
else
  echo "Updating Homebrew..."
  brew update
fi
