# oh-my-zsh defaults
export TERM="xterm-256color"

case "$OSTYPE" in
  darwin*)
    export ZSH="/Users/davidker/.oh-my-zsh"
  ;;
  linux*)
    export ZSH="/home/david/.oh-my-zsh"
  ;;
esac

DISABLE_AUTO_TITLE="true"

plugins=(
  bundler
  git
  heroku
  mosh
  osx
  rails
  vscode
)

# Powerlevel10k - https://github.com/romkatv/powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Shell Options
source $ZSH/oh-my-zsh.sh

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

# oh-my-zsh Customizations
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Dev Environment
## Tab Titles
### Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}

### Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle

### Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }

### Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

### Show cwd when shell prompts for input.
tabtitle_precmd() {
   if overridden; then return; fi
   pwd=$(pwd) # Store full path as variable
   cwd=${pwd##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions tabtitle_precmd)

### Prepend command (w/o arguments) to cwd while waiting for command to complete.
tabtitle_preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions tabtitle_preexec)

## rbenv
which rbenv > /dev/null
if [[ $? = 0 ]] ; then
  path=("$HOME/.rbenv/bin" $path)
  export RBENV_ROOT=$HOME/.rbenv
  eval "$(rbenv init -)"
fi

## git
path+=("$HOME/.git/scripts")

## code
export EDITOR='code -w'

## aliases
alias rs='bundle exec rspec'
alias hrc='heroku run rails c -a'
alias hl='hyperlayout'

## Relative cd - h/t https://twitter.com/paulredmond/status/1204557648026144768?s=20
cdpath=(~/Code ~/Projects)

## fzf
export FZF_DEFAULT_COMMAND="find -L"

## Add ~/.dotfiles/bin to path
path+=("$HOME/.dotfiles/bin")

source ~/.dotfiles/zsh/zshrc.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'

# Export path at the very end
export PATH
