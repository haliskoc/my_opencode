---
description: Validate that required environment variables are set
agent: full
---

Check that all required environment variables are properly configured.

Workflow:
1. Scan the project for environment variable usage:
   - `process.env.VAR_NAME` (Node.js)
   - `os.environ["VAR_NAME"]` or `os.getenv("VAR_NAME")` (Python)
   - `os.Getenv("VAR_NAME")` (Go)
   - `.env` files, docker-compose env sections, CI config
2. Check for `.env.example` or `.env.template` files.
3. For each detected variable, check if it is currently set (without printing values).
4. Categorize as: required, optional, or has default.

Output format:
| Variable | Status | Source | Required | Has Default |
|----------|--------|--------|----------|-------------|
| OPENAI_API_KEY | ✅ Set | .env | Yes | No |
| DATABASE_URL | ❌ Missing | docker-compose | Yes | No |
| LOG_LEVEL | ⚠️ Using default | app config | No | Yes (info) |

Summary:
- Total variables detected: X
- Set: X
- Missing (required): X — these will cause failures.
- Missing (optional): X — using defaults.

If any required variables are missing, provide setup instructions.
