---
name: agent-browser
description: Browser automation workflow for navigation, form filling, screenshots, and extraction.
license: MIT
compatibility: opencode
metadata:
  category: browser
  source: extracted-from-oh-my-opencode
---

## Quick workflow
1. Open target URL.
2. Snapshot interactive elements.
3. Interact using stable element references.
4. Re-snapshot after significant navigation.

## Typical tasks
- Functional website validation
- Form automation and submission checks
- Screenshot capture
- Structured data extraction from pages

## Reliability rules
- Prefer reference-based element targeting over fragile selectors.
- Wait for navigation/network-idle before assertions.
- Keep scripts incremental and observable.
