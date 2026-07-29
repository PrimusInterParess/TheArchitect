#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-}"
FORCE="${FORCE:-0}"

if [[ -z "$TARGET" ]]; then
  echo "Usage: FORCE=1 $0 /path/to/target-project" >&2
  exit 1
fi

mkdir -p "$TARGET"

copy_path() {
  local rel="$1"
  local src="$ROOT/$rel"
  local dst="$TARGET/$rel"
  if [[ ! -e "$src" ]]; then
    echo "SKIP missing source: $rel"
    return
  fi
  if [[ -e "$dst" && "$FORCE" != "1" ]]; then
    echo "SKIP (exists): $rel"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  cp -R "$src" "$dst"
  echo "COPIED: $rel"
}

copy_path "AGENTS.md"
copy_path "core"
copy_path "schemas"
copy_path "examples"
copy_path "scripts"
copy_path "references/source-prompts"
copy_path ".cursor/skills"
copy_path ".cursor/commands"
copy_path ".cursor/rules"

if [[ -f "$ROOT/adapters/claude-code/CLAUDE.md" ]]; then
  if [[ -e "$TARGET/CLAUDE.md" && "$FORCE" != "1" ]]; then
    echo "SKIP (exists): CLAUDE.md"
  else
    cp "$ROOT/adapters/claude-code/CLAUDE.md" "$TARGET/CLAUDE.md"
    echo "COPIED: CLAUDE.md"
  fi
fi

if [[ -f "$ROOT/adapters/copilot/copilot-instructions.md" ]]; then
  mkdir -p "$TARGET/.github"
  if [[ -e "$TARGET/.github/copilot-instructions.md" && "$FORCE" != "1" ]]; then
    echo "SKIP (exists): .github/copilot-instructions.md"
  else
    cp "$ROOT/adapters/copilot/copilot-instructions.md" "$TARGET/.github/copilot-instructions.md"
    echo "COPIED: .github/copilot-instructions.md"
  fi
fi

echo
echo "Install complete into: $TARGET"
echo "Next: open the project and run /architect or say 'Start agent system discovery'"
