# Delegation Examples — Sample Catalog API

## Example A — List endpoint sketch

- Primary: `backend-engineer`
- Delegator: `principal-software-architect`
- Objective: Document list-items route and response fields
- Excluded: auth, payments, deploy

See `protocols/task-delegation.yaml` for the filled envelope.

## Example B — Blocked persistence binding

- Primary: `backend-engineer`
- Stop when asked to bind a cloud datastore without user approval
- Escalation: Architect → user (provider decision)
