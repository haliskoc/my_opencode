---
description: Generate OpenAPI/Swagger specification from project API routes
agent: full
---

Generate an OpenAPI specification for the current project's API.

Workflow:
1. Detect the API framework in use:
   - Express, Fastify, Hono, Koa (Node.js)
   - FastAPI, Flask, Django (Python)
   - Gin, Echo, Fiber (Go)
   - Spring Boot (Java)
2. Scan route definitions, controllers, and handler files.
3. Extract endpoints, HTTP methods, path parameters, query parameters, and request/response bodies.
4. Detect authentication schemes (Bearer, API key, OAuth).
5. Infer request/response schemas from TypeScript types, Zod schemas, Pydantic models, or inline validation.

Output:
- OpenAPI 3.1 specification in YAML format.
- Endpoint summary table with method, path, description, and auth requirement.
- Schema definitions for request/response bodies.
- Notes on endpoints that need manual documentation.

Arguments:
- `$ARGUMENTS` can specify: `--output openapi.yaml` to write to file, `--format json|yaml`, `--version 3.0|3.1`.
