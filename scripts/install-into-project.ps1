#Requires -Version 5.1
param(
  [Parameter(Mandatory = $true)]
  [string]$TargetPath,
  [switch]$Force,
  [switch]$SkipCursorAdapters,
  [switch]$SkipCopilot,
  [switch]$SkipClaude
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$Target = Resolve-Path -LiteralPath $TargetPath -ErrorAction SilentlyContinue
if (-not $Target) {
  New-Item -ItemType Directory -Force -Path $TargetPath | Out-Null
  $Target = Resolve-Path -LiteralPath $TargetPath
}
$Target = $Target.Path

function Copy-Tree {
  param([string]$Relative, [switch]$Optional)
  $src = Join-Path $Root $Relative
  $dst = Join-Path $Target $Relative
  if (-not (Test-Path -LiteralPath $src)) {
    if ($Optional) { return }
    throw "Missing source: $Relative"
  }
  if ((Test-Path -LiteralPath $dst) -and -not $Force) {
    Write-Host "SKIP (exists): $Relative"
    return
  }
  $parent = Split-Path -Parent $dst
  if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
  if (Test-Path -LiteralPath $src -PathType Container) {
    if (Test-Path -LiteralPath $dst) { Remove-Item -Recurse -Force -LiteralPath $dst }
    Copy-Item -Recurse -Force -LiteralPath $src -Destination $dst
  }
  else {
    Copy-Item -Force -LiteralPath $src -Destination $dst
  }
  Write-Host "COPIED: $Relative"
}

Copy-Tree "AGENTS.md"
Copy-Tree "core"
Copy-Tree "schemas"
Copy-Tree "examples"
Copy-Tree "scripts"
Copy-Tree "references/source-prompts"
Copy-Tree "INSTALL.md" -Optional
Copy-Tree "core\slash-commands.md" -Optional

if (-not $SkipCursorAdapters) {
  Copy-Tree ".cursor\skills"
  Copy-Tree ".cursor\commands"
  Copy-Tree ".cursor\rules"
}

if (-not $SkipClaude) {
  $src = Join-Path $Root "adapters\claude-code\CLAUDE.md"
  $dst = Join-Path $Target "CLAUDE.md"
  if ((Test-Path -LiteralPath $dst) -and -not $Force) {
    Write-Host "SKIP (exists): CLAUDE.md"
  }
  elseif (Test-Path -LiteralPath $src) {
    Copy-Item -Force -LiteralPath $src -Destination $dst
    Write-Host "COPIED: CLAUDE.md"
  }
}

if (-not $SkipCopilot) {
  $src = Join-Path $Root "adapters\copilot\copilot-instructions.md"
  $dstDir = Join-Path $Target ".github"
  $dst = Join-Path $dstDir "copilot-instructions.md"
  if ((Test-Path -LiteralPath $dst) -and -not $Force) {
    Write-Host "SKIP (exists): .github/copilot-instructions.md"
  }
  elseif (Test-Path -LiteralPath $src) {
    New-Item -ItemType Directory -Force -Path $dstDir | Out-Null
    Copy-Item -Force -LiteralPath $src -Destination $dst
    Write-Host "COPIED: .github/copilot-instructions.md"
  }
}

Write-Host ""
Write-Host "Install complete into: $Target"
Write-Host "Next: open the project and run /architect or say 'Start agent system discovery'"
