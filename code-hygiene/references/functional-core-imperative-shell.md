# CH-10: Functional Core, Imperative Shell

## Rules

- Business logic functions should take data in and return data out — no `db.save()`, no `http.post()`, no `print()` inside them
- The orchestration layer (controller, CLI handler, main function) calls pure logic, then performs side effects with the results
- When you need the current time, a random number, or a config value — pass it in as a parameter, don't reach out and grab it
- This naturally produces code that's structured for both unit testing (pure core) and integration testing (imperative shell)

## Detection Signals

- `db.query()`, `db.save()`, `db.delete()` inside a function that also contains business logic (conditionals, calculations, transformations)
- `requests.get()`, `fetch()`, `http.post()` inside business logic
- `open()`, `write()`, `read()` file operations inside business logic
- `print()`, `logger.info()` inside business logic (logging in the shell is fine)
- `datetime.now()`, `random()`, `uuid4()` called directly instead of passed as parameters
- `os.environ[]` or `config.get()` accessed inside business logic

## Pattern

```
# PURE — testable with no mocks
def calculate_discount(order_items, customer_tier, now):
    if customer_tier == "gold" and now.month == 12:
        return sum(i.price for i in order_items) * 0.2
    return 0

# IMPURE SHELL — thin orchestration
def handle_checkout(order_id):
    order = db.get_order(order_id)          # side effect: DB read
    customer = db.get_customer(order.cid)   # side effect: DB read
    discount = calculate_discount(           # pure
        order.items, customer.tier, datetime.now()
    )
    db.apply_discount(order_id, discount)   # side effect: DB write
```

## Refactoring

Extract I/O to Caller, Parameterize Side Effects
