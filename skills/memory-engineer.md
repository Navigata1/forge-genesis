# memory-engineer
# SHARED Sub-skill — Available to FORGE RECALL, FORGE GENESIS, and FORGE HIVEMIND
# Purpose: Formalize memory units, enable progressive disclosure, recursive improvement,
#          semantic retrieval, self-bootstrapping, and mistake tracking
# Location: Must exist in ALL THREE packages at skills/memory-engineer.md

## TRIGGER
This sub-skill is invoked by ANY orchestrator when:
- Initial install or enhancement is complete (post-Layer 6 setup)
- Agent requests "deep memory" or "memory engineering" capabilities
- `.forge/memory-engineer/config.md` exists with enabled=true
- Environment has vector DB credentials (PINECONE_API_KEY, CHROMA_PATH, etc.)

## WHAT THIS ADDS (Layer 7: ENGINEERING)

Layer 7 sits ABOVE the 6-layer model. It does not replace any layer.
It governs HOW memory flows through all layers — formalization, efficiency,
retrieval intelligence, and self-improvement.

```
┌─────────────────────────────────────────────────┐
│  LAYER 7: MEMORY ENGINEERING (this sub-skill)   │
│  Units │ Disclosure │ Retrieval │ Bootstrap │    │
├─────────────────────────────────────────────────┤
│  Layer 1-6: Standard Memory Model               │
│  ROUTING → CAPTURE → COMPILE → DURABLE →        │
│  GRAPH → RECALL                                  │
└─────────────────────────────────────────────────┘
```

## COMPONENT A: MEMORY UNIT FORMALIZATION

Every piece of information stored in ANY layer must conform to a
memory unit schema. Memory units are the atoms of the system.

### Base Memory Unit Schema
```yaml
id: {unique-id}              # UUID or timestamp-hash
content: {text}              # The actual information
type: {decision|knowledge|question|action|error|pattern}
source: {session|compile|human|agent|voice|vision}
timestamp: {ISO-8601}
importance: {1-5}            # 1=trivial, 5=critical
recency_score: {computed}    # Decays over time
relevance_tags: [{tag}]      # Semantic tags for retrieval
references: [{memory-id}]    # Links to other memory units
embedding: {vector}          # Optional: for semantic retrieval
layer: {1-6}                 # Which layer this unit lives in
```

### Type-Specific Extensions

**Decision Unit** (extends base):
```yaml
options_considered: [{option}]
rationale: {text}
reversible: {yes|no}
```

