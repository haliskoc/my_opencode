---
name: ai
description: "AI & LLM skills: prompt engineering, API integration, streaming, cost control."
license: MIT
metadata:
  category: ai
  contains: prompt-engineer, ai-integration
---

# AI & LLM Skills

## 1. Prompt Engineering

Write, test, and optimize LLM prompts for accuracy, consistency, and cost efficiency.

### Design principles
- Start with the simplest prompt that works, then add constraints only as needed.
- Use explicit output format instructions (JSON schema, markdown template, etc.).
- Separate context, instructions, and examples into distinct sections.
- Prefer few-shot examples over long-form instructions when possible.
- Include negative examples to prevent common failure patterns.

### Optimization workflow
1. Define success criteria (accuracy, format compliance, latency, cost).
2. Write baseline prompt and test against representative inputs.
3. Identify failure cases and categorize (factual, format, reasoning, refusal).
4. Apply targeted fixes: add constraints, examples, chain-of-thought, or tool use.
5. Re-test and compare against baseline with same inputs.
6. Document final prompt with rationale for each design choice.

### Anti-patterns
- Overly long system prompts that dilute key instructions.
- Contradictory constraints that confuse the model.
- Missing output format spec leading to inconsistent responses.
- Prompt injection vulnerabilities in user-facing prompts.
- Hardcoded knowledge that should come from retrieval or tools.

---

## 2. AI/LLM API Integration

Integrate LLM APIs with streaming, retry logic, rate limiting, and cost controls.

### Integration patterns
- **Provider abstraction**: Wrap provider-specific SDKs behind a common interface.
- **Streaming**: Use SSE or WebSocket for incremental response delivery.
- **Retry with backoff**: Exponential backoff with jitter for transient failures.
- **Rate limiting**: Token bucket or sliding window per user/tenant.
- **Circuit breaker**: Fail fast when provider is degraded.
- **Fallback chain**: Primary → secondary model → cached response → graceful error.

### Cost and usage controls
- Estimate tokens before sending (tiktoken or provider estimator).
- Set per-request and per-session token budgets.
- Alert on unusual usage spikes.
- Cache identical requests where safe (deterministic prompts with temperature=0).

### Security
- Never log full API keys; mask or use environment variables.
- Sanitize user input before prompt injection.
- Validate and sanitize model output before trusting.
- Rate limit per user to prevent abuse.
