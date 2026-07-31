# Changelog

## 0.5.3 — 2026-07-31

### Added

- Default fleet SPECIALIST **`architecture-engineer`**: SAVE packs must create
  it unless the approved spec excludes architecture design/redesign or an
  equivalent owner already exists.
- `core/templates/architecture-engineer.md` — library seed prompt for design /
  redesign handoffs (Principal orchestrates; feature engineers implement;
  `code-review-engineer` owns review findings).
- `/upgrade-architect` + `generate-prompt-pack` **auto-create**
  `architecture-engineer` when regenerating (same hard rule as
  `code-review-engineer`).
- Sample fleet updated to include `architecture-engineer`.

### Upgrade path

1. Update The Architect to **≥ 0.5.3**.
2. Reload the IDE.
3. Run **`/upgrade-architect`** in each app with a fleet — the library
   creates/wires `agents/architecture-engineer.md` when missing (unless
   excluded).

## 0.5.2 — 2026-07-31

### Added

- `/update-ownership` — scan repo or diff vs fleet ownership; propose matrix
  updates; write only after user confirmation. Does not create agents or
  regenerate the whole pack.
- `/upgrade-architect` **chains** the same ownership sync after pack refresh
  (user may decline the ownership pass without failing the library upgrade).

### Upgrade path

1. Update The Architect to **≥ 0.5.2**.
2. Reload the IDE.
3. Existing fleets: `/upgrade-architect` (pack + optional ownership sync) **or**
   on-demand `/update-ownership` only.

## 0.5.1 — 2026-07-31

### Changed

- `/upgrade-architect` + `generate-prompt-pack` **must auto-create**
  `code-review-engineer` in existing fleets when regenerating (unless the
  approved spec excludes code review or an equivalent REVIEWER already
  exists). Users should not need `/extend-fleet` / `/create-agent` for this
  default reviewer.

### Upgrade path for existing apps (e.g. TheraPro / sunshine-summarizer)

1. Update The Architect library to **≥ 0.5.1**.
2. Reload the IDE.
3. Run **`/upgrade-architect`** in the app — the library creates/wires
   `agents/code-review-engineer.md` into the pack.
4. Use `/architect-review <base>` (project reviewer overrides the library
   template).

## 0.5.0 — 2026-07-31

Library capability release: on-demand **`/architect-review`**. Consumers get the
command when they update library files (reload IDE adapters if needed).

### Added

- `core/workflows/architect-review.md` — branch vs required base; structured
  review; optional GitHub/GitLab comment publish (`gh`/`glab`) after draft
  confirmation.
- `core/templates/code-review-engineer.md` — library default REVIEWER prompt
  (overridden by project fleet reviewer when present).
- Cursor command + skill: `/architect-review`.
- Slash map, AGENTS, README, and adapter docs updated.
- `generate-prompt-pack` recommends `code-review-engineer` unless excluded.

### Upgrade path for existing apps

1. Update The Architect checkout (submodule / pull / `scripts/update-into-project.*`).
2. Reload the IDE if adapters/commands changed.
3. Use `/architect-review <base>` immediately (works without a fleet).
4. Run `/upgrade-architect` so the pack gains `code-review-engineer`
   automatically (see **0.5.1** for the hard auto-create rule).

## 0.4.0 — 2026-07-30

Library prompt quality release. **Consumers must update library files, then run `/upgrade-architect` in each app that has an `agent-system/` fleet.** Library file update alone does not rewrite generated agent prompts.

### Breaking / behavior clarifications

- Deep playbooks under `references/source-prompts/` defer to `core/` on conflict; prompt-pack generation defaults to workspace `SAVE` (not chat dumps).
- `/operate` A/B may write proposed planning artifacts under `agent-system/`; they still must not modify application source.
- Cursor-specific tool names (`AskQuestion`, `Task`, `subagent_type`) live primarily in `.cursor/` adapters; `core/` uses host-neutral wording.

### Added

- Pack/operate JSON schemas (`manifest`, agent-registry, task-delegation, agent-handoff, validation-report, context-index).
- `examples/sample-agent-system/` for inspectable fleet layout + validator CI.
- `core/glossary.md` — shared decision-state / ledger vocabulary.
- Library vs pack version mismatch warning on `/operate`.
- CHANGELOG and upgrade reminder for old installs.
- Generate-prompt-pack **§6 / §11** guidance: bind style, patterns, skills, and
  knowledge to project paths; allow labeled `ARCHITECT_PROPOSED` improvement
  suggestions (no silent house-style override).

### Fixed

- UTF-8 mojibake in workflows, AGENTS, schemas, and references.
- `validate-skills.py` parity with PowerShell required-file lists.
- Adapter slash maps (`/update-context`, `/upgrade-architect`).
- `/create-agent` and `/extend-fleet` SAVE/verify gates aligned with generate.
- Existing-operating-procedures coverage called out in deep playbooks.
- INSTALL post-approval flow (auto-SAVE; `/generate-prompt-pack` is recovery).

### Upgrade path for existing apps

1. Update The Architect checkout (submodule / pull / `scripts/update-into-project.*`).
2. Reload the IDE if adapters changed.
3. Run `/upgrade-architect` in the app (approved `project-specification.md` required).
4. Continue with `/operate`.
