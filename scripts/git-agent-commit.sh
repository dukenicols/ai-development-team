#!/bin/bash
# Usage: ./scripts/git-agent-commit.sh <agent-name> <task-id> <commit-type> <scope> <message>
# Example: ./scripts/git-agent-commit.sh backend-developer T001 feat auth "add user authentication"
#
# This script:
# 1. Validates the agent name against known agents
# 2. Checks that all staged files are within the agent's allowed paths
# 3. Creates the branch if it doesn't exist (agent/task-id-scope format)
# 4. Commits with conventional commit format
#
# Compatible with macOS bash 3.2+ (no associative arrays)

set -euo pipefail

AGENT="${1:?Usage: git-agent-commit.sh <agent> <task-id> <type> <scope> <message>}"
TASK_ID="${2:?Missing task ID}"
COMMIT_TYPE="${3:?Missing commit type (feat|fix|refactor|test|docs|chore)}"
SCOPE="${4:?Missing scope}"
MESSAGE="${5:?Missing commit message}"

# Get allowed paths per agent (macOS bash 3.2 compatible — no associative arrays)
get_allowed_paths() {
  case "$1" in
    backend-developer)
      echo "backend/"
      ;;
    frontend-developer)
      echo "frontend/"
      ;;
    database-engineer)
      echo "backend/prisma/ communication/domains/"
      ;;
    qa-engineer)
      echo ".test. tests/ e2e/"
      ;;
    project-manager)
      echo "communication/"
      ;;
    user-proxy)
      echo "communication/messages/ communication/domains/"
      ;;
    *)
      echo ""
      ;;
  esac
}

ALLOWED=$(get_allowed_paths "$AGENT")

if [ -z "$ALLOWED" ]; then
  echo "Error: Unknown agent '$AGENT'"
  echo "Valid agents: backend-developer, frontend-developer, database-engineer, qa-engineer, project-manager, user-proxy"
  exit 1
fi

# Validate commit type
case "$COMMIT_TYPE" in
  feat|fix|refactor|test|docs|chore)
    ;;
  *)
    echo "Error: Invalid commit type '$COMMIT_TYPE'"
    echo "Valid types: feat, fix, refactor, test, docs, chore"
    exit 1
    ;;
esac

# Check staged files are within allowed paths
STAGED_FILES=$(git diff --cached --name-only)
if [ -z "$STAGED_FILES" ]; then
  echo "Error: No files staged for commit"
  exit 1
fi

for FILE in $STAGED_FILES; do
  ALLOWED_FLAG=false
  for PATH_PATTERN in $ALLOWED; do
    if echo "$FILE" | grep -q "$PATH_PATTERN"; then
      ALLOWED_FLAG=true
      break
    fi
  done
  if [ "$ALLOWED_FLAG" = false ]; then
    echo "Error: Agent '$AGENT' is not allowed to modify '$FILE'"
    echo "Allowed paths: $ALLOWED"
    exit 1
  fi
done

# Create/checkout agent branch
BRANCH="${AGENT}/${TASK_ID}-${SCOPE}"
CURRENT_BRANCH=$(git branch --show-current)

if ! git show-ref --verify --quiet "refs/heads/${BRANCH}"; then
  git checkout -b "$BRANCH"
  echo "Created new branch: $BRANCH"
else
  if [ "$CURRENT_BRANCH" != "$BRANCH" ]; then
    git checkout "$BRANCH"
  fi
fi

# Commit with conventional format
git commit -m "$(cat <<EOF
${COMMIT_TYPE}(${SCOPE}): ${MESSAGE}

Agent: ${AGENT}
Task: ${TASK_ID}
EOF
)"

echo ""
echo "Committed to branch: $BRANCH"
echo "Message: ${COMMIT_TYPE}(${SCOPE}): ${MESSAGE}"
