#!/bin/bash
# Usage: ./scripts/list-unread-messages.sh <agent_name>
# Example: ./scripts/list-unread-messages.sh backend-developer

set -euo pipefail

AGENT="${1:?Usage: list-unread-messages.sh <agent_name>}"
MESSAGES_DIR="communication/messages"

echo "=== Unread messages for ${AGENT} ==="
find "$MESSAGES_DIR" -name "*-to-${AGENT}-new-*.md" 2>/dev/null | sort | while read -r f; do
  echo "  $(basename "$f")"
done

COUNT=$(find "$MESSAGES_DIR" -name "*-to-${AGENT}-new-*.md" 2>/dev/null | wc -l | tr -d ' ')
echo ""
echo "Total unread: ${COUNT}"
