---
name: project-management
description: "Project skills: git workflow, release management, monorepo maintenance, documentation, dependency upgrades."
license: MIT
metadata:
  category: project-management
  contains: git-master, release-manager, monorepo-maintainer, docs-writer, dependency-upgrade-safety
---

# Project Management Skills

## 1. Git Workflow

Prepare safe, atomic Git commits with proper messages and workflow.

### Rules
- Group related changes into one commit. Don't mix features with fixes.
- Conventional commit format: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`.
- Write commit body with rationale when change is non-obvious.
- Verify staged content before committing (`git diff --cached`).
- Never force push to shared branches.
- Use feature branches; merge via PR with review.

---

## 2. Release Management

Prepare release checklists, changelogs, and rollout steps.

### Workflow
1. Feature freeze: no new features after cut-off.
2. Changelog from conventional commits.
3. Version bump (semver).
4. Release candidate testing.
5. Rollout: canary → staged → full.
6. Rollback plan documented and tested.
7. Post-release monitoring.

---

## 3. Monorepo Maintenance

Manage monorepo changes with impact mapping and scoped validation.

### Process
- Map impacted packages from changed files.
- Run only affected package tests (scoped builds).
- Coordinated versioning across packages.
- Workspace-aware dependency management.
- Clear ownership boundaries per package.

---

## 4. Documentation

Write clear, maintainable technical documentation.

### Types
- README: project overview, setup, quick start.
- API docs: endpoints, parameters, examples.
- Architecture docs: system design, data flow, decisions (ADRs).
- Runbooks: operational procedures for common tasks.
- Inline: JSDoc/TSDoc for public APIs and complex logic.

---

## 5. Dependency Upgrade Safety

Upgrade dependencies safely with testing and rollback planning.

### Process
1. Check current versions and available updates.
2. Read changelogs for breaking changes.
3. Update one dependency at a time (major versions).
4. Run full test suite after each upgrade.
5. Test in staging before production.
6. Pin versions for reproducible builds.
