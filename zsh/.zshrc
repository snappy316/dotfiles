# Shell Options
## Enable better tab completion
autoload -Uz compinit && compinit

## Enable automatic `cd`
setopt AUTO_CD

## Enable correction of mistyped commands
setopt CORRECT
setopt CORRECT_ALL

## Enable case-insensitive globbing
setopt NO_CASE_GLOB

## Enable case-insensitive auto-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

## Enable partial path completion
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

## History
setopt HIST_VERIFY          # verify the `!!`-substituted command before running it
SAVEHIST=5000               # override the history buffer defaults
HISTSIZE=2000               # override the history buffer defaults
setopt SHARE_HISTORY        # share history across multiple zsh sessions
setopt APPEND_HISTORY       # append to history, instead of overwriting
setopt INC_APPEND_HISTORY   # adds commands as they are typed, not at shell exit

# Functions
## Tab Titles
function title() { echo -e "\033]0;${1:?please specify a title}\007" ; }

# Dev Environment
## rbenv
path=("$HOME/.rbenv/bin" $path)
export PATH
export RBENV_ROOT=$HOME/.rbenv
eval "$(rbenv init -)"

## code
export EDITOR='code -w'

## aliases
alias be='bundle exec'
alias rs='bundle exec rspec'
alias hrc='heroku run rails c -a'
alias hl='hyperlayout'

## PCO-specific
eval "$($HOME/Code/pco/bin/pco init -)"
export MYSQL_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_PORT=3307
export PATH=/Users/davidker/pco-box/bin:/usr/local/bin:$PATH
