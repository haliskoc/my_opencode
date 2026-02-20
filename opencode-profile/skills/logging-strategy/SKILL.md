---
name: logging-strategy
description: Design structured logging with log levels, correlation IDs, and observability integration.
license: MIT
compatibility: opencode
metadata:
  category: reliability
---

## What I do
- Design structured logging that enables fast debugging and incident response.
- Implement correlation IDs for distributed request tracing.
- Define log level policies and rotation strategies.
- Integrate with observability platforms (ELK, Loki, Datadog, CloudWatch).

## Structured logging principles
- Log in JSON format for machine parseability.
- Include standard fields: `timestamp`, `level`, `service`, `correlationId`, `message`.
- Add contextual fields: `userId`, `endpoint`, `duration`, `statusCode`.
- Never log sensitive data: passwords, tokens, PII, credit cards.
- Use consistent field names across all services.

## Log levels
- **ERROR**: Something failed and needs attention. Alert-worthy.
- **WARN**: Something unexpected but handled. Monitor for trends.
- **INFO**: Normal operations: request completed, job finished, config loaded.
- **DEBUG**: Detailed flow data for development. Disabled in production.
- **TRACE**: Very granular. Only enable temporarily for specific investigations.

## Correlation and tracing
- Generate a unique `correlationId` at the entry point (API gateway, first service).
- Propagate through all downstream calls via headers (`X-Correlation-Id`).
- Include in all log entries for cross-service request reconstruction.
- Link to distributed tracing spans (OpenTelemetry) when available.

## What to log
- **Always log**: Request start/end, errors, auth events, config changes, job execution.
- **Conditionally log**: Performance metrics, cache hits/misses, external API calls.
- **Never log**: Passwords, API keys, session tokens, personal data, request bodies with sensitive fields.

## Log rotation and retention
- Rotate logs by size (100MB) or time (daily).
- Retain production logs for 30–90 days depending on compliance.
- Archive older logs to cold storage if needed.
- Set up automated cleanup to prevent disk fill.

## Library recommendations
- **Node.js**: pino (fast), winston (flexible).
- **Python**: structlog, python-json-logger.
- **Go**: zerolog, zap.
- **Java**: Logback with JSON encoder, Log4j2.

## Output
- Logging architecture and standard field schema
- Log level usage guide
- Correlation ID implementation plan
- Sensitive data protection rules
- Retention and rotation policy
