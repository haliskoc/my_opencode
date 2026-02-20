---
name: i18n-localizer
description: Build internationalization infrastructure with translation workflows, RTL support, and locale management.
license: MIT
compatibility: opencode
metadata:
  category: frontend
---

## What I do
- Set up i18n infrastructure with proper key management and fallback chains.
- Design translation workflows for developer and translator collaboration.
- Implement RTL layout support and bidirectional text handling.
- Handle locale-specific formatting (dates, numbers, currencies, plurals).

## Architecture decisions
- **Library choice**: react-intl, next-intl, i18next, vue-i18n, or built-in Intl API.
- **Key naming**: Use dot-notation namespaces (`page.settings.title`), not random strings.
- **File structure**: One JSON/YAML per locale per namespace, or single file per locale.
- **Default locale**: Always define a complete default locale as fallback.
- **Lazy loading**: Load locale files on demand for large apps.

## Translation key best practices
- Keys should describe purpose, not content: `button.submit` not `button.click_here`.
- Use ICU message format for plurals, gender, and select patterns.
- Avoid string concatenation; use interpolation variables.
- Keep translation strings complete sentences for proper grammar across languages.
- Provide context comments for translators on ambiguous keys.

## RTL support
- Use CSS logical properties (`margin-inline-start` instead of `margin-left`).
- Set `dir="rtl"` on the HTML root based on locale.
- Mirror layouts automatically with `direction` CSS property.
- Test with actual RTL content, not just flipped English.
- Handle bidirectional text (mixed LTR/RTL) with Unicode markers.

## Formatting
- **Dates**: Use `Intl.DateTimeFormat` with locale-aware options.
- **Numbers**: Use `Intl.NumberFormat` for thousands separators and decimals.
- **Currency**: Always include currency code; format per locale rules.
- **Plurals**: Use `Intl.PluralRules` or ICU plural syntax.
- **Relative time**: Use `Intl.RelativeTimeFormat` for "3 days ago" patterns.

## Workflow
1. Extract strings from code into locale files.
2. Send new/changed keys to translation service or team.
3. Import completed translations and validate completeness.
4. Run visual regression tests across locales.
5. Monitor missing translation keys in production.

## Output
- i18n architecture and library recommendation
- Key naming convention guide
- RTL implementation checklist
- Locale formatting examples
- Translation workflow process
