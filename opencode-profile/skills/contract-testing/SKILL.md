---
name: contract-testing
description: Implement API contract tests with Pact or similar tools for consumer-driven development.
license: MIT
compatibility: opencode
metadata:
  category: testing
---

## What I do
- Implement consumer-driven contract testing between services.
- Prevent breaking API changes from reaching production.
- Design contract versioning and evolution strategies.
- Integrate contract tests into CI/CD pipelines.

## What is contract testing
- A contract defines the expected request/response between a consumer and provider.
- **Consumer tests**: Consumer defines what it expects from the provider.
- **Provider verification**: Provider verifies it satisfies all consumer contracts.
- Contracts live in a broker (Pact Broker, PactFlow) for cross-team sharing.

## When to use contract tests
- Microservice-to-microservice API boundaries.
- Frontend-to-backend API contracts.
- Third-party API integration (mock the provider with contracts).
- Event-driven systems (message contract testing).

## Pact workflow
1. **Consumer side**: Write tests that define expected interactions.
2. **Generate pact**: Tests produce a pact file (JSON contract).
3. **Publish**: Upload pact to Pact Broker.
4. **Provider side**: Provider runs verification against published pacts.
5. **Can I Deploy**: Use `can-i-deploy` check in CI before releasing.

## Contract design principles
- Test the contract shape, not business logic (that's for unit/integration tests).
- Use loose matchers (type-based) instead of exact value matching.
- Version contracts when breaking changes are intentional.
- Keep contracts minimal: only fields the consumer actually uses.
- Test error responses and edge cases, not just happy paths.

## Message contract testing
- For event-driven systems (Kafka, RabbitMQ, SNS).
- Consumer defines expected message schema and content.
- Producer verifies published messages match consumer expectations.
- Use content-type matchers for flexible schema evolution.

## CI/CD integration
- Run consumer contract tests as part of consumer CI.
- Run provider verification as part of provider CI.
- Use `can-i-deploy` check before any deployment.
- Block deployment if contract verification fails.
- Tag pacts with environment names (dev, staging, prod).

## Anti-patterns
- Testing full business flows in contract tests (use integration tests instead).
- Exact value matching that breaks on any data change.
- Missing provider states making tests fragile.
- Not running verification in provider CI.
- Ignoring contract test failures as "not my problem".

## Output
- Contract testing architecture plan
- Consumer test examples
- Provider verification setup
- CI/CD integration steps
- Contract evolution guidelines
