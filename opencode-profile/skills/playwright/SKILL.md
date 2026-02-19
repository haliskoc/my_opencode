---
name: playwright
description: Create or improve Playwright E2E tests with stable selectors and deterministic assertions.
license: MIT
compatibility: opencode
metadata:
  category: testing
---

## What I do
- Build resilient E2E flows using stable selectors.
- Reduce flaky waits with explicit event-based synchronization.
- Validate key user journeys and failure states.

## Recommended flow
- Start from user-critical paths first (auth, checkout, save flows).
- Prefer role-based or test-id selectors over brittle CSS chains.
- Reuse fixtures and helper actions for maintainability.

## Reliability rules
- Avoid arbitrary sleeps; use event or state-based waits.
- Capture screenshot or trace artifacts on failure.
- Keep assertions specific to expected UX outcomes.

## Output
- Test coverage plan
- Playwright test updates
- Flake-reduction recommendations
