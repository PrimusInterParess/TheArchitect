# The Architect — IDE-agnostic Agent System Library

**Version:** [`0.4.0`](VERSION) · **Changelog:** [`CHANGELOG.md`](CHANGELOG.md)

**Orchestration automation for multi-agent software work:** discover a project,
generate a governed agent fleet, then run that fleet through Architect
delegation (in Cursor: native Task subagents with each agent’s purpose + task
injected).

**Source of truth:** [`core/`](core/)  
**Contracts:** [`schemas/`](schemas/)  
**Universal entry:** [`AGENTS.md`](AGENTS.md)  
**License:** [MIT](LICENSE)

IDE folders (`.cursor/`, `CLAUDE.md`, Copilot instructions) are **optional adapters**. Other tools should ignore them and use `AGENTS.md` + `core/`.
If a deep playbook under [`references/source-prompts/`](references/source-prompts/)
conflicts with `core/`, **`core/` wins**.

---

## What’s new in 0.4.0

Full notes: [`CHANGELOG.md`](CHANGELOG.md). Highlights:

| Area | Change |
|---|---|
| Generate / SAVE | Prompt packs write real files under `agent-system/`; no chat-dump-as-pack |
| Operate | Library vs pack `library_version` warning; A/B may write proposed plans/mappings under `agent-system/` only |
| Delegation | Host-neutral inject rules in `core/`; Cursor `AskQuestion` / `Task` details in `.cursor/` |
| Style & knowledge | Agents bind to project style/skills/CONTEXT paths; may propose better approaches as `ARCHITECT_PROPOSED` |
| Schemas | Pack/operate schemas: manifest, registry, delegation, handoff, validation, context-index |
| Examples | Inspectable fleet: [`examples/sample-agent-system/`](examples/sample-agent-system/) |
| Upgrade | After pulling the library, run **`/upgrade-architect`** in each app with a fleet |

**Existing apps:** update library files → `/upgrade-architect` (library pull alone does not rewrite agent prompts).

---

## What this is / isn’t

| It is | It is not |
|---|---|
| Controlled multi-agent **orchestration** (who owns what, what they’re told, handoffs, gates) | An unsupervised “ship the whole app alone” runtime |
| A portable workflow + prompt-pack library (`core/`) | A product application (e.g. not a CV builder itself) |
| Cursor Task inject of fleet roles via prompts + delegation YAML | A way to register custom Cursor Task *kinds* |
| Approval-gated discovery → fleet → `/operate` | A guarantee that hosts without Task get the same isolation |

Prompt-pack generation is the factory step. **Operate** is the point: Architect
plans; specialists execute bounded work; results return as handoffs. Blockers
and questions come back via handoff (`BLOCKED` / proposals); the Architect
resolves (ask user / approve) and re-delegates — specialists do not silently
invent decisions.

---

## What it does

1. Discovers a greenfield, brownfield, or hybrid project (capability before provider).
2. Produces an approval-gated requirements specification.
3. Generates Architect + specialized agent prompts and governance artifacts.
4. Operates the pack through orchestration: delegation, handoffs, and validation.
5. In Cursor, `/operate` runs specialists as native **Task** subagents, each
   injected with that agent’s purpose file plus a per-request delegation
   envelope (same Task types, different prompts — not new Cursor agent kinds).

---

## Quick start

### Use this repo standalone

1. Open this folder in your AI IDE.
2. Run `/architect` (Cursor) or say: `Start agent system discovery`.
3. Select a project mode:
   - `A` — Greenfield: a future project with no implementation.
   - `B` — Brownfield: an existing repository to research.
   - `C` — Hybrid: an existing repository receiving major new functionality.
4. Answer one discovery question at a time.
5. Review the generated specification and reply:
   - `APPROVED`
   - `APPROVED WITH CHANGES: ...`
   - `REVISE: ...`
6. Approval automatically generates and saves the selected agent fleet.
7. Run `/operate` when you are ready to plan or implement project work.

You do not need to ask separately for agent creation after approval.

### Files created automatically

During discovery:

```text
agent-system/project-specification.md
```

