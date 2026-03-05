---
name: init-dev-team
description: Initialize AI Development Team for a new project
user-invocable: true
---

# Initialize AI Development Team

When the user runs `/init-dev-team`, follow this interactive workflow to bootstrap the project.

The plugin templates are at `${CLAUDE_PLUGIN_ROOT}/templates/`. Use them as a starting point.

## Step 1: Gather Project Information

Ask the user the following questions (you can ask them all at once or conversationally):

1. **Project name** — "What's your project name?"
2. **Project description** — "Describe your project in 1-2 sentences. What does it do and who is it for?"
3. **Tech stack** — "What tech stack are you using?" (Ask for specifics:)
   - Backend framework & language (e.g., Node.js + Express, Python + Django, Go + Gin)
   - Frontend framework (e.g., React 18, Vue 3, Next.js, SvelteKit)
   - Database (e.g., PostgreSQL, MySQL, MongoDB, SQLite)
   - ORM/query builder (e.g., Prisma, Drizzle, SQLAlchemy, TypeORM)
   - Testing tools (e.g., Vitest, Jest, Pytest, Playwright)
   - Package manager (e.g., npm, pnpm, bun, pip, cargo)
4. **Architecture pattern** — "What architecture pattern do you want to follow?" (e.g., Clean Architecture, MVC, Hexagonal, Layered, Modular Monolith)
5. **Key domains** — "What are the key domains/modules in your project?" (e.g., Users, Products, Orders, Payments, Notifications)
6. **Language/locale** — "What language should the UI be in?" (default: English)

## Step 2: Create/Update All Files

Once you have the answers, create **every** file listed below in the user's project. Do NOT leave any `<!-- CUSTOMIZE -->` placeholders or `(define your ...)` text — fill everything in with the user's specifics.

### 2.1: Create `CLAUDE.md`

Read the template at `${CLAUDE_PLUGIN_ROOT}/templates/CLAUDE.md.template`, then create `CLAUDE.md` in the project root with:
- Project name as the heading
- The user's project description in the Overview section
- Current phase (default: "Phase 1 — see PRD.md")
- Full tech stack details filled in
- Project structure updated to match their stack
- Domain ownership mapped to agents
- Remove all `<!-- CUSTOMIZE -->` comments

### 2.2: Create `PRD.md`

Read the template at `${CLAUDE_PLUGIN_ROOT}/templates/PRD.md.template`, then create `PRD.md` in the project root with the project name, description, and template structure. Pre-fill what you can from the user's answers.

### 2.3: Create Domain Folders

For each domain the user specified:
1. Read the template at `${CLAUDE_PLUGIN_ROOT}/communication/_templates/domain-readme.md`
2. Create `communication/domains/{DomainName}/README.md`
3. Pre-fill with the domain name and template sections

### 2.4: Copy Git Scripts

Copy the git helper scripts from `${CLAUDE_PLUGIN_ROOT}/scripts/` to the project's `scripts/` directory:
- `git-agent-commit.sh`
- `git-agent-merge.sh`

Make them executable with `chmod +x`.

### 2.5: Ensure Directory Structure

Make sure these directories exist (create if missing):
```
communication/domains/
backend/    (or appropriate name for their backend)
frontend/   (or appropriate name for their frontend)
scripts/
```

### 2.6: Initialize Git (if not already)

If the project is not already a git repository, offer to initialize one.

Add `.claude/worktrees/` and `.claude/agent-activity.log` to `.gitignore`.

## Step 3: Report Results

After all files are created/updated, display a summary:

```
AI Development Team initialized for '{ProjectName}'!

Plugin: ai-dev-team-framework v1.0.0

Team Available (provided by plugin):
  - user-proxy — Your advocate, interprets intent
  - project-manager — Coordinates team tasks
  - backend-developer — {Backend stack} specialist
  - frontend-developer — {Frontend stack} specialist
  - database-engineer — {Database} specialist
  - qa-engineer — {Testing tools} specialist

Project Files Created:
  - CLAUDE.md — Project configuration
  - PRD.md — Product requirements (fill in your requirements!)
  - communication/domains/ — Domain knowledge folders
  - scripts/ — Git helper scripts

Domains Created:
  - {Domain1}
  - {Domain2}
  - ...

Next Steps:
  1. Fill in PRD.md with your product requirements
  2. Use /delegate to assign work to the team
```
