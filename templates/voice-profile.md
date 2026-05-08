# Voice Profile: {PROFILE_NAME}
# Stored in: life/resources/voice-profiles/
# Loaded as Flash Live system_instruction at session start

<!-- FORGE:VOICE:PROFILE:START -->

## Identity
- **Name**: {profile display name}
- **Purpose**: {when to use this profile}
- **Voice Preset**: {Kore|Charon|Puck|Aoede|Fenrir|Leda|Orus|Zephyr}

## System Instruction
```
{The full system instruction text injected into Flash Live session.
Include: role, expertise, tone, behavioral rules.
This is the Craig DNA Bible equivalent for voice.}
```

## Tone Calibration
- **Pace**: {slow|measured|conversational|rapid}
- **Formality**: {casual|professional|academic|technical}
- **Energy**: {calm|engaged|enthusiastic|intense}
- **Thinking Level**: {minimal|low|medium|high}

## Guardrails (What NOT To Do)
- {e.g., "Never use filler words like 'um' or 'basically'"}
- {e.g., "Never interrupt a question to answer prematurely"}
- {e.g., "Never use jargon without defining it first"}

## Domain Context
Load these PARA areas when this profile activates:
- life/areas/{area_name}
- life/resources/{resource_name}

## Memory Integration
- **HOTCACHE injection**: {yes|no} (prepend HOTCACHE to system instruction)
- **Live tool calling**: {yes|no} (enable memory_write/memory_recall tools)
- **Vision**: {yes|no} (enable visual context capture)

<!-- FORGE:VOICE:PROFILE:END -->