Before approval it is marked `PROPOSED — APPROVAL REQUIRED`. After approval it
is updated to `APPROVED`.

After approval, the system automatically creates:

```text
agent-system/
  project-specification.md
  README.md
  manifest.yaml          # includes library_version for drift checks
  agents/
  governance/
  protocols/
  examples/
```

The generator writes real files, verifies them, and returns only a short
summary. It must not dump the complete prompt pack into chat.

### Start using the generated agents

After prompt-pack generation succeeds:

```text
/operate
```

Then provide the real project request. The Principal Architect reads the saved
specification and shared context, selects the relevant agents, writes a
delegation envelope per agent, and (in Cursor) launches each specialist via
native **Task** with that agent’s prompt + delegation injected. Specialists
return handoffs; the Architect requests validation and performs integration
review.

**How you know subagents are in use (Cursor):** nested Task runs appear for
each specialist (e.g. `backend-engineer: …`). The parent chat should only
orchestrate — not role-play every agent in one turn.

If `/operate` is used without a request, it displays:

| Option | Result | Writes application files? |
|---|---|---:|
| A | Implementation plan only (`agent-system/implementation-plan.md`) | No (may write proposed plan under `agent-system/`) |
| B | Repository task mapping (`agent-system/repository-task-mapping.md`) | No (may write proposed mapping under `agent-system/`) |
| C | Implement the next approved milestone | Yes, when authorized |
| D | Execute a specific request | Yes, when authorized |
| E | Resume or review existing work | No by default |

It recommends an option only when the saved project state supports that
recommendation. For a new Greenfield project with no plan, it normally
recommends **A**.

### Download & first test (step-by-step)

1. Download/clone this repo.
2. Open this repo in your AI IDE.
3. Run `/architect`.
4. Pick `A` (GREENFIELD) and answer the questions one-by-one until the
   workflow ends with `APPROVAL REQUIRED`.
5. Reply `APPROVED`.
6. After approval, the prompt-pack files are generated under
   `agent-system/` automatically.
7. Run `/operate`.
8. Choose **A** (implementation plan only) for a safe first test.

After testing, delete generated artifacts before publishing:

```powershell
Remove-Item -Recurse -Force agent-system
```

What happens next:

- **A** saves `agent-system/implementation-plan.md`, waits for approval, then
  recommends B or C.
- **B** saves `agent-system/repository-task-mapping.md`, waits for approval,
  then recommends C.
- **C** implements one approved milestone via Task-backed specialists (Cursor),
  validates it, reports status, then offers the next milestone.
- **D** asks for (or uses) a specific request and runs only that bounded work
  through the same delegation runtime.
- **E** reports completed work, blockers, approvals, and the next valid action.

### How `/operate` assigns purpose + work (automated flow)

| Piece | Source | Meaning |
|---|---|---|
| Purpose | `agent-system/agents/<agent>.md` + registry | Standing mission and ownership |
| This task | Filled `task-delegation.yaml` | Objective, scope, contracts, DoD |
| Runtime | Host isolated subagent / Cursor `Task` | Isolated run with both artifacts injected |
| Result | Agent handoff package | Status, evidence, blockers, proposals back to Architect |

When a specialist needs a decision, it returns a handoff (`BLOCKED` /
`ARCHITECT_PROPOSED`, etc.). The Architect asks you or applies an approval gate,
then re-delegates with clearer bounds.

The library does **not** register new Cursor Task kinds. It automates *what each
agent is told* and requires the host to run each selected agent as an isolated
subagent when available. Portable rules:
[`core/workflows/operate-agent-system.md`](core/workflows/operate-agent-system.md).
Cursor tool names: [`.cursor/skills/operate-agent-system/SKILL.md`](.cursor/skills/operate-agent-system/SKILL.md)
and [`adapters/cursor/README.md`](adapters/cursor/README.md).

#### What repository task mapping means

Repository task mapping turns an implementation plan into a concrete execution
map:

```text
task
  -> owning agent
  -> affected project / folder / file
  -> contracts and dependencies
  -> execution order
  -> validation and approval gates
```

