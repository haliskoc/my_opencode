---
name: code-quality
description: "Code quality skills: code review, safe refactoring, regex mastery, bug investigation."
license: MIT
metadata:
  category: code-quality
  contains: code-review, refactor-safe, regex-master, bug-investigator
---

# Code Quality Skills

## 1. Code Review

Perform thorough, constructive code reviews focused on correctness, security, and maintainability.

### Review checklist
- Correctness: logic errors, off-by-one, null handling.
- Security: injection, auth bypass, sensitive data exposure.
- Performance: N+1 queries, unnecessary re-renders, memory leaks.
- Maintainability: naming, single responsibility, readability.
- Tests: are changes covered? Should new tests be added?

### Feedback principles
- Be specific: point to exact lines with concrete suggestions.
- Separate blockers from nitpicks.
- Acknowledge good patterns.
- Suggest, don't demand (unless it's a real bug).

---

## 2. Safe Refactoring

Execute low-risk refactors in small, reversible steps.

### Rules
- Keep behavior unchanged unless explicitly requested.
- Split changes minimally: one concern per commit.
- Preserve public APIs.
- Write or verify tests before refactoring.
- Use automated refactoring tools when available (IDE, ast-grep).
- Plan rollback path before starting.

---

## 3. Regex Mastery

Write, debug, and optimize complex regular expressions.

### Design principles
- Use named capture groups: `(?<year>\d{4})`.
- Prefer non-greedy quantifiers when appropriate.
- Anchor patterns (`^`, `$`).
- Avoid catastrophic backtracking: no nested quantifiers on overlapping patterns.
- Use verbose/comment mode for complex patterns.
- Test with adversarial inputs.

---

## 4. Bug Investigation

Systematic debugging to find root cause and fix permanently.

### Methodology
1. **Reproduce**: Create reliable reproduction steps.
2. **Isolate**: Narrow scope with bisection (git bisect, feature flags).
3. **Diagnose**: Read logs, add instrumentation, trace execution.
4. **Fix**: Address root cause, not symptoms.
5. **Verify**: Confirm fix resolves the issue without regressions.
6. **Prevent**: Add test covering the bug scenario.
