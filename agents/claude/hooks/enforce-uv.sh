#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)
[[ -z "$command" ]] && exit 0

check_command() {
  local cmd="$1"
  # Trim leading whitespace
  cmd="${cmd#"${cmd%%[! ]*}"}"
  # Get the binary name, strip any path prefix
  local first_word="${cmd%% *}"
  first_word="${first_word##*/}"

  case "$first_word" in
    pip|pip3)
      cat <<'MSG' >&2
BLOCKED: pip is not allowed. Use uv instead:

  uv add PACKAGE           # add dependency to project
  uv run --with PACKAGE cmd  # one-off dependency
  uv pip install PACKAGE   # pip-compatible interface
MSG
      return 1
      ;;
    poetry)
      cat <<'MSG' >&2
BLOCKED: poetry is not allowed. Use uv instead:

  uv add PACKAGE    # add dependency
  uv run COMMAND    # run in environment
  uv lock           # update lockfile
  uv init           # new project
MSG
      return 1
      ;;
    python|python3)
      cat <<'MSG' >&2
BLOCKED: direct python is not allowed. Use uv instead:

  uv run python ARGS          # run python
  uv run script.py            # run a script
  uv run --with PKG python CMD  # with extra deps
  uv run python -m MODULE     # run a module
MSG
      return 1
      ;;
  esac
  return 0
}

# Split on ; && || | to check each command in a chain
while IFS= read -r segment; do
  [[ -z "$segment" ]] && continue
  check_command "$segment" || exit 2
done < <(echo "$command" | sed 's/&&/\n/g; s/||/\n/g; s/|/\n/g; s/;/\n/g')

exit 0
