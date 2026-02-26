# CH-06: Principle of Least Surprise

## Rules

- Functions named `get_*` or `find_*` must not have side effects (no writes, no mutations, no network calls unless clearly a fetch)
- Don't mix queries and commands — a function should either return a value OR cause a side effect, not both (command-query separation)
- Parameters should behave as their names suggest — `timeout` should be in seconds (or named `timeout_ms`), not some internal tick format
- Boolean parameters are almost always surprising at the call site: `process(data, true, false)` → prefer named options, enums, or separate methods
- Avoid "action at a distance" — don't mutate something the caller didn't explicitly pass to you

## Detection Signals

- `get_*` or `find_*` function that writes to DB, sends email, or mutates state
- Function that both returns a value and causes a side effect
- Boolean parameters visible at call site: `foo(x, true, false)`
- Function that mutates an object it received but wasn't asked to modify
- Parameter names that don't match their actual units or format

## Pattern

```
# AVOID: get_* with side effects — caller expects a pure query
def get_active_users(db):
    users = db.query("SELECT * FROM users WHERE active = true")
    db.execute("UPDATE users SET last_checked = NOW() WHERE active = true")
    analytics.track("active_users_fetched", count=len(users))
    return users

# PREFER: separate query from side effects
def get_active_users(db):
    return db.query("SELECT * FROM users WHERE active = true")

def mark_users_checked(db, user_ids):
    db.execute("UPDATE users SET last_checked = NOW() WHERE id = ANY(%s)", [user_ids])
```

## Refactoring

Separate Query from Modifier, Replace Parameter with Explicit Methods
