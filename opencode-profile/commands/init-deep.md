---
description: Generate hierarchical AGENTS.md knowledge base
agent: full
---

Create hierarchical `AGENTS.md` files for this project.

Rules:
- Analyze structure first using parallel exploration.
- Always generate root `AGENTS.md`.
- Generate subdirectory `AGENTS.md` only where complexity justifies it.
- Preserve useful existing guidance when present.
- Keep each file concise and specific to the directory.

Arguments:
- `$ARGUMENTS` may include `--create-new` or `--max-depth=N`.
