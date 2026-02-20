---
name: regex-master
description: Write, debug, and optimize complex regular expressions with clear explanations.
license: MIT
compatibility: opencode
metadata:
  category: utility
---

## What I do
- Write precise regular expressions for validation, extraction, and transformation.
- Debug failing patterns with step-by-step match analysis.
- Optimize catastrophic backtracking and performance issues.
- Translate between regex flavors (PCRE, JavaScript, Python, Go, Rust).

## Design principles
- Start with the simplest pattern that matches the requirement.
- Use named capture groups for readability: `(?<year>\d{4})`.
- Prefer non-greedy quantifiers (`*?`, `+?`) when appropriate.
- Anchor patterns (`^`, `$`) to prevent partial matches.
- Use character classes (`[a-z]`) over alternation (`a|b|c|...`) for single chars.

## Common tasks
- **Email validation**: RFC-compliant vs practical patterns.
- **URL parsing**: Protocol, domain, path, query, fragment extraction.
- **Date/time**: Multiple format matching with named groups.
- **Log parsing**: Structured extraction from unstructured log lines.
- **Code transformation**: Find-and-replace with backreferences.
- **Input sanitization**: Whitelist allowed characters.

## Performance rules
- Avoid catastrophic backtracking: no nested quantifiers on overlapping patterns.
- Use atomic groups or possessive quantifiers when available.
- Prefer `\d` over `[0-9]` for clarity (flavor-dependent).
- Test with adversarial inputs (long strings of near-matches).
- Benchmark complex patterns against realistic data volumes.

## Debugging workflow
1. Identify the failing input and expected match.
2. Break the pattern into sub-expressions and test individually.
3. Use verbose/comment mode (`x` flag) for complex patterns.
4. Visualize with step-through tools (regex101, debuggex).
5. Document the final pattern with inline comments.

## Output
- Regex pattern with annotated explanation
- Test cases covering matches, non-matches, and edge cases
- Performance notes for high-volume usage
- Flavor compatibility notes if cross-platform
