# CH-07: Tell, Don't Ask

## Rules

- If you find yourself reading multiple fields from an object to make a decision → that decision belongs inside the object as a method
- Replace `if obj.state == X and obj.flag: do_thing()` with `obj.do_thing()` where the object checks its own state
- Avoid "feature envy" — one class excessively accessing another class's data
- This applies to data structures too: prefer `cart.total()` over manually summing `cart.items` externally

## Detection Signals

- 2+ field accesses on the same object driving a conditional
- Same multi-field check repeated at multiple call sites
- One class accessing another class's fields more than its own
- Long chains like `order.customer.address.city == "..."` used for branching

## Pattern

```
# AVOID: asking, then deciding externally
if user.role == "admin" and user.is_active and not user.is_suspended:
    user.permissions.append("delete")

# PREFER: telling
user.grant_permission("delete")
# user internally checks role, active status, suspension, etc.
```

## Refactoring

Move Function, Encapsulate Record
