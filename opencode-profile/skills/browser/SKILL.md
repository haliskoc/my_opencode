---
name: browser
description: "Browser skills: browser automation, navigation, screenshots, form filling, data extraction."
license: MIT
metadata:
  category: browser
  contains: agent-browser, dev-browser
---

# Browser Automation Skills

## 1. Browser Automation

Automate browser tasks: navigation, form filling, screenshots, data extraction.

### Workflow
1. Navigate to target URL.
2. Wait for page load (use explicit waits, not timeouts).
3. Interact: click, type, select, scroll.
4. Extract data or take screenshots.
5. Validate results.

### Reliability rules
- Use stable selectors: data-testid, aria-label, role.
- Explicit waits with `waitForSelector`.
- Handle popups, modals, and alerts.
- Retry on transient failures.

---

## 2. Development Browser

Browser-based development tools and debugging.

### Capabilities
- DevTools inspection: DOM, network, console, performance.
- Mobile device emulation.
- Network throttling for performance testing.
- Cookie and storage management.
- Screenshot and recording capture.
