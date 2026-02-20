---
description: Audit dependencies for known vulnerabilities and outdated packages
agent: full
---

Run a dependency security audit for the current project.

Workflow:
1. Detect the package manager in use:
   - npm: `npm audit --json`
   - pnpm: `pnpm audit --json`
   - yarn: `yarn audit --json`
   - pip: `pip audit` or `safety check`
   - go: `govulncheck ./...`
   - cargo: `cargo audit`
2. Parse the output and categorize findings by severity (critical, high, medium, low).
3. Check for outdated packages: `npm outdated` / `pip list --outdated` / equivalent.
4. Cross-reference with known exploit databases when possible.

Output format:
- Summary table: total vulnerabilities by severity.
- Top 5 critical/high findings with package name, vulnerability ID, and recommended fix.
- Outdated packages that have security-relevant updates.
- Suggested fix commands (e.g., `npm audit fix`, specific version bumps).

Arguments:
- `$ARGUMENTS` can specify: `--fix` to auto-apply safe fixes, `--severity high` to filter.
