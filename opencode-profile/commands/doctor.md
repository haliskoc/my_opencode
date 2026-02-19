---
description: Run health checks for runtime, MCP, agents, plugins, and keys
agent: full
---

Run a full diagnostics report for this environment.

Collect and summarize:

- OpenCode version: !`opencode --version`
- Docker availability: !`docker --version || true`
- MCP status: !`opencode mcp list`
- Installed commands: !`ls ~/.config/opencode/commands | wc -l`
- Installed skills: !`ls ~/.config/opencode/skills | wc -l`
- Plugin files: !`ls ~/.config/opencode/plugins`

Also verify whether these env vars are set (do not print full values):
- OPENAI_API_KEY
- CONTEXT7_API_KEY
- EXA_API_KEY

Output format:
- Status (healthy or warning)
- Findings
- Recommended fixes
