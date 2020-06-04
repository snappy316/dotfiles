function s:vtr_rubocop_file()
  let current_path = expand("%:p")
  let command = "bundle exec rubocop " . current_path
  execute "VtrSendCommandToRunner " . command 
endfunction

function s:vtr_rubocop_changed()
  let command = "git diff --name-only \"$(git rev-parse master)\" --diff-filter AM | xargs bundle exec rubocop --force-exclusion"
  execute "VtrSendCommandToRunner " . command
endfunction

function s:vtr_rubocop_project()
  let command = "bundle exec rubocop \"$(git rev-parse --show-toplevel)\""
  execute "VtrSendCommandToRunner " . command
endfunction

command VtrRubocopFile call s:vtr_rubocop_file()
command VtrRubocopChanged call s:vtr_rubocop_changed()
command VtrRubocopProject call s:vtr_rubocop_project()
