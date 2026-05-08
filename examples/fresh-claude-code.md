# Example: Fresh Install on Claude Code Project

## Scenario
New Claude Code project with only a CLAUDE.md file. No memory system exists.

## Detection
```
Runtime: claude-code (CLAUDE.md found)
Version: Claude Code with hook support
Shell Access: yes
Write Access: yes
Existing Memory: none
Recommendation: PROCEED_GENESIS
```

## Capability Assessment
```
Layer 1 (ROUTING): partial — CLAUDE.md exists but no MEMORY.md
Layer 2 (CAPTURE): partial — hook system available but not configured
Layer 3 (COMPILE): no — nothing present
Layer 4 (DURABLE): no — nothing present
Layer 5 (GRAPH): no — nothing present
Layer 6 (RECALL): no — nothing present

Strategy: Build all 6 layers, leverage CLAUDE.md and hook system
```

## Installation Sequence
1. ✅ scaffold.sh — Created 10 directories, copied 7 templates
2. ✅ wire-hooks.sh — Installed 2 hooks in .claude/hooks/
3. ✅ Added memory config block to CLAUDE.md
4. ✅ Installed compile.sh, flush.sh, compile-prompt.md
5. ✅ Scheduled lint via session-end hook

## Final Structure
```
project/
├── CLAUDE.md                    # Extended with memory config block
├── MEMORY.md                    # NEW — routing index
├── AGENTS.md                    # NEW — agent rules
├── memory/
│   ├── logs/                    # NEW — daily session capture
│   ├── wiki/                    # NEW — compiled concepts
│   │   └── index.md
│   ├── connections/             # NEW — backlink graph
│   └── recall/
│       └── HOTCACHE.md          # NEW — instant recall
├── life/                        # NEW — PARA structure
│   ├── projects/
│   ├── areas/
│   ├── resources/
│   └── archive/
├── scripts/
│   ├── compile.sh               # NEW
│   ├── flush.sh                 # NEW
│   └── lint.sh                  # NEW
├── .claude/hooks/
│   ├── forge-session-start.sh   # NEW
│   └── forge-session-end.sh     # NEW
└── .forge/genesis/
    ├── runtime-report.md
    ├── capability-report.md
    └── install-log.md
```

## Activation Result
```
✅ Layer 1 (ROUTING): MEMORY.md present
✅ Layer 2 (CAPTURE): Hooks directory present
✅ Layer 3 (COMPILE): Wiki with index present
✅ Layer 4 (DURABLE): PARA structure present
✅ Layer 5 (GRAPH): Connections directory present
✅ Layer 6 (RECALL): HOTCACHE present
Status: FULLY ACTIVATED (6/6)
```
