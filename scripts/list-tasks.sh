#!/bin/bash
# Usage: ./scripts/list-tasks.sh [filter]
# Examples:
#   ./scripts/list-tasks.sh                    # all tasks
#   ./scripts/list-tasks.sh open               # by status
#   ./scripts/list-tasks.sh backend-developer  # by agent
#   ./scripts/list-tasks.sh p1                 # by priority

TASKS_DIR="communication/tasks"
FILTER="${1:-}"

if [ -z "$FILTER" ]; then
  echo "=== All Tasks ==="
  ls -1 "${TASKS_DIR}"/*.md 2>/dev/null | while read -r f; do
    basename "$f"
  done
else
  echo "=== Tasks matching: ${FILTER} ==="
  ls -1 "${TASKS_DIR}"/*"${FILTER}"*.md 2>/dev/null | while read -r f; do
    basename "$f"
  done
fi

# Summary counts
echo ""
echo "=== Summary ==="
echo "Open:        $(ls "${TASKS_DIR}"/*-open-*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "In Progress: $(ls "${TASKS_DIR}"/*-in_progress-*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "Blocked:     $(ls "${TASKS_DIR}"/*-blocked-*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "Completed:   $(ls "${TASKS_DIR}"/*-completed-*.md 2>/dev/null | wc -l | tr -d ' ')"
