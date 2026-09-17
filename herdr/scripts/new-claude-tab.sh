#!/bin/sh
set -e
tab_json=$(herdr tab create --label claude --focus)
pane_id=$(echo "$tab_json" | jq -r '.result.root_pane.pane_id')
herdr agent start "claude-$(date +%s)" --kind claude --pane "$pane_id"
