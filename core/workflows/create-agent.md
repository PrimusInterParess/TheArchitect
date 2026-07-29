# Create Agent

Create one specialized agent prompt for an existing or in-progress fleet.

## Prerequisites

- Approved project context, or an explicit CREATE_AGENT request with enough scope
- Clear capability the agent must own
- Provider status: verified, required, preferred, proposed, undecided, or not applicable

## Steps

1. Check whether an existing agent already owns the capability.
2. If overlap exists, recommend `EXTEND_FLEET` / ownership split instead of a duplicate.
3. Decide generic vs provider-specialized.
4. Generate a complete agent prompt with all 18 required sections (see [generate-prompt-pack.md](generate-prompt-pack.md)).
5. Produce an Architect update block:
   - registry entry
   - invocation conditions
   - required inputs/outputs
   - integration checks
   - ownership conflict rules
6. Produce handoff contracts for producers/consumers.
7. List quality gates and Definition of Done.

## Output

1. Necessity assessment
2. Generated agent prompt (copy-ready)
3. Architect update block
4. Handoff table
5. Execution-order notes
6. Quality checklist

Do not invent credentials, repo files, or test results.
