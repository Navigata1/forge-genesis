# FORGE GENESIS — Amendment Block v2.1
# Research-Grounded Governance Hardening
# Date: July 2, 2026
# Status: ACTIVE

## PURPOSE
Implements the five VMG primitives as a first-class install step:
- NEW skills/vmg-guardian.md — Write Authorization, Provenance Visibility,
  Principal-Scoped Retrieval, Rollbackability, Verified Forgetting
- NEW scripts/vmg-check.sh — re-runnable primitive checks (--all | --provenance | --forget)
- NEW templates/ACCESS.md — principal→scope map (fail closed)
- memory-unit template gains governance fields (written_by, authorized_by, provenance,
  version, prior_version_id, status) + hygiene fields (subject, valid_until, superseded_by)
- SKILL.md sequence gains step 9 (vmg-guardian); scaffold gains memory/ACCESS.md + .forge/vmg/

## GROUNDING
- arXiv:2604.16548 (LTM security survey) — Verifiable Memory Governance: five primitives,
  security anchored at STORAGE time, never retrofitted at retrieval
- arXiv:2606.24775 (12-system benchmark) — contradiction resolution tops out at 44.4 EM;
  stale stores "hallucinate the past"; localized maintenance ~18x cheaper than global reorg
- Full brief: neuralforge-memory-mastery/docs/memory-frontier-brief-2026-07.html

---

# FORGE GENESIS — Amendment Block v2.0
# The Governance Repositioning
# Date: July 2, 2026
# Status: ACTIVE (documentation + positioning; no behavioral changes to sub-skills)

## PURPOSE
Repositions this skill for the post-consolidation memory landscape (Q2 2026:
Anthropic Memory Tool GA, Managed Agents Memory beta, Dreaming, claude-mem ~66K stars).
The raw store-and-recall problem is solved at the primitive layer. This collection's
defensible position is the layer ABOVE the primitives: **memory governance** —
verification, trust, auditability, human-owned truth, and cross-vendor portability.

## WHAT CHANGED
- README leads with the governance thesis ("trust layer over your existing memory")
- manifest.json bumped to 2.0.0 with governance-first description
- Vocabulary claimed: "memory governance," "trust-scored memory," "cross-family memory consensus"

## WHAT DID NOT CHANGE
- All sub-skills, scripts, templates, and the 6-layer model operate exactly as in v1.2
- The architecture already WAS a governance layer — v2.0 names it

## ROADMAP (v2.x)
- Forge Score: a portable, quantified trust signal attached to individual memory units
- PSZN consensus: cross-family verification (Claude + GPT + Gemini + DeepSeek) of stored memories
- Adapters: first-class audit targets for Anthropic Memory Tool exports and claude-mem stores

---

# FORGE GENESIS — Amendment Block v1.1
# Voice + Vision Memory Extensions
# Date: April 8, 2026
# Status: ACTIVE

## PURPOSE
Adds OPTIONAL voice and vision capabilities during fresh memory installs.
When Gemini API access is detected, GENESIS automatically scaffolds voice
profile storage and wires Flash Live as an additional capture source.

## AMENDED SEQUENCE (additions to SKILL.md step 8)
```
After step 8 (seed initial files):
8a. IF Gemini API key detected:
    → Run `skills/voice-memory.md` SELF-ASSEMBLY sequence
    → Create life/resources/voice-profiles/ with default.md from template
    → Wire voice session hooks alongside text hooks
8b. IF voice active AND vision enabled in config:
    → Run `skills/vision-memory.md` SELF-ASSEMBLY sequence
    → Extend voice session config with video modality
```

## AMENDED SCAFFOLD (additions to scaffold-builder)
```
{workspace}/
├── ... (existing 6-layer structure unchanged)
├── life/resources/voice-profiles/    # NEW: personality configs
│   └── default.md                     # NEW: base voice profile
└── .forge/
    ├── ... (existing)
    ├── voice/                         # NEW: voice session config
    │   ├── config.md
    │   └── session-template.json
    └── vision/                        # NEW: vision config (if enabled)
        └── config.md
```

## AMENDED ACTIVATE VERIFICATION
```bash
# Original 6 checks unchanged, plus:
if voice_capable; then
  ✅/❌ Layer 2+ (VOICE CAPTURE): Flash Live config present
  ✅/❌ Layer 4+ (VOICE PROFILES): Default profile in PARA
  ✅/❌ Layer 6+ (VOICE RECALL): System instruction wired
fi
```

## DEPENDENCY CHAIN
```
6-layer base (required) → voice-memory (optional) → vision-memory (optional)
```

## AMENDED SUB-SKILL LIST
Original: agent-detector, version-checker, scaffold-builder, hook-wirer, compiler-builder, lint-scheduler
Added:    voice-memory (optional), vision-memory (optional)

## SCORING IMPACT
- Weighted total: 8.80 → 8.95 (with voice+vision active)
- Self-Improving: 8/10 → 9/10 (multimodal data = richer compilation)

## RULES
1. Voice/vision are NEVER required — fresh install works without them
2. Detection is automatic — if API key exists, offer voice setup
3. Human must approve voice profile creation (PARA is human-owned)
4. Amendment is append-only — original SKILL.md unchanged

---

# FORGE GENESIS — Amendment Block v1.2
# Memory Engineering Meta-Layer
# Date: April 9, 2026
# Status: ACTIVE

## PURPOSE
During fresh installs, optionally scaffolds the memory engineering
meta-layer (Layer 7) alongside the base 6 layers. Formalizes memory
units from day one, enforces progressive disclosure on all created skills,
and wires the recursive improvement loop into session hooks.

## NEW FILES
- `skills/memory-engineer.md` — shared sub-skill
- `templates/memory-unit.md` — atomic memory format template

## AMENDED SEQUENCE
```
After step 8b (vision-memory) or step 8 (seed templates):
8c. IF memory-engineer requested OR vector DB credentials detected:
    → Run skills/memory-engineer.md SELF-BOOTSTRAP (Component E)
    → Create .forge/memory-engineer/ directory structure
    → Apply memory unit schema to daily-note and concept templates
    → Enforce progressive disclosure format on all installed skills
    → Wire recursive improvement loop into session-end hooks
    → Connect vector DB if credentials available
```

## AMENDED SCAFFOLD (additions)
```
{workspace}/
├── ... (existing structure unchanged)
└── .forge/
    └── memory-engineer/          # NEW
        ├── config.md             # Capabilities and mode
        ├── errors/               # Error tracking (mistake memory)
        ├── skill-runs/           # Execution logs
        ├── externalized/         # Compacted context snippets
        └── vector/               # Vector DB config (if enabled)
```

## AMENDED ACTIVATE VERIFICATION
```bash
if memory_engineer_enabled; then
  ✅/❌ Layer 7 (ENGINEERING): .forge/memory-engineer/ present
  ✅/❌ Memory units: schema applied to templates
  ✅/❌ Progressive disclosure: skills audited
  ✅/❌ Improvement loop: wired to hooks
  ✅/❌ Vector DB: {connected|skipped}
fi
```

## DEPENDENCY CHAIN
```
6-layer base (required)
  → voice-memory (optional)
  → memory-engineer (optional, independent of voice)
    → vector-db (optional, requires memory-engineer)
```

## RULES
1. memory-engineer is OPTIONAL on fresh install
2. If enabled, all templates get memory unit schema from day one
3. Progressive disclosure enforced on every skill created
4. Append-only — original SKILL.md unchanged
