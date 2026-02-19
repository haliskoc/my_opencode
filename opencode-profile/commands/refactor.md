---
description: Intelligent refactor with LSP and AST-aware workflow
agent: hephaestus
---

Execute an intelligent refactor for:

$ARGUMENTS

Workflow:
1. Clarify scope and success criteria.
2. Build codemap with parallel explore/librarian runs.
3. Use LSP-aware operations for symbol-safe changes where available.
4. Use AST-aware pattern search and replacement when applicable.
5. Validate incrementally with tests and diagnostics after each major step.
6. End with explicit risk and rollback notes.
