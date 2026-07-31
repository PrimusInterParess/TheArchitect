Follow core/slash-commands.md for command `/upgrade-architect`.

Read and execute: core/workflows/upgrade-architect.md

This is the **only** upgrade slash command. It:

1. Refreshes the agent-system pack after a library update
2. Auto-adds `code-review-engineer` when missing (unless excluded)
3. Then runs ownership sync (same steps as `/update-ownership`; confirm before write)

Preserve project-specification.md. Do not implement the application.
Do not invent a second `/upgrade-architect` entry or alias.
