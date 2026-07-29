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

## Updating to a new library version

Bump `VERSION` in this repo when you publish. Consumers update as follows.

### Easiest ongoing: Option C (submodule) — recommended for teams

```bash
cd /path/to/your/app
git submodule update --remote vendor/thearchitect
# or pin a release tag:
# cd vendor/thearchitect && git fetch && git checkout v0.2.0
```

Point IDE instructions at `vendor/thearchitect/AGENTS.md` so you never copy
library files into the app root.

### Option A (standalone clone)

```bash
cd thearchitect
git pull
# or: git fetch && git checkout v0.2.0
```

### Option B (copied into an app) — use the update script

From a checkout of the **new** Architect version:

```powershell
powershell -File scripts/update-into-project.ps1 -TargetPath "C:\path\to\your\app"
```

```bash
bash scripts/update-into-project.sh /path/to/your/app
```

Preview first:

```powershell
powershell -File scripts/update-into-project.ps1 -TargetPath "C:\path\to\your\app" -DryRun
```

What the update script does:

- Refreshes `core/`, `schemas/`, `references/source-prompts/`, `scripts/`,
  adapters, `AGENTS.md`, `VERSION`
- Writes `.architect/library-version`
- **Does not touch** `agent-system/` (your generated fleet stays intact)

If you customized `AGENTS.md` / `CLAUDE.md` / Cursor rules in the app, review
the git diff after update (or pass `-SkipAgentsMd` / `-SkipClaude` /
`-SkipCursorAdapters`).

Do **not** use `install-into-project` with `-Force` for routine upgrades — that
is a blunt reinstall. Prefer `update-into-project`.

### Refresh generated agent docs (required for new core rules)

Updating library files does **not** rewrite `agent-system/agents/*.md`. After
the library update, in the target project run:

```text
/upgrade-architect
```

That regenerates the prompt pack from the approved specification using the new
`core/` workflows (procedure adaptation, operating principles, etc.) while
preserving `project-specification.md`.

## Uninstall

Delete the copied folders/files listed above, plus `.architect/` if present.
If you used a submodule, remove the submodule entry normally.
