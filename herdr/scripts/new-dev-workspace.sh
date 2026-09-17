#!/bin/sh
set -e

roots=""
for root in "$HOME/Code" "$HOME/Projects"; do
  [ -d "$root" ] && roots="$roots $root"
done

dir=$(fd --type d --max-depth 1 . $roots | fzf --prompt="workspace> ")
[ -z "$dir" ] && exit 0

ws_json=$(herdr workspace create --cwd "$dir" --focus)
ws_id=$(echo "$ws_json" | jq -r '.result.workspace.workspace_id')
claude_tab=$(echo "$ws_json" | jq -r '.result.tab.tab_id')
claude_pane=$(echo "$ws_json" | jq -r '.result.root_pane.pane_id')

herdr tab rename "$claude_tab" claude
herdr agent start "claude-$(date +%s)" --kind claude --pane "$claude_pane"

nvim_json=$(herdr tab create --workspace "$ws_id" --label nvim --no-focus)
herdr pane run "$(echo "$nvim_json" | jq -r '.result.root_pane.pane_id')" nvim

lazygit_json=$(herdr tab create --workspace "$ws_id" --label lazygit --no-focus)
herdr pane run "$(echo "$lazygit_json" | jq -r '.result.root_pane.pane_id')" lazygit

herdr tab create --workspace "$ws_id" --label zsh --no-focus > /dev/null
