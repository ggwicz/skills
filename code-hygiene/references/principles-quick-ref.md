# Code Hygiene Principles Quick Reference

## Detection

What to look for when reviewing code. Default severity may be escalated — see `severity-rubric.md`.

| ID | Smell Name | Default Severity | Detection Signal |
|----|-----------|------------------|-----------------|
| CH-01 | Fragile Base Class | High | Inheritance used for code reuse, deep class hierarchies |
| CH-02 | Hidden Dependency | High | `import` + instantiate inside constructor/method, hard-coded infrastructure |
| CH-03 | Nested Pyramid | Medium | Nested conditionals, `if (valid) { ... }` wrapping main logic |
| CH-04 | God Function / God Class | High | Long functions, classes named "Manager"/"Handler"/"Utils", mixed abstraction levels |
| CH-05 | Silent Failure | High | Bare `except:`/`catch {}`, silent `None`/`null` returns, swallowed errors |
| CH-06 | Surprising Side Effect | Medium | `get_*`/`find_*` with side effects, boolean params at call site, command-query mixing |
| CH-07 | Feature Envy | Medium | External code reads multiple fields from an object to make a decision |
| CH-08 | Mutable Shared State | Medium | `var` (JS), argument mutation, shared mutable state, in-place collection modification |
| CH-09 | Uncommunicative Name | Low | Vague names (`data`, `info`, `result`, `item`, `value`), abbreviations (`usr`, `mgr`, `amt`) |
| CH-10 | Impure Core | High | I/O calls (db, http, file, print) inside business logic functions |

## Thresholds

Numeric defaults. Deviate when you can articulate a specific reason.

| Metric | Threshold | Principle |
|--------|-----------|-----------|
| Function length | > 25 lines | CH-04 |
| Nesting depth | > 2 levels | CH-03 |
| Parameter count | > 4 params | CH-02 / CH-04 |
| Inheritance depth | > 1 level (2 max) | CH-01 |
| Class length | > 200 lines | CH-04 |
| Cyclomatic complexity | > 10 per function | CH-03 / CH-04 |
| Boolean parameters | > 0 at call site | CH-06 |
| Field accesses before conditional | 2+ on same object | CH-07 |

## Refactoring

What to suggest in the "Refactoring" field of each finding.

| ID | Named Refactoring |
|----|-------------------|
| CH-01 | Replace Superclass with Delegate |
| CH-02 | Extract Parameter, Introduce Constructor Injection |
| CH-03 | Replace Nested Conditional with Guard Clauses |
| CH-04 | Extract Function, Extract Class |
| CH-05 | Replace Error Code with Exception |
| CH-06 | Separate Query from Modifier, Replace Parameter with Explicit Methods |
| CH-07 | Move Function, Encapsulate Record |
| CH-08 | Remove Setting Method, Change Reference to Value |
| CH-09 | Rename Variable/Function/Class |
| CH-10 | Extract I/O to Caller, Parameterize Side Effects |
