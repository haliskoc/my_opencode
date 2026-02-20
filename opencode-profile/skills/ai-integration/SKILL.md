---
name: ai-integration
description: Integrate LLM APIs with streaming, retry logic, rate limiting, and cost controls.
license: MIT
compatibility: opencode
metadata:
  category: ai
---

## What I do
- Design LLM API integration layers with proper abstraction and provider flexibility.
- Implement streaming responses for real-time UX.
- Add retry, timeout, rate limiting, and circuit breaker patterns.
- Track token usage and enforce cost budgets.

## Integration patterns
- **Provider abstraction**: Wrap provider-specific SDKs behind a common interface.
- **Streaming**: Use SSE or WebSocket for incremental response delivery.
- **Retry with backoff**: Exponential backoff with jitter for transient failures.
- **Rate limiting**: Token bucket or sliding window per user/tenant.
- **Circuit breaker**: Fail fast when provider is degraded.
- **Fallback chain**: Primary → secondary model → cached response → graceful error.

## Prompt management
- Store prompts as versioned templates, not inline strings.
- Inject context variables at runtime with clear schemas.
- Log prompt versions alongside responses for debugging.

## Cost and usage controls
- Estimate tokens before sending (tiktoken or provider estimator).
- Set per-request and per-session token budgets.
- Alert on unusual usage spikes.
- Cache identical requests where safe (deterministic prompts with temperature=0).

## Security considerations
- Never log full API keys; mask or use environment variables.
- Sanitize user input before prompt injection.
- Validate and sanitize model output before trusting.
- Rate limit per user to prevent abuse.

## Output
- Integration architecture sketch
- Provider abstraction interface
- Streaming implementation notes
- Cost tracking and budget enforcement plan
