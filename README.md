# FORGE GENESIS — The Builder
## Universal Agent Memory Installation System
### Version 2.0.0 | NeuralForge Memory Mastery Collection · The Memory Governance Layer

---

> **v2.0 — THE GOVERNANCE REFRAME.** Memory primitives are commodities now. What no primitive
> ships is *governance*: role separation, human-owned truth, audit trails, lint gates, and
> portability that survives a vendor switch. FORGE GENESIS v2.0 is repositioned as the
> *governed-memory bootstrap*: it stands up the full 6-layer model on a fresh agent and wraps
> whatever storage primitive is present — plain markdown, Anthropic's Memory Tool, a vector
> store — so the governance travels even when the backend changes. Build once, own it forever.

## What It Does

FORGE GENESIS builds a complete 6-layer memory system from scratch on any AI agent. It detects the agent runtime, checks its native capabilities, scaffolds the full file structure, wires hooks and pipelines, and activates the system — taking an agent from zero memory to full persistent recall.

**v2.1**: ships the five **Verifiable Memory Governance** primitives (arXiv:2604.16548) as an install step — write authorization, provenance, scoped retrieval, rollback, verified forgetting. See `skills/vmg-guardian.md`.

**Philosophy**: Build right the first time. Calibrate to the runtime. Activate everything.

## The 6-Layer Memory Model

| Layer | Name | Purpose | What Gets Built |
|-------|------|---------|-----------------|
| 1 | ROUTING | WHERE to look | MEMORY.md index, agents.md |
| 2 | CAPTURE | WHAT happened | Hooks/events per runtime |
| 3 | COMPILE | WHAT it means | Compilation pipeline + flush |
| 4 | DURABLE | WHAT is real | PARA directory structure |
| 5 | GRAPH | HOW things connect | Connections directory + backlink syntax |
| 6 | RECALL | WHAT to remember now | HOTCACHE + pre-prompt injection |

## How It Works

```
DETECT → FETCH → SCAFFOLD → CONFIGURE → SEED → ACTIVATE
```

1. **DETECT**: Fingerprint the agent runtime (OpenClaw, Claude Code, Hermes, etc.)
2. **FETCH**: Check native memory capabilities already present
3. **SCAFFOLD**: Create complete directory structure with all 6 layers
4. **CONFIGURE**: Wire hooks, events, and config appropriate to runtime
5. **SEED**: Generate initial index, routing files, templates, PARA structure
6. **ACTIVATE**: Connect everything — hooks fire, compilation runs, linting scheduled

## Supported Agent Runtimes

| Agent | Hook Strategy | Config Target | Special Handling |
|-------|--------------|---------------|------------------|
| OpenClaw | `.openclaw/hooks/` events | `.openclaw/config.yml` | Memory-stack compatible |
| Claude Code | `.claude/hooks/` scripts | `CLAUDE.md` managed blocks | Agent SDK for compilation |
| Hermes | `.hermes/plugins/` | `hermes.config` | Plugin-based hooks |
| Paperclip | Custom event handlers | `package.json` scripts | Node.js ecosystem |
| Agent Zero | `.agent-zero/` config | Agent config file | Knowledge file integration |
| NemoClaw | `.nemoclaw/` events | NemoClaw config | Event-driven |
| Generic | Manual templates | README instructions | Markdown-only, no automation |

## Installation

### For the agent to self-install:
```bash
cat INSTALL_PROMPT.md | <your-agent-command>
```

### Manual:
```bash
# 1. Copy to agent's skill directory
cp -r forge-genesis/ ~/.agent/skills/forge-genesis/

# 2. Agent reads SKILL.md and executes the full sequence
```

## File Structure

```
forge-genesis/
├── README.md                     # This file
├── SKILL.md                      # Orchestrator (entry point)
├── INSTALL_PROMPT.md             # Handoff prompt for any agent
├── manifest.json                 # Machine-readable contract
├── skills/
│   ├── agent-detector.md         # Runtime fingerprinting
│   ├── version-checker.md        # Native capability assessment
│   ├── scaffold-builder.md       # Directory structure creation
│   ├── hook-wirer.md             # Hook/event installation
│   ├── compiler-builder.md       # Compilation pipeline creation
│   └── lint-scheduler.md         # Health check automation
├── scripts/
│   ├── detect-runtime.sh         # Agent fingerprinting (shared)
│   ├── scaffold.sh               # Directory creation
│   ├── wire-hooks.sh             # Hook installation
│   └── activate.sh               # System activation
├── templates/
│   ├── MEMORY.md                 # Routing index
│   ├── AGENTS.md                 # Agent rules
│   ├── PARA.md                   # PARA structure guide
│   ├── daily-note.md             # Daily log template
│   ├── concept.md                # Wiki concept template
│   ├── HOTCACHE.md               # Recall hot cache
│   └── WORKSPACE_MEMORY.md       # Workspace memory guide
├── docs/
│   └── ARCHITECTURE.md           # Design decisions
└── examples/
    ├── fresh-claude-code.md      # Example: new Claude Code project
    └── fresh-generic.md          # Example: agent without hooks
```

## Scoring

| Criterion | Weight | Score | Notes |
|-----------|--------|-------|-------|
| Universality | 25% | 9/10 | 7 runtimes + generic fallback |
| Memory Completeness | 20% | 10/10 | Builds all 6 layers from scratch |
| Self-Healing | 20% | 7/10 | Lint scheduled but not self-repairing |
| Token Efficiency | 15% | 9/10 | Pointer-first, small bootstrap files |
| Distributable | 10% | 10/10 | Self-contained package |
| Self-Improving | 10% | 8/10 | Compilation loop built in from start |
| **Weighted Total** | | **8.80/10** | |

---

*"Define everything as a pointer." — Bellman*
