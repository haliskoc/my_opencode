---
name: frontend
description: "Frontend skills: animation, state management, responsive design, i18n, UI/UX, accessibility."
license: MIT
metadata:
  category: frontend
  contains: animation-motion, state-management, mobile-responsive, i18n-localizer, frontend-ui-builder, frontend-ui-ux, frontend-accessibility
---

# Frontend Engineering Skills

## 1. Animation & Motion

Design purposeful animations with CSS, Framer Motion, GSAP, or Web Animations API.

### Principles
- Every animation should serve a UX goal (feedback, orientation, delight).
- Duration: 150ms–400ms for UI transitions, 300ms–600ms for page transitions.
- Easing: ease-out for entrances, ease-in for exits.
- Only animate `transform` and `opacity` for 60fps (GPU-composited).
- Respect `prefers-reduced-motion` media query.

---

## 2. State Management

Choose and implement state patterns with Zustand, Redux, Jotai, Signals, or Context API.

### Decision framework
| Need | Recommended |
|------|-------------|
| Simple component state | useState / useReducer |
| Theme/auth shared | React Context |
| Complex client state | Zustand (simple), Redux Toolkit (large teams) |
| Atomic reactivity | Jotai, Signals |
| Server state | TanStack Query, SWR |
| Form state | React Hook Form |

### Principles
- Separate server state (TanStack Query) from client state (Zustand).
- Derive, don't duplicate. Compute from source state.
- Use selectors to prevent unnecessary re-renders.

---

## 3. Mobile & Responsive Design

Build mobile-first, touch-friendly, responsive layouts.

### Approach
- Start with smallest viewport, progressively enhance with `min-width`.
- Minimum touch target: 44×44px.
- Handle `100dvh` issues on mobile.
- Account for safe areas with `env(safe-area-inset-*)`.
- Use responsive images with `srcset` and `sizes`.
- Test on actual devices, not just DevTools resize.

---

## 4. Internationalization (i18n)

Build multi-language infrastructure with RTL support and locale management.

### Architecture
- Use dot-notation key namespaces: `page.settings.title`.
- Use ICU message format for plurals, gender, select.
- Avoid string concatenation; use interpolation variables.
- CSS logical properties for RTL (`margin-inline-start`).
- Use `Intl.DateTimeFormat`, `Intl.NumberFormat` for locale-aware formatting.

---

## 5. UI/UX Building

Build production-ready UI components with design system alignment.

### Principles
- Component-first: reusable, composable, single-responsibility.
- Design tokens: colors, spacing, typography from a single source.
- Responsive by default.
- Dark mode support.
- Smooth transitions between states.

---

## 6. Accessibility (a11y)

Ensure WCAG 2.1 AA compliance with semantic HTML, ARIA, keyboard navigation, and screen readers.

### Checklist
- Semantic HTML elements over generic divs.
- All interactive elements keyboard-accessible.
- ARIA labels for non-text content.
- Color contrast ratio ≥ 4.5:1 for text.
- Focus indicators visible and clear.
- Form fields with associated labels.
- Skip navigation links for screen readers.
