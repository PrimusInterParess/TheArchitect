# Upgrade Architect Library + Refresh Fleet

After installing a newer The Architect version, refresh the **generated**
prompt pack so agent docs and governance match the current `core/` workflows
(including existing-operating-procedures adaptation).

Slash: `/upgrade-architect`

## Mission

1. Confirm (or apply) the library update in this project.
2. Keep `agent-system/project-specification.md` as the approved source of truth.
3. Re-run prompt-pack generation in `SAVE` mode so agents, shared context,
   execution workflow, and governance pick up new library rules.
4. Do **not** implement application features.

## When to use

- User updated The Architect via submodule, `git pull`, or
  `scripts/update-into-project.*`
- User wants generated `agent-system/agents/*.md` and governance rewritten for
  the new library (e.g. procedure-adaptation Operating Principles)
- Equivalent phrases: refresh fleet after library update, upgrade architect,
  sync agent prompts with new core

## Prerequisites

| Check | If missing |
|---|---|
| Approved `agent-system/project-specification.md` | Stop; run discovery / approval first |
| Spec status `APPROVED` or `APPROVED WITH CHANGES` | Stop; finish approval |
| Current `core/workflows/generate-prompt-pack.md` present | Stop; update the library first |

## Steps

### 1. Library version check

Discover the installed library version in this order (first hit wins). Report
the path used and the version string. **Do not assume fixed folder names** —
each project may place the library anywhere.

1. **Project policy (preferred):** `agent-system/architect-install.yaml`
   - If `library_root` is set, read `<library_root>/VERSION`
   - Honor `write_app_root_stamp` / `install_style` from the same file
2. **Linked `core/`:** if `core/` is a junction or symlink, resolve it to its
   target directory, then read sibling `VERSION` (parent of that `core/`)
3. **In-tree library:** app-root `VERSION` when this workspace *is* the
   Architect checkout (or a copy-install that copied `VERSION`)
4. **Existing stamp only:** `.architect/library-version` if that file
   already exists (never create it in this step)

If none of the above yield a version, ask the user where the Architect
checkout lives, or have them add `library_root` to
`agent-system/architect-install.yaml`. Do not invent a path.

`agent-system/architect-install.yaml` fields (when present):

| Field | Meaning |
|---|---|
| `install_style` | `submodule` \| `standalone_clone` \| `junction` \| `copy_install` |
| `library_root` | Project-specific relative (or absolute) path to the Architect checkout — **required for non-obvious layouts** |
| `write_app_root_stamp` | `false` = never write `.architect/` at the app root |

**Do not create `.architect/`** unless all of the following are true:

- Install style is `copy_install` (or the user explicitly asked for a
  copy-install stamp), **and**
- `write_app_root_stamp` is not `false`

Non-copy installs track version via the checkout’s `VERSION` (from policy
and/or resolved `core/`). App-root stamps are Option B (copy-install) only.

If the user has not updated library files yet, tell them to update the
checkout at `library_root` (or the resolved `core/` target), using whatever
install style they use (submodule update, `git pull` / tag checkout, or
`scripts/update-into-project.*` for copy-install). Then re-invoke
`/upgrade-architect`.

If library files are already current, continue.

Do not run install/update scripts unless the user explicitly authorizes shell
file copies in this session.

### 2. Preserve project artifacts

**Never delete or regenerate** unless the user explicitly asks:

- `agent-system/project-specification.md`
- `agent-system/implementation-plan.md` (if present)
- `agent-system/repository-task-mapping.md` (if present)
- Application source code outside `agent-system/` library paths

### 3. Refresh procedure inventory (Brownfield / Hybrid)

If the specification mode is `BROWNFIELD` or `HYBRID`, or existing procedures
were previously recorded:

1. Re-run the detection rules in
   [existing-operating-procedures.md](existing-operating-procedures.md)
   (read-only scan).
2. Update the specification section
   **Existing Agent / Skills / Documentation Procedures** when the inventory
   or adaptation mode changed.
3. Keep status `APPROVED WITH CHANGES` only if material adoption decisions
   changed; otherwise leave approval status as-is and note procedure refresh
   in the upgrade summary.
4. If adoption decisions would change in a breaking way, stop and ask for
   approval before regenerating agents.

For `GREENFIELD` with `NOT_FOUND` / `NONE`, skip unless the user points at a
new skills pack.

### 4. Regenerate the prompt pack

Execute [generate-prompt-pack.md](generate-prompt-pack.md) in `SAVE` mode with
these upgrade rules:

1. Authorized to replace existing pack files for **this same project**
   (same project id/name in manifest / specification).
2. Rewrite agents, governance, and protocols from the approved specification
   using **current** core rules.
3. Preserve `project-specification.md` (and plan/mapping files above).
4. Bind `existing_operating_procedures` into shared context when adopted.
5. Verify with the generate-prompt-pack save verification steps.

### 5. Report

Return a short summary only:

1. Library version before → after (if known)
2. Spec path + approval status
3. Procedure adaptation mode (`FOLLOW` / `COMPOSE` / `BRIDGE` / `NONE`)
4. Files created / updated / skipped under `agent-system/`
5. Verification result
6. Next step: `/operate` (or `/audit` if they want a review pass)

## Result status

- `ARCHITECT_UPGRADE_READY` — library current and fleet regenerated
- `ARCHITECT_UPGRADE_LIBRARY_PENDING` — user must update library files first
- `ARCHITECT_UPGRADE_BLOCKED` — missing/invalid approved spec, project
  conflict, or verification failure

## Safety

- No application implementation
- No secret values
- No silent overwrite of an unrelated project's prompt pack
- Prefer regenerating from the approved spec over hand-editing dozens of
  agent files
- Never create an app-root `.architect/` stamp for submodule, standalone,
  or junction installs; stamps are copy-install (Option B) only
- Honor `agent-system/architect-install.yaml` when present
  (`write_app_root_stamp: false` wins)
