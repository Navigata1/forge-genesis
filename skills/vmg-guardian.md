# vmg-guardian
# Sub-skill of FORGE GENESIS
# Purpose: wire the five Verifiable Memory Governance primitives (arXiv:2604.16548)
# Principle: security is anchored at STORAGE time, never retrofitted at retrieval time.

## INPUT
- `workspace_root`: path to agent workspace (post-scaffold)
- `runtime-report.md`: detected runtime

## THE FIVE PRIMITIVES

### 1. WRITE AUTHORIZATION — every entry attributable to an authenticated source
- Every memory unit MUST carry `written_by` (agent id / human / hook name) and `authorized_by`
- Units missing attribution are quarantined to `memory/quarantine/`, never merged
- Hooks wired by hook-wirer stamp `written_by` automatically; human edits stamp `human`

### 2. PROVENANCE VISIBILITY — queryable, lineage-complete provenance
- Every unit carries `provenance:` (ordered chain: origin → transforms → current)
- COMPILE (Layer 3) must APPEND to the chain, never replace it
- `scripts/vmg-check.sh --provenance` lists any unit with a broken/empty chain

### 3. PRINCIPAL-SCOPED RETRIEVAL — memory answers only to its principals
- `memory/ACCESS.md` maps principals → readable scopes (default: single-principal, all)
- RECALL (Layer 6) injection filters by scope BEFORE relevance scoring
- Multi-agent setups: scope = agent manifest id (FORGE HIVEMIND enforces on sync)

### 4. ROLLBACKABILITY — versioned snapshots + write logs
- Every unit carries `version` + `prior_version_id`; superseded units keep `status: superseded`
- Write log: `.forge/vmg/write-log.md` (append-only: timestamp, unit id, actor, op)
- Snapshot before any batch operation (reuse FORGE RECALL `scripts/backup.sh` pattern)

### 5. VERIFIED FORGETTING — demonstrable non-recoverability
- Deletion = tombstone (`status: tombstoned`, content REMOVED) + purge sweep
- `scripts/vmg-check.sh --forget <id|phrase>` proves absence across store,
  HOTCACHE, wiki, backups older than retention, and the write log content field
- Forgetting is only DONE when the check passes — report or it didn't happen

## SEQUENCE
1. Create `memory/ACCESS.md` from template (single-principal default)
2. Create `.forge/vmg/write-log.md` (managed block header)
3. Patch capture hooks: stamp `written_by` on every new unit (managed blocks)
4. Verify memory-unit template carries provenance fields (fail → re-seed template)
5. Run `scripts/vmg-check.sh --all` → outputs `.forge/vmg/vmg-report.md`

## OUTPUT → `.forge/vmg/vmg-report.md`
```markdown
# VMG Report — {ISO-8601}
| Primitive | Status | Details |
|-----------|--------|---------|
| Write Authorization | PASS/FAIL | {n} unattributed units (quarantined) |
| Provenance | PASS/FAIL | {n} broken chains |
| Scoped Retrieval | PASS/N-A | principals: {list} |
| Rollbackability | PASS/FAIL | write-log present, {n} versioned units |
| Verified Forgetting | PASS/PENDING | last proof: {id or none} |
```

## RULES
- Non-destructive: quarantine, never delete (except verified-forget flow)
- Human approves ACCESS.md scope changes (GATE)
- Every primitive check is re-runnable and idempotent
- Max 3 retry loops; log to `.forge/genesis/install-log.md`
