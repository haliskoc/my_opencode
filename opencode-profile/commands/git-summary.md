---
description: Show a meaningful summary of recent git commits
agent: full
---

Summarize recent git history in a meaningful way.

Workflow:
1. Run: `git log --oneline --no-merges -${COUNT:-20}`
2. Also run: `git log --stat --no-merges -${COUNT:-20}` for file change context.
3. Group commits by theme (feature area, component, or type).
4. Summarize what changed and why, not just commit messages.

Output format:
- **Period**: Date range of commits analyzed.
- **Summary**: 2-3 sentence high-level overview of what happened.
- **By theme**:
  - Theme name: what changed and key decisions made.
- **Stats**: Total commits, files changed, insertions, deletions.
- **Contributors**: Who committed what (if multiple authors).
- **Notable changes**: Any breaking changes, large refactors, or new dependencies.

Arguments:
- `$ARGUMENTS` can specify: `--count 50`, `--since 2024-01-01`, `--author name`.
