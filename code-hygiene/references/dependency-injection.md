# CH-02: Dependency Injection

## Rules

- Constructor injection is the primary pattern — pass collaborators as constructor/init parameters
- Never instantiate infrastructure (DB connections, HTTP clients, file handles, API clients) inside business logic
- Dependencies should be visible in the function/class signature — no hidden `import` and instantiate patterns
- You do NOT need a DI framework. Plain constructor parameters are sufficient in most cases
- For functions, pass dependencies as arguments rather than relying on module-level globals

## Detection Signals

- `import` followed by instantiation inside a constructor or method body
- Hard-coded connection strings, URLs, or service addresses inside business logic
- `new DatabaseConnection()`, `requests.get()`, `open()` inside non-shell functions
- Global singletons accessed inside functions

## Pattern

```
# AVOID: hidden, hard-coded dependency
class OrderService:
    def __init__(self):
        self.db = PostgresConnection("prod:5432")
        self.mailer = SmtpMailer("mail.prod.com")

# PREFER: injected, visible, testable
class OrderService:
    def __init__(self, db, mailer):
        self.db = db
        self.mailer = mailer
```

## Refactoring

Extract Parameter / Introduce Constructor Injection
