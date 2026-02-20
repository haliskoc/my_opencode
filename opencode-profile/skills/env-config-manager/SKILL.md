---
name: env-config-manager
description: Manage environment configuration, secret rotation, and deployment-safe config patterns.
license: MIT
compatibility: opencode
metadata:
  category: devops
---

## What I do
- Design environment configuration strategy across dev, staging, and production.
- Implement secret management with rotation and access controls.
- Prevent config-related outages with validation and safe defaults.
- Separate build-time, deploy-time, and runtime configuration.

## Configuration hierarchy
1. **Defaults in code**: Safe fallback values for non-sensitive config.
2. **Config files**: Environment-specific overrides (JSON, YAML, TOML).
3. **Environment variables**: Deployment-specific values injected by platform.
4. **Secret manager**: Sensitive values (API keys, DB passwords) via Vault, AWS SSM, etc.
5. **Runtime overrides**: Feature flags and dynamic config via config service.

## Environment variable best practices
- Use prefixed names: `APP_DATABASE_URL`, `APP_REDIS_HOST`.
- Validate all required env vars at startup, fail fast if missing.
- Never commit real values; use `.env.example` with placeholder values.
- Document each variable: purpose, format, default, required/optional.
- Use typed parsing: convert strings to numbers, booleans, lists at load time.

## Secret management
- **Never in code or git**: Use `.gitignore` for `.env` files.
- **Rotation policy**: Rotate secrets regularly (90 days for keys, 30 for passwords).
- **Least privilege**: Each service gets only the secrets it needs.
- **Audit trail**: Log secret access (not values) for compliance.
- **Emergency rotation**: Have a runbook for immediate secret rotation on breach.

## Config validation
- Validate config schema at application startup.
- Define required vs optional fields with types and constraints.
- Fail fast with clear error messages about what's missing or invalid.
- Test config loading in CI with representative environment files.

## Multi-environment patterns
- Same code artifact across all environments; only config changes.
- Use environment names consistently: `development`, `staging`, `production`.
- Never use production secrets in lower environments.
- Feature flags for environment-specific behavior, not config branching.

## Output
- Configuration architecture diagram
- Environment variable catalog with documentation
- Secret rotation runbook
- Config validation implementation plan
