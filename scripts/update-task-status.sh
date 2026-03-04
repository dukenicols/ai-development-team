#!/bin/bash
# Usage: ./scripts/update-task-status.sh <task_id> <new_status>
# Example: ./scripts/update-task-status.sh T001 in_progress
# Statuses: open, in_progress, blocked, completed

set -euo pipefail

TASK_ID="${1:?Usage: update-task-status.sh <task_id> <new_status>}"
NEW_STATUS="${2:?Missing new status (open|in_progress|blocked|completed)}"
TASKS_DIR="communication/tasks"

# Find the task file
TASK_FILE=$(ls "${TASKS_DIR}"/*-"${TASK_ID}"-*.md 2>/dev/null | head -1)

if [ -z "$TASK_FILE" ]; then
  echo "Error: No task found with ID ${TASK_ID}"
  exit 1
fi

# Extract current status from filename
BASENAME=$(basename "$TASK_FILE")
# Pattern: p{priority}-{status}-{agent}-{task_id}-{slug}.md
CURRENT_STATUS=$(echo "$BASENAME" | cut -d'-' -f2)

# Build new filename by replacing status
NEW_BASENAME=$(echo "$BASENAME" | sed "s/-${CURRENT_STATUS}-/-${NEW_STATUS}-/")
NEW_FILE="${TASKS_DIR}/${NEW_BASENAME}"

# Update status in file content
sed -i '' "s/status: .*/status: ${NEW_STATUS}/" "$TASK_FILE"

# Rename file
mv "$TASK_FILE" "$NEW_FILE"

echo "Updated ${TASK_ID}: ${CURRENT_STATUS} → ${NEW_STATUS}"
echo "File: ${NEW_FILE}"
