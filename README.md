# AI Development Team Framework

A Claude Code plugin that turns a single AI assistant into a team of specialized agents — backend developer, frontend developer, database engineer, QA engineer — all coordinating through Claude Code's native subagent system.

Instead of one agent context-switching between concerns, you get focused specialists that work in parallel in isolated git worktrees, with structured handoffs and domain knowledge.

## How It Works

```
You ──> /delegate "Add user auth with OAuth"
         │
         ├─> user-proxy (clarifies requirements, read-only)
         │     └─> project-manager (breaks into tasks, coordinates)
         │           ├─> backend-developer (APIs, in worktree)
         │           ├─> database-engineer (schema, in worktree)
         │           ├─> frontend-developer (UI, in worktree)
         │           └─> qa-engineer (tests, in worktree)
         │
         └─> Results reported back with summary
```

## Installation

### As a Plugin (recommended)

Install once, use in any project. Agents, skills, and hooks are provided by the plugin — only project-specific files (CLAUDE.md, PRD.md, domain docs) live in your repo.

```bash
# Add the marketplace
/plugin marketplace add dukenicols/ai-development-team-framework

# Install the plugin
/plugin install ai-dev-team-framework@ai-dev-team

# Enable for your project
/plugin enable ai-dev-team-framework --scope project
```

**Updating:**
```bash
/plugin update ai-dev-team-framework@ai-dev-team
```

When the plugin is updated, all your projects get the latest agents, skills, and hooks automatically. Your project-specific files (CLAUDE.md, PRD.md, domain docs) are untouched.

### As a Template (clone)

Fork or clone the repo to start a new project from scratch:

```bash
git clone https://github.com/dukenicols/ai-development-team-framework.git my-project
cd my-project
claude
```

With this approach, agents and skills live inside your repo in `.claude/agents/` and `.claude/skills/`. You manage updates manually.

## Getting Started

### 1. Initialize your team

```
/init-dev-team
```

Claude will ask about your project name, tech stack, architecture, and domains, then generate:
- `CLAUDE.md` — project configuration with your tech stack
- `PRD.md` — product requirements template
- `communication/domains/` — domain knowledge folders
- `scripts/` — git helper scripts

### 2. Fill in your PRD

Open `PRD.md` and define your product requirements — vision, target users, phased roadmap, data model, and success metrics.

### 3. Start building

```
/delegate Implement user registration with email and password
```

## Architecture

### Native Subagents with YAML Frontmatter

Each agent is a Markdown file with YAML frontmatter that controls tools, permissions, and isolation:

```yaml
---
description: "When to use this agent"
tools: [Read, Write, Edit, Bash]
isolation: worktree
maxTurns: 30
---
```

### Worktree Isolation

Specialist agents run in isolated git worktrees — each gets its own branch and working directory. No conflicts when multiple agents work simultaneously.

### Direct Communication

Subagents return results directly to their parent. No file polling, no message queues. The project-manager aggregates results and returns a summary.

### Domain Knowledge

`communication/domains/` is the shared state between agents. Each domain folder has business rules, schema decisions, and API contracts that agents read before implementing.

## What's in the Plugin

```
ai-development-team-framework/
├── .claude-plugin/
│   ├── plugin.json              # Plugin metadata
│   └── marketplace.json         # Marketplace listing
├── agents/                      # 6 specialist agents
│   ├── user-proxy.md           #   Read-only, interprets intent
│   ├── project-manager.md      #   Coordinates, spawns agents
│   ├── backend-developer.md    #   Backend, worktree isolated
│   ├── frontend-developer.md   #   Frontend, worktree isolated
│   ├── database-engineer.md    #   Database, worktree isolated
│   └── qa-engineer.md          #   Testing, worktree isolated
├── skills/                      # 2 skills (slash commands)
│   ├── delegate/SKILL.md       #   /delegate — assign work
│   └── init-dev-team/SKILL.md  #   /init-dev-team — bootstrap
├── hooks/hooks.json             # SubagentStop logging
├── settings.json                # Permissions allowlist
├── scripts/                     # Git helpers (copied to projects)
│   ├── git-agent-commit.sh
│   └── git-agent-merge.sh
├── templates/                   # Templates for /init-dev-team
│   ├── CLAUDE.md.template
│   └── PRD.md.template
└── communication/
    └── _templates/
        └── domain-readme.md     # Domain folder template
```

## What Lives in Your Project

After running `/init-dev-team`, your project gets only project-specific files:

```
your-project/
├── CLAUDE.md                    # Your project config
├── PRD.md                       # Your product requirements
├── communication/
│   └── domains/                 # Your domain knowledge
│       ├── Users/README.md
│       └── Products/README.md
├── scripts/                     # Git helpers (copied from plugin)
│   ├── git-agent-commit.sh
│   └── git-agent-merge.sh
├── backend/                     # Your code
├── frontend/                    # Your code
└── .gitignore
```

Agents, skills, hooks, and permissions are all provided by the plugin — not duplicated in your repo.

## The Agent Team

| Agent | Role | Tools | Isolation |
|-------|------|-------|-----------|
| **user-proxy** | Interprets intent, structures requirements | Read-only | plan mode |
| **project-manager** | Breaks down work, coordinates parallel execution | Read + Write + Agent | standard |
| **backend-developer** | APIs, business logic, server-side code | Full coding | worktree |
| **frontend-developer** | UI components, responsive design, accessibility | Full coding | worktree |
| **database-engineer** | Schema design, migrations, query optimization | Full coding | worktree |
| **qa-engineer** | Unit, integration, and E2E tests | Full coding | worktree |

## Customization

### Adding Agents

Create `.claude/agents/your-agent.md` in your project (overrides plugin agents of the same name):

```yaml
---
description: "When to delegate to this agent"
tools: [Read, Write, Edit, Bash]
isolation: worktree
maxTurns: 20
---

Your agent instructions...
```

### Adding Domains

Create `communication/domains/YourDomain/README.md` in your project.

### Adding Skills

Create `.claude/skills/your-skill/SKILL.md` in your project.

## Credits

Based on the multi-agent coordination pattern described by [Mohammed H. Jabreel](https://medium.com/@mohammedhjabreel/how-i-built-an-ai-development-team-on-top-of-claude-code-ce0b49c78eb1), modernized to use Claude Code's native plugin and subagent system.

## License

MIT
