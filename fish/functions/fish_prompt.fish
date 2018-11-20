set fish_greeting

set fish_color_autosuggestion 555 yellow
set fish_color_command normal --bold
set fish_color_comment black
set fish_color_cwd blue
set fish_color_cwd_root black
set fish_color_error red --bold
set fish_color_escape cyan
set fish_color_history_current cyan
set fish_color_match cyan
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param normal
set fish_color_quote green
set fish_color_redirection cyan
set fish_color_search_match --background=515151
set fish_color_selection --background=purple
set fish_color_valid_path --underline

set fish_pager_color_completion blue
set fish_pager_color_description black
set fish_pager_color_prefix normal
set fish_pager_color_progress cyan

function _git_branch_name
  echo (git symbolic-ref --short HEAD ^/dev/null)
end

function _is_git_dirty
  echo (git status --short --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  if test $status -eq 0
    set_color $fish_color_cwd
  else
    set_color red
  end

  echo -ns (prompt_pwd) " "

  set -l branch (_git_branch_name)

  if test -n $branch
    set_color yellow
    echo -n "$branch "

    if test -n (_is_git_dirty)
      set_color red
      echo -n "✖ "
    else
      set_color green
      echo -n "✔ "
    end
  else
    set_color magenta
    echo -n '$ '
  end

  set_color normal
end