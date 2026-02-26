# CH-01: Composition Over Inheritance

## Rules

- Use inheritance ONLY for genuine, shallow "is-a" relationships (1 level preferred, 2 max)
- If you're creating a base class just to share a few methods → extract those methods into a separate object and inject it
- Prefer "has-a" and "can-do" relationships over "is-a"
- Favor interfaces/protocols/traits over abstract base classes when the language supports them

## Detection Signals

- Inheritance depth > 1
- Base class exists only to share utility methods
- Subclass overrides most parent methods
- Class name includes "Base" or "Abstract" without a clear domain concept

## Pattern

```
# AVOID: inheritance for code reuse
class AdminUser(User):      # inherits auth, profile, permissions, logging...
    pass

# PREFER: composition — assemble behavior from focused parts
class User:
    def __init__(self, auth: AuthProvider, profile: Profile, permissions: PermissionSet):
        self.auth = auth
        self.profile = profile
        self.permissions = permissions
```

## Refactoring

Replace Superclass with Delegate
