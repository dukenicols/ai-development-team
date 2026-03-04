#!/bin/bash
# Usage: ./scripts/create-message.sh <from> <to> <type>
# Example: ./scripts/create-message.sh project-manager backend-developer task_assigned

set -euo pipefail

FROM="${1:?Usage: create-message.sh <from> <to> <type>}"
TO="${2:?Missing recipient}"
TYPE="${3:?Missing message type}"
TIMESTAMP=$(date -u +"%Y%m%d-%H%M")
DATE_DIR=$(date -u +"%Y%m%d")

MESSAGES_DIR="communication/messages/${DATE_DIR}"
FILENAME="${MESSAGES_DIR}/${TIMESTAMP}-${FROM}-to-${TO}-new-${TYPE}.md"

mkdir -p "$MESSAGES_DIR"

cat > "$FILENAME" << EOF
---
from: ${FROM}
to: ${TO}
type: ${TYPE}
status: new
created: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
related_task: TBD
---

# ${TYPE}

## Content
[Fill in message content]

## Action Required
[Describe what the recipient should do]

## Context
[Relevant background information]
EOF

echo "Created message: $FILENAME"
