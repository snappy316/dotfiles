# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export RBENV_ROOT=$HOME/.rbenv
eval "$(rbenv init -)"

# code
export EDITOR='code -w'

# aliases
alias be='bundle exec'
alias rs='bundle exec rspec'
alias hrc='heroku run rails c -a'
alias hl='hyperlayout'

# bash-completion
if [[ -f /usr/local/etc/bash_completion ]]; then
  source /usr/local/etc/bash_completion
fi

# prompt
source ~/.config/bash/prompt.sh

# tab titles
function title() { echo -e "\033]0;${1:?please specify a title}\007" ; }
