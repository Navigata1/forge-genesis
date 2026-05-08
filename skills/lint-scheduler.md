# lint-scheduler
# Sub-skill of FORGE GENESIS
# Purpose: Schedule automated health checks for the memory system

## INPUT
- `runtime-report.md`: detected runtime
- `workspace_root`: where lint should run

## SCHEDULING STRATEGIES

### Claude Code
- Add lint to session-end hook (runs after every session)
- Add lint to CLAUDE.md as periodic reminder
- Config: "After compilation, run lint checks and report health"

### OpenClaw
- Add lint to post-session event
- Wire into skill that runs on workspace open
- Config in .openclaw/config.yml

### Hermes
- Add lint as scheduled plugin task
- Run on session boundaries

### Generic
- Create `.forge/lint-schedule.md` with manual checklist
- Suggest: "Run scripts/lint.sh weekly or after major changes"

## LINT CHECKS (same as FORGE RECALL's lint-runner)
1. Orphan check — files not linked
2. Stale check — untouched 30+ days
3. Contradiction check — conflicting facts
4. Gap check — referenced but missing
5. Broken link check — dead references
6. Bloat check — files too large

## AUTOMATION LEVELS
| Runtime | Auto-Lint | Schedule | Report Location |
|---------|-----------|----------|-----------------|
| Claude Code | ✅ | Every session end | .forge/recall/ |
| OpenClaw | ✅ | Post-session event | .forge/recall/ |
| Hermes | ✅ | Plugin schedule | .forge/recall/ |
| Generic | ❌ | Manual reminder | .forge/recall/ |

## OUTPUT
- Lint schedule wired into runtime events/hooks
- `scripts/lint.sh` installed (shared with FORGE RECALL)
- Schedule documented in `.forge/genesis/install-log.md`

## RULES
- Lint is advisory — never auto-fix
- Health reports accumulate (never overwrite previous)
- Delta comparison: each report shows change from last
- If lint finds CRITICAL, surface to human immediately
