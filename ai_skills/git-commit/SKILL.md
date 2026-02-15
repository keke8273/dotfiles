---
name: git-commit
description: Create well-formed conventional commits following repository standards, with proper message formatting and scope organization.
---

# Git Commit

## When to use this skill

Use this skill when you need to:
- Create git commits with proper conventional commit formatting
- Generate descriptive commit messages that follow this repository's conventions
- Ensure commit messages are atomic, clear, and follow best practices
- Make commits that are consistent with the project's git history

## Commit message format

Always follow conventional commit format:

```
type(scope): subject

body (optional)

footer (optional)
```

## Commit types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation changes only
- **refactor**: Code refactoring without feature changes
- **test**: Adding or updating tests
- **perf**: Performance improvements
- **ci**: CI/CD configuration changes
- **chore**: Build, dependencies, or tooling changes

## Guidelines

1. Keep subject line under 50 characters
2. Use imperative mood: "add feature" not "adds feature" or "added feature"
3. Don't capitalize the subject line
4. Don't end subject with a period
5. Reference issues in footer if applicable: `Closes #42` or `Fixes #123`
6. Include a meaningful body for complex changes that explain the why, not the what
7. Separate subject, body, and footer with blank lines

## Examples

```
feat(vim): add vim-airline status line plugin

vim-airline provides better visual feedback and displays git branch info.

Closes #42
```

```
fix(zsh): correct powerlevel10k theme initialization order
```

```
docs: enhance README with quick start guide
```

## Repository conventions

This repository uses the conventional commit standard. Check `.github/copilot-instructions.md` for repository-specific setup and conventions.
