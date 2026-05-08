# Example: Fresh Install on Generic Agent (No Hook Support)

## Scenario
Unknown agent runtime with basic file read/write but no hook system, no event architecture, and no plugin ecosystem. Markdown-only mode.

## Detection
```
Runtime: generic (no known fingerprints found)
Shell Access: yes
Write Access: yes
Existing Memory: none
Recommendation: PROCEED_GENESIS (markdown-only mode)
```

## What's Different in Generic Mode
- **No automated hooks** — replaced with manual checklists
- **No event-driven capture** — human must remember to log
- **Scripts still work** — compile.sh and lint.sh are shell-based
- **Full 6-layer model** — structure identical, automation absent

## Installation Sequence
1. ✅ scaffold.sh — Created full directory structure
2. ✅ Checklists installed in .forge/hooks/ (manual workflow)
3. ✅ compile.sh installed (runs manually)
4. ✅ lint.sh installed (runs manually)
5. ✅ All templates seeded

## Manual Workflow (Generic Mode)

### Starting a Session
```
1. Open MEMORY.md — review where everything lives
2. Read memory/recall/HOTCACHE.md — load recent context
3. Check memory/logs/ — skim yesterday's summary
```

### During a Session
```
Work normally. Note important decisions and new knowledge mentally.
```

### Ending a Session
```
1. Create memory/logs/{YYYY-MM-DD}.md from daily-note template
2. Write: session summary, key decisions, new knowledge, files modified
3. Add [[backlinks]] to any concepts you referenced
```

### Weekly Maintenance
```
1. Run: bash scripts/compile.sh
2. Run: bash scripts/lint.sh
3. Review health report in .forge/recall/health-report.md
4. Promote stable wiki concepts to life/resources/ if appropriate
```

## Activation Result
```
✅ Layer 1 (ROUTING): MEMORY.md present
✅ Layer 2 (CAPTURE): Checklists present (manual mode)
✅ Layer 3 (COMPILE): Wiki with index present
✅ Layer 4 (DURABLE): PARA structure present
✅ Layer 5 (GRAPH): Connections directory present
✅ Layer 6 (RECALL): HOTCACHE present
Status: FULLY ACTIVATED (6/6) — manual mode
```

## Upgrade Path
When this agent gains hook support (e.g., switches to Claude Code or OpenClaw), run FORGE RECALL to detect the manual setup and wire in automation.
