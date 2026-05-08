# FORGE GENESIS — Architecture Decisions

## Why "Builder" Not "Installer"

Traditional installers copy files. FORGE GENESIS calibrates to the runtime. A Claude Code installation looks different from an OpenClaw installation — same 6-layer model, different wiring. The "builder" metaphor captures this calibration step that installers miss.

## Relationship to FORGE RECALL

FORGE GENESIS builds from scratch. FORGE RECALL enhances what exists. They share:
- The same 6-layer model
- The same agent detection fingerprint
- The same lint checks
- The same templates

The critical gate: if GENESIS detects existing memory artifacts, it STOPS and suggests RECALL. This prevents destructive overwrites.

## Why PARA for Layer 4

PARA (Projects, Areas, Resources, Archive) was chosen because:
1. It maps cleanly to how humans organize knowledge
2. It has a clear promotion path (projects complete → archive)
3. It separates "active" from "reference" material
4. It's been battle-tested by thousands of knowledge workers
5. It protects durable truth from automated corruption (human-owned)

## Why Hooks Over Polling

Session hooks (fire on events) beat polling (check periodically) because:
1. Zero wasted computation — capture happens exactly when needed
2. No missed events — polling can skip short sessions
3. Natural integration — hooks use the runtime's native event system
4. Lower complexity — no scheduler, no cron, no daemon

The tradeoff: not all runtimes support hooks. Generic mode falls back to manual checklists — worse UX but still functional.

## Why LLM-Agnostic Compilation

The compilation pipeline (`compile.sh`) doesn't call any specific LLM API. Instead, it:
1. Bundles raw logs into `compile-input.md`
2. Includes `compile-prompt.md` with extraction instructions
3. The human or agent feeds this to whatever LLM is available

This means FORGE GENESIS works with OpenAI, Anthropic, local models, or even manual human compilation. The pipeline is a format, not a vendor lock.

## Scoring vs FORGE RECALL

| Criterion | RECALL | GENESIS | Why Different |
|-----------|--------|---------|---------------|
| Universality | 9 | 9 | Same detection system |
| Completeness | 10 | 10 | Both cover all 6 layers |
| Self-Healing | 8 | 7 | RECALL has delta comparison advantage |
| Token Efficiency | 9 | 9 | Same pointer-first approach |
| Distributable | 10 | 10 | Both self-contained |
| Self-Improving | 7 | 8 | GENESIS builds compounding loop from day one |
| **Weighted** | **8.85** | **8.80** | RECALL edges out on self-healing maturity |
