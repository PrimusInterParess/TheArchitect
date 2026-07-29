# Contributing

## Source of truth

- Edit workflow behavior in `core/workflows/`.
- Keep IDE adapters thin (`.cursor/skills/`, `.cursor/commands/`, `CLAUDE.md`, Copilot instructions).
- Do not put provider assumptions into core logic.

## Before opening a PR

1. Run validation:

```powershell
powershell -File scripts/validate-skills.ps1
```

2. Ensure new workflows are linked from:
   - `core/workflows/agent-system-builder.md`
   - `AGENTS.md`
   - `core/slash-commands.md` (if user-invocable)
3. Keep each Cursor `SKILL.md` under ~500 lines and pointing at `core/`.
4. Prefer progressive disclosure (`*.reference.md`) over giant single files.

## Adding a workflow

1. Add `core/workflows/<name>.md` (+ optional `*.reference.md`).
2. Add a thin Cursor skill under `.cursor/skills/<name>/SKILL.md` if auto-discovery helps.
3. Add a Cursor command under `.cursor/commands/<name>.md` if slash invocation is desired.
4. Update the router and slash-command map.
5. Update validators� required file list if the workflow is mandatory.

## Adding an IDE adapter

Document install steps under `adapters/<ide>/README.md` and keep instructions pointing at `core/`, never a rewritten fork of the logic.
