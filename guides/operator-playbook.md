# Operator Playbook — Getting the Most From Your Agent

Practical patterns for running a persistent AI agent effectively. These are lessons from real daily use, not theory.

## 1. Context Architecture

Your agent's context window is finite (~200K tokens for Claude, ~128K for GPT-4). Everything in `workspace/` is loaded every session. This is powerful but has a budget.

**Rules of thumb:**
- AGENTS.md: Keep under 100 lines. Move details into referenced docs.
- SOUL.md: Keep under 50 lines. Personality, not policy manuals.
- MEMORY.md: Keep under 150 lines. Curate aggressively.
- TOOLS.md: Only local environment specifics. Can start empty.
- HEARTBEAT.md: Keep under 50 lines. Simple check-in rules.

**If your agent starts feeling "dumber" in long sessions:**
1. Your context window is filling up → use the Context Doctor skill to diagnose
2. Compaction happened and MEMORY.md is too sparse → add missing context
3. Too many workspace files loaded → use Context Slimmer to audit

## 2. Memory Hygiene

**Write only durable information to MEMORY.md:**
- User preferences (communication style, tools, timezone)
- Key decisions ("Chose PostgreSQL over MongoDB")
- Environment facts ("Server at 192.168.1.100, Python 3.12")
- Lessons learned ("Never push to main without tests")

**Don't put in MEMORY.md:**
- Work-in-progress status (use daily logs)
- Temporary information ("Waiting for Bob's reply")
- Duplicate information (if it's in USER.md, don't repeat in MEMORY.md)
- Full conversation summaries (that's what daily logs are for)

**Consolidation cadence:**
- Daily: Agent writes raw notes to `memory/YYYY-MM-DD.md`
- Weekly: Review daily logs, promote key facts to MEMORY.md
- Monthly: Prune MEMORY.md — remove outdated entries, consolidate related facts

## 3. Compaction Survival

When your conversation gets long, OpenClaw "compacts" it — summarizing older messages. This is where agents usually break. Here's how to survive it:

**Before compaction (automatic if configured):**
- Memory flush writes any unsaved important context to daily log
- This is your safety net — configure `memoryFlush.enabled: true`

**After compaction (automatic if configured):**
- `postCompactionSections` re-injects key AGENTS.md sections
- Agent reads MEMORY.md + daily log to reconstruct context
- LCM plugin (if installed) keeps full conversation searchable

**Manual recovery if agent seems confused:**
- "Read MEMORY.md and today's daily log, then continue where we left off"
- "Search your memory for [topic]" (triggers semantic memory search)

## 4. Delegation Patterns

If your agent supports subagents or background tasks:

**Delegate mechanical work:**
- Formatting, template generation, batch operations
- Research lookups, data gathering
- File organization, cleanup tasks

**Keep judgment calls in the main session:**
- Architecture decisions, strategy
- Anything requiring your conversation context
- Responses that need your preferences/personality

## 5. Heartbeat Tuning

Heartbeats are periodic check-ins. Too frequent = annoying. Too rare = things fall through.

**Starting point:** `"30m"` to `"1h"`
**Increase frequency when:** Running background tasks, monitoring something, in a critical work phase
**Decrease frequency when:** Casual conversation, not much active, agent checks are low-value

**The agent should reply `HEARTBEAT_OK` when nothing needs attention.** If every heartbeat generates a wall of text, your HEARTBEAT.md is too complex. Simplify it.

## 6. The Correction Loop

When your agent makes a mistake:
1. **Tell it directly:** "That's wrong because X. Do Y instead."
2. **Verify it understood:** It should acknowledge and correct.
3. **Make it durable:** "Add this to MEMORY.md so you don't forget."
4. **If it keeps happening:** The lesson needs to be in AGENTS.md (loaded every session), not just MEMORY.md.

Persistent correction > repeated correction. Write it down once properly.

## 7. Security Basics

- Never put API keys or passwords in workspace files (MEMORY.md, TOOLS.md, etc.)
- Use `~/.openclaw/secrets/` or environment variables for credentials
- Run Heimdall scan before installing any new skill
- If your agent has access to email/messaging, be explicit about what it can send
- Review SOUL.md security rules periodically

## 8. Progressive Capability Building

Don't try to configure everything at once. Build capability over time:

**Week 1:** Basic conversation, MEMORY.md building, personality calibration
**Week 2:** First skills installed (Context Doctor, Heimdall), heartbeat tuned
**Week 3:** Background tasks (cron jobs), automated routines
**Month 1:** Full workflow automation, multiple skills, memory search working well
**Month 2+:** Agent is calibrated to you, handles routine work autonomously

## 9. When Things Go Wrong

| Symptom | Quick Fix |
|---------|-----------|
| Agent doesn't remember yesterday | Check `memoryFlush.enabled: true` in config |
| Agent personality resets after long chat | Check `postCompactionSections` matches your AGENTS.md headers |
| Agent is slow or verbose | Context window full — run Context Doctor |
| Heartbeats are annoying | Increase interval or simplify HEARTBEAT.md |
| Agent does something dangerous | Add explicit rule to SOUL.md safety section |
| Skills not loading | Check `~/.openclaw/workspace/skills/` path and SKILL.md exists |
| Memory search doesn't find things | Verify `memorySearch` config and API key |
| Agent seems confused after restart | Read `start.md` flow — is MEMORY.md populated? |

## 10. The Golden Rule

Your agent is exactly as good as its workspace files. A well-maintained MEMORY.md + clear AGENTS.md + honest SOUL.md = an agent that feels like it knows you. Neglect them and it's just a chatbot with amnesia.

Invest 5 minutes a week reviewing these files. It compounds.
