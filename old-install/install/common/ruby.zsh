#!/bin/zsh

# rbenv
which rbenv
if [[ $? != 0 ]] ; then
  if read -q "choice?Would you like to install rbenv? (y/N): "; then
    echo
    echo "Installing rbenv..."
    brew install rbenv
  else
    echo "Skipping rbenv install"
  fi
else
  echo "rbenv already installed"
fi

# ruby
echo "Versions of ruby already installed:"
rbenv versions
echo

if read -q "choice?Would you like to install a new version of ruby?? (y/N): "; then
  echo

  # Update ruby-build
  echo "Updating ruby-build..."
  brew upgrade ruby-build
  cd ~/.rbenv/plugins/ruby-build && git pull && cd -

  # List and prompt for version
  echo
  echo "Available versions:"
  rbenv install -l
  echo
  vared -p "Which version to install? " -c ans

  if [ -z "$ans" ]; then
    echo "Aborting"
    return 1
  fi

  echo "Installing ${ans}..."
  rbenv install ${ans}

  # Set as global
  if read -q "choice?Set ${ans} as global default? (y/N): "; then
    rbenv global ${ans}
    echo
    echo "Set ${ans} as global default"
  fi
fi
