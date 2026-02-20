---
name: caching-strategy
description: Design caching layers with invalidation policies, TTL planning, and consistency trade-offs.
license: MIT
compatibility: opencode
metadata:
  category: backend
---

## What I do
- Select appropriate caching layers (browser, CDN, application, database).
- Design cache key schemas and TTL policies.
- Implement invalidation strategies that prevent stale data.
- Balance consistency, latency, and cost.

## Cache layer selection
- **Browser cache**: Static assets, API responses with ETag/Last-Modified.
- **CDN cache**: Public content, media, immutable assets.
- **Application cache (Redis/Memcached)**: Session data, computed results, rate counters.
- **Database query cache**: Materialized views, read replicas.
- **In-process cache**: Hot config, lookup tables, small reference data.

## Key design principles
- Use structured, predictable key schemas: `entity:id:field:version`.
- Include version or hash in keys for safe deployments.
- Namespace keys by tenant in multi-tenant systems.
- Keep key length short but readable for debugging.

## Invalidation strategies
- **TTL-based**: Simple, eventual consistency. Set TTL based on data change frequency.
- **Event-driven**: Invalidate on write/update events. Strongest consistency.
- **Write-through**: Update cache on every write. Low read latency, higher write cost.
- **Write-behind**: Async cache update. Better write performance, eventual consistency.
- **Cache-aside (lazy load)**: Populate on cache miss. Simple but cold-start slow.

## Anti-patterns to avoid
- Cache stampede: Use locking or probabilistic early expiration.
- Unbounded cache growth: Always set maxmemory and eviction policy.
- Caching errors: Never cache 500 responses or transient failures.
- Over-caching: Don't cache data that changes faster than the TTL.
- Missing monitoring: Track hit rate, miss rate, eviction rate, and latency.

## Output
- Cache architecture diagram
- Key schema and TTL policy table
- Invalidation strategy per data type
- Monitoring and alerting plan
