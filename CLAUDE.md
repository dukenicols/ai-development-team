# AI Development Team Framework

## CRITICAL: Product Requirements Document
**Every agent MUST read `PRD.md` at the root of this project before starting any work.** The PRD is the single source of truth for what the product is, who it's for, what we're building, and in what order. All implementation decisions must align with the PRD.

## Project Overview
<!-- CUSTOMIZE: Replace this section with your product description -->
This project uses the AI Development Team Framework — a multi-agent coordination system where specialized AI agents collaborate to build software. Define your product in `PRD.md`, configure agents to match your tech stack, and use `/delegate` to assign work.

## Current Phase
<!-- CUSTOMIZE: Update this with your current development phase -->
See `PRD.md` for the full phased roadmap and current phase requirements.

## Project Structure
```
your-project/
├── backend/          # Backend application code
├── frontend/         # Frontend application code
├── communication/    # AI dev team coordination files
├── scripts/          # Helper scripts for agent workflow
├── PRD.md            # Product requirements document
└── CLAUDE.md         # This file
```

## Tech Stack
<!-- CUSTOMIZE: Update these to match your project's tech stack -->
- **Backend:** (define your backend stack)
- **Frontend:** (define your frontend stack)
- **Database:** (define your database)
- **Testing:** (define your testing tools)
- **Architecture:** (define your architecture patterns)

## AI Development Team

This project uses a multi-agent coordination framework. Agents communicate through markdown files in the `communication/` directory. **No agent relies on memory** — all state is persisted to files.

### Team Members
| Agent | Role |
|-------|------|
| `user-proxy` | Interprets user intent, asks clarifying questions |
| `project-manager` | Coordinates tasks, manages dependencies, monitors progress |
| `backend-developer` | Backend specialist |
| `frontend-developer` | Frontend specialist |
| `database-engineer` | Database and schema specialist |
| `qa-engineer` | Testing and quality assurance specialist |

### Communication Protocol

#### Directory Structure
```
communication/
├── tasks/           # Task assignments
├── messages/        # Inter-agent messages
├── status/          # Current agent states
├── domains/         # Domain knowledge
├── _templates/      # File templates
└── _index/          # Quick summaries
```

#### Task Filename Pattern
```
p{priority}-{status}-{agent}-{task_id}-{description}.md
```
Example: `p1-open-backend-developer-T001-implement-user-auth.md`

#### Message Filename Pattern
```
{timestamp}-{sender}-to-{recipient}-{status}-{type}.md
```
Example: `20251009-1030-project-manager-to-backend-developer-new-task_assigned.md`

### Agent Rules
1. **Always check for unread messages** before starting work
2. **Always read assigned task file** before implementing
3. **Update task status** when starting (`in_progress`) and finishing (`completed`)
4. **Send completion message** to project-manager when done
5. **Document decisions** in the relevant domain folder
6. **Never rely on memory** — read files for context

### Domain Ownership
<!-- CUSTOMIZE: Map your domains to agents -->
Domains are defined in `communication/domains/`. Each domain folder contains a README with business rules, schema decisions, and key concepts. Assign domain ownership based on your team's responsibilities.

### Commands
- `/delegate` — Delegate a task to the team

### Helper Scripts
```bash
./scripts/create-task.sh <priority> <agent> <task_id> <slug>     # Create a new task
./scripts/create-message.sh <from> <to> <type>                    # Send an inter-agent message
./scripts/update-task-status.sh <task_id> <new_status>            # Update task status
./scripts/list-tasks.sh [filter]                                   # List tasks (by status/agent/priority)
./scripts/list-unread-messages.sh <agent_name>                     # Check unread messages
./scripts/check-agent-status.sh [agent_name]                       # Check agent availability
./scripts/git-agent-commit.sh <agent> <task_id> <type> <scope> <msg>  # Agent-scoped git commit
./scripts/git-agent-merge.sh <branch-name>                         # Merge agent branch to main
```
