# compiler-builder
# Sub-skill of FORGE GENESIS
# Purpose: Install Layer 3 (COMPILE) pipeline — the Karpathy+Jones merger

## INPUT
- `runtime-report.md`: detected runtime
- `workspace_root`: installation target

## PIPELINE ARCHITECTURE
```
Raw Session Logs → Concept Extraction (LLM) → Wiki Articles →
Index Rebuild → Graph Linking → Linting → PARA Promotion (if durable)
```

## FILES TO CREATE

### scripts/compile.sh
**Purpose**: Process uncompiled daily logs into wiki concepts
**Trigger**: Session end hook or manual invocation
**Steps**:
1. Find daily logs newer than last compilation timestamp
2. Bundle into compile-input.md for LLM processing
3. LLM extracts concepts → creates/updates wiki articles
4. Rebuild wiki/index.md
5. Update last-compiled timestamp

### scripts/flush.sh
**Purpose**: Daily promotion of stable concepts to PARA
**Trigger**: Scheduled (daily) or manual
**Steps**:
1. Find wiki concepts mentioned 5+ times and unchanged for 7+ days
2. Flag for promotion to life/resources/
3. Concepts promoted get "canonical: true" marker
4. Archive source daily logs older than 30 days

### scripts/compile-prompt.md
**Purpose**: Instructions for the LLM doing concept extraction
**Content**:
```markdown
# Compilation Instructions
You are processing raw session logs into structured knowledge.

For each log entry:
1. Extract distinct concepts (things, decisions, patterns, tools)
2. For each concept, check if wiki article exists:
   - EXISTS: update with new information (append, don't replace)
   - NEW: create from templates/concept.md template
3. Add [[backlinks]] to related concepts
4. Update wiki/index.md with new/updated entries
5. Generate one-line summaries for HOTCACHE candidates

Output: list of files created/modified with paths
```

### Compilation Config (`.forge/genesis/compile-config.md`)
```markdown
# Compile Configuration
- Source: memory/logs/
- Target: memory/wiki/
- Promotion: memory/wiki/ → life/resources/ (at threshold)
- Archive: memory/logs/ → memory/logs/archive/ (after 30 days)
- HOTCACHE rebuild: after every compilation
- HOTCACHE max: 500 characters, 5 concepts
```

## OUTPUT
- `scripts/compile.sh` installed and executable
- `scripts/flush.sh` installed and executable
- `scripts/compile-prompt.md` ready for LLM handoff
- Compile config documented in `.forge/genesis/`

## RULES
- Compilation requires an LLM — scripts prepare input, not execute AI
- Never auto-promote to PARA without human review flag
- Archive, don't delete old logs
- Compile-prompt.md is runtime-agnostic (works with any LLM)
