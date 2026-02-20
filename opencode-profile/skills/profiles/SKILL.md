---
name: profiles
description: "Industry profiles: SaaS, E-commerce, Fintech, Game Backend — domain-specific engineering priorities."
license: MIT
metadata:
  category: profiles
  contains: profile-saas, profile-ecommerce, profile-fintech, profile-game-backend
---

# Industry Profiles

Use with `/use-profile <name>` to apply domain-specific priorities.

## 1. SaaS (`saas`)
- Multi-tenant safety: data isolation, tenant-scoped queries.
- Predictable releases with feature flags and backward compatibility.
- Observability: per-tenant metrics, error tracking, SLO dashboards.
- Subscription and billing integration safety.

## 2. E-Commerce (`ecommerce`)
- Conversion-first: optimize checkout flow, minimize friction.
- Catalog performance: fast search, filtering, pagination.
- Payment safety: PCI compliance, idempotent transactions.
- SEO preservation: structured data, canonical URLs, sitemap.
- Safe failure modes: show cached products if backend is degraded.

## 3. Fintech (`fintech`)
- Compliance first: audit trails, regulatory requirements (PSD2, SOX).
- Correctness: decimal arithmetic, rounding rules, currency handling.
- Traceability: every transaction logged with correlation ID.
- Risk-controlled changes: phased rollouts, rollback capability.
- Security: encryption at rest/transit, MFA, anomaly detection.

## 4. Game Backend (`game-backend`)
- Low latency: sub-100ms response times for game actions.
- Concurrency: handle thousands of simultaneous connections.
- Live-ops: hot-fix capability without downtime.
- Player experience: fair matchmaking, anti-cheat measures.
- State management: eventual consistency acceptable, but player-visible data must be consistent.
