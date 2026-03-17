# CLAUDE.md

This file provides guidance to AI assistants (Claude and others) working in this repository.

## Repository Overview

**Repository:** AlexandreFenyo/ClaudeTest
**Status:** Newly initialized repository

This is a fresh repository. As the codebase grows, update this file to reflect the actual tech stack, conventions, and workflows.

---

## Repository Structure

```
ClaudeTest/
├── CLAUDE.md          # This file — AI assistant guidance
└── .git/              # Git metadata
```

As new directories and files are added, document them here with a brief description of their purpose.

---

## Development Workflow

### Branching Strategy

- Feature/task branches follow the pattern: `claude/<description>-<sessionId>`
- Never push directly to `main` or `master` without explicit permission
- Always develop on the designated branch for each task

### Git Operations

```bash
# Create and switch to a new branch
git checkout -b claude/<description>-<id>

# Stage and commit
git add <files>
git commit -m "<type>: <short description>"

# Push (always use -u on first push)
git push -u origin <branch-name>
```

### Commit Message Conventions

Use conventional commits format:

```
<type>: <short imperative description>

[optional body explaining why, not what]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code restructuring without behavior change
- `test`: Adding or updating tests
- `chore`: Build process, tooling, or dependency updates
- `ci`: CI/CD configuration changes

**Examples:**
```
feat: add user authentication endpoint
fix: handle null pointer in config loader
docs: update API reference for v2 endpoints
```

---

## AI Assistant Instructions

### When Working on Tasks

1. **Read before editing** — always read a file before modifying it
2. **Minimal changes** — only change what is necessary; avoid refactoring unrelated code
3. **No unnecessary files** — do not create files unless they are required for the task
4. **No unnecessary comments** — only add comments where logic is non-obvious
5. **Security first** — never introduce SQL injection, XSS, command injection, or other OWASP Top 10 vulnerabilities

### When Committing

1. Stage specific files by name, not `git add -A` or `git add .`
2. Write clear commit messages following the conventions above
3. Push to the correct branch (see Branching Strategy)
4. Do not amend published commits — create new commits instead

### When the Codebase Grows

Update this file when:
- A new language or framework is introduced
- Build/test commands change
- New conventions are established
- Directory structure changes significantly

---

## Testing

*(No tests configured yet. Update this section when a test framework is added.)*

Expected pattern once established:
```bash
# Run all tests
<test command here>

# Run a single test file
<test command here> <path>
```

---

## Build & Run

*(No build system configured yet. Update this section when tooling is added.)*

---

## Linting & Formatting

*(No linters configured yet. Update this section when linting is added.)*

---

## Environment Variables

*(No environment variables required yet. Update this section as needed.)*

---

## Key Conventions

- Keep this file up to date as the project evolves
- Document any non-obvious decisions or architectural constraints here
- If a convention is established through code review, add it here so AI assistants follow it consistently
