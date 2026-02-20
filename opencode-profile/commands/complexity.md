---
description: Analyze code complexity and suggest simplification
agent: deep
subtask: true
---

Analyze code complexity for:

$ARGUMENTS

Workflow:
1. If a file or directory is specified, analyze it. Otherwise analyze the most complex files in the project.
2. Evaluate complexity metrics:
   - Cyclomatic complexity (branches, conditions, loops).
   - Cognitive complexity (nesting depth, mental overhead).
   - Function length (lines of code per function).
   - Parameter count per function.
   - Dependency fan-in/fan-out.
3. Identify the top 5 most complex functions or modules.

Output format:
| File | Function | Cyclomatic | Cognitive | Lines | Risk |
|------|----------|-----------|-----------|-------|------|
| ... | ... | ... | ... | ... | High/Med/Low |

For each high-complexity item, provide:
- Why it is complex (specific patterns causing complexity).
- Refactoring suggestion with expected complexity reduction.
- Risk assessment for the refactoring.

Rules:
- Focus on actionable findings, not theoretical metrics.
- Suggest extract-function, early-return, strategy pattern, or other concrete simplifications.
- Preserve behavior; recommend tests before refactoring where needed.
