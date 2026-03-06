# AI Development Team

## CRITICAL: Product Requirements Document
**Every agent MUST read `PRD.md` at the root of this project before starting any work.** The PRD is the single source of truth for what the product is, who it's for, what we're building, and in what order. All implementation decisions must align with the PRD.

## Project Overview
<!-- CUSTOMIZE: Replace this section with your product description -->
This project uses the AI Development Team — a multi-agent coordination system where specialized AI agents collaborate to build software. Define your product in `PRD.md`, configure agents to match your tech stack, and use `/delegate` to assign work.

## Current Phase
<!-- CUSTOMIZE: Update this with your current development phase -->
See `PRD.md` for the full phased roadmap and current phase requirements.

## Project Structure
```
your-project/
├── .claude/
│   ├── agents/          # Specialist agent definitions (with YAML frontmatter)
│   ├── skills/          # Custom skills (/delegate, /init-dev-team)
│   ├── settings.json    # Shared permissions, hooks, agent allowlist
│   └── settings.local.json  # Local overrides (gitignored)
├── backend/             # Backend application code
├── frontend/            # Frontend application code
├── communication/
│   └── domains/         # Domain knowledge and business rules
├── scripts/             # Git helper scripts
├── PRD.md               # Product requirements document
└── CLAUDE.md            # This file
```

## Tech Stack
<!-- CUSTOMIZE: Update these to match your project's tech stack -->
- **Backend:** (define your backend stack)
- **Frontend:** (define your frontend stack)
- **Database:** (define your database)
- **Testing:** (define your testing tools)
- **Architecture:** (define your architecture patterns)

## AI Development Team

This project uses a multi-agent coordination framework built on Claude Code's native subagent system. Agents are defined in `.claude/agents/` with YAML frontmatter controlling their tools, permissions, and isolation.

### Team Members
| Agent | Role | Isolation |
|-------|------|-----------|
| `user-proxy` | Interprets user intent, produces structured requirements | read-only (plan mode) |
| `project-manager` | Coordinates tasks, spawns specialist agents in parallel | standard |
| `backend-developer` | Backend APIs, business logic, server-side code | worktree |
| `frontend-developer` | UI components, responsive design, accessibility | worktree |
| `mobile-developer` | React Native / Expo mobile apps, native integrations | worktree |
| `database-engineer` | Schema design, migrations, query optimization | worktree |
| `qa-engineer` | Unit, integration, and E2E testing | worktree |

### How It Works

```
/delegate "Add user auth with OAuth"
  └─> user-proxy (clarifies + structures requirements)
        └─> project-manager (plans tasks, manages dependency graph)
              │
              ├─ Wave 0 (parallel background tasks):
              │   ├─> database-engineer (schema, in worktree)
              │   └─> qa-engineer (test scaffolds + plan, in worktree)
              │
              ├─ Wave 1 (after schema ready, launched as each dependency clears):
              │   ├─> backend-developer (APIs, in worktree)
              │   ├─> frontend-developer (UI, in worktree)
              │   └─> mobile-developer (mobile app, in worktree)
              │
              ├─ Wave 2 (after implementation):
              │   └─> qa-engineer (integration + E2E tests, in worktree)
              │
              └─ Final: merge all worktree branches → main
```

Agents run as **background tasks** via `TaskCreate`/`TaskGet` for true concurrent execution — the PM doesn't block waiting for one agent before launching the next. Specialist agents run in **git worktrees** for file-level isolation. Agents that finish early trigger their dependents immediately, without waiting for the full wave.

### Domain Knowledge
Domain knowledge lives in `communication/domains/`. Each domain folder contains a README with business rules, schema decisions, API contracts, and key concepts. All agents read these before implementing.

### Skills
| Skill | Description |
|-------|-------------|
| `/delegate` | Delegate a task to the development team |
| `/init-dev-team` | Bootstrap a new project with team configuration |

### Git Scripts
```bash
./scripts/git-agent-commit.sh <agent> <task_id> <type> <scope> <msg>  # Agent-scoped git commit
./scripts/git-agent-merge.sh <branch-1> [branch-2] [branch-3] ...     # Batch merge agent branches to main
```

### Hooks
Configured in `.claude/settings.json`:
- **SubagentStop** — logs agent completions to `.claude/agent-activity.log`

### Agent Design Principles
1. **Agents are stateless** — they read PRD.md, CLAUDE.md, and domain docs for context every time
2. **Worktree isolation** — specialist agents work on isolated git branches to prevent conflicts
3. **Background task parallelism** — the PM uses TaskCreate/TaskGet for true concurrent agent execution
4. **Dependency-driven scheduling** — agents launch as soon as their dependencies clear, not in fixed waves
5. **Early QA** — test scaffolds and plans are written in parallel with implementation, not just after
6. **Automated merge coordination** — the PM merges all worktree branches in dependency order after completion
7. **Domain docs are the shared memory** — `communication/domains/` is the only persistent inter-agent state
