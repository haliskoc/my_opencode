---
name: load-testing
description: Design and run load tests with k6, Artillery, or similar tools to find performance limits.
license: MIT
compatibility: opencode
metadata:
  category: testing
---

## What I do
- Design load test scenarios that reflect real user behavior.
- Write test scripts with k6, Artillery, or equivalent tools.
- Analyze results to find bottlenecks, breaking points, and regressions.
- Establish performance baselines and SLO thresholds.

## Test types
- **Smoke test**: Minimal load (1–5 VUs) to verify the system works under test.
- **Load test**: Expected traffic (target VUs) sustained for 10–30 minutes.
- **Stress test**: Beyond expected load to find breaking point.
- **Spike test**: Sudden traffic burst to test auto-scaling and recovery.
- **Soak test**: Moderate load for hours to detect memory leaks and degradation.

## Scenario design
- Model realistic user journeys, not just single endpoint hits.
- Mix read and write operations in realistic ratios.
- Include think time (pauses between requests) for realistic concurrency.
- Use dynamic data (parameterized users, randomized inputs).
- Test authenticated flows with proper session/token management.

## k6 script patterns
- Use `scenarios` for complex traffic shapes (ramping VUs, constant rate).
- Define `thresholds` for pass/fail criteria: `http_req_duration: ['p95<500']`.
- Use `groups` and `tags` to organize and filter results.
- Import shared data from CSV or JSON files.
- Use `check()` for response validation within load tests.

## Metrics to track
- **Latency**: p50, p90, p95, p99 response times.
- **Throughput**: Requests per second (RPS) at various load levels.
- **Error rate**: HTTP 5xx percentage under load.
- **Saturation**: CPU, memory, connections, queue depth during test.
- **Recovery time**: How fast the system returns to normal after overload.

## Analysis workflow
1. Establish baseline with smoke test.
2. Run load test at expected traffic and verify SLOs.
3. Gradually increase load to find the stress threshold.
4. Correlate response time degradation with server metrics.
5. Identify bottleneck (CPU, memory, database, network, connection pool).
6. Fix bottleneck, re-test, and compare to baseline.

## Common bottlenecks
- Database: Missing indexes, N+1 queries, connection pool exhaustion.
- Application: Synchronous blocking, memory leaks, inefficient algorithms.
- Network: DNS resolution, TLS handshake overhead, bandwidth limits.
- Infrastructure: Under-provisioned instances, misconfigured auto-scaling.

## Output
- Load test script with realistic scenarios
- Performance baseline report
- Bottleneck analysis with evidence
- SLO threshold recommendations
- Optimization action plan
