#!/bin/bash
# Usage: ./scripts/check-agent-status.sh [agent_name]
# Example: ./scripts/check-agent-status.sh backend-developer

STATUS_DIR="communication/status"
AGENT="${1:-}"

if [ -z "$AGENT" ]; then
  echo "=== All Agent Statuses ==="
  for f in "${STATUS_DIR}"/*.md; do
    name=$(basename "$f" .md)
    status=$(grep "^status:" "$f" | head -1 | awk '{print $2}')
    task=$(grep "^current_task:" "$f" | head -1 | awk '{print $2}')
    printf "%-25s %-12s %s\n" "$name" "$status" "$task"
  done
else
  FILE="${STATUS_DIR}/${AGENT}.md"
  if [ -f "$FILE" ]; then
    cat "$FILE"
  else
    echo "Error: No status file for agent '${AGENT}'"
    exit 1
  fi
fi
