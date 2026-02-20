---
description: Analyze test coverage and suggest missing test cases
agent: full
---

Analyze test coverage and identify gaps for the current project.

Workflow:
1. Detect the test framework and coverage tool:
   - Jest/Vitest: `npx vitest run --coverage` or `npx jest --coverage`
   - pytest: `pytest --cov --cov-report=term-missing`
   - go: `go test -cover ./...`
   - cargo: `cargo llvm-cov`
2. Run coverage analysis and collect results.
3. Identify untested or under-tested areas.
4. Prioritize gaps by risk (business-critical paths first).

Output format:
- **Overall coverage**: Line, branch, and function coverage percentages.
- **Coverage by module/file**: Table with file, line %, branch %, and risk level.
- **Critical gaps**: Top 10 uncovered areas ranked by business risk.
- **Suggested tests**: For each gap, describe what test cases would provide the most value.
- **Quick wins**: Low-effort tests that would significantly improve coverage.

Rules:
- Focus on meaningful coverage, not just hitting 100%.
- Prioritize error paths, edge cases, and integration boundaries.
- Suggest test types (unit, integration, e2e) appropriate for each gap.

Arguments:
- `$ARGUMENTS` can specify: `--threshold 80` for minimum target, `--focus src/api` for specific directory.
