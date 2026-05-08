# Memory Unit Template
# The atom of the memory system — every stored piece of information
# conforms to this schema. Type-specific fields are optional.

<!-- FORGE:ENGINEER:UNIT:START -->

## Base Fields (required)
```yaml
id:              # {timestamp}-{short-hash}
content:         # The actual information (text)
type:            # decision | knowledge | question | action | error | pattern
source:          # session | compile | human | agent | voice | vision
timestamp:       # ISO-8601
importance:      # 1 (trivial) to 5 (critical)
relevance_tags:  # [tag1, tag2, ...]
references:      # [memory-id-1, memory-id-2, ...]
layer:           # 1-6 (which memory layer this lives in)
```

## Decision Unit (extends base)
```yaml
options_considered: # [option-a, option-b, ...]
rationale:          # Why this option was chosen
reversible:         # yes | no
```

## Error Unit (extends base)
```yaml
error_description:  # What went wrong
root_cause:         # Why it went wrong
fix_applied:        # What was done to fix it
skill_updated:      # yes | no | path-to-skill
recurrence_count:   # How many times this error has occurred
```

## Workflow Unit (extends base)
```yaml
steps:              # [step-1-description, step-2-description, ...]
outcome:            # success | failure | partial
duration:           # Seconds elapsed
tools_used:         # [tool-1, tool-2, ...]
```

## Knowledge Unit (extends base)
```yaml
domain:             # Which knowledge domain
confidence:         # 0-100% (how certain is this fact)
source_count:       # How many independent sources confirm this
canonical:          # true | false (promoted to PARA?)
```

## Scoring (computed, not stored)
```
retrieval_score = (relevance × 0.4) + (importance × 0.35) + (recency × 0.25)

relevance:  cosine similarity to query (0.0 - 1.0), or 1.0 if exact match
importance: value / 5 (normalized to 0.0 - 1.0)
recency:    exp(-0.099 × days_since_creation), half-life ≈ 7 days
```

<!-- FORGE:ENGINEER:UNIT:END -->
