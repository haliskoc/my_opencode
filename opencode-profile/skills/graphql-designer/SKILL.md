---
name: graphql-designer
description: Design GraphQL schemas with efficient resolvers, N+1 prevention, and federation readiness.
license: MIT
compatibility: opencode
metadata:
  category: api
---

## What I do
- Design type-safe GraphQL schemas aligned with domain models.
- Prevent N+1 query problems with DataLoader and batching.
- Plan pagination, filtering, and error handling conventions.
- Prepare for schema federation in microservice architectures.

## Schema design principles
- Model types around domain entities, not database tables.
- Use nullable fields intentionally: non-null by default, nullable only when data may genuinely be absent.
- Define clear input types for mutations separate from output types.
- Use enums for bounded value sets.
- Prefer interfaces and unions for polymorphic types.

## Resolver patterns
- **DataLoader**: Batch and cache database lookups per request to prevent N+1.
- **Field-level resolvers**: Only resolve fields that are actually requested.
- **Context injection**: Pass auth, tenant, and request context through resolver context.
- **Error handling**: Use union types (Result pattern) or structured error extensions.

## Pagination
- Prefer cursor-based pagination (Relay connection spec) for infinite scroll.
- Use offset-based only for admin dashboards with page numbers.
- Always include `totalCount`, `hasNextPage`, and `endCursor`.

## Performance
- Set query depth and complexity limits to prevent abuse.
- Use persisted queries in production to reduce parsing overhead.
- Enable automatic query plan caching where supported.
- Monitor resolver execution time per field.

## Security
- Validate and authorize at the resolver level, not just the gateway.
- Rate limit by query complexity, not just request count.
- Disable introspection in production unless needed.
- Sanitize user-provided filter and search inputs.

## Output
- Schema definition with type annotations
- Resolver architecture with DataLoader plan
- Pagination and error handling conventions
- Performance and security checklist
