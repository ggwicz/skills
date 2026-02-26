# CH-05: Fail Fast, Fail Loudly

## Rules

- Validate at system boundaries (API endpoints, function entry, config loading, user input)
- Throw/raise with descriptive messages that include the actual bad value: `f"Expected positive amount, got {amount}"`
- NEVER silently return `None`, `null`, `[]`, or `""` to indicate an error condition — use exceptions or result types
- NEVER use bare `except:` / `catch {}` that swallows all errors
- Catch specific exceptions, handle them specifically, or let them propagate
- If a function receives input it doesn't know how to handle, fail — don't guess

## Detection Signals

- Bare `except:` or `catch {}` with no specific exception type
- `except Exception: pass` or similar swallowing patterns
- Functions returning `None`/`null` for both "not found" and "error" cases
- Empty `catch` blocks
- Error messages without the actual bad value
- `try/except` wrapping entire function bodies

## Pattern

```
# AVOID: silent failure
def get_user(id):
    result = db.query(id)
    return result  # returns None on missing user — caller won't know why

# PREFER: loud, clear failure
def get_user(id):
    if not id:
        raise ValueError("User ID is required")
    result = db.query(id)
    if result is None:
        raise UserNotFoundError(f"No user with ID {id}")
    return result
```

## Refactoring

Replace Error Code with Exception
