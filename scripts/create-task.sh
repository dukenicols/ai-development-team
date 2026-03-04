#!/bin/bash
# Usage: ./scripts/create-task.sh <priority> <agent> <task_id> <slug>
# Example: ./scripts/create-task.sh p1 backend-developer T001 implement-statement-parser

set -euo pipefail

PRIORITY="${1:?Usage: create-task.sh <priority> <agent> <task_id> <slug>}"
AGENT="${2:?Missing agent name}"
TASK_ID="${3:?Missing task ID}"
SLUG="${4:?Missing task slug}"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

TASKS_DIR="communication/tasks"
TEMPLATE="communication/_templates/task.md"
FILENAME="${TASKS_DIR}/${PRIORITY}-open-${AGENT}-${TASK_ID}-${SLUG}.md"

if [ ! -d "$TASKS_DIR" ]; then
  mkdir -p "$TASKS_DIR"
fi

# Create task from template with placeholders replaced
sed \
  -e "s/{TASK_ID}/${TASK_ID}/g" \
  -e "s/{PRIORITY}/${PRIORITY}/g" \
  -e "s/{AGENT}/${AGENT}/g" \
  -e "s/{TIMESTAMP}/${TIMESTAMP}/g" \
  -e "s/{DOMAIN}/TBD/g" \
  -e "s/{HOURS}/TBD/g" \
  -e "s/{TITLE}/${SLUG}/g" \
  "$TEMPLATE" > "$FILENAME"

echo "Created task: $FILENAME"
