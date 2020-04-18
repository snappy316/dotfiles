#!/bin/bash

which brew
if [[ $? != 0 ]] ; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Updating Homebrew..."
  brew update
fi
