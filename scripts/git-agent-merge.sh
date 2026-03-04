#!/bin/bash
# Usage: ./scripts/git-agent-merge.sh <branch-name>
# Example: ./scripts/git-agent-merge.sh backend-developer/T001-statements
#
# Merges an agent branch into main using --no-ff (preserves branch history).
# Only the project-manager agent should use this script.

set -euo pipefail

BRANCH="${1:?Usage: git-agent-merge.sh <branch-name>}"

# Verify branch exists
if ! git show-ref --verify --quiet "refs/heads/${BRANCH}"; then
  echo "Error: Branch '${BRANCH}' does not exist"
  echo ""
  echo "Available agent branches:"
  git branch | grep -E "^\s+\w+-\w+/" || echo "  (none)"
  exit 1
fi

# Store current branch to return to it if not main
CURRENT_BRANCH=$(git branch --show-current)

# Switch to main and merge
git checkout main
git merge --no-ff "$BRANCH" -m "$(cat <<EOF
merge: ${BRANCH} into main

Merged by: project-manager
EOF
)"

echo "Merged ${BRANCH} into main"

# Delete the merged branch
git branch -d "$BRANCH"
echo "Deleted branch: ${BRANCH}"
