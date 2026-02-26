# CH-08: Immutability by Default

## Rules

- Declare variables as `const`/`final`/`let` (not `var`) by default
- Return new collections/objects rather than mutating arguments: `return [...items, newItem]` not `items.push(newItem)`
- If a function receives data, don't mutate it — copy and transform
- Use the language's immutability tools: `Object.freeze`, `readonly` properties, frozen dataclasses, `copy()` methods
- Reserve mutability for performance-critical hot paths where profiling proves it matters

## Detection Signals

- `var` in JavaScript/TypeScript where `const` would work
- `let` in JavaScript/TypeScript where the variable is never reassigned
- Functions that mutate their arguments (e.g., `items.push()`, `dict.update()`, `list.sort()`)
- Shared mutable state accessed from multiple functions
- In-place collection modification: `.push()`, `.pop()`, `.splice()`, `.sort()`, `.reverse()`

## Language-Specific Immutable Alternatives

| Mutable | Immutable | Language |
|---------|-----------|----------|
| `arr.push(x)` | `[...arr, x]` | JS/TS |
| `arr.sort()` | `arr.toSorted()` | JS/TS (ES2023) |
| `arr.reverse()` | `arr.toReversed()` | JS/TS (ES2023) |
| `list.append(x)` | `[*list, x]` | Python |
| `dict[k] = v` | `{**dict, k: v}` | Python |
| `var x = 1` | `let x = 1` | Swift |
| `var x = 1` | `val x = 1` | Kotlin |

## Refactoring

Remove Setting Method, Change Reference to Value
