# Execution Workflow — Sample Catalog API

Existing operating procedures: **NONE** (Architect defaults).

1. **Initialize** — Architect loads shared context, registry, contracts, ownership.
2. **Classify request** — Map to ownership; select agents.
3. **Delegate** — Fill `task-delegation.yaml`; inject agent prompt + delegation via host Task when available.
4. **Execute** — Primary agent works in bounds; no provider invention.
5. **Handoff** — Return `agent-handoff.yaml` package.
6. **Validate** — Architect (or reviewer) fills `validation-report.yaml` when required.
7. **Integrate** — Apply integration policy; resolve conflicts if needed.
8. **Close** — Status: `REQUEST COMPLETE` | `REQUEST COMPLETE WITH DOCUMENTED LIMITATIONS` | `REQUEST BLOCKED`.
