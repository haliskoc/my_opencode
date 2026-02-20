---
description: Review staged or unstaged git changes as a code reviewer
agent: full
---

Perform a code review on current git changes.

Workflow:
1. Check for staged changes: `git diff --cached --stat`
2. Check for unstaged changes: `git diff --stat`
3. If both exist, ask which to review. If only one, review that.
4. Run the full diff and analyze.

Delegate review to the `reviewer` subagent with focus on:
- **Correctness**: Logic errors, off-by-one, null/undefined handling.
- **Security**: Injection, auth bypass, sensitive data exposure.
- **Performance**: N+1 queries, unnecessary re-renders, memory leaks.
- **Maintainability**: Code clarity, naming, single responsibility.
- **Tests**: Are changes covered by tests? Should new tests be added?

Output format:
| Severity | File | Line | Finding | Suggestion |
|----------|------|------|---------|------------|
| 🔴 Critical | ... | ... | ... | ... |
| 🟡 Warning | ... | ... | ... | ... |
| 🔵 Suggestion | ... | ... | ... | ... |

Summary:
- Overall assessment: approve / request changes / needs discussion.
- Top 3 concerns.
- Positive highlights (what was done well).

Arguments:
- `$ARGUMENTS` can specify: `--staged` for staged only, `--unstaged` for unstaged only, `--branch main` to diff against branch.
