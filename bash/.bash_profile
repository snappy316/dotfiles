# rbenv
eval "$(rbenv init -)"

# code
export EDITOR='code -w'

# aliases
alias be='bundle exec'

# bash-completion
if [[ -f /usr/local/etc/bash_completion ]]; then
  source /usr/local/etc/bash_completion
fi

# prompt
source ~/.config/bash/prompt.sh
