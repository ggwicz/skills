# Severity Rubric

Use these definitions to classify each finding.

## High — Structural damage

The code is hard to test, hard to change safely, or hides critical behavior. Fix these first.

**Triggers:** hidden dependencies instantiated inside constructors/methods (CH-02), deep inheritance hierarchies used for code reuse (CH-01), business logic mixed with I/O calls (CH-10), swallowed exceptions or bare `except:`/`catch {}` (CH-05), functions doing multiple unrelated things with mixed abstraction levels (CH-04).

| Before | After | Why high |
|--------|-------|----------|
| `self.db = PostgresConnection("prod:5432")` inside constructor | `def __init__(self, db):` with injected dependency | Hidden dependency — untestable, tightly coupled to Postgres |
| 200-line function that validates, queries DB, transforms data, and sends email | 4 focused functions: validate, query, transform, notify | God function — every change risks breaking unrelated behavior |
| `except: pass` swallowing all errors | `except ConnectionError as e: logger.error(e); raise` | Silent failure — bugs propagate invisibly |

## Medium — Readability tax

The code works but forces readers to work harder than necessary. Fix after high-severity items.

**Triggers:** nesting depth > 2 without guard clauses (CH-03), feature envy — external code reading multiple fields to decide (CH-07), mutable state where immutable would work (CH-08), surprising side effects in getter/query functions (CH-06), boolean parameters at call sites.

| Before | After | Why medium |
|--------|-------|------------|
| 3 levels of nested `if` wrapping the main logic | Guard clauses at top, flat happy path | Nested pyramid — reader maintains a mental stack |
| `if user.role == "admin" and user.active and not user.suspended:` | `user.can_perform("delete")` | Feature envy — decision logic belongs inside User |
| `process(data, true, false, true)` | `process(data, options={validate: true, dryRun: false, verbose: true})` | Boolean params — call site is unreadable |

## Low — Polish

Functional and readable but could be tighter. Address if time permits.

**Triggers:** vague names that are still partially understandable (CH-09), minor immutability opportunities like `const` vs `let` (CH-08), long functions only slightly over the 25-line threshold (CH-04).

| Before | After | Why low |
|--------|-------|---------|
| `let result = calculate(x)` where result is never reassigned | `const result = calculate(x)` | Minor — `let` works but `const` signals intent |
| `data` as a variable name in a small function | `orderItems` or `userRecords` | Vague but understandable from context |
| 30-line function with clear single responsibility | Consider extracting, but not urgent | Slightly over threshold; judgment call |

## Severity Escalation

The default severity for each principle is listed in `principles-quick-ref.md`. Escalate to the next severity level when a violation intersects with:

- **Concurrency** — mutable shared state (CH-08) accessed from multiple threads/async tasks → escalate to High
- **Security boundaries** — silent failures (CH-05) in authentication or authorization code → escalate to High
- **Public API surfaces** — surprising side effects (CH-06) or uncommunicative names (CH-09) in exported/public interfaces → escalate to Medium or High
