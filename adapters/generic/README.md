# Generic IDE / chat adapter

Use when your tool does not read `.cursor/skills` or `.cursor/commands`.

## Source of truth

`core/` + `AGENTS.md` + `schemas/`. Adapters never fork the logic.

## Slash commands without native slash support

Type the command text literally, for example:

```text
/discover
```

or:

```text
Run /generate-prompt-pack using core/slash-commands.md
```

The agent should map it via `core/slash-commands.md`.

## Bootstrap any chat

1. Attach `AGENTS.md` and `core/workflows/agent-system-builder.md`.
2. Send: `Confirm you will follow these instructions. Reply: ARCHITECT CORE READY`
3. Then run a command or: `Start project discovery`

## Install into another project

See [../../INSTALL.md](../../INSTALL.md).
