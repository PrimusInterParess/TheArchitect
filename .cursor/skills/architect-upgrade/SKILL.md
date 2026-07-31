---
name: architect-upgrade
description: >-
  Upgrades The Architect library usage in a project and regenerates the
  agent-system prompt pack so agent docs match current core workflows (then
  runs ownership sync). Use when the user says /upgrade-architect, refresh
  fleet after library update, sync agent prompts with new Architect version,
  or update generated agents after core changes.
disable-model-invocation: true
---

# Cursor adapter: architect-upgrade

Thin wrapper for the **`/upgrade-architect`** slash command (single command name).

**Read and follow:** [core/workflows/upgrade-architect.md](../../../core/workflows/upgrade-architect.md)
