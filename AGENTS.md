# The Architect � Agent Instructions (IDE-agnostic)

Portable source of truth: `core/`.

## When to activate

User asks to discover a project, build an agent fleet, run The Architect / Prompt Factory, analyze a brownfield repo, generate a multi-agent prompt pack, create/extend/audit agents, or operate an agent system � including slash commands listed in [`core/slash-commands.md`](core/slash-commands.md).

## Default procedure

1. Read [`core/slash-commands.md`](core/slash-commands.md) if a `/command` was used.
2. Otherwise follow [`core/workflows/agent-system-builder.md`](core/workflows/agent-system-builder.md).
3. Align discovery outputs with [`schemas/`](schemas/).
4. Do not invent providers.
5. Discovery stops at `APPROVAL REQUIRED` until approved.
6. After approval, automatically use
   [`core/workflows/generate-prompt-pack.md`](core/workflows/generate-prompt-pack.md)
   in `SAVE` mode. Do not ask a second question about whether to create agents.

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

## IDE adapters

- Cursor: `.cursor/skills/` + `.cursor/commands/` + `.cursor/rules/` (Task delegation for `/operate`)
- Generic: [`adapters/generic/README.md`](adapters/generic/README.md)
- Claude Code: `CLAUDE.md` (from [`adapters/claude-code/CLAUDE.md`](adapters/claude-code/CLAUDE.md))
- GitHub Copilot: `.github/copilot-instructions.md` (from [`adapters/copilot/copilot-instructions.md`](adapters/copilot/copilot-instructions.md))

Deep archived prompts remain under `references/source-prompts/` for progressive disclosure.
