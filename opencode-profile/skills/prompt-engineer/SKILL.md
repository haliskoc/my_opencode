---
name: prompt-engineer
description: Write, test, and optimize LLM prompts for accuracy, consistency, and cost efficiency.
license: MIT
compatibility: opencode
metadata:
  category: ai
---

## What I do
- Craft system and user prompts with clear intent, constraints, and output format.
- Identify failure modes: hallucination, instruction drift, format divergence, over-verbosity.
- Iterate prompts with A/B variants and measurable quality criteria.

## Prompt design principles
- Start with the simplest prompt that works, then add constraints only as needed.
- Use explicit output format instructions (JSON schema, markdown template, etc.).
- Separate context, instructions, and examples into distinct sections.
- Prefer few-shot examples over long-form instructions when possible.
- Include negative examples to prevent common failure patterns.

## Optimization workflow
1. Define success criteria (accuracy, format compliance, latency, cost).
2. Write baseline prompt and test against representative inputs.
3. Identify failure cases and categorize (factual, format, reasoning, refusal).
4. Apply targeted fixes: add constraints, examples, chain-of-thought, or tool use.
5. Re-test and compare against baseline with same inputs.
6. Document final prompt with rationale for each design choice.

## Anti-patterns to avoid
- Overly long system prompts that dilute key instructions.
- Contradictory constraints that confuse the model.
- Missing output format spec leading to inconsistent responses.
- Prompt injection vulnerabilities in user-facing prompts.
- Hardcoded knowledge that should come from retrieval or tools.

## Output
- Prompt draft with annotated sections
- Test case matrix with expected vs actual results
- Optimization changelog with before/after comparisons
- Cost and latency impact notes
