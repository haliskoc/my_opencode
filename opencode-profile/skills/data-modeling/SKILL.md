---
name: data-modeling
description: Design database schemas with normalization, indexing strategy, and evolution planning.
license: MIT
compatibility: opencode
metadata:
  category: backend
---

## What I do
- Design relational and document schemas aligned with access patterns.
- Apply normalization (1NF–BCNF) and strategic denormalization.
- Plan index strategy for query performance.
- Design schema evolution paths with backward compatibility.

## Schema design workflow
1. Identify entities, relationships, and cardinality.
2. Map primary access patterns and query shapes.
3. Normalize to 3NF, then selectively denormalize for read performance.
4. Define primary keys, foreign keys, and unique constraints.
5. Add indexes aligned with WHERE, JOIN, and ORDER BY patterns.
6. Plan for soft deletes, audit columns, and multi-tenancy if needed.

## Indexing strategy
- **Composite indexes**: Column order must match query filter/sort order.
- **Covering indexes**: Include all SELECT columns to avoid table lookups.
- **Partial indexes**: Filter unused rows to reduce index size.
- **Unique constraints**: Enforce business rules at the database level.
- **Avoid over-indexing**: Each index adds write overhead.

## Data types and constraints
- Use the narrowest type that fits (INT vs BIGINT, VARCHAR length).
- Always add NOT NULL unless the column is genuinely optional.
- Use ENUM or CHECK constraints for bounded value sets.
- Store timestamps in UTC with timezone awareness.
- Use UUID v7 or ULID for distributed primary keys when needed.

## Schema evolution
- Prefer additive migrations (add column, add table).
- Avoid renaming or removing columns in high-traffic systems without phased rollout.
- Use expand-contract pattern for breaking changes.
- Always plan rollback migration alongside forward migration.

## Output
- Entity-relationship diagram (Mermaid or text)
- Table definitions with types and constraints
- Index plan with justification
- Migration sequence with rollback notes
