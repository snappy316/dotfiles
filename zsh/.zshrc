# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/davidker/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Powerlevel9k - https://github.com/Powerlevel9k/powerlevel9k
## Font mode
POWERLEVEL9K_MODE='awesome-patched'

## Prompt Settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(rbenv time)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="❯ "

POWERLEVEL9K_TIME_FORMAT="%D{%F %T}"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  bundler
  git
  heroku
  mosh
  osx
  rails
  vscode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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

# oh-my-zsh Customizations
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
path=("$HOME/.rbenv/bin" $path)
export PATH
export RBENV_ROOT=$HOME/.rbenv
eval "$(rbenv init -)"

## code
export EDITOR='code -w'

## aliases
alias rs='bundle exec rspec'
alias hrc='heroku run rails c -a'
alias hl='hyperlayout'

## PCO-specific
eval "$($HOME/Code/pco/bin/pco init -)"
export MYSQL_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_PORT=3307
export PATH=/Users/davidker/pco-box/bin:/usr/local/bin:$PATH
