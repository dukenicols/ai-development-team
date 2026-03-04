# AI Development Team Framework

A multi-agent coordination framework for [Claude Code](https://claude.ai/code) that turns a single AI assistant into a team of specialized agents — backend developer, frontend developer, database engineer, QA engineer — all coordinating through structured markdown files.

Instead of one agent context-switching between concerns, you get focused specialists that work in parallel, track dependencies, and never lose context between sessions.

## How It Works

```
You ──> /delegate "Add user auth with OAuth"
         │
         ├─> user-proxy (clarifies requirements)
         │     └─> project-manager (breaks into tasks)
         │           ├─> backend-developer (API + business logic)
         │           ├─> database-engineer (schema + migrations)
         │           ├─> frontend-developer (UI components)
         │           └─> qa-engineer (tests)
         │
         └─> Results reported back with summary
```

Agents communicate through markdown files in `communication/` — no memory, no context window tricks. Everything is persisted, version-controlled, and human-readable.

## Quick Start

### 1. Clone the framework

```bash
git clone https://github.com/yourusername/ai-development-team-framework.git my-project
cd my-project
```

### 2. Open in Claude Code

```bash
claude
```

### 3. Initialize your team

```
/init-dev-team
```

Claude will ask about your:
- **Project name** and description
- **Tech stack** (backend, frontend, database, testing tools)
- **Architecture pattern** (Clean Architecture, MVC, Hexagonal, etc.)
- **Key domains** (Users, Products, Orders, etc.)
- **UI language/locale**

Then it automatically configures all agent files, creates domain folders, and fills in `CLAUDE.md` and `PRD.md` with your specifics.

### 4. Fill in your PRD

Open `PRD.md` and define your product requirements — vision, target users, phased roadmap, data model, and success metrics. This is the single source of truth that all agents reference.

### 5. Start building

```
/delegate Implement user registration with email and password
```

Or just describe what you want directly — the user-proxy agent will interpret your intent and coordinate the team.

## Project Structure

```
your-project/
├── .claude/
│   ├── agents/              # Specialist agent configurations
│   │   ├── user-proxy.md
│   │   ├── project-manager.md
│   │   ├── backend-developer.md
│   │   ├── frontend-developer.md
│   │   ├── database-engineer.md
│   │   └── qa-engineer.md
│   └── commands/            # Custom slash commands
│       ├── init-dev-team.md # Bootstrap a new project
│       └── delegate.md      # Delegate work to the team
├── communication/           # Agent coordination (all state lives here)
│   ├── tasks/               # Task assignments and status
│   ├── messages/            # Inter-agent messages
│   ├── status/              # Agent availability
│   ├── domains/             # Domain knowledge and business rules
│   ├── _templates/          # File templates for consistency
│   └── _index/              # Quick summaries
├── scripts/                 # Helper bash scripts
├── CLAUDE.md                # Project config (agents read this first)
└── PRD.md                   # Product requirements document
```

## The Agent Team

| Agent | Role | When It's Invoked |
|-------|------|-------------------|
| **user-proxy** | Interprets your intent, asks clarifying questions, translates business needs into technical requirements | First — receives your request |
| **project-manager** | Breaks requirements into tasks, manages dependencies, coordinates parallel work, reports completion | Second — plans the work |
| **backend-developer** | APIs, business logic, server-side code following your architecture patterns | Specialist — implements backend |
| **frontend-developer** | UI components, responsive design, accessibility, frontend framework patterns | Specialist — implements frontend |
| **database-engineer** | Schema design, migrations, indexes, query optimization | Specialist — implements database |
| **qa-engineer** | Unit tests, integration tests, E2E tests, test strategy | Specialist — writes tests |

## Communication Protocol

Agents coordinate through files, not memory. This means:

- **No context lost** — restart anytime without losing state
- **Full auditability** — complete history of who did what and why
- **Git-friendly** — track all decisions with version control
- **Human-readable** — just open the markdown files

### Filename-Based Metadata

Critical information is encoded in filenames for instant lookups via glob patterns:

```bash
# Task files
p1-open-backend-developer-T001-implement-auth.md
│  │    │                  │     └─ Description
│  │    │                  └─────── Task ID
│  │    └────────────────────────── Assigned agent
│  └─────────────────────────────── Status (open/in_progress/blocked/completed)
└────────────────────────────────── Priority (p1/p2/p3)

# Message files
20251009-1030-project-manager-to-backend-developer-new-task_assigned.md
│             │                   │                 │    └─ Type
│             │                   │                 └────── Status
│             │                   └──────────────────────── Recipient
│             └──────────────────────────────────────────── Sender
└────────────────────────────────────────────────────────── Timestamp
```

```bash
# Find all tasks for an agent
ls communication/tasks/*-backend-developer-*.md

# Find all blocked tasks
ls communication/tasks/*-blocked-*.md

# Find unread messages
ls communication/messages/*/*-to-backend-developer-new-*.md
```

## Helper Scripts

```bash
./scripts/create-task.sh <priority> <agent> <task_id> <slug>          # Create a new task
./scripts/create-message.sh <from> <to> <type>                         # Send inter-agent message
./scripts/update-task-status.sh <task_id> <new_status>                 # Update task status
./scripts/list-tasks.sh [filter]                                        # List tasks (by status/agent/priority)
./scripts/list-unread-messages.sh <agent_name>                          # Check unread messages
./scripts/check-agent-status.sh [agent_name]                            # Check agent availability
./scripts/git-agent-commit.sh <agent> <task_id> <type> <scope> <msg>   # Agent-scoped git commit
./scripts/git-agent-merge.sh <branch-name>                              # Merge agent branch to main
```

## When to Use This Framework

**Use it when:**
- Multiple domains are involved (backend + frontend + database)
- Dependencies exist between tasks
- You want structured coordination and audit trails
- Long-running projects need persistent context across sessions

**Skip it when:**
- Simple single-file changes
- Quick bug fixes
- Tasks a single Claude Code session handles easily

## Customization

### Adding Agents

Create a new file in `.claude/agents/your-agent.md` with:
- Role description
- Tech stack expertise
- Workflow steps (check messages, read task, update status, implement, report)

Then add the agent to the team table in `project-manager.md` and `CLAUDE.md`.

### Adding Domains

Create `communication/domains/YourDomain/README.md` with:
- Overview and key concepts
- Business rules
- Schema decisions (filled in as development progresses)

### Adding Commands

Create `.claude/commands/your-command.md` with instructions for what Claude should do when the command is invoked.

## Design Decisions

**Why files instead of a database?** Simplicity, portability, git integration, zero dependencies, human-readable.

**Why markdown?** Structured (YAML frontmatter + markdown body), universal tooling support, readable by both humans and machines.

**Why filename metadata?** Glob patterns are faster than reading every file. `ls *-blocked-*.md` beats parsing YAML in 16 files.

## Credits

Based on the multi-agent coordination pattern described by [Mohammed H. Jabreel](https://medium.com/@mohammedhjabreel/how-i-built-an-ai-development-team-on-top-of-claude-code-ce0b49c78eb1).

## License

MIT
