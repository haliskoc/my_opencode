---
description: Provide a detailed explanation of a file, function, or concept
agent: oracle
subtask: true
---

Explain in detail:

$ARGUMENTS

Workflow:
1. If a file path is given, read and analyze the file.
2. If a function/class name is given, locate it in the codebase and analyze.
3. If a concept is given, explain with context relevant to this project.

Explanation should cover:
- **What it does**: Clear description of purpose and behavior.
- **How it works**: Step-by-step flow of execution or logic.
- **Why it exists**: Design rationale and the problem it solves.
- **Dependencies**: What it depends on and what depends on it.
- **Edge cases**: Known limitations, error conditions, or special handling.
- **Examples**: Usage examples if applicable.

Rules:
- Be thorough but structured.
- Use code references with line numbers when explaining implementation.
- Highlight non-obvious behavior or potential gotchas.
- If the target is complex, break into sections with headers.
