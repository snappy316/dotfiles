#!/bin/bash
# Claude Code status line — inspired by Rands' setup
# Reads JSON from stdin, outputs a multi-line status bar

input=$(cat)

# Debug: dump raw JSON to temp file for inspection (remove when done)
echo "$input" | jq . > /tmp/claude-statusline-debug.json 2>/dev/null

# ANSI colors
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
RED='\033[31m'
CYAN='\033[36m'
DIM='\033[2m'
RESET='\033[0m'

# --- Extract data via jq ---
model_id=$(echo "$input" | jq -r '.model.id // ""')
model_name=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
remain_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // 100')

# Token counts
total_tokens=$(echo "$input" | jq '
  (.context_window.current_usage //
    {input_tokens:0, output_tokens:0, cache_creation_input_tokens:0, cache_read_input_tokens:0})
  | .input_tokens + .output_tokens + .cache_creation_input_tokens + .cache_read_input_tokens
')
total_tokens=${total_tokens:-0}

# Rate limits
current_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
weekly_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
current_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
weekly_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')


# Git / directory info
cwd=$(echo "$input" | jq -r '.workspace.current_dir // ""')
short_dir=$(echo "$cwd" | sed "s|^$HOME|~|")
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null || echo "detached")
  dirty=""
  if ! git -C "$cwd" diff --quiet 2>/dev/null || ! git -C "$cwd" diff --cached --quiet 2>/dev/null; then
    dirty="*"
  fi
  git_info=" on ${branch}${dirty}"
fi

# --- Formatting helpers ---

# Model version from ID
case "$model_id" in
  *opus-4-6*)   model_ver="Opus 4.6" ;;
  *sonnet-4-6*) model_ver="Sonnet 4.6" ;;
  *haiku-4-5*)  model_ver="Haiku 4.5" ;;
  *)            model_ver="$model_name" ;;
esac

# Context size label
if [ "$ctx_size" -ge 1000000 ]; then
  ctx_label="1M context"
  ctx_short=$(awk "BEGIN {printf \"%.1fm\", $ctx_size/1000000}")
else
  ctx_short=$(awk "BEGIN {printf \"%.0fk\", $ctx_size/1000}")
  ctx_label="${ctx_short} context"
fi

# Token display
if [ "$total_tokens" -ge 1000 ]; then
  tokens_short=$(awk "BEGIN {printf \"%.0fk\", $total_tokens/1000}")
else
  tokens_short="$total_tokens"
fi
used_int=$(printf "%.0f" "$used_pct")

# Gauge: 9 circles, filled proportional to percentage, colored by severity
gauge() {
  local pct=${1:-0}
  local total=9
  local filled=$(awk "BEGIN {v=int($pct * $total / 100 + 0.5); if(v>$total) v=$total; print v}")
  local empty=$((total - filled))

  local color
  if [ "$pct" -lt 50 ]; then color="$GREEN"
  elif [ "$pct" -lt 80 ]; then color="$YELLOW"
  else color="$RED"; fi

  local bar=""
  for ((i=0; i<filled; i++)); do bar+="●"; done
  for ((i=0; i<empty; i++)); do bar+="○"; done
  printf "%b%s%b" "$color" "$bar" "$RESET"
}

# --- Line 1: Directory + git + model + context ---
printf "%b%s%s%b  |  %b%s (%s)%b  |  %b%s / %s%b (%b%s%%%b)\n" \
  "$CYAN" "$short_dir" "$git_info" "$RESET" \
  "$GREEN" "$model_ver" "$ctx_label" "$RESET" \
  "$YELLOW" "$tokens_short" "$ctx_short" "$RESET" \
  "$BLUE" "$used_int" "$RESET"

# --- Line 2: Rate limits + reset times (only if data available) ---
if [ -n "$current_pct" ]; then
  cur_int=$(printf "%.0f" "$current_pct")
  wk_int=$(printf "%.0f" "${weekly_pct:-0}")

  # macOS date uses %l for non-padded 12-hour, %p for AM/PM
  cur_reset_fmt=""
  if [ -n "$current_reset" ]; then
    cur_reset_fmt=$(date -r "$current_reset" "+%l:%M%p" 2>/dev/null | tr '[:upper:]' '[:lower:]' | sed 's/^ //')
  fi
  wk_reset_fmt=""
  if [ -n "$weekly_reset" ]; then
    wk_reset_fmt=$(date -r "$weekly_reset" "+%b %e, %l:%M%p" 2>/dev/null | tr '[:upper:]' '[:lower:]' | sed 's/  / /g; s/^ //')
  fi

  printf "current: %s %s%%" "$(gauge "$cur_int")" "$cur_int"
  [ -n "$cur_reset_fmt" ] && printf "  %b(resets %s)%b" "$DIM" "$cur_reset_fmt" "$RESET"
  printf "  |  weekly: %s %s%%" "$(gauge "$wk_int")" "$wk_int"
  [ -n "$wk_reset_fmt" ] && printf "  %b(resets %s)%b" "$DIM" "$wk_reset_fmt" "$RESET"
  printf "\n"
fi
