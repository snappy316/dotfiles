_get_current_git_branch() {
  git symbolic-ref --short HEAD 2> /dev/null
}

_is_git_staging_area_dirty() {
  git status --short --ignore-submodules=dirty 2> /dev/null
}

_git_branch_prompt() {
  local last_exit_code=$?

  local blue='\[\e[0;34m\]'
  local green='\[\e[0;32m\]'
  local purple='\[\e[0;35m\]'
  local red='\[\e[0;31m\]'
  local reset='\[\e[0;0m\]'
  local yellow='\[\e[0;33m\]'

  if [[ $last_exit_code -eq 0 ]]; then
    PS1="$blue"
  else
    PS1="$red"
  fi

  PS1="$PS1\w"

  local branch=$(_get_current_git_branch)

  if [[ -n $branch ]]; then
    PS1="$PS1$yellow $branch"

    if [[ -n $(_is_git_staging_area_dirty) ]]; then
      PS1="$PS1$red ✖"
    else
      PS1="$PS1$green ✔"
    fi
  else
    PS1="$PS1$purple \$"
  fi

  PS1="$PS1$reset "
}

PROMPT_DIRTRIM=1
PROMPT_COMMAND=_git_branch_prompt