---
name: kubernetes-deploy
description: Design Kubernetes deployments with manifests, Helm charts, and rollout strategies.
license: MIT
compatibility: opencode
metadata:
  category: devops
---

## What I do
- Write production-ready Kubernetes manifests and Helm charts.
- Design deployment strategies (rolling, blue-green, canary).
- Configure auto-scaling, health checks, and resource limits.
- Plan for observability, security, and disaster recovery.

## Manifest essentials
- **Deployment**: Set replicas, resource requests/limits, and update strategy.
- **Service**: Use ClusterIP for internal, LoadBalancer or Ingress for external.
- **ConfigMap/Secret**: Externalize configuration; mount as env vars or files.
- **HPA**: Auto-scale based on CPU, memory, or custom metrics.
- **PDB**: Pod Disruption Budget to maintain availability during updates.

## Resource management
- Always set both `requests` and `limits` for CPU and memory.
- Requests = guaranteed resources; limits = maximum allowed.
- Start conservative, then tune based on actual usage metrics.
- Use resource quotas per namespace to prevent noisy-neighbor issues.
- Set `LimitRange` defaults so no pod runs without limits.

## Health checks
- **Liveness probe**: Restart pod if unhealthy. Use simple health endpoint.
- **Readiness probe**: Remove from service if not ready. Use dependency checks.
- **Startup probe**: Allow slow-starting apps time before liveness kicks in.
- Set appropriate `initialDelaySeconds`, `periodSeconds`, and `failureThreshold`.

## Deployment strategies
- **Rolling update**: Default. Set `maxUnavailable: 0` and `maxSurge: 1` for zero-downtime.
- **Blue-green**: Run two full environments, switch traffic via service selector.
- **Canary**: Route percentage of traffic to new version via Istio or Argo Rollouts.
- **Recreate**: Stop all old, start all new. Only for stateful apps that can't overlap.

## Security
- Run as non-root user with `securityContext.runAsNonRoot: true`.
- Drop all capabilities: `drop: [ALL]`.
- Use read-only root filesystem where possible.
- Use NetworkPolicies to restrict pod-to-pod communication.
- Scan images for vulnerabilities before deployment.
- Use RBAC with least-privilege service accounts.

## Helm chart structure
- `values.yaml`: All user-configurable values with sensible defaults.
- Use `_helpers.tpl` for reusable template functions.
- Include NOTES.txt with post-install instructions.
- Version chart independently from app version.

## Output
- Kubernetes manifest set or Helm chart
- Deployment strategy recommendation
- Resource sizing guidelines
- Security hardening checklist
- Rollback procedure
