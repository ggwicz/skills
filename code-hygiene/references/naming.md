# CH-09: Naming as Documentation

## Rules

- **Functions** → verbs/verb phrases: `calculateTotal`, `sendNotification`, `validateInput`, `isEligible`
- **Booleans** → questions that read naturally in conditionals: `isReady`, `hasPermission`, `shouldRetry`, `canDelete`
- **Collections** → plural nouns: `users`, `orderItems`, `activeConnections`
- **Avoid abbreviations** unless universal (`id`, `url`, `http` are fine; `usr`, `amt`, `proc`, `mgr` are not)
- **Scope-proportional length**: loop index `i` is fine; a module-level constant should be descriptive (`MAX_RETRY_ATTEMPTS`, not `MAX`)
- **No redundant context**: inside a `User` class, use `name` not `userName`; inside `email_service.py`, use `send()` not `send_email()`
- **Don't name things for what they are** — name them for what they mean: `data`, `info`, `item`, `result`, `value` are almost always too vague

## Detection Signals

### Vague Names (always flag)

`data`, `info`, `item`, `result`, `value`, `temp`, `thing`, `stuff`, `obj`, `element`, `node`, `entry`, `record`, `entity`, `payload`

### Bad Abbreviations (flag outside their idiomatic context)

`usr`, `amt`, `proc`, `mgr`, `btn`, `msg`, `cb`, `fn`, `cfg`, `tmp`, `str`, `num`, `val`, `idx`, `cnt`, `len`, `buf`, `impl`, `util`

### Context-Dependent Abbreviations (flag only outside their idiomatic use)

- `err` — idiomatic in Go (`if err != nil`); flag in other languages
- `req`, `res` — idiomatic in Express.js/Koa middleware signatures (`(req, res, next) =>`); flag elsewhere
- `ctx` — idiomatic in Go (`context.Context`) and Python (Click/Flask context); flag when used as a generic variable name
- `env` — acceptable when referring to environment configuration; flag when used as a generic variable name

### Acceptable Abbreviations (never flag)

`id`, `url`, `http`, `html`, `css`, `api`, `db`, `io`, `os`, `ui`, `i`/`j`/`k` (loop indices)

## Refactoring

Rename Variable/Function/Class
