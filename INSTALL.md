# Install The Architect into another project

Use this when you want Architect workflows inside an existing application repo.

## Option A � Clone as a standalone toolkit

```bash
git clone <YOUR_REPO_URL> thearchitect
cd thearchitect
```

Open the folder in your AI IDE and follow `AGENTS.md`.

## Option B � Copy portable files into a target project

From this repository:

```powershell
powershell -File scripts/install-into-project.ps1 -TargetPath "C:\path\to\your\app"
```

Or:

```bash
bash scripts/install-into-project.sh /path/to/your/app
```

This copies:

- `AGENTS.md`
- `core/`
- `schemas/`
- `references/source-prompts/` (required for phase-2 prompt-pack generation)
- `examples/` (sample outputs)
- optional Cursor adapters into the target’s `.cursor/` (skills, commands, rules)
- `scripts/`
- optional `CLAUDE.md` and `.github/copilot-instructions.md`

It does **not** overwrite existing target files unless you pass `-Force`.

## Option C � Git submodule

```bash
cd /path/to/your/app
git submodule add <YOUR_REPO_URL> vendor/thearchitect
```

Then point your IDE instructions at:

- `vendor/thearchitect/AGENTS.md`
- `vendor/thearchitect/core/workflows/agent-system-builder.md`

## After install

1. Open the target project.
2. Run `/discover` (Cursor) or say: `Start agent system discovery`.
3. Complete discovery ? `APPROVAL REQUIRED` ? approve.
4. Run `/generate-prompt-pack` (or equivalent) for phase 2.

## Uninstall

Delete the copied folders/files listed above. If you used a submodule, remove the submodule entry normally.
