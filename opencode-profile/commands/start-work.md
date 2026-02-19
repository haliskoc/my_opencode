---
description: Start execution from active plan and continue unfinished work
agent: atlas
---

Start work session from plan context.

Behavior:
- Detect active plan context and progress.
- Resume from the first incomplete actionable item.
- Track execution state and todo completion continuously.
- Report resumed scope, progress, and next checkpoint.

Optional argument:
- `$ARGUMENTS` can specify a plan name.
