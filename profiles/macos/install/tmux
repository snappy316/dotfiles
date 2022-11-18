#!/bin/zsh

if [ ! -d ~/.tmux/plugins/tpm ] ; then
  echo "Installing tpm"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Updating tmux plugins"
~/.tmux/plugins/tpm/bin/install_plugins

# Gracefully handle SSH Agent Forwarding
if read -q "choice?Is this a remote machine you'll be SSHing to?? (y/N): "; then
  echo
  echo "Setting up tmux / SSH Agent Forwarding"
  cp ~/.dotfiles/ssh/rc ~/.ssh/rc
  cat ~/.dotfiles/ssh/tmux.conf.local >> ~/.dotfiles/.tmux.conf.local
fi
