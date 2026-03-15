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

## Recommended Skills

Skills live in `~/.openclaw/workspace/skills/`. Download from [ClawHub](https://clawhub.com).

**Already built into OpenClaw (no install needed):**
- weather, summarize, github, session-logs, healthcheck, coding-agent, skill-creator

**Essential add-ons (install these first):**
| Skill | What It Does |
|-------|-------------|
| context-doctor | Diagnose context window health and token budget |
| context-slimmer | Audit and slim always-loaded workspace files |
| context-aware-delegation | Give cron jobs and sub-agents main session context |
| cron-doctor | Diagnose and triage scheduled task failures |
| heimdall | Security scanner — scan new skills before installing |
| openclaw-backup | Backup/restore config, skills, and workspace |

**Productivity (pick what you use):**
| Skill | What It Does |
|-------|-------------|
| google-calendar | View events, schedule meetings, find free time |
| gmail-secretary | AI email triage with draft replies (never auto-sends) |
| google-docs / sheets / slides | Create and edit Google Workspace documents |
| data-analyst | Data viz, SQL, charts, dashboards, statistics |
| docx / xlsx / pptx | Create Word, Excel, PowerPoint files |
| deep-research | Autonomous multi-step research reports ($2-5/task) |

**Safety tip:** Before installing skills from unknown sources, scan with Heimdall first.

## Full Guide

Open `docs/smart-agent-guide.html` in your browser for the complete visual setup guide.

## Troubleshooting

- **Agent doesn't remember?** → Check `memoryFlush.enabled: true` AND `postCompactionSections`
- **Can't find config?** → Windows: `Win+R` → `%USERPROFILE%\.openclaw\openclaw.json`
- **Confused after long chats?** → `postCompactionSections` must match AGENTS.md headers exactly
- **No daily logs?** → Create `memory/` directory in workspace
- **Run diagnostics:** `openclaw doctor`

## Credits

Built by Mission Labs. Inspired by [awesome-agent-cortex](https://github.com/0xNyk/awesome-agent-cortex).

[Docs](https://docs.openclaw.ai) · [GitHub](https://github.com/openclaw/openclaw) · [Community](https://discord.com/invite/clawd) · [Skills](https://clawhub.com)
