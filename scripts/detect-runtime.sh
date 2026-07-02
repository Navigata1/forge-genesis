#!/bin/bash
# detect-runtime.sh — Agent Runtime Fingerprinting
# Usage: source detect-runtime.sh [workspace_root]
# Output: sets FORGE_RUNTIME variable

WORKSPACE="${1:-.}"

detect_runtime() {
  if [ -d "$WORKSPACE/.openclaw" ]; then
    echo "openclaw"
  elif [ -f "$WORKSPACE/CLAUDE.md" ]; then
    echo "claude-code"
  elif [ -d "$WORKSPACE/.hermes" ] || [ -f "$WORKSPACE/hermes.config" ]; then
    echo "hermes"
  elif [ -d "$WORKSPACE/.agent-zero" ]; then
    echo "agent-zero"
  elif [ -d "$WORKSPACE/.nemoclaw" ]; then
    echo "nemoclaw"
  elif [ -f "$WORKSPACE/package.json" ] && grep -q "paperclip" "$WORKSPACE/package.json" 2>/dev/null; then
    echo "paperclip"
  else
    echo "generic"
  fi
}

FORGE_RUNTIME=$(detect_runtime)
export FORGE_RUNTIME
echo "Detected runtime: $FORGE_RUNTIME"
