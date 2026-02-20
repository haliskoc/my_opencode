---
description: Create a migration plan for framework, library, or language upgrade
agent: full
---

Create a comprehensive migration plan for:

$ARGUMENTS

Workflow:
1. Identify what is being migrated (framework version, library, language, database, etc.).
2. Analyze current usage patterns and dependencies.
3. Research breaking changes, deprecations, and new features.
4. Map impacted files and components.

Output a migration plan with:
- **Scope**: What is changing and what is not.
- **Prerequisites**: Required tooling updates or environment changes.
- **Breaking changes**: List of known incompatibilities with remediation steps.
- **Migration steps**: Ordered sequence of changes with estimated effort per step.
- **Coexistence strategy**: Can old and new run side by side during migration?
- **Testing plan**: What to test at each phase.
- **Rollback plan**: How to revert if migration fails midway.
- **Timeline estimate**: Based on codebase size and change count.

Rules:
- Prefer incremental migration over big-bang rewrite.
- Flag high-risk changes that need extra review.
- Include specific file paths and code patterns to search for.
