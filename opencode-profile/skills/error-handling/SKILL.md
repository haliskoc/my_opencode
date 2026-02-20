---
name: error-handling
description: Design global error boundaries, structured error responses, and user-facing error messages.
license: MIT
compatibility: opencode
metadata:
  category: reliability
---

## What I do
- Design layered error handling from infrastructure to user-facing messages.
- Implement error boundaries, fallbacks, and graceful degradation.
- Standardize error response formats across APIs and UIs.
- Ensure errors are actionable for both developers and end users.

## Error classification
- **Operational errors**: Expected failures (network timeout, invalid input, rate limit). Handle gracefully.
- **Programming errors**: Bugs (null reference, type error, assertion failure). Fix the code.
- **Infrastructure errors**: Service down, disk full, out of memory. Alert and recover.

## Backend error handling
- Use a consistent error response envelope: `{ error: { code, message, details } }`.
- Map internal errors to appropriate HTTP status codes.
- Never expose stack traces or internal details to clients.
- Log full error context (stack, request, user) server-side.
- Use error codes (not just messages) for client-side branching.
- Wrap external service calls in try/catch with timeout and fallback.

## Frontend error handling
- **React Error Boundaries**: Catch rendering errors, show fallback UI.
- **API error handling**: Centralize in HTTP client interceptor.
- **Form validation**: Show inline errors next to fields, not just alerts.
- **Network errors**: Detect offline state, queue retries, show status.
- **Unexpected errors**: Global handler with "something went wrong" + report option.

## User-facing error messages
- Be specific: "Email address is already registered" not "Error occurred".
- Be actionable: Tell the user what they can do to fix it.
- Be polite: Never blame the user.
- Provide escape: Always offer a way to go back, retry, or get help.
- Log correlation ID for support escalation.

## Logging and monitoring
- Log errors with severity level, timestamp, correlation ID, and context.
- Alert on error rate spikes, not individual errors.
- Track error categories over time for trend analysis.
- Set up dead-letter queues for failed async operations.

## Output
- Error handling architecture diagram
- Error response format specification
- Frontend error boundary implementation plan
- User-facing error message guidelines
