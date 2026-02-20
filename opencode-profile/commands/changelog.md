---
description: Generate a changelog from recent git commits
agent: writing
---

Generate a structured changelog from git history.

Workflow:
1. Read recent git log: `git log --oneline --no-merges -50` (or since last tag).
2. Detect the last version tag if available: `git describe --tags --abbrev=0`.
3. Categorize commits by conventional commit prefix:
   - `feat:` → Features
   - `fix:` → Bug Fixes
   - `refactor:` → Refactoring
   - `docs:` → Documentation
   - `test:` → Tests
   - `chore:` → Maintenance
   - `perf:` → Performance
   - `ci:` → CI/CD
4. Group and format as a markdown changelog section.

Output format:
```markdown
## [Unreleased] - YYYY-MM-DD

### Features
- description (commit hash)

### Bug Fixes
- description (commit hash)
...
```

If commits don't follow conventional format, infer categories from content.

Arguments:
- `$ARGUMENTS` can specify: `--since v1.0.0`, `--count 20`, `--format keep-a-changelog`.
