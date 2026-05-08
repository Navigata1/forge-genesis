# scaffold-builder
# Sub-skill of FORGE GENESIS
# Purpose: Create the complete 6-layer directory structure from scratch

## INPUT
- `capability-report.md`: which layers to build vs. leverage
- `workspace_root`: where to create the structure
- Templates directory path

## PROCEDURE

### Step 1: Create Core Directories
```bash
mkdir -p memory/logs          # Layer 2: daily capture
mkdir -p memory/wiki          # Layer 3: compiled knowledge
mkdir -p memory/connections   # Layer 5: inter-concept graph
mkdir -p memory/recall        # Layer 6: pre-prompt injection
mkdir -p life/projects        # Layer 4: PARA - active projects
mkdir -p life/areas           # Layer 4: PARA - ongoing areas
mkdir -p life/resources       # Layer 4: PARA - reference material
mkdir -p life/archive         # Layer 4: PARA - completed/inactive
mkdir -p scripts              # Automation scripts
mkdir -p .forge/genesis       # Install metadata
```

### Step 2: Copy Templates (Layer 1 — ROUTING)
- Copy `templates/MEMORY.md` → `MEMORY.md` (workspace root)
- Copy `templates/AGENTS.md` → `AGENTS.md` (if runtime supports it)
- Populate with actual paths created in Step 1

### Step 3: Seed Wiki (Layer 3 — COMPILE)
- Copy `templates/concept.md` → `memory/wiki/.template.md`
- Create `memory/wiki/index.md` with empty structure
- Create `memory/wiki/README.md` explaining the wiki

### Step 4: Seed PARA (Layer 4 — DURABLE)
- Copy `templates/PARA.md` → `life/README.md`
- Create starter files in each PARA directory:
  - `life/projects/.gitkeep`
  - `life/areas/.gitkeep`
  - `life/resources/.gitkeep`
  - `life/archive/.gitkeep`

### Step 5: Seed Recall (Layer 6 — RECALL)
- Copy `templates/HOTCACHE.md` → `memory/recall/HOTCACHE.md`
- Initial content: "No concepts compiled yet — hot cache empty"

### Step 6: Create Install Log
- Write all actions to `.forge/genesis/install-log.md`
- Record: timestamp, files created, directories created, runtime

## OUTPUT
- Complete directory structure at workspace_root
- All template files copied and customized
- Install log at `.forge/genesis/install-log.md`

## RULES
- NEVER overwrite existing files (check first, skip if exists)
- Log every file creation
- Use managed block markers in all seeded files
- If any step fails, continue with remaining steps (resilient)
- Template variables ({RUNTIME}, {DATE}, etc.) get populated during copy
