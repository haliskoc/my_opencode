---
name: mobile-responsive
description: Build mobile-first, touch-friendly, responsive layouts with viewport and device awareness.
license: MIT
compatibility: opencode
metadata:
  category: frontend
---

## What I do
- Design mobile-first responsive layouts that adapt across breakpoints.
- Implement touch-friendly interactions and gestures.
- Handle viewport units, safe areas, and device-specific quirks.
- Optimize performance for mobile networks and lower-powered devices.

## Mobile-first approach
- Start with the smallest viewport and progressively enhance.
- Use `min-width` media queries to add complexity at larger sizes.
- Design content hierarchy for single-column first.
- Ensure all interactions work with touch before adding hover enhancements.

## Breakpoint strategy
- **Small**: 0–639px (phones, portrait)
- **Medium**: 640–1023px (tablets, landscape phones)
- **Large**: 1024–1279px (small laptops, tablets landscape)
- **Extra large**: 1280px+ (desktops)
- Use content-driven breakpoints over device-driven when possible.

## Touch interaction patterns
- **Minimum touch target**: 44×44px (Apple HIG) or 48×48dp (Material).
- **Touch feedback**: Visual response within 100ms of touch.
- **Swipe gestures**: Use for navigation, dismiss, reveal actions.
- **Pull to refresh**: Standard pattern for list/feed content.
- **Long press**: Use sparingly; always provide alternative access.
- **No hover dependency**: Never hide essential features behind hover-only states.

## Viewport and layout
- Use CSS logical properties for RTL compatibility.
- Handle `100vh` issues on mobile (use `100dvh` or `100svh`).
- Account for safe areas with `env(safe-area-inset-*)`.
- Use `scroll-snap` for carousel and gallery patterns.
- Prevent horizontal overflow causing layout shift.

## Performance on mobile
- Lazy load images below the fold with `loading="lazy"`.
- Use responsive images with `srcset` and `sizes`.
- Minimize JavaScript bundle for faster parse on slow CPUs.
- Reduce DOM depth for faster rendering.
- Use `content-visibility: auto` for long scrollable lists.
- Test with throttled CPU (4x slowdown) and slow 3G network.

## Testing
- Test on actual devices, not just browser DevTools resize.
- Validate with both iOS Safari and Android Chrome.
- Check landscape and portrait orientations.
- Test with on-screen keyboard open (input fields, forms).
- Verify accessibility with mobile screen readers (VoiceOver, TalkBack).

## Output
- Responsive layout plan with breakpoints
- Touch interaction specifications
- Mobile performance optimization checklist
- Device testing matrix
