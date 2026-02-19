---
description: Prepare a release-ready shipping flow from changes to notes
agent: atlas
---

Run an end-to-end ship flow for the current project.

Workflow:
1. Inspect git status and diff.
2. Run project checks with the detected toolchain:
   - npm: `npm run lint`, `npm test`, `npm run build`
   - pnpm: `pnpm lint`, `pnpm test`, `pnpm build`
   - bun: `bun run lint`, `bun test`, `bun run build`
3. If checks fail, summarize blockers and propose fix steps.
4. If checks pass, produce:
   - release checklist
   - commit/PR summary draft
   - release notes draft
   - rollback checklist

Be explicit about which commands were run and their outcomes.
