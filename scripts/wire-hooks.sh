#!/bin/bash
# wire-hooks.sh — Install capture hooks for detected runtime
# Usage: source detect-runtime.sh && ./wire-hooks.sh [workspace_root]

WORKSPACE="${1:-.}"
RUNTIME="${FORGE_RUNTIME:-generic}"

echo "=== FORGE GENESIS: Wire Hooks ==="
echo "Runtime: $RUNTIME"

case "$RUNTIME" in
  claude-code)
    mkdir -p "$WORKSPACE/.claude/hooks"
    
    cat > "$WORKSPACE/.claude/hooks/forge-session-start.sh" << 'HOOK'
#!/bin/bash
# FORGE GENESIS: Session Start Hook
cat "$(git rev-parse --show-toplevel 2>/dev/null || echo .)/MEMORY.md" 2>/dev/null
cat "$(git rev-parse --show-toplevel 2>/dev/null || echo .)/memory/recall/HOTCACHE.md" 2>/dev/null
HOOK
    chmod +x "$WORKSPACE/.claude/hooks/forge-session-start.sh"
    
    cat > "$WORKSPACE/.claude/hooks/forge-session-end.sh" << 'HOOK'
#!/bin/bash
# FORGE GENESIS: Session End Hook
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo .)"
TODAY=$(date +%Y-%m-%d)
LOG="$ROOT/memory/logs/$TODAY.md"
echo "" >> "$LOG"
echo "## Session End: $(date -Iseconds)" >> "$LOG"
echo "<!-- Capture session summary here -->" >> "$LOG"
HOOK
    chmod +x "$WORKSPACE/.claude/hooks/forge-session-end.sh"
    echo "Installed Claude Code hooks"
    ;;
    
  openclaw)
    mkdir -p "$WORKSPACE/.openclaw/hooks"
    cat > "$WORKSPACE/.openclaw/hooks/forge-start.md" << 'HOOK'
# FORGE GENESIS: Session Start
Read MEMORY.md for routing. Read memory/recall/HOTCACHE.md for instant context.
HOOK
    cat > "$WORKSPACE/.openclaw/hooks/forge-capture.md" << 'HOOK'
# FORGE GENESIS: Session Capture
Write session summary to memory/logs/{YYYY-MM-DD}.md using daily-note template.
HOOK
    echo "Installed OpenClaw hooks"
    ;;
    
  *)
    mkdir -p "$WORKSPACE/.forge/hooks"
    cat > "$WORKSPACE/.forge/hooks/SESSION_START_CHECKLIST.md" << 'HOOK'
# Session Start Checklist (Manual)
1. Read MEMORY.md for navigation
2. Read memory/recall/HOTCACHE.md for recent context
3. Check memory/logs/ for yesterday's summary
HOOK
    cat > "$WORKSPACE/.forge/hooks/SESSION_END_CHECKLIST.md" << 'HOOK'
# Session End Checklist (Manual)
1. Write session summary to memory/logs/{YYYY-MM-DD}.md
2. Note key decisions and new knowledge
3. Run scripts/compile.sh if new logs exist
4. Run scripts/lint.sh weekly
HOOK
    echo "Installed generic checklists (no automation)"
    ;;
esac

echo "=== HOOKS WIRED ==="
