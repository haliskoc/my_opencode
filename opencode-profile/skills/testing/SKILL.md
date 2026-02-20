---
name: testing
description: "Testing skills: load testing, contract testing, E2E with Playwright, test writing."
license: MIT
metadata:
  category: testing
  contains: load-testing, contract-testing, test-writer, playwright
---

# Testing Skills

## 1. Load Testing

Design and run load tests with k6, Artillery, or similar tools.

### Test types
- **Smoke**: 1-5 VUs, verify system works under test.
- **Load**: Target VUs sustained for 10-30 minutes.
- **Stress**: Beyond expected load to find breaking point.
- **Spike**: Sudden burst to test auto-scaling.
- **Soak**: Moderate load for hours (memory leaks, degradation).

### Metrics
- Latency: p50, p90, p95, p99.
- Throughput: RPS at various levels.
- Error rate: 5xx percentage under load.
- Saturation: CPU, memory, connections during test.

---

## 2. Contract Testing

Implement API contract tests with Pact for consumer-driven development.

### Workflow
1. Consumer writes tests defining expected interactions.
2. Tests produce a pact file (JSON contract).
3. Publish to Pact Broker.
4. Provider runs verification against published pacts.
5. Use `can-i-deploy` check in CI before releasing.

### Rules
- Test contract shape, not business logic.
- Use loose matchers (type-based) instead of exact values.
- Block deployment if contract verification fails.

---

## 3. Test Writing

Write effective unit, integration, and E2E tests.

### Principles
- Test behavior, not implementation details.
- One assertion per test (ideally).
- Use AAA pattern: Arrange, Act, Assert.
- Mock external dependencies, not internal modules.
- Name tests descriptively: "should return 404 when user not found".
- Cover happy path, edge cases, and error paths.
- Aim for meaningful coverage, not 100% line coverage.

---

## 4. Playwright E2E

Create reliable Playwright end-to-end tests.

### Reliability rules
- Use stable selectors: data-testid, role, label.
- Explicit waits with `waitForSelector` or auto-waiting locators.
- Avoid `page.waitForTimeout` (flaky).
- Isolate test data; don't depend on prior test state.
- Use `test.describe` for grouping related scenarios.
- Screenshot on failure for debugging.
