---
name: dev-browser
description: Stateful browser automation pattern for iterative script-driven workflows.
license: MIT
compatibility: opencode
metadata:
  category: browser
  source: extracted-from-oh-my-opencode
---

## Operating style
- Use short focused scripts for each step.
- Inspect resulting page state after each step.
- Keep browser session state persistent for iterative workflows.

## Best use cases
- Authenticated user-flow checks
- Reproducible scraping runs
- Multi-step UI regression probes

## Safety and quality
- Use explicit waits for URL/load/selector conditions.
- Capture screenshots at decision points.
- Prefer deterministic interactions and clear output logs.
