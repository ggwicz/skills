# CH-04: Single Responsibility

## Rules

- If you struggle to name something without "and", "or", "manager", "handler", "utils", or "helpers" → it's doing too much; split it
- Functions should do one thing at one level of abstraction
- Classes should represent one concept or capability
- A function longer than ~25 lines often has a second responsibility hiding inside it — extract it
- Validation, business logic, persistence, and presentation are separate concerns — keep them in separate functions/classes

## Detection Signals

- Function > 25 lines
- Class > 200 lines
- Class name contains "Manager", "Handler", "Utils", "Helpers", "Service" (with multiple unrelated methods)
- Function name requires "and" to describe what it does
- Mixed abstraction levels in a single function (e.g., string formatting next to DB queries)
- Parameter count > 4

## Smell Test

Describe what the function does in one sentence without using "and." If you can't, split it.

## Pattern

```
# AVOID: god function — validates, queries, transforms, and notifies
def process_order(order_data):
    if not order_data.get("items"):
        return {"error": "No items"}
    total = sum(i["price"] * i["qty"] for i in order_data["items"])
    tax = total * 0.08
    record = db.insert("orders", {"total": total + tax, "items": order_data["items"]})
    send_email(order_data["email"], f"Order {record.id} confirmed: ${total + tax:.2f}")
    return record

# PREFER: focused functions at one level of abstraction
def calculate_order_total(items):
    subtotal = sum(i["price"] * i["qty"] for i in items)
    tax = subtotal * 0.08
    return subtotal + tax

def save_order(db, total, items):
    return db.insert("orders", {"total": total, "items": items})

def notify_customer(mailer, email, order_id, total):
    mailer.send(email, f"Order {order_id} confirmed: ${total:.2f}")
```

## Refactoring

Extract Function, Extract Class
