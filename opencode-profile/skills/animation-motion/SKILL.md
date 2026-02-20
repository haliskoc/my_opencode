---
name: animation-motion
description: Design and implement UI animations with CSS, Framer Motion, GSAP, and Web Animations API.
license: MIT
compatibility: opencode
metadata:
  category: frontend
---

## What I do
- Design purposeful animations that improve UX, not distract.
- Implement with CSS transitions, CSS animations, Framer Motion, GSAP, or Web Animations API.
- Ensure performance with GPU-accelerated properties and reduced motion support.
- Create animation systems with consistent timing and easing across the app.

## Design principles
- **Purpose first**: Every animation should serve a UX goal (feedback, orientation, delight).
- **Duration**: Keep most UI transitions between 150ms–400ms. Page transitions 300ms–600ms.
- **Easing**: Use ease-out for entrances, ease-in for exits, ease-in-out for position changes.
- **Consistency**: Create a timing/easing token system and reuse across components.
- **Restraint**: Fewer, meaningful animations beat many decorative ones.

## Animation categories
- **Micro-interactions**: Button press, toggle, hover feedback (50ms–200ms).
- **Transitions**: Page/route changes, modal open/close (200ms–500ms).
- **Loading states**: Skeleton, spinner, progress indicators (loop/indeterminate).
- **Data changes**: List reorder, counter increment, chart update (300ms–600ms).
- **Scroll-driven**: Parallax, reveal-on-scroll, progress bars.
- **Gesture-driven**: Drag, swipe, pinch (frame-locked, no delay).

## Performance rules
- Only animate `transform` and `opacity` for 60fps (GPU-composited).
- Avoid animating `width`, `height`, `top`, `left` (trigger layout reflow).
- Use `will-change` sparingly and remove after animation completes.
- Prefer CSS transitions for simple state changes.
- Use requestAnimationFrame for JavaScript-driven animations.
- Test on low-end devices and throttled CPU.

## Accessibility
- Respect `prefers-reduced-motion` media query.
- Provide instant/no-animation fallback for reduced motion users.
- Never rely on animation alone to convey information.
- Avoid flashing content (seizure risk per WCAG 2.3.1).
- Keep auto-playing animations pausable.

## Library guidance
- **CSS only**: Simple hover, focus, and state transitions.
- **Framer Motion**: React component animations, layout transitions, gestures.
- **GSAP**: Complex timelines, scroll-triggered sequences, SVG animation.
- **Web Animations API**: Native browser API, good for programmatic control.
- **Lottie**: Designer-created vector animations exported from After Effects.

## Output
- Animation system tokens (durations, easings, delays)
- Component animation specifications
- Performance validation checklist
- Accessibility compliance notes
