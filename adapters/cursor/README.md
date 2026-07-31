# Cursor adapter

## Skills

`.cursor/skills/*/SKILL.md` — thin wrappers that point at `core/workflows/`.

Edit behavior in `core/`, not in the wrappers (except Cursor `description` triggers).

## Slash commands

`.cursor/commands/*.md` — type `/` in Cursor chat to invoke:

| Slash | File |
|---|---|
| `/architect` | `architect.md` |
| `/discover` | `discover.md` |
| `/brownfield` | `brownfield.md` |
| `/hybrid` | `hybrid.md` |
| `/generate-prompt-pack` | `generate-prompt-pack.md` |
| `/create-agent` | `create-agent.md` |
| `/extend-fleet` | `extend-fleet.md` |
| `/audit` | `audit.md` |
| `/operate` | `operate.md` |
| `/update-context` | `update-context.md` |
| `/upgrade-architect` | `upgrade-architect.md` |
| `/architect-review` | `architect-review.md` |

If a command does not appear, reload the window or ensure this repo (or an install that copied `.cursor/commands`) is the workspace root.

## Clickable choices

Discovery and `/operate` menus should use Cursor's native `AskQuestion` tool.
If an agent prints A/B/C options instead, tell it:

```text
Use AskQuestion for this choice.
```

The updated workflows explicitly require `AskQuestion` when it is available.

## Native Task delegation (`/operate`)

Cursor does not let the library register custom Task kinds (`backend-engineer`,
etc.). Instead, `/operate` requires:

1. Parent chat = Architect (orchestrate only).
2. Each selected fleet agent runs as a Cursor **`Task`**.
3. The Task prompt injects that agent’s `agent-system/agents/*.md` (purpose)
   plus a filled `task-delegation.yaml` (this request’s work).

Enforced by:

- `core/workflows/operate-agent-system.md` (§ Delegation runtime)
- `.cursor/skills/operate-agent-system/SKILL.md`
- `.cursor/rules/operate-native-subagents.mdc`
- `.cursor/commands/operate.md`

You know it is working when nested Task runs appear for each specialist, not
when one chat role-plays every agent.
