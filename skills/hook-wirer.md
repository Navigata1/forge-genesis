# hook-wirer
# Sub-skill of FORGE GENESIS
# Purpose: Install Layer 2 (CAPTURE) hooks calibrated to detected runtime

## INPUT
- `runtime-report.md`: detected runtime and capabilities
- `workspace_root`: where hooks should be installed

## HOOK DEFINITIONS

### Event: SESSION_START
**Purpose**: Load routing index + hot cache into agent context
**Fires**: When a new session begins

### Event: PRE_COMPACT
**Purpose**: Before context window is compressed, capture full session state
**Fires**: When context approaches limit (runtime-specific trigger)

### Event: SESSION_END
**Purpose**: Write session summary to daily log, trigger compilation
**Fires**: When session terminates normally

## RUNTIME-SPECIFIC WIRING

### Claude Code
```
Create: .claude/hooks/forge-session-start.sh
  → cat MEMORY.md && cat memory/recall/HOTCACHE.md

Create: .claude/hooks/forge-pre-compact.sh
  → Capture session transcript to memory/logs/{date}.md

Create: .claude/hooks/forge-session-end.sh
  → Same as pre-compact + trigger scripts/compile.sh

Add to CLAUDE.md (managed block):
  <!-- FORGE:GENESIS:HOOKS:START -->
  ## Memory Hooks
  - On session start: read MEMORY.md and memory/recall/HOTCACHE.md
  - On pre-compact: flush context to memory/logs/
  - On session end: compile and update indexes
  <!-- FORGE:GENESIS:HOOKS:END -->
```

### OpenClaw
```
Create: .openclaw/hooks/forge-start.md
  → Instructions to load MEMORY.md pointer

Create: .openclaw/hooks/forge-capture.md
  → Instructions to write session to daily log

Wire in: .openclaw/config.yml (managed block)
```

### Hermes
```
Create: .hermes/plugins/forge-memory.js
  → Hook into Hermes event system
  → session:start, session:compact, session:end

Wire in: hermes.config (managed block)
```

### Generic (no automation)
```
Create: .forge/hooks/SESSION_START_CHECKLIST.md
  → Manual: "Read MEMORY.md, then read HOTCACHE.md"

Create: .forge/hooks/SESSION_END_CHECKLIST.md
  → Manual: "Write summary to memory/logs/{date}.md"
  → Manual: "Run scripts/compile.sh if available"
```

## OUTPUT
- Hook files created in runtime-appropriate location
- Config files updated with managed blocks
- `.forge/genesis/install-log.md` updated with hook details

## RULES
- Test hooks with dry-run where possible
- Never overwrite existing hooks — append alongside them
- Generic mode provides checklists, not automation
- All managed blocks clearly attributed to FORGE:GENESIS
