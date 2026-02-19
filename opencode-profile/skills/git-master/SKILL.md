---
name: git-master
description: Prepare safe, atomic commits with clear intent and verification notes.
license: MIT
compatibility: opencode
metadata:
  category: workflow
---

## What I do
- Group changes into coherent atomic commit units.
- Draft commit messages focused on rationale.
- Verify staged content matches intent before commit.

## Commit discipline
- Default to multiple commits for multi-file work.
- Keep implementation and related tests together.
- Match existing repository commit style and language.

## Workflow
- Inspect status, staged diff, unstaged diff, and recent log first.
- Produce commit plan before executing commits.
- Include short verification notes per commit group.

## Safety
- Avoid destructive git operations unless explicitly requested.
- Flag potentially sensitive files before commit.
