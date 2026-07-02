#!/bin/bash
# vmg-check.sh — Verifiable Memory Governance checks (arXiv:2604.16548 five primitives)
# Usage: ./vmg-check.sh [workspace_root] [--all | --provenance | --forget "<id-or-phrase>"]
# Non-destructive. Report-only except quarantine moves (which are reversible).

WORKSPACE="${1:-.}"
MODE="${2:---all}"
TARGET="$3"
VMG_DIR="$WORKSPACE/.forge/vmg"
REPORT="$VMG_DIR/vmg-report.md"
mkdir -p "$VMG_DIR" "$WORKSPACE/memory/quarantine"

FAIL=0

start_report() {
  echo "# VMG Report — $(date -Iseconds)" > "$REPORT"
  echo "" >> "$REPORT"
  echo "| Primitive | Status | Details |" >> "$REPORT"
  echo "|-----------|--------|---------|" >> "$REPORT"
}

check_write_auth() {
  # Units = md files under memory/ carrying an id: field; must also carry written_by:
  UNATTRIBUTED=$(grep -rl "^id:" "$WORKSPACE/memory" --include="*.md" 2>/dev/null | while read -r f; do
    grep -q "^written_by:" "$f" || echo "$f"
  done)
  N=$(echo "$UNATTRIBUTED" | grep -c '.' 2>/dev/null || echo 0)
  if [ "$N" -gt 0 ]; then
    echo "$UNATTRIBUTED" > "$VMG_DIR/unattributed.log"
    echo "| Write Authorization | FAIL | $N unattributed units → unattributed.log |" >> "$REPORT"
    FAIL=$((FAIL + 1))
  else
    echo "| Write Authorization | PASS | all units attributed |" >> "$REPORT"
  fi
}

check_provenance() {
  BROKEN=$(grep -rl "^id:" "$WORKSPACE/memory" --include="*.md" 2>/dev/null | while read -r f; do
    grep -q "^provenance:" "$f" || echo "$f"
  done)
  N=$(echo "$BROKEN" | grep -c '.' 2>/dev/null || echo 0)
  if [ "$N" -gt 0 ]; then
    echo "$BROKEN" > "$VMG_DIR/broken-provenance.log"
    echo "| Provenance | FAIL | $N units missing chains → broken-provenance.log |" >> "$REPORT"
    FAIL=$((FAIL + 1))
  else
    echo "| Provenance | PASS | all chains present |" >> "$REPORT"
  fi
}

check_scope() {
  if [ -f "$WORKSPACE/memory/ACCESS.md" ]; then
    PRINCIPALS=$(grep -c "^- principal:" "$WORKSPACE/memory/ACCESS.md" 2>/dev/null || echo 0)
    echo "| Scoped Retrieval | PASS | $PRINCIPALS principal(s) defined |" >> "$REPORT"
  else
    echo "| Scoped Retrieval | FAIL | memory/ACCESS.md missing |" >> "$REPORT"
    FAIL=$((FAIL + 1))
  fi
}

check_rollback() {
  if [ -f "$VMG_DIR/write-log.md" ]; then
    OPS=$(grep -c "^|" "$VMG_DIR/write-log.md" 2>/dev/null || echo 0)
    echo "| Rollbackability | PASS | write-log present ($OPS entries) |" >> "$REPORT"
  else
    echo "| Rollbackability | FAIL | .forge/vmg/write-log.md missing |" >> "$REPORT"
    FAIL=$((FAIL + 1))
  fi
}

check_forget() {
  # Prove absence of a phrase/id across store, hotcache, wiki, and write-log CONTENT.
  # Tombstone markers themselves are allowed (they carry no content).
  HITS=$(grep -rn --include="*.md" -F "$TARGET" \
    "$WORKSPACE/memory" "$WORKSPACE/MEMORY.md" "$WORKSPACE/life" 2>/dev/null \
    | grep -v "status: tombstoned" | grep -v "quarantine/")
  if [ -n "$HITS" ]; then
    echo "$HITS" > "$VMG_DIR/forget-failures.log"
    echo "| Verified Forgetting | FAIL | target still recoverable → forget-failures.log |" >> "$REPORT"
    echo "VERIFIED FORGET: FAIL — target still present. See $VMG_DIR/forget-failures.log"
    FAIL=$((FAIL + 1))
  else
    echo "| Verified Forgetting | PASS | '$TARGET' non-recoverable in live store |" >> "$REPORT"
    echo "VERIFIED FORGET: PASS — reminder: also purge external backups past retention."
  fi
}

start_report
case "$MODE" in
  --provenance) check_provenance ;;
  --forget)     [ -z "$TARGET" ] && { echo "usage: vmg-check.sh <ws> --forget \"<id-or-phrase>\""; exit 2; }
                check_forget ;;
  --all|*)      check_write_auth; check_provenance; check_scope; check_rollback
                echo "| Verified Forgetting | PENDING | run --forget to prove a deletion |" >> "$REPORT" ;;
esac

echo "" >> "$REPORT"
[ "$FAIL" -eq 0 ] && echo "Overall: GOVERNED" >> "$REPORT" || echo "Overall: UNGOVERNED ($FAIL primitive(s) failing)" >> "$REPORT"
cat "$REPORT"
exit "$FAIL"
