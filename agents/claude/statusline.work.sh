#!/bin/bash
# Work-only statusline additions, linked to ~/.claude/statusline.local.sh by the work profile.
# Called after the shared statusline.sh with the same Claude Code status JSON on stdin.

input=$(cat)

# ANSI colors (match shared statusline)
YELLOW='\033[33m'
RED='\033[31m'
DIM='\033[2m'
RESET='\033[0m'

costs_script="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/plugins/marketplaces/planning-center/plugins/statusline/scripts/statusline.py"
[ -f "$costs_script" ] || exit 0

costs=$(echo "$input" | python3 "$costs_script" --costs-json 2>/dev/null) || exit 0

session=$(echo "$costs" | jq -r '.session_usd')
today=$(echo "$costs" | jq -r '.today_usd')
month=$(echo "$costs" | jq -r '.month_usd')
today_pct=$(echo "$costs" | jq -r '.daily_budget_used_percentage')
month_pct=$(echo "$costs" | jq -r '.monthly_budget_used_percentage')
unpriced=$(echo "$costs" | jq -r '.unpriced_models | join(",")')

# --- Formatting helpers ---

budget_color() {
  local pct=${1%.*}
  if [ "$pct" -ge 90 ]; then printf "%s" "$RED"
  elif [ "$pct" -ge 75 ]; then printf "%s" "$YELLOW"; fi
}

# --- Line: session / today / month-to-date spend ---
printf "%bsession:%b \$%.2f  |  %btoday:%b %b\$%.2f (%.0f%%)%b  |  %bmtd:%b %b\$%.2f (%.0f%%)%b" \
  "$DIM" "$RESET" "$session" \
  "$DIM" "$RESET" "$(budget_color "$today_pct")" "$today" "$today_pct" "$RESET" \
  "$DIM" "$RESET" "$(budget_color "$month_pct")" "$month" "$month_pct" "$RESET"
[ -n "$unpriced" ] && printf "  %b(unpriced: %s)%b" "$YELLOW" "$unpriced" "$RESET"
printf "\n"
