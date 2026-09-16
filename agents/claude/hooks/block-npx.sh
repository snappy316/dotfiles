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
    npx|pnpx|bunx)
      echo "BLOCKED: $first_word is not allowed due to npm supply chain attack policy. Use the internal package registry proxy instead." >&2
      return 1
      ;;
    bun)
      if echo "$cmd" | grep -qE '^bun\s+x\b'; then
        echo "BLOCKED: bun x is not allowed due to npm supply chain attack policy. Use the internal package registry proxy instead." >&2
        return 1
      fi
      ;;
    npm)
      if echo "$cmd" | grep -qE '^npm\s+(exec|x)\b'; then
        echo "BLOCKED: npm exec is not allowed due to npm supply chain attack policy. Use the internal package registry proxy instead." >&2
        return 1
      fi
      ;;
    pnpm)
      if echo "$cmd" | grep -qE '^pnpm\s+dlx\b'; then
        echo "BLOCKED: pnpm dlx is not allowed due to npm supply chain attack policy. Use the internal package registry proxy instead." >&2
        return 1
      fi
      ;;
    yarn)
      if echo "$cmd" | grep -qE '^yarn\s+dlx\b'; then
        echo "BLOCKED: yarn dlx is not allowed due to npm supply chain attack policy. Use the internal package registry proxy instead." >&2
        return 1
      fi
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
