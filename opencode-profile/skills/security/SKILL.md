---
name: security
description: "Security skills: code audit, vulnerability detection, authentication, secret management."
license: MIT
metadata:
  category: security
  contains: security-audit
---

# Security Skills

## Security Audit

Audit code and configuration for common security vulnerabilities.

### Checklist
- **Authentication**: Secure password hashing (bcrypt/argon2), MFA support, session management.
- **Authorization**: Role-based or attribute-based access control, least privilege.
- **Input validation**: Whitelist validation, parameterized queries (SQL injection), output encoding (XSS).
- **Secret handling**: No hardcoded secrets, environment variables, rotation policy.
- **Dependencies**: Regular `npm audit` / `pip audit`, pin versions, monitor CVEs.
- **HTTPS**: TLS everywhere, HSTS headers, secure cookie flags.
- **Headers**: CSP, X-Frame-Options, X-Content-Type-Options.
- **Logging**: Log auth events, never log secrets, correlation IDs.

### Common vulnerabilities
- SQL/NoSQL injection
- Cross-site scripting (XSS)
- Cross-site request forgery (CSRF)
- Insecure deserialization
- Server-side request forgery (SSRF)
- Broken access control
- Security misconfiguration
- Sensitive data exposure
