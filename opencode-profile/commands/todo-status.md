---
description: Show the status of all active and pending todos in a table
agent: full
---

Display the current todo status in a structured table format.

Collect all active todos from the session and present as:

| # | Status | Description | Priority | Notes |
|---|--------|-------------|----------|-------|
| 1 | ✅ done | ... | high | ... |
| 2 | 🔄 in-progress | ... | medium | ... |
| 3 | ⏳ pending | ... | low | ... |

Summary stats:
- Total: X
- Completed: X
- In Progress: X
- Pending: X
- Blocked: X

If no todos are active, suggest creating a plan with `/ulw` or `/start-work`.
