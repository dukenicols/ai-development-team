#!/bin/bash
# Usage: ./scripts/git-agent-merge.sh <branch-name> [branch-name-2] [branch-name-3] ...
# Example: ./scripts/git-agent-merge.sh backend-developer/T001-auth frontend-developer/T001-auth
#
# Merges one or more agent branches into main using --no-ff (preserves branch history).
# Merges branches in the order provided — put dependencies first.
# Stops on conflict and reports which branch caused it.
# Only the project-manager agent should use this script.

set -euo pipefail

if [ $# -eq 0 ]; then
  echo "Usage: git-agent-merge.sh <branch-name> [branch-name-2] ..."
  exit 1
fi

# Store current branch to return to if needed
CURRENT_BRANCH=$(git branch --show-current)
MERGED=()
FAILED=""

# Switch to main
git checkout main

for BRANCH in "$@"; do
  # Verify branch exists
  if ! git show-ref --verify --quiet "refs/heads/${BRANCH}"; then
    echo "Error: Branch '${BRANCH}' does not exist"
    echo ""
    echo "Available agent branches:"
    git branch | grep -E "^\s+\w+-\w+/" || echo "  (none)"
    FAILED="$BRANCH"
    break
  fi

  # Attempt merge
  if git merge --no-ff "$BRANCH" -m "$(cat <<EOF
merge: ${BRANCH} into main

Merged by: project-manager
EOF
)"; then
    echo "Merged ${BRANCH} into main"
    MERGED+=("$BRANCH")
  else
    echo ""
    echo "CONFLICT: Merge of '${BRANCH}' has conflicts."
    echo "Already merged: ${MERGED[*]:-none}"
    echo ""
    echo "Aborting this merge. Resolve conflicts manually or re-run after fixing."
    git merge --abort
    FAILED="$BRANCH"
    break
  fi
done

# Delete successfully merged branches
for BRANCH in "${MERGED[@]}"; do
  git branch -d "$BRANCH"
  echo "Deleted branch: ${BRANCH}"
done

# Summary
echo ""
echo "=== Merge Summary ==="
echo "Merged: ${MERGED[*]:-none}"
if [ -n "$FAILED" ]; then
  echo "Failed: ${FAILED}"
  exit 1
else
  echo "All branches merged successfully."
fi