# Initialize AI Development Team

When the user runs `/init-dev-team`, follow this interactive workflow to bootstrap the project.

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

Once you have the answers, update **every** file listed below. Do NOT leave any `<!-- CUSTOMIZE -->` placeholders or `(define your ...)` text — fill everything in with the user's specifics.

### 2.1: Update `CLAUDE.md`

Rewrite the CLAUDE.md file with:
- Project name as the heading
- The user's project description in the Overview section
- Current phase (default: "Phase 1 — see PRD.md")
- Full tech stack details filled in
- Project structure updated to match their stack
- Domain ownership mapped to agents
- Remove all `<!-- CUSTOMIZE -->` comments

### 2.2: Create `PRD.md`

Create a Product Requirements Document at the project root with the project name, description, and a template structure the user can fill in. Include sections for: Vision, Target Users, Phased Roadmap, Data Model, Non-Functional Requirements, and Success Metrics. Pre-fill what you can from the user's answers.

### 2.3: Update Agent Files

Update ALL agent files in `.claude/agents/` with the user's tech stack:

- **`project-manager.md`** — Update the team table with tech stack expertise per agent
- **`backend-developer.md`** — Fill in the specific backend framework, language, ORM, architecture patterns, and folder structure
- **`frontend-developer.md`** — Fill in the specific frontend framework, styling, state management, and folder structure
- **`database-engineer.md`** — Fill in the specific database, ORM, migration tool
- **`qa-engineer.md`** — Fill in the specific testing frameworks, test commands
- **`user-proxy.md`** — Update domain knowledge with project context

### 2.4: Create Domain Folders

For each domain the user specified:
1. Create `communication/domains/{DomainName}/README.md`
2. Pre-fill with the domain name and template sections (Overview, Key Concepts, Business Rules, Schema Decisions)
3. Remove any pre-existing example domain folders that don't match the user's domains

### 2.5: Initialize Status Files

Ensure `communication/status/` has a status file for each agent:
- `backend-developer.md`
- `frontend-developer.md`
- `database-engineer.md`
- `qa-engineer.md`

Each with `status: available`, `current_task: none`.

### 2.6: Ensure Directory Structure

Make sure these directories exist (create if missing):
```
communication/tasks/
communication/messages/
communication/status/
communication/domains/
communication/_templates/
communication/_index/
scripts/
backend/    (or appropriate name for their backend)
frontend/   (or appropriate name for their frontend)
```

### 2.7: Initialize Git (if not already)

If the project is not already a git repository, offer to initialize one.

## Step 3: Report Results

After all files are created/updated, display a summary:

```
AI Development Team initialized for '{ProjectName}'!

Team Created:
  - user-proxy — Your advocate, interprets intent
  - project-manager — Coordinates team tasks
  - backend-developer — {Backend stack} specialist
  - frontend-developer — {Frontend stack} specialist
  - database-engineer — {Database} specialist
  - qa-engineer — {Testing tools} specialist

Domains Created:
  - {Domain1} (owned by {agent})
  - {Domain2} (owned by {agent})
  - ...

Files Updated:
  - CLAUDE.md — Project configuration
  - PRD.md — Product requirements (fill in your requirements!)
  - .claude/agents/* — All agent configurations
  - communication/* — Team coordination structure
  - scripts/* — Helper scripts

Next Steps:
  1. Fill in PRD.md with your product requirements
  2. Use /delegate to assign work to the team
  3. Check communication/tasks/ to monitor progress

Ready for work! Just tell me what you want to build.
```
