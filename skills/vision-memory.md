# vision-memory
# OPTIONAL Sub-skill of FORGE RECALL + FORGE GENESIS
# Purpose: Visual context capture, screen memory, and spatial awareness via Gemini 3.1 Flash Live
# Additive only — does NOT modify existing sub-skills

## TRIGGER
Detected when:
- Voice-memory sub-skill is active (vision extends voice), AND
- Flash Live session configured with video input enabled, OR
- `.forge/vision/config.md` exists with vision enabled flag

## SELF-ASSEMBLY SEQUENCE
1. DETECT: Verify Flash Live supports video input in current environment
2. SCAFFOLD: Create `.forge/vision/` directory structure
3. CONFIGURE: Extend voice session config to include video modality
4. WIRE: Add vision capture to Layer 2 hooks
5. SEED: Create initial vision context templates
6. ACTIVATE: Verify camera/screen → description → memory pipeline

## WHAT THIS ADDS TO THE 6-LAYER MODEL

### Layer 2 (CAPTURE) Extension — Visual Context Logs
Standard capture logs text. Voice capture adds tone. Vision capture adds:
- **Screen context**: What application, document, or UI the human is looking at
- **Physical environment**: Workspace setup, whiteboard content, hardware
- **Object identification**: Tools, documents, devices in frame
- **Spatial relationships**: How things are arranged and organized
- **Change detection**: "User switched from IDE to browser at 3:42"

Vision observations → appended to voice session logs (same file, enriched)

### Layer 3 (COMPILE) Extension — Visual Concept Enrichment
When concepts are compiled from session logs that include vision data:
- Concepts gain `visual_context` field: "This decision was made while viewing {X}"
- Architecture decisions linked to specific diagrams or UI states
- Physical artifacts (whiteboards, notebooks) transcribed into wiki concepts

### Layer 5 (GRAPH) Extension — Spatial Connections
Vision enables a new connection type: SPATIAL
- "This concept was discussed while viewing {screenshot_description}"
- "This file was on screen when {decision} was made"
- Links between concepts gain visual provenance

## VISION MODES

### Mode 1: WEBCAM (physical environment)
**Captures**: Physical workspace, whiteboard, hardware, human gestures
**Use case**: Design reviews, physical prototyping, workspace documentation
**Memory value**: Records CONTEXT that text alone misses
```
Flash Live sees: "User has a whiteboard with three columns labeled
'Must Have', 'Nice to Have', 'Cut'. The 'Must Have' column has 5 items."
→ Captured to daily log as visual context
→ Whiteboard content transcribed as wiki-candidate knowledge
```

### Mode 2: SCREEN SHARE (digital environment)
**Captures**: Active applications, documents, code, UI state
**Use case**: Coding sessions, document reviews, research navigation
**Memory value**: Records WHAT THE HUMAN WAS LOOKING AT during decisions
```
Flash Live sees: "User is viewing a React component file in VS Code.
The file is auth-provider.tsx. There is an error underline on line 47."
→ Captured to daily log as screen context
→ File reference added to session's "Files Modified" section
```

### Mode 3: AMBIENT (periodic snapshots)
**Captures**: Low-frequency environmental snapshots (every 5 min)
**Use case**: Long sessions where visual context changes gradually
**Memory value**: Creates a visual timeline without constant processing
**Token cost**: Minimal — only processes changes from previous snapshot

## TOOL DEFINITIONS (extending voice-memory tools)

### Tool: vision_describe
```json
{
  "name": "vision_describe",
  "description": "Capture and describe current visual context for memory",
  "parameters": {
    "type": "object",
    "properties": {
      "focus": {
        "type": "string",
        "enum": ["full_frame", "text_content", "ui_state", "objects", "changes"]
      },
      "save_to_memory": { "type": "boolean" }
    }
  }
}
```
Agent can self-trigger visual capture during conversation.

### Tool: vision_compare
```json
{
  "name": "vision_compare",
  "description": "Compare current visual state with a previous description",
  "parameters": {
    "type": "object",
    "properties": {
      "previous_description": { "type": "string" },
      "focus": { "type": "string", "enum": ["what_changed", "what_remains"] }
    }
  }
}
```
Enables change detection across a session.

## SCAFFOLD STRUCTURE
```
.forge/vision/
├── config.md               # Vision mode settings, frequency, focus areas
├── context-log.md           # Running visual context descriptions
└── snapshots/               # Periodic snapshot descriptions (text, not images)
    └── {date}-{time}.md     # Individual snapshot description
```

## VISION-ENRICHED SESSION LOG ADDITIONS
```markdown
### Visual Context (appended to voice/text session log)
**Mode**: {webcam|screen|ambient}
**Captures**: {count}

#### Snapshot: {HH:MM:SS}
- **Scene**: {one-line description}
- **Key objects/content**: {list}
- **Relevance to discussion**: {connection to current topic}
- **Changes from previous**: {delta description}
```

## PRIVACY AND STORAGE RULES
1. **NO raw images stored** — only text descriptions of visual content
2. **NO facial recognition** — people described by role/position, not identity
3. **NO sensitive screen content logged** — passwords, financial data, PII excluded
4. Vision descriptions are text → same storage/compilation pipeline as everything else
5. User can disable vision at any time without affecting other layers
6. Ambient mode frequency configurable (default: every 5 minutes)
7. Screen share mode respects application exclusion list

## COMPILATION INTEGRATION
Vision descriptions are text and feed directly into standard pipeline:
- `scripts/compile.sh` processes them alongside text and voice logs
- Visual context enriches concept extraction with provenance
- No special handling needed — it's all markdown in the daily log

## DEPENDENCY CHAIN
```
vision-memory REQUIRES voice-memory REQUIRES 6-layer base
```
Vision cannot operate independently — it extends voice sessions.
Voice can operate independently without vision.
Both are optional extensions to the core 6-layer system.

## RULES
1. Vision is OPTIONAL and requires voice-memory as prerequisite
2. NEVER store raw images or video — text descriptions only
3. Privacy-first: user controls what gets captured via config
4. Degrades gracefully: if camera/screen unavailable, voice continues normally
5. Vision descriptions use same managed block markers as all other content
6. Screen share exclusion list prevents sensitive app capture
7. All vision data flows through the standard compilation pipeline
