# version-checker
# Sub-skill of FORGE GENESIS
# Purpose: Assess native memory capabilities of detected runtime

## INPUT
- `runtime-report.md`: from agent-detector

## PROCEDURE
1. Parse runtime type from report
2. Check known native capabilities per runtime:

### OpenClaw Capabilities
- Native memory-stack support (if installed)
- Gigabrain plugin (Layer 6)
- OpenStinger graph (Layer 5, optional)
- LCM session recovery (Layer 2)
- Skill file system (pointer-compatible)

### Claude Code Capabilities
- CLAUDE.md project rules (partial Layer 1)
- Hook system: PreToolUse, PostToolUse, Notification, Stop
- Session hooks: start, pre-compact, end (Layer 2)
- Agent SDK for external LLM processing
- No native compilation or PARA

### Hermes Capabilities
- Plugin architecture for hooks
- Session persistence (configurable)
- No native compilation
- No PARA or knowledge wiki

### Generic Capabilities
- File read/write only
- No hooks, no events, no automation
- Templates for manual workflow

3. Determine which layers need to be built vs. leveraged

## OUTPUT → `capability-report.md`
```markdown
# Capability Report
- Runtime: {runtime}
- Native Capabilities: {count}/6 layers partially covered

| Layer | Native Support | Build Strategy |
|-------|---------------|----------------|
| 1 ROUTING | {yes|partial|no} | {leverage|build|extend} |
| 2 CAPTURE | {yes|partial|no} | {leverage|build|extend} |
| 3 COMPILE | {yes|partial|no} | {leverage|build|extend} |
| 4 DURABLE | {yes|partial|no} | {leverage|build|extend} |
| 5 GRAPH | {yes|partial|no} | {leverage|build|extend} |
| 6 RECALL | {yes|partial|no} | {leverage|build|extend} |

## Build Plan Summary
- Layers to build from scratch: {list}
- Layers to extend: {list}
- Layers to leverage as-is: {list}
- Estimated install time: {minutes}
```

## RULES
- Never assume capabilities — check for actual artifacts
- "partial" means some support exists but incomplete
- "leverage" means native is good enough — don't duplicate
- Report is advisory — human makes final call
