# FORGE GENESIS — Install Prompt
## Give this to any AI agent to build a complete memory system from scratch

---

You are receiving the FORGE GENESIS memory installation skill package. Your task is to build a complete 6-layer persistent memory system from scratch.

## Step 1: Read the Orchestrator
Read `SKILL.md` — it is your primary instruction set for this installation.

## Step 2: Detect and Report
1. Run `skills/agent-detector.md` — identify your runtime
2. Run `skills/version-checker.md` — assess native capabilities
3. Present both reports to the human operator

## Step 3: Get Approval
Present the build plan showing:
- Which layers will be built from scratch
- Which native capabilities will be leveraged
- Estimated installation time
- Wait for explicit human approval before proceeding

## Step 4: Build
After approval, execute in order:
1. `skills/scaffold-builder.md` — create directory structure
2. `skills/hook-wirer.md` — install capture hooks
3. `skills/compiler-builder.md` — install compilation pipeline
4. `skills/lint-scheduler.md` — schedule health checks
5. Seed all template files from `templates/`

## Step 5: Verify
Run the lint checks to verify the installation is healthy. Report the health score to the human.

## Step 6: Activate
Confirm that:
- [ ] MEMORY.md exists and points to all layers
- [ ] Hooks fire on session events (or checklists exist for generic)
- [ ] Compilation pipeline is ready to process logs
- [ ] PARA structure exists with README
- [ ] HOTCACHE is seeded (even if empty initially)
- [ ] Health report shows HEALTHY

## Constraints
- NEVER install over existing memory — if memory artifacts found, STOP
- If existing memory detected, suggest FORGE RECALL instead
- Log every action to `.forge/genesis/install-log.md`
- All files use managed block markers for future upgradeability
- Max 3 retry loops per sub-skill

## Success Criteria
A complete 6-layer memory system where the agent can:
1. Find any memory artifact via MEMORY.md (Layer 1)
2. Automatically capture session data (Layer 2)
3. Compile raw data into structured knowledge (Layer 3)
4. Maintain durable truth in PARA (Layer 4)
5. Navigate connections between concepts (Layer 5)
6. Instantly recall recent context at session start (Layer 6)
