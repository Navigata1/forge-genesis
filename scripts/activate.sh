#!/bin/bash
# activate.sh — Final activation and verification
# Usage: ./activate.sh [workspace_root]

WORKSPACE="${1:-.}"
echo "=== FORGE GENESIS: Activate ==="

PASS=0
FAIL=0

# Verify Layer 1: ROUTING
if [ -f "$WORKSPACE/MEMORY.md" ]; then
  echo "✅ Layer 1 (ROUTING): MEMORY.md present"
  PASS=$((PASS + 1))
else
  echo "❌ Layer 1 (ROUTING): MEMORY.md missing"
  FAIL=$((FAIL + 1))
fi

# Verify Layer 2: CAPTURE
if [ -d "$WORKSPACE/.claude/hooks" ] || [ -d "$WORKSPACE/.openclaw/hooks" ] || [ -d "$WORKSPACE/.forge/hooks" ]; then
  echo "✅ Layer 2 (CAPTURE): Hooks directory present"
  PASS=$((PASS + 1))
else
  echo "❌ Layer 2 (CAPTURE): No hooks found"
  FAIL=$((FAIL + 1))
fi

# Verify Layer 3: COMPILE
if [ -d "$WORKSPACE/memory/wiki" ] && [ -f "$WORKSPACE/memory/wiki/index.md" ]; then
  echo "✅ Layer 3 (COMPILE): Wiki with index present"
  PASS=$((PASS + 1))
else
  echo "❌ Layer 3 (COMPILE): Wiki or index missing"
  FAIL=$((FAIL + 1))
fi

# Verify Layer 4: DURABLE
if [ -d "$WORKSPACE/life/projects" ] && [ -d "$WORKSPACE/life/areas" ]; then
  echo "✅ Layer 4 (DURABLE): PARA structure present"
  PASS=$((PASS + 1))
else
  echo "❌ Layer 4 (DURABLE): PARA structure missing"
  FAIL=$((FAIL + 1))
fi

# Verify Layer 5: GRAPH
if [ -d "$WORKSPACE/memory/connections" ]; then
  echo "✅ Layer 5 (GRAPH): Connections directory present"
  PASS=$((PASS + 1))
else
  echo "❌ Layer 5 (GRAPH): Connections directory missing"
  FAIL=$((FAIL + 1))
fi

# Verify Layer 6: RECALL
if [ -f "$WORKSPACE/memory/recall/HOTCACHE.md" ]; then
  echo "✅ Layer 6 (RECALL): HOTCACHE present"
  PASS=$((PASS + 1))
else
  echo "❌ Layer 6 (RECALL): HOTCACHE missing"
  FAIL=$((FAIL + 1))
fi

echo ""
echo "=== ACTIVATION RESULT ==="
echo "Passed: $PASS/6"
echo "Failed: $FAIL/6"

if [ "$FAIL" -eq 0 ]; then
  echo "Status: ✅ FULLY ACTIVATED"
  echo "$(date -Iseconds) — GENESIS COMPLETE" >> "$WORKSPACE/.forge/genesis/install-log.md"
else
  echo "Status: ⚠️ PARTIAL — $FAIL layer(s) need attention"
fi