- For **Greenfield**, it proposes where the future code should live.
- For **Brownfield/Hybrid**, it inspects the repository read-only and maps work
  to verified existing paths.
- It identifies tasks that can run in parallel and tasks that are blocked.
- It does not implement features or modify application files.

Illustrative mapping shape (from a sample generated fleet — not this library’s
own product):

| Task | Owner | Repository area | Depends on |
|---|---|---|---|
| Editor form | frontend-engineer | `src/app/…` | UX specification |
| HTTP API | backend-engineer | `Api/` | API contract |
| Persistence | backend-engineer | `Data/` | Domain model |
| Quality gate | qa-engineer | tests / validation plan | Relevant contracts |

### How discovery questions are presented

The agent explains each option, marks its suggested answer as `Recommended`,
and gives one short reason. If context is insufficient, it does not display a
recommendation.

When the IDE supports native structured questions, options are clickable.
In Cursor, adapters use `AskQuestion`. Plain A/B/C text is used only as a
fallback when no choice UI is available.

### Test cleanup

When testing this library inside its own repository, all generated project
artifacts are placed under `agent-system/`. Delete that directory after testing
and before publishing the reusable library:

```powershell
Remove-Item -Recurse -Force agent-system
```

Do not run that command inside a real project if you intend to keep its
generated agents.

### Install into another project

See [`INSTALL.md`](INSTALL.md).

```powershell
powershell -File scripts/install-into-project.ps1 -TargetPath "C:\path\to\your\app"
```

```bash
bash scripts/install-into-project.sh /path/to/your/app
```

### Update an installed copy

Bump [`VERSION`](VERSION) when you release. Consumers:

| Install style | Update |
|---|---|
| Submodule (`vendor/thearchitect`) | `git submodule update --remote`, then **`/upgrade-architect`** |
| Standalone clone | `git pull` / checkout a tag, then **`/upgrade-architect`** in each app that has a fleet |
| Copied into an app | `scripts/update-into-project.*`, then **`/upgrade-architect`** in the app |

Details: [`INSTALL.md`](INSTALL.md) → **Updating to a new library version**.

### Upgrading a project that still has an older Architect

Use this when an application repo already has The Architect installed (old
`core/`, old `.cursor/` adapters, and usually an `agent-system/` fleet) and you
want the new library behavior (including procedure scanning and refreshed agent
docs).

**Who this is for:** humans, or an agent asked for “upgrade Architect” /
“migrate to the new The Architect version” guidelines.

#### Step 0 — Identify how Architect was installed

Prefer `agent-system/architect-install.yaml` when present (`install_style`,
`library_root`). Otherwise infer from layout clues — paths vary by project:

| Clue in the app repo | Install style |
|---|---|
| Git submodule containing Architect `AGENTS.md` / `core/` | Submodule |
| `core/workflows/`, `AGENTS.md`, `.cursor/commands/` copied at app root | Copy-install |
| `core/` is a junction/symlink into another checkout | Junction / linked clone |
| Separate Architect clone; app only references it | Standalone toolkit |

Version discovery (first hit; **no hardcoded folder names**):

1. Policy `library_root` → `VERSION`
2. Resolved `core/` link → sibling `VERSION`
3. App-root `VERSION` when present
4. Existing `.architect/library-version` only (copy-install; do not create)

Optional for copy-install: compare `.architect/library-version` with this
repo’s [`VERSION`](VERSION).

#### Step 1 — Update library files (do this first)

**Submodule**

```bash
cd /path/to/your/app
git submodule update --remote vendor/thearchitect
# or pin: cd vendor/thearchitect && git fetch && git checkout vX.Y.Z
```

Point IDE instructions at `vendor/thearchitect/AGENTS.md` if not already.

**Copy-install** — from a checkout of the **new** Architect repo:

```powershell
powershell -File scripts/update-into-project.ps1 -TargetPath "C:\path\to\your\app"
```

```bash
bash scripts/update-into-project.sh /path/to/your/app
```

Preview: add `-DryRun` (PowerShell) or `DRY_RUN=1` (bash).

This refreshes `core/`, `schemas/`, adapters, `AGENTS.md`, etc. It does **not**
rewrite `agent-system/`.

