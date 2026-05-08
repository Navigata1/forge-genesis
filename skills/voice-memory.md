# voice-memory
# OPTIONAL Sub-skill of FORGE RECALL + FORGE GENESIS
# Purpose: Voice-native capture, personality persistence, and tonal recall via Gemini 3.1 Flash Live
# Additive only — does NOT modify existing sub-skills

## TRIGGER
Detected when:
- Environment variable `GEMINI_API_KEY` or `GOOGLE_AI_KEY` is set, OR
- `.forge/voice/config.md` exists with API key reference, OR
- Agent explicitly instructed to enable voice memory

## SELF-ASSEMBLY SEQUENCE
1. DETECT: Check for Gemini API access (key exists, endpoint reachable)
2. SCAFFOLD: Create `.forge/voice/` directory structure
3. CONFIGURE: Generate WebSocket session config from templates
4. WIRE: Extend Layer 2 (CAPTURE) hooks to include voice sessions
5. SEED: Create initial voice profile in PARA from templates
6. ACTIVATE: Verify round-trip audio → text → memory pipeline

## WHAT THIS ADDS TO THE 6-LAYER MODEL

### Layer 2 (CAPTURE) Extension — Voice Session Logs
Standard capture logs WHAT was said (text). Voice capture adds:
- **Tonal context**: frustration, excitement, sarcasm, uncertainty
- **Pacing signals**: rushed speech = urgency, slow = deliberation
- **Interruption patterns**: what the human chose to override
- **Language switching**: multilingual context (90+ languages)
- **Environmental context**: noisy = field work, quiet = deep focus

Voice session logs → `memory/logs/{date}-voice.md` (alongside text logs)

### Layer 4 (DURABLE/PARA) Extension — Voice Profiles
Personality configurations stored as reusable system instructions:
```
life/resources/voice-profiles/
├── default.md          # Base personality + tone rules
├── professional.md     # Formal, precise, domain-expert voice
├── coaching.md         # Supportive, challenging, motivational
├── creative.md         # Playful, exploratory, associative
└── custom/             # User-created profiles
```

Each profile contains:
- System instruction text (injected into Flash Live session config)
- Guardrails (Craig's DNA Bible pattern — what NOT to say/do)
- Tone calibration (pitch preference, pacing, vocabulary level)
- Domain context (which PARA areas to load for this persona)

### Layer 6 (RECALL) Extension — Voice-Native Injection
HOTCACHE content becomes the system instruction preamble:
```
Flash Live Session Config:
  system_instruction: {HOTCACHE content} + {active voice profile}
  voice: {selected voice preset}
  thinking_level: {minimal|low|medium|high}
  tools: [{memory_write_tool}, {recall_tool}]
```

## TOOL DEFINITIONS (for Flash Live function calling)

### Tool: memory_write
```json
{
  "name": "memory_write",
  "description": "Write important information to the memory system during voice conversation",
  "parameters": {
    "type": "object",
    "properties": {
      "category": {
        "type": "string",
        "enum": ["decision", "knowledge", "question", "action_item"]
      },
      "content": { "type": "string" },
      "importance": { "type": "string", "enum": ["low", "medium", "high"] }
    }
  }
}
```
When Flash Live calls this tool during conversation, it writes directly
to the active daily voice log — no post-session extraction needed.

### Tool: memory_recall
```json
{
  "name": "memory_recall",
  "description": "Look up information from the memory system during voice conversation",
  "parameters": {
    "type": "object",
    "properties": {
      "query": { "type": "string" },
      "scope": { "type": "string", "enum": ["hotcache", "wiki", "para", "all"] }
    }
  }
}
```
Flash Live can self-query memory mid-conversation without human prompting.

## SCAFFOLD STRUCTURE
```
.forge/voice/
├── config.md               # API endpoint, key reference, defaults
├── session-template.json    # WebSocket session config template
├── profiles/                # Symlinks to life/resources/voice-profiles/
├── logs/                    # Voice-specific session metadata
└── tonal-index.md           # Running index of emotional context patterns
```

## VOICE SESSION LOG FORMAT → `memory/logs/{date}-voice.md`
```markdown
## Voice Session: {HH:MM:SS}
**Profile**: {active voice profile name}
**Duration**: {minutes}
**Language**: {detected language}
**Environment**: {quiet|moderate|noisy}

### Tonal Summary
- Dominant tone: {e.g., focused, frustrated, exploratory}
- Notable shifts: {e.g., "shifted from uncertain to confident at 4:30"}
- Interruption count: {N}

### Content (tool-captured)
- [DECISION] {content} (importance: high)
- [KNOWLEDGE] {content} (importance: medium)
- [ACTION_ITEM] {content} (importance: high)

### Concepts Referenced
- [[{concept_name}]] (recalled via memory_recall tool)

### Raw Transcript Pointer
→ .forge/voice/logs/{session-id}-transcript.txt
```

## COMPILATION INTEGRATION
Voice logs feed into the standard compilation pipeline:
- `scripts/compile.sh` already processes `memory/logs/*.md`
- Voice logs follow the same format → automatically included
- Tonal context enriches concept extraction (concepts marked with emotional weight)
- Voice-specific patterns promoted to `tonal-index.md` over time

## RULES
1. Voice memory is OPTIONAL — system works fully without it
2. API key stored as environment variable or pointer, NEVER in skill files
3. Voice profiles are human-owned (live in PARA Layer 4)
4. Raw audio is NOT stored — only transcripts and tonal metadata
5. Tool calls during voice sessions write to the SAME daily log format
6. If Flash Live is unavailable, degrade to standard text capture
7. SynthID watermarking is automatic — no action needed
8. Session config always includes HOTCACHE as system instruction preamble

## DEPENDENCIES
- Gemini API key (free tier sufficient for development)
- WebSocket support (Node.js or Python environment)
- Existing 6-layer memory system (FORGE GENESIS or RECALL)
- No additional infrastructure required
