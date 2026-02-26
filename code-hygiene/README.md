# code-hygiene

Review source code for structural quality violations — hidden dependencies, deep nesting, god functions, silent failures, mutable shared state — across any programming language. Produces a findings report with concrete refactoring suggestions.

## Install

```bash
npx skills add ggwicz/skills --skill code-hygiene
```

## What it checks

10 language-agnostic principles, each with a named code smell, detection thresholds, and a named refactoring technique:

| ID | Smell | Default Severity |
|----|-------|-----------------|
| CH-01 | Fragile Base Class | High |
| CH-02 | Hidden Dependency | High |
| CH-03 | Nested Pyramid | Medium |
| CH-04 | God Function / God Class | High |
| CH-05 | Silent Failure | High |
| CH-06 | Surprising Side Effect | Medium |
| CH-07 | Feature Envy | Medium |
| CH-08 | Mutable Shared State | Medium |
| CH-09 | Uncommunicative Name | Low |
| CH-10 | Impure Core | High |

## Output

Writes findings to `code-hygiene-findings-YYYYMMDD.md` in the project root. Each finding includes the line, the violated principle, a named refactoring technique, and a concrete suggested rewrite.

## License

[MIT](../LICENSE)
