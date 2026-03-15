# OpenClaw Smart Agent Starter

> Turn a basic AI assistant into one that **remembers everything, learns from mistakes, and gets better over time.**

A vanilla OpenClaw install gives you a capable AI agent. But without the right workspace setup, it forgets everything between sessions. This starter kit fixes that.

## What's Inside

```
workspace/           → Copy these to ~/.openclaw/workspace/
  AGENTS.md          → Operating manual (session startup, memory rules, safety)
  SOUL.md            → Agent personality and communication style
  USER.md            → Information about YOU
  IDENTITY.md        → Agent name and role
  TOOLS.md           → Local notes (starts empty)
  HEARTBEAT.md       → Proactive check-in schedule
  MEMORY.md          → Long-term memory (starts nearly empty)
  start.md           → Quick-start checklist for each session
  memory/            → Daily log folder (empty to start)

skills/              → Copy these to ~/.openclaw/workspace/skills/
  17 essential skills bundled — context management, security,
  agent discipline, and development workflows (see below)

docs/
  smart-agent-guide.html   → Full visual setup guide (open in browser)
  example-config.json5     → Copy-paste config with comments
  memory-system.md         → How the memory system works
  customization.md         → Guide to personalizing each file
  troubleshooting.md       → Common issues and fixes
```

## Quick Start (15 minutes)

1. **Install OpenClaw:** `npm install -g openclaw && openclaw configure`
2. **Copy workspace files** to `~/.openclaw/workspace/` (see paths below)
3. **Fill in the brackets** in USER.md, SOUL.md, IDENTITY.md
4. **Configure memory** — copy `docs/example-config.json5` into your `openclaw.json`
5. **Start:** `openclaw gateway start`

### Where is everything?

| What | Windows | Mac/Linux |
|------|---------|-----------|
| Config file | `C:\Users\YOU\.openclaw\openclaw.json` | `~/.openclaw/openclaw.json` |
| Workspace | `C:\Users\YOU\.openclaw\workspace\` | `~/.openclaw/workspace/` |

**Windows tip:** Press `Win + R`, type `%USERPROFILE%\.openclaw`, press Enter.

## Critical Config Settings

These go in your `openclaw.json` under `agents.defaults`. See `docs/example-config.json5` for a complete example.

```json5
compaction: {
  mode: "safeguard",
  memoryFlush: {
    enabled: true,  // ← REQUIRED — saves notes before compaction
    prompt: "Write any lasting notes to memory/YYYY-MM-DD.md",
    systemPrompt: "Session nearing compaction. Store durable memories now."
  },
  // Re-injects these AGENTS.md sections after compaction
  // Must match your ## headers exactly
  postCompactionSections: ["Every Session", "Memory", "Safety"]
},
heartbeat: {
  every: "30m"
}
```

**Without `memoryFlush` + `postCompactionSections`, your agent WILL forget things.**

- `memoryFlush` tells your agent to save notes before compaction happens
- `postCompactionSections` re-injects key instructions after compaction so the agent knows to read those saved notes
- Without both, the agent saves its notes but then forgets it has notes to read

## Optional Enhancements

### Semantic Memory Search (Free)
Get a free API key from [Google AI Studio](https://aistudio.google.com/apikey), then add:
```json5
memorySearch: {
  remote: {
    provider: "gemini",
    model: "gemini-embedding-2-preview",
    apiKey: "YOUR_KEY",
    fallback: "local"
  }
}
```

### LCM Plugin (Lossless Compaction)
Makes compaction lossless — old messages become searchable summaries instead of being lost:
```bash
openclaw plugin install @martian-engineering/lossless-claw
```

### Mission Control Dashboard
A web UI for tasks, memory, chat, and monitoring. Included separately — see the guide.

## Bundled Skills (17 — ready to use)

Copy the `skills/` folder to `~/.openclaw/workspace/skills/`. These are what separate a forgetful chatbot from a reliable persistent agent.

**Context Management** (the compaction survival kit):
| Skill | What It Does |
|-------|-------------|
| context-aware-delegation | **Critical.** Gives cron/sub-agents access to main session history |
| context-doctor | X-ray your context window — see what's eating your token budget |
| context-slimmer | Slim always-loaded files to free token headroom |
| arc-memory-pruner | Auto-prune memory files — prevents unbounded growth |

**Security:**
| Skill | What It Does |
|-------|-------------|
| heimdall | **Run before installing ANY new skill.** 65+ malicious pattern detectors |
| eridian-carapace | Agent security hardening — 8 attack vector defenses |
| credence | Vet MCP servers and AI tools against trust registry (0-100 score) |
| openclaw-backup | Scheduled automatic backups of config, workspace, skills |

**Agent Discipline** (good habits, built in):
| Skill | What It Does |
|-------|-------------|
| writing-plans | Structured plans before touching code |
| verification-before-completion | Verify before claiming done |
| systematic-debugging | Reproduce → isolate → trace → fix → verify |
| root-cause-tracing | Find original trigger, not symptoms |
| deterministic-controller | Evidence-gated heartbeats (no false alarms) |
| cron-doctor | Diagnose and triage scheduled task failures |

**Development Workflow:**
| Skill | What It Does |
|-------|-------------|
| git-workflows | Advanced git: rebase, bisect, worktrees, reflog |
| using-git-worktrees | **Prevents file conflicts between parallel agents** |
| finishing-a-development-branch | Guides branch completion — merge vs PR vs cleanup |

## More Skills

**53 built into OpenClaw** (no install needed): weather, summarize, github, session-logs, healthcheck, coding-agent, skill-creator, nano-pdf, voice-call, and 44 more.

**Recommended add-ons** from [ClawHub](https://clawhub.com): google-calendar, gmail-secretary, google-docs/sheets/slides, data-analyst, docx/xlsx/pptx, deep-research, academic-research, crawl4ai, and hundreds more.

**Safety tip:** Heimdall is bundled — always scan new skills before installing.

## Full Guide

Open `docs/smart-agent-guide.html` in your browser for the complete visual setup guide.

## Troubleshooting

- **Agent doesn't remember?** → Check `memoryFlush.enabled: true` AND `postCompactionSections`
- **Can't find config?** → Windows: `Win+R` → `%USERPROFILE%\.openclaw\openclaw.json`
- **Confused after long chats?** → `postCompactionSections` must match AGENTS.md headers exactly
- **No daily logs?** → Create `memory/` directory in workspace
- **Run diagnostics:** `openclaw doctor`

## Credits

Inspired by [awesome-agent-cortex](https://github.com/0xNyk/awesome-agent-cortex).

[Docs](https://docs.openclaw.ai) · [GitHub](https://github.com/openclaw/openclaw) · [Community](https://discord.com/invite/clawd) · [Skills](https://clawhub.com)
