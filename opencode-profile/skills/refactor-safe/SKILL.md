---
name: refactor-safe
description: Execute low-risk refactors in small reversible steps.
license: MIT
compatibility: opencode
---

## What I do
- Keep behavior unchanged unless explicitly requested.
- Split changes into minimal units.
- Preserve public APIs by default.

## Safety
- Add or run nearby tests before broad edits.
- Call out rollback path for risky edits.
