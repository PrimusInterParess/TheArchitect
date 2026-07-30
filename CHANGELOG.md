# Changelog

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
