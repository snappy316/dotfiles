#!/bin/zsh

if [ ! -d ~/.tmux/plugins/tpm ] ; then
  echo "Installing tpm"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Updating tmux plugins"
~/.tmux/plugins/tpm/bin/install_plugins
