# Product Requirements Document

<!-- This file is the single source of truth for what we're building. -->
<!-- The /init-dev-team command will pre-fill project name and description. -->
<!-- Fill in the remaining sections to guide your AI development team. -->

## 1. Vision

**Project Name:** (your project name)

**One-liner:** (what does it do in one sentence?)

**Vision Statement:** (where is this product going long-term?)

## 2. Target Users

### Primary Users
- **Who:** (describe your primary user persona)
- **Pain point:** (what problem do they have?)
- **Current solution:** (how do they solve it today?)

### Secondary Users
- (additional user personas if applicable)

## 3. Phased Roadmap

### Phase 1 — MVP
**Goal:** (what's the minimum viable product?)

**Features:**
- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3

**Success criteria:** (how do you know Phase 1 is done?)

### Phase 2 — (name)
**Goal:** (what comes after MVP?)

**Features:**
- [ ] Feature 1
- [ ] Feature 2

### Phase 3 — (name)
**Goal:** (long-term features)

**Features:**
- [ ] Feature 1
- [ ] Feature 2

## 4. Tech Stack

<!-- This section will be filled by /init-dev-team -->

- **Backend:** (framework, language, runtime)
- **Frontend:** (framework, styling, state management)
- **Database:** (database, ORM)
- **Testing:** (unit, integration, E2E tools)
- **Architecture:** (pattern — Clean Architecture, MVC, etc.)

## 5. Data Model

### 5.1 Entities

<!-- Define your core entities/models here -->

**Entity 1:**
- field_name: type — description
- field_name: type — description

**Entity 2:**
- field_name: type — description

### 5.2 Relationships
- Entity1 has many Entity2
- Entity2 belongs to Entity1

### 5.3 Enums
- StatusEnum: VALUE_1, VALUE_2, VALUE_3

## 6. API Design

### Endpoints
| Method | Path | Description |
|--------|------|-------------|
| GET | /api/v1/resource | List resources |
| POST | /api/v1/resource | Create resource |
| GET | /api/v1/resource/:id | Get resource |
| PUT | /api/v1/resource/:id | Update resource |
| DELETE | /api/v1/resource/:id | Delete resource |

## 7. Non-Functional Requirements

- **Performance:** (response time targets, throughput)
- **Security:** (authentication, authorization, data protection)
- **Scalability:** (expected load, growth plan)
- **Accessibility:** (WCAG level, screen reader support)
- **Internationalization:** (languages, locales, date/currency formats)

## 8. Success Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Metric 1 | target value | measurement method |
| Metric 2 | target value | measurement method |

## 9. Competitive Landscape

| Competitor | Strengths | Weaknesses | Our Differentiator |
|------------|-----------|------------|-------------------|
| Competitor 1 | | | |
| Competitor 2 | | | |

## 10. Open Questions

- [ ] Question 1
- [ ] Question 2
