---
name: state-management
description: Choose and implement state management patterns with Zustand, Redux, Jotai, Signals, or Context API.
license: MIT
compatibility: opencode
metadata:
  category: frontend
---

## What I do
- Evaluate state management needs and recommend the right tool.
- Implement stores with clean separation of server state vs client state.
- Prevent common pitfalls: unnecessary re-renders, stale closures, prop drilling.
- Design state architecture that scales with application complexity.

## Decision framework

| Need | Recommended |
|------|-------------|
| Simple component state | `useState` / `useReducer` |
| Theme/auth shared state | React Context (small, rarely changing) |
| Complex client state | Zustand (simple), Redux Toolkit (large teams) |
| Atomic/granular reactivity | Jotai, Recoil, or Signals |
| Server state (API data) | TanStack Query, SWR, or RTK Query |
| Form state | React Hook Form, Formik |
| URL state | Search params, router state |

## Architecture principles
- **Separate concerns**: Server state (TanStack Query) vs client state (Zustand/Redux).
- **Minimize global state**: Only globalize what multiple unrelated components need.
- **Derive, don't duplicate**: Compute derived values from source state, don't store copies.
- **Normalize**: For relational data, normalize into ID-indexed maps.
- **Immutability**: Always create new references; never mutate state objects directly.

## Zustand patterns
- Create small, focused stores (auth store, UI store, cart store).
- Use selectors to prevent unnecessary re-renders: `useStore(s => s.count)`.
- Use middleware for persistence, devtools, and logging.
- Avoid putting server-fetched data in Zustand; use TanStack Query instead.

## Redux Toolkit patterns
- Use `createSlice` for reducers with Immer-powered immutable updates.
- Use RTK Query for API data fetching and caching.
- Keep slices small and domain-focused.
- Use `createSelector` (reselect) for memoized derived state.

## Anti-patterns to avoid
- Storing everything in global state (components should own their UI state).
- Mixing server cache data with UI state in the same store.
- Deep nesting in state shape making updates complex.
- Missing selectors causing full-tree re-renders on any state change.
- Synchronizing state between multiple sources of truth.

## Output
- State architecture diagram
- Store structure recommendation
- Migration plan if refactoring existing state
- Performance impact analysis
