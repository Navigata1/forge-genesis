# agent-detector
# Sub-skill of FORGE GENESIS
# Purpose: Identify agent runtime and gather environment details

## INPUT
- `workspace_root`: path to agent workspace

## PROCEDURE
1. Run fingerprint checks (same order as orchestrator detection)
2. For detected runtime, gather additional context:
   - Version: check config files, package.json, CLI output
   - Plugin ecosystem: what extensions/plugins are installed
   - Existing config: what settings are already in place
   - Shell access: can we run bash scripts? (test with `echo test`)
   - Write access: can we create files? (test with temp file)
3. Check for EXISTING memory artifacts (if found → recommend FORGE RECALL)

## FINGERPRINT ORDER
```
1. .openclaw/          → openclaw  (check .openclaw/version)
2. CLAUDE.md           → claude-code (check for hooks in .claude/)
3. .hermes/            → hermes (check hermes.config for version)
4. .agent-zero/        → agent-zero
5. .nemoclaw/          → nemoclaw
6. package.json+paperclip → paperclip (check package.json version)
7. none                → generic
```

## EXISTING MEMORY CHECK
```
Scan for: MEMORY.md, agents.md, memory/, wiki/, knowledge/,
          life/, para/, .gigabrain/, hooks/, compile scripts
If ANY found → set existing_memory=true → recommend FORGE RECALL
```

## OUTPUT → `runtime-report.md`
```markdown
# Runtime Detection Report
- **Runtime**: {detected}
- **Version**: {version or unknown}
- **Shell Access**: {yes|no}
- **Write Access**: {yes|no}
- **Existing Memory**: {none|partial|full}
- **Plugins/Extensions**: {list}
- **Recommendation**: {PROCEED_GENESIS|USE_RECALL_INSTEAD}
```

## RULES
- Read-only — detection must not modify anything
- If existing memory detected, STOP and report (never overwrite)
- Generic is always the fallback — never fail detection entirely
- Log detection reasoning for debugging