**Standalone Architect clone** (toolkit only):

```bash
cd thearchitect
git pull
# or: git fetch && git checkout vX.Y.Z
```

Then still run Step 3 inside each **application** that has a generated fleet.

#### Step 2 — Reload the IDE

If Cursor adapters changed, reload the window so `/upgrade-architect` is
available.

#### Step 3 — Regenerate agent docs (required)

In the **application** project (where `agent-system/` lives), run:

```text
/upgrade-architect
```

Or say: `Upgrade The Architect and refresh the generated agent fleet`.

That workflow:

1. Detects install style; auto-writes `agent-system/architect-install.yaml`
2. Checks library version; removes stray `.architect/` on non-copy installs
3. Re-scans project skills/docs procedures (brownfield/hybrid)
4. Regenerates `agent-system/` agents + governance from the approved spec
5. Preserves `agent-system/project-specification.md` (and plan/mapping if present)
6. Does not implement application features
7. Does **not** create `.architect/` unless copy-install stamps are opted in

#### Step 4 — If `/upgrade-architect` is blocked

| Problem | What to do |
|---|---|
| No `agent-system/project-specification.md` | Run discovery (`/discover` / `/brownfield` / `/hybrid`) and get approval first |
| Spec not `APPROVED` | Finish approval, then retry `/upgrade-architect` |
| Library files still old | Finish Step 1, reload IDE, retry |
| Unrelated prompt-pack conflict | Stop; resolve project identity before overwriting |

#### Step 5 — Continue work

```text
/operate
```

Optional review: `/audit`.

#### What gets updated vs preserved

| Updated | Preserved |
|---|---|
| Library: `core/`, `schemas/`, `AGENTS.md`, Cursor/Claude/Copilot adapters | `agent-system/project-specification.md` |
| Generated: `agent-system/agents/*`, governance, protocols (via `/upgrade-architect`) | `implementation-plan.md` / `repository-task-mapping.md` if present |
| `.architect/library-version` (copy-install / Option B only) | Application source code; non-copy installs use checkout `VERSION` |

**Do not** use `install-into-project -Force` for routine upgrades — that is a
blunt reinstall. Prefer `update-into-project` + `/upgrade-architect`.

### Publish for others

1. Push this repo to GitHub/GitLab (tag releases that match `VERSION`).
2. Prefer telling teams to use a **git submodule** so library file updates are one command.
3. Tell them every library update is followed by **`/upgrade-architect`** so generated agent docs match new `core/` rules.
4. For copy installs, point them at `scripts/update-into-project.*` and `INSTALL.md`.
5. Point them at the slash-command table below.

---

## Layout

```text
thearchitect/
  AGENTS.md
  VERSION
  CHANGELOG.md
  LICENSE
  INSTALL.md
  CONTRIBUTING.md
  core/
    slash-commands.md
    glossary.md
    workflows/              # Portable logic (source of truth)
    templates/              # Library defaults (e.g. code-review-engineer)
  schemas/                  # Discovery + pack/operate contracts
  examples/
    sample-requirements-spec.md
    sample-agent-system/    # Validated example fleet
  adapters/
    generic/
    cursor/
    claude-code/
    copilot/
  .cursor/
    skills/                 # Cursor auto-discovery (thin)
    commands/               # Cursor /slash commands
    rules/                  # Cursor /operate Task delegation rule
  references/source-prompts/  # Progressive disclosure; core/ wins on conflict
  scripts/
```

---

## Slash commands

| Command | What it does |
|---|---|
| `/architect` | Router / entry |
| `/discover` | Greenfield discovery |
| `/brownfield` | Existing-repo research |
| `/hybrid` | Existing + major new work |
| `/generate-prompt-pack` | Manually regenerate/recover the pack after approval |
| `/create-agent` | One new specialized agent |
| `/extend-fleet` | Add agents to an existing pack |
| `/audit` | Review prompts / packs |
| `/operate` | Orchestrate fleet: plan/map/implement via Architect + Task specialists |
| `/update-context` | Refresh where context artifacts live |
| `/upgrade-architect` | After a library update: regenerate pack; auto-add reviewer; **then run ownership sync** |
| `/update-ownership` | On demand: propose/confirm ownership-matrix updates from repo or diff |
| `/architect-review` | On-demand review: current branch vs required base; optional PR/MR comments via `gh`/`glab` |