**Error Unit** (extends base — Finn's mistake memory):
```yaml
error_description: {text}
root_cause: {text}
fix_applied: {text}
skill_updated: {yes|no|skill-path}
recurrence_count: {N}
```

**Workflow Unit** (extends base — Richmond's procedural memory):
```yaml
steps: [{step_description}]
outcome: {success|failure|partial}
duration: {seconds}
tools_used: [{tool}]
```

### Scoring Algorithm (Stanford Generative Agents pattern)
```
retrieval_score = (relevance × 0.4) + (importance × 0.35) + (recency × 0.25)

relevance:  cosine similarity to current query (0-1)
importance: normalized from 1-5 scale (0-1)
recency:    exponential decay from timestamp, half-life = 7 days
```

## COMPONENT B: PROGRESSIVE DISCLOSURE

All skill files MUST follow this structure for token efficiency:

### Skill File Format (enforced)
```markdown
# {SKILL_NAME}
# {ONE-LINE DESCRIPTION — this is what enters context}

## TRIGGER
{When to load the full skill — 2-3 lines max}

## [FULL CONTENT BELOW — loaded only on demand]
...
```

### How It Works
1. Orchestrator reads ONLY line 1 (name) and line 2 (description)
2. These go into context: ~50-100 tokens per skill
3. When agent determines skill is needed, it reads the FULL file
4. Full content is used for that operation only, then released

### Token Budget Rule
```
Agent.md / CLAUDE.md: MAX 500 tokens (routing only)
Skill name + description: MAX 100 tokens per skill
Full skill on-demand: MAX 70 lines (Bellman's Law)
HOTCACHE: MAX 500 characters
MEMORY.md: MAX 50 lines
```

### Restructuring Existing Skills
When memory-engineer activates, it audits all skill files:
1. Checks if line 1 is name, line 2 is description
2. Checks total line count (warn if >70)
3. Checks if CLAUDE.md/agents.md exceeds 500 tokens
4. Reports token waste and suggests restructuring

## COMPONENT C: RECURSIVE SKILL IMPROVEMENT

Skills are living documents. They improve through use.
(Ross Mike's pattern: workflow → teach → skill → fail → fix → update)

### The Improvement Loop
```
1. Agent executes skill
2. IF success → log success in .forge/memory-engineer/skill-runs.log
3. IF failure → create Error Unit in .forge/memory-engineer/errors/
4. Agent diagnoses failure (ask: "Why did you fail?")
5. Agent fixes the issue
6. Agent updates skill with fix (append to skill, managed block)
7. Error Unit updated: skill_updated = path-to-skill
8. After 3 successful runs post-fix → error archived
```

### Error Log Format → `.forge/memory-engineer/errors/{id}.md`
```markdown
# Error: {id}
- Skill: {skill-path}
- Date: {ISO-8601}
- Run: {N}th execution
- Error: {description}
- Root Cause: {diagnosis}
- Fix: {what was changed}
- Skill Updated: {yes|no}
- Recurrence: {count}
```

### Skill Versioning
Every skill update via this loop appends a version block:
```markdown
<!-- FORGE:ENGINEER:FIX:v{N}:START -->
## Fix v{N} — {date}
{description of fix}
<!-- FORGE:ENGINEER:FIX:v{N}:END -->
```

## COMPONENT D: SEMANTIC RETRIEVAL (Optional)

When vector DB credentials detected, enables semantic search over
compiled knowledge. Extends Layer 3 (COMPILE) with intent-based retrieval.

### Detection Priority
```
1. PINECONE_API_KEY env var     → Pinecone (cloud, Roberts pattern)
2. CHROMA_PATH env var          → ChromaDB (local, open-source)
3. .forge/vector/config.md     → Custom configuration
4. None detected               → Skip, degrade to file-based search
```

### Self-Bootstrap Sequence
```bash
# If Pinecone detected:
pip install pinecone-client --break-system-packages 2>/dev/null ||
npm install @pinecone-database/pinecone 2>/dev/null

# If ChromaDB detected:
pip install chromadb --break-system-packages 2>/dev/null

# If neither available and shell exists:
echo "No vector DB detected. Semantic retrieval disabled."
echo "To enable: set PINECONE_API_KEY or CHROMA_PATH"
```

### Vectorization Pipeline (extends compile.sh)
```
After standard compilation:
1. For each new/updated wiki concept:
   a. Extract content + tags + summary
   b. Generate embedding via model
   c. Upsert to vector DB with memory unit metadata
   d. Store vector ID back in wiki concept file
2. HOTCACHE candidates selected by retrieval_score
```

### Retrieval at Query Time
```
1. Agent receives query
2. Generate query embedding
3. Search vector DB: top-K results by cosine similarity
4. Score results with retrieval_score formula
5. Return ranked memory units
6. Agent uses in response (just-in-time, not pre-loaded)
```

### Namespace Strategy (Roberts pattern)
```
Vector DB index: {project-name}
Namespaces:
  - wiki:      compiled concepts
  - sessions:  session summaries
  - emails:    email content (if connected)
  - documents: uploaded/ingested documents
  - errors:    error patterns (for anti-pattern detection)
```

## COMPONENT E: SELF-BOOTSTRAPPING

The skill installs its own dependencies based on environment.

### Bootstrap Sequence
```
1. DETECT environment:
   - Shell access? (test with `echo test`)
   - Package manager? (npm, pip, brew)
   - Vector DB credentials? (env vars)
   - Runtime? (agent fingerprint)

2. SCAFFOLD:
   mkdir -p .forge/memory-engineer/{errors,skill-runs,vector}

3. INSTALL dependencies (only what's available):
   - Vector DB client (if credentials exist)
   - Embedding model access (via OpenRouter or local)

4. CONFIGURE:
   - Write .forge/memory-engineer/config.md
   - Register with orchestrator's AMENDMENTS.md

5. VERIFY:
   - Test vector DB connection (if enabled)
   - Test memory unit write/read cycle
   - Report capabilities to human
```

### Graceful Degradation
```
FULL MODE:    Vector DB + all components → retrieval_score ranking
STANDARD:     No vector DB → file-based search, all other components
MINIMAL:      No shell → memory units + progressive disclosure only
```

## COMPONENT F: COMPACTION WITH EXTERNALIZATION

Beyond summarization — externalize snippets with reference IDs.
(Richmond's advanced compaction pattern)

### How It Works
```
1. Context approaching limit (>70% full)
2. Identify low-relevance segments (tool calls, old exchanges)
3. Externalize to .forge/memory-engineer/externalized/{id}.md
4. Replace in context with:
   "[EXTERNALIZED:{id}] {one-line summary} → retrieve with memory_recall"
5. Agent can retrieve full content via tool call when needed
6. Reduces context usage while preserving zero information loss
```

### Externalization Priority (what to externalize first)
1. Tool call results (verbose, rarely re-referenced)
2. Old conversation turns (>10 turns ago)
3. Intermediate reasoning (superseded by final answer)
4. Duplicate information (already in HOTCACHE)
5. NEVER externalize: current task, active decisions, human instructions

## ROUTING — HOW ORCHESTRATORS FIND THIS SKILL

### For FORGE RECALL (The Enhancer):
```
After step 9 (index-builder) or step 11 (vision-memory):
→ IF .forge/memory-engineer/ exists OR config requests it:
  → Run skills/memory-engineer.md COMPONENT A (formalize units)
  → Run COMPONENT B (audit progressive disclosure)
  → Run COMPONENT C (check for error patterns)
  → Run COMPONENT D (if vector DB available)
```

### For FORGE GENESIS (The Builder):
```
After step 8b (vision-memory) or during ACTIVATE:
→ Run skills/memory-engineer.md SELF-BOOTSTRAP (Component E)
→ Scaffold .forge/memory-engineer/ directory
→ Apply COMPONENT A schema to all seeded templates
→ Apply COMPONENT B format to all installed skills
→ Wire COMPONENT C error loop into session-end hooks
```

### For FORGE HIVEMIND (The Synchronizer):
```
After step 6 (collective-learner):
→ IF memory-engineer active on participating agents:
  → Shared vector DB namespace for collective knowledge
  → Error patterns from individual agents promote to collective
  → Memory unit schemas must match across all agents
  → Retrieval scores normalize across agents for consensus
```

## RULES
1. Memory-engineer is ALWAYS optional — system works without it
2. All components degrade gracefully (full → standard → minimal)
3. Memory units are the ONLY standardized format — everything else adapts
4. Progressive disclosure is enforced on ALL skill files when active
5. Recursive improvement requires human approval for skill updates
6. Vector DB credentials NEVER stored in skill files (env vars only)
7. Self-bootstrap NEVER installs without shell access confirmation
8. This skill file itself follows progressive disclosure format
