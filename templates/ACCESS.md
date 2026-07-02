# Memory Access Map — Principal-Scoped Retrieval (VMG Primitive 3)
# Who may read which memory scopes. RECALL filters by scope BEFORE relevance scoring.
# Human-owned: agents PROPOSE changes here; humans approve (GATE).

<!-- FORGE:VMG:ACCESS:START -->

## Principals

- principal: default
  kind: human | agent | hook
  scopes: [routing, capture, compile, durable, graph, recall]   # all six layers
  notes: single-principal default — edit when adding agents

## Scope Definitions

| Scope | Maps to | Contains |
|-------|---------|----------|
| routing | MEMORY.md | The index — where to look |
| capture | memory/logs/ | Raw session events |
| compile | memory/wiki/ | Extracted concepts |
| durable | life/ (PARA) | Human-owned truth |
| graph | memory/connections/ | Backlinks & relations |
| recall | memory/recall/ | HOTCACHE — pre-prompt injection |

## Rules
1. A unit is retrievable by a principal only if the unit's layer ∈ principal's scopes
2. Un-scoped principals get NOTHING (fail closed, never open)
3. FORGE HIVEMIND: principal = agent manifest id; sync-gateway enforces on every exchange
4. Scope changes are logged to `.forge/vmg/write-log.md`

<!-- FORGE:VMG:ACCESS:END -->
