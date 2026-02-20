---
description: Generate a Mermaid or ASCII architecture diagram of the project
agent: full
---

Analyze the current project structure and generate an architecture diagram.

Workflow:
1. Explore the project directory tree and key configuration files.
2. Identify major components, services, modules, and their relationships.
3. Detect data flow patterns (API calls, event buses, database connections).
4. Generate a Mermaid diagram showing:
   - Module/service boundaries
   - Data flow direction
   - External dependencies
   - Database and storage connections

Output format:
- Mermaid diagram code block (ready to paste into docs or GitHub).
- Brief legend explaining each component.
- If $ARGUMENTS specifies "ascii", produce an ASCII art diagram instead.

Arguments:
- `$ARGUMENTS` can include: `--format mermaid|ascii`, `--scope frontend|backend|full`, `--depth shallow|deep`.
