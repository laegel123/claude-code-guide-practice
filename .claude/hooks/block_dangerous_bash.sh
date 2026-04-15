#!/usr/bin/env bash
# Claude Code PreToolUse hook: blocks dangerous Bash commands.
# Exit 0 with JSON output to deny or allow.

set -euo pipefail

input="$(cat)"
cmd="$(echo "$input" | jq -r '.tool_input.command // ""')"

deny() {
  local reason="$1"
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}' "$reason"
  exit 0
}

# 1. rm -rf (any variant)
if echo "$cmd" | grep -qE 'rm\s+(-[a-zA-Z]*f[a-zA-Z]*r[a-zA-Z]*|-[a-zA-Z]*r[a-zA-Z]*f[a-zA-Z]*)\s'; then
  deny "rm -rf는 위험한 명령입니다. 실행이 차단되었습니다."
fi
if echo "$cmd" | grep -qP 'rm\s+.*--force\b' 2>/dev/null || \
   echo "$cmd" | grep -qE 'rm\s+.*-rf|rm\s+.*-fr'; then
  deny "rm -rf는 위험한 명령입니다. 실행이 차단되었습니다."
fi

# 2. DROP TABLE (case-insensitive)
if echo "$cmd" | grep -qiE 'DROP\s+TABLE'; then
  deny "DROP TABLE은 위험한 SQL 명령입니다. 실행이 차단되었습니다."
fi

# 3. git push --force / -f
if echo "$cmd" | grep -qE 'git\s+push\b.*(\s--force\b|\s-f\b)'; then
  deny "git push --force는 위험한 명령입니다. 실행이 차단되었습니다."
fi

# Safe: allow
exit 0
