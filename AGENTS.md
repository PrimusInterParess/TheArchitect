# The Architect — Agent Instructions (IDE-agnostic)

Portable source of truth: `core/`.

## When to activate

User asks to discover a project, build an agent fleet, run The Architect / Prompt Factory, analyze a brownfield repo, generate a multi-agent prompt pack, create/extend/audit agents, or operate an agent system — including slash commands listed in [`core/slash-commands.md`](core/slash-commands.md).

## Default procedure

1. Read [`core/slash-commands.md`](core/slash-commands.md) if a `/command` was used.
2. Otherwise follow [`core/workflows/agent-system-builder.md`](core/workflows/agent-system-builder.md).
3. Align discovery outputs with [`schemas/`](schemas/).
4. Do not invent providers.
5. Discovery stops at `APPROVAL REQUIRED` until approved.
6. After approval, automatically use
   [`core/workflows/generate-prompt-pack.md`](core/workflows/generate-prompt-pack.md)
   in `SAVE` mode. Do not ask a second question about whether to create agents.
7. When a project already defines agent/skills/documentation procedures, detect
   and adapt per
   [`core/workflows/existing-operating-procedures.md`](core/workflows/existing-operating-procedures.md)
   — prefer those procedures over Architect defaults.
8. Upgrading an app from an older Architect: follow
   [`README.md`](README.md) → **Upgrading a project that still has an older Architect**
   (library update, then `/upgrade-architect`).

## Slash commands

| Command | Workflow |
|---|---|
| `/architect` | `core/workflows/agent-system-builder.md` |
| `/discover` | `core/workflows/project-discovery.md` |
| `/brownfield` | `core/workflows/brownfield-research.md` |
| `/hybrid` | `core/workflows/brownfield-research.md` (Hybrid) |
| `/generate-prompt-pack` | `core/workflows/generate-prompt-pack.md` |
| `/create-agent` | `core/workflows/create-agent.md` |
| `/extend-fleet` | `core/workflows/extend-fleet.md` |
| `/audit` | `core/workflows/audit-prompts.md` |
| `/operate` | `core/workflows/operate-agent-system.md` |
| `/update-context` | `core/workflows/update-context-mapping.md` |
| `/upgrade-architect` | `core/workflows/upgrade-architect.md` |

## IDE adapters

- Cursor: `.cursor/skills/` + `.cursor/commands/` + `.cursor/rules/` (Task delegation for `/operate`)
- Generic: [`adapters/generic/README.md`](adapters/generic/README.md)
- Claude Code: `CLAUDE.md` (from [`adapters/claude-code/CLAUDE.md`](adapters/claude-code/CLAUDE.md))
- GitHub Copilot: `.github/copilot-instructions.md` (from [`adapters/copilot/copilot-instructions.md`](adapters/copilot/copilot-instructions.md))

Deep archived prompts remain under `references/source-prompts/` for progressive disclosure.
**If a deep playbook conflicts with `core/`, `core/` wins.**
