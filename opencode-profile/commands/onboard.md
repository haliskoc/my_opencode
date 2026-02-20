---
description: Generate onboarding documentation for new developers
agent: full
---

Create a developer onboarding guide for this project.

Workflow:
1. Explore the project structure, README, and configuration files.
2. Detect the tech stack, build system, and key dependencies.
3. Identify setup prerequisites (runtime versions, databases, services).
4. Map the development workflow (build, test, run, deploy commands).

Generate a comprehensive onboarding document covering:
- **Project overview**: What this project does in 2-3 sentences.
- **Prerequisites**: Required tools, runtimes, and versions.
- **Setup steps**: Clone, install, configure, run (copy-paste ready).
- **Project structure**: Key directories and their purpose.
- **Development workflow**: How to make changes, run tests, and submit PRs.
- **Key concepts**: Domain-specific terms and patterns used in the codebase.
- **Common tasks**: How to add a feature, fix a bug, update dependencies.
- **Troubleshooting**: Common setup issues and their solutions.
- **Contacts**: Where to ask questions (if detectable from repo config).

Arguments:
- `$ARGUMENTS` can specify: `--output ONBOARDING.md` to write to file, `--depth brief|full`.
