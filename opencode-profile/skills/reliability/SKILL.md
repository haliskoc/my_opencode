---
name: reliability
description: "Reliability skills: error handling, logging, observability, performance profiling, incident response."
license: MIT
metadata:
  category: reliability
  contains: error-handling, logging-strategy, observability-debugger, performance-profiler, incident-response
---

# Reliability Engineering Skills

## 1. Error Handling

Design global error boundaries, structured responses, and user-facing messages.

### Classification
- **Operational errors**: Expected failures (timeout, invalid input). Handle gracefully.
- **Programming errors**: Bugs (null reference, type error). Fix the code.
- **Infrastructure errors**: Service down, disk full. Alert and recover.

### Rules
- Consistent error response: `{ error: { code, message, details } }`.
- Never expose stack traces to clients.
- Frontend: React Error Boundaries, centralized API error handler.
- User messages: specific, actionable, polite. Log correlation ID for support.

---

## 2. Logging Strategy

Design structured logging with log levels, correlation IDs, and observability.

### Structured logging
- JSON format. Fields: `timestamp`, `level`, `service`, `correlationId`, `message`.
- Propagate `correlationId` via headers across services.
- **ERROR**: Alert-worthy failures. **WARN**: Unexpected but handled. **INFO**: Normal operations. **DEBUG**: Dev only.
- Never log passwords, tokens, PII, credit cards.

---

## 3. Observability & Debugging

Isolate production issues by correlating logs, metrics, and traces.

### Workflow
1. Collect signals: logs, metrics (CPU/memory/latency), distributed traces.
2. Correlate across services using trace IDs.
3. Build failure hypotheses with evidence.
4. Identify instrumentation gaps and propose improvements.

---

## 4. Performance Profiling

Identify performance bottlenecks and propose optimizations.

### Process
1. Measure before optimizing. Establish baseline metrics.
2. Profile hot paths: CPU, memory, I/O, network.
3. Rank bottlenecks by impact (latency × frequency).
4. Apply targeted fixes. Re-measure to verify.
5. Balance latency vs memory vs complexity trade-offs.

---

## 5. Incident Response

Triage production incidents with containment-first approach.

### Workflow
1. **Detect**: Alert fires or user report.
2. **Triage**: Severity classification (P1-P4).
3. **Contain**: Immediate mitigation (rollback, feature flag, scale up).
4. **Diagnose**: Root cause analysis with evidence.
5. **Resolve**: Fix and deploy.
6. **Postmortem**: Timeline, root cause, action items, prevention.
