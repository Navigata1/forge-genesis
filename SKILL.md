# FORGE GENESIS — Orchestrator
# Mode: Fresh install / clean slate memory system
# Max: 70 lines (Bellman's Law)

## TRIGGER
Agent has no memory system or needs a complete fresh install.

## SEQUENCE
1. Run `skills/agent-detector.md` → outputs `runtime-report.md`
2. Run `skills/version-checker.md` with runtime → outputs `capability-report.md`
3. Human confirms: proceed with full install? (GATE)
4. Run `skills/scaffold-builder.md` → creates complete directory structure
5. Run `skills/hook-wirer.md` with runtime → installs capture hooks
6. Run `skills/compiler-builder.md` → installs compilation pipeline
7. Run `skills/lint-scheduler.md` → schedules automated health checks
8. Seed initial files from templates/ (incl. memory/ACCESS.md — VMG scope map)
9. Run `skills/vmg-guardian.md` → wires the 5 VMG primitives (arXiv:2604.16548) → vmg-report.md ★v2.1
10. Run FORGE RECALL's `lint-runner` to verify → outputs health-report.md

## AGENT DETECTION (same as FORGE RECALL)
```
if exists .openclaw/        → runtime=openclaw
if exists CLAUDE.md         → runtime=claude-code
if exists .hermes/          → runtime=hermes
if exists .agent-zero/      → runtime=agent-zero
if exists .nemoclaw/        → runtime=nemoclaw
if package.json has paperclip → runtime=paperclip
else                        → runtime=generic
```

## SCAFFOLD STRUCTURE (created by scaffold-builder)
```
{workspace}/
├── MEMORY.md                    # Layer 1: Routing
├── memory/
│   ├── logs/                    # Layer 2: Capture (daily notes)
│   ├── wiki/                    # Layer 3: Compile (concepts)
│   │   └── index.md
│   ├── connections/             # Layer 5: Graph (backlinks)
│   └── recall/                  # Layer 6: Recall
│       └── HOTCACHE.md
├── life/                        # Layer 4: Durable (PARA)
│   ├── projects/
│   ├── areas/
│   ├── resources/
│   └── archive/
├── scripts/
│   ├── compile.sh
│   ├── flush.sh
│   └── lint.sh
├── memory/ACCESS.md             # VMG: principal-scoped retrieval ★v2.1
└── .forge/
    ├── vmg/                     # VMG: write-log.md + vmg-report.md ★v2.1
    └── genesis/
        ├── runtime-report.md
        ├── capability-report.md
        └── install-log.md
```

## POINTER CONTRACT
- Every sub-skill reads from file, writes to file
- No sub-skill exceeds 70 lines
- All outputs go to `.forge/genesis/` directory
- Templates are copied, never modified in-place

## RULES
1. NEVER install over an existing memory system — run FORGE RECALL instead
2. If scan detects existing layers, STOP and suggest FORGE RECALL
3. Human must approve before scaffold creation (GATE at step 3)
4. All created files use managed block markers for future upgrades
5. Generic runtime gets templates only — no automation wired
6. Log every action to `.forge/genesis/install-log.md`
7. Max 3 retry loops per sub-skill

## DEPENDENCIES
- Shell access for scripts/ (optional — markdown-only fallback)
- File create/write access to agent workspace
- No external APIs required
