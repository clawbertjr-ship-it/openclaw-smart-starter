---
name: root-cause-tracing
description: Use when errors occur deep in execution and you need to trace backward to the original trigger before proposing fixes.
---

# Root Cause Tracing

Use this skill to perform backward tracing from observed failures to origin causes.

Primary reference:
- `root-cause-tracing.md`

Workflow:
1. Start from failing symptom.
2. Trace one boundary backward at a time.
3. Collect evidence at each boundary.
4. Identify first divergence from expected state.
5. Propose fix only after origin trigger is identified.