Full map: [`core/slash-commands.md`](core/slash-commands.md)  
Cursor wiring: [`.cursor/commands/`](.cursor/commands/) and [`adapters/cursor/README.md`](adapters/cursor/README.md)

In IDEs without native slash support, type the same text; `AGENTS.md` maps it.

### `/architect-review` (on-demand)

Compare the **current branch** to a **required** base ref. Report-only by
default. Optional PR/MR comments (GitHub/`gh`, GitLab/`glab`) only when you ask,
after you choose what to post and confirm a draft.

```text
/architect-review main
/architect-review origin/develop
# then optionally: leave comments on PR 123 (draft + confirm)
```

Uses the project `code-review-engineer` when present; otherwise
[`core/templates/code-review-engineer.md`](core/templates/code-review-engineer.md).
After a library update, **`/upgrade-architect` auto-creates** that project
reviewer in existing fleets (unless the approved spec excludes code review).
New packs also create it on generate. Ownership drift vs the live repo is
handled by **`/update-ownership`** (also chained at the end of
`/upgrade-architect`).

### Direct mode commands

Use `/architect` when you want the router to select the workflow. You can skip
the router when the mode is already known:

```text
/discover    # Greenfield interview
/brownfield  # Existing-repository research
/hybrid      # Repository research plus new-feature discovery
```

Discovery always saves the specification and waits for approval. Approval then
generates the agent files automatically.

---

## Architecture

```text
/architect
   -> discovery (/discover | /brownfield | /hybrid)
       -> specification saved
           -> APPROVAL REQUIRED
               -> approval automatically generates agent-system/
                   -> prompt pack saved and verified
                       -> /operate  (Architect orchestrates; specialists via Task in Cursor)
```

---

## Adapters

| Tool | How |
|---|---|
| Any chat | Attach `AGENTS.md` + `core/workflows/...` — [`adapters/generic`](adapters/generic/README.md) |
| Cursor | Skills + `/` commands + rules under `.cursor/` (Task delegation for `/operate`) |
| Claude Code | [`adapters/claude-code/CLAUDE.md`](adapters/claude-code/CLAUDE.md) → install as `CLAUDE.md` |
| GitHub Copilot | [`adapters/copilot/copilot-instructions.md`](adapters/copilot/copilot-instructions.md) → `.github/copilot-instructions.md` |

---

## Validation

```powershell
powershell -File scripts/validate-skills.ps1
powershell -File scripts/validate-agent-system.ps1 -AgentSystemPath examples/sample-agent-system
```

Validate a generated prompt pack in an app:

```powershell
powershell -File scripts/validate-agent-system.ps1 -AgentSystemPath agent-system
```

```bash
python scripts/validate-skills.py
```

---

## Example output

Abbreviated discovery sample: [`examples/sample-requirements-spec.md`](examples/sample-requirements-spec.md)

Sample generated fleet (passes `scripts/validate-agent-system.ps1`):
[`examples/sample-agent-system/`](examples/sample-agent-system/)

Shared vocabulary (decision states, EOP modes, style/knowledge): [`core/glossary.md`](core/glossary.md)

Release history and upgrade reminders: [`CHANGELOG.md`](CHANGELOG.md) —
after updating library files, run **`/upgrade-architect`** in each app with a fleet.

Deep reference prompts: [`references/source-prompts/`](references/source-prompts/)
(progressive disclosure; defer to `core/` on conflict).

---

## Principles

- Orchestration over unsupervised autonomy
- Capability before provider
- Evidence over assumption
- Prefer project skills / style / knowledge paths; propose better as `ARCHITECT_PROPOSED`
- Minimal necessary complexity
- No fabricated access, tests, or deployments
- No secrets in prompts
- Adapters never become the source of truth
- `core/` wins over deep `references/` playbooks

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md).
