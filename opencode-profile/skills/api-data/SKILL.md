---
name: api-data
description: "API & Data skills: GraphQL design, REST API patterns, database migration safety."
license: MIT
metadata:
  category: api-data
  contains: graphql-designer, api-designer, db-migration-safety
---

# API & Data Skills

## 1. GraphQL Design

Design type-safe GraphQL schemas with efficient resolvers and N+1 prevention.

### Schema principles
- Model types around domain entities, not database tables.
- Non-null by default, nullable only when genuinely optional.
- Use DataLoader for batching to prevent N+1 queries.
- Cursor-based pagination (Relay connection spec) for infinite scroll.
- Set query depth and complexity limits to prevent abuse.
- Disable introspection in production.

---

## 2. REST API Design

Design consistent, discoverable REST APIs with proper resource modeling.

### Principles
- Resource-oriented URLs: `/users/{id}/orders`.
- Proper HTTP methods: GET (read), POST (create), PUT (replace), PATCH (update), DELETE.
- Consistent error response envelope: `{ error: { code, message, details } }`.
- Versioning strategy: URL path (`/v1/`) or header (`Accept-Version`).
- Pagination: cursor or offset with `Link` headers.
- Rate limiting with `X-RateLimit-*` headers.
- HATEOAS links for discoverability where practical.

---

## 3. Database Migration Safety

Execute schema migrations safely with zero-downtime and rollback capability.

### Rules
- Prefer additive changes (add column, add table).
- Never rename or drop columns in a single step.
- Use expand-contract pattern: add new → migrate data → remove old.
- Always write rollback migration.
- Test migrations on production-size data before deploying.
- Lock timeout protection for ALTER TABLE operations.
- Blue-green or rolling deployment for schema changes.
