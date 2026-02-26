# CH-03: Guard Clauses (Early Returns)

## Rules

- Check for invalid/empty/null/unauthorized states first, return or throw immediately
- NEVER nest the main logic inside an `if (valid)` block — invert the condition and return early
- Each guard clause should be independent and handle exactly one concern
- After all guards pass, the remaining code can trust its preconditions without further checking

## Detection Signals

- Nesting depth > 2 levels
- Main logic wrapped inside `if (valid) { ... }`
- Pyramid-shaped indentation pattern
- Multiple conditions checked in a single deeply-nested block

## Pattern

```
# AVOID: nested pyramid
function processOrder(order) {
  if (order) {
    if (order.items.length > 0) {
      if (order.payment) {
        // ...actual logic buried 3 levels deep
      }
    }
  }
}

# PREFER: flat, sequential guards
function processOrder(order) {
  if (!order) return null;
  if (order.items.length === 0) return null;
  if (!order.payment) throw new Error("Missing payment");

  // happy path — no nesting
  // ...
}
```

## Refactoring

Replace Nested Conditional with Guard Clauses
