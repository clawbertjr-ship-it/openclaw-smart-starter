# OpenClaw Operations Kit

> **Drop-in workspace templates, 17 essential skills, production configs, and the complete operations guide for running AI agents that remember everything, learn from mistakes, and get better over time.**

A vanilla OpenClaw install gives you a capable AI agent. This kit gives you the workspace architecture, skills, and operational knowledge to run it like a production system.

## 🚀 Quick Start (15 minutes)

```bash
# 1. Install OpenClaw
npm install -g openclaw && openclaw configure

# 2. Clone this kit
git clone https://github.com/clawbertjr-ship-it/openclaw-smart-starter
cd openclaw-smart-starter

# 3. Run setup
./setup.bat    # Windows
./setup.sh     # Mac/Linux

# 4. Fill in USER.md, SOUL.md, IDENTITY.md with your info
# 5. Copy a config from configs/ to ~/.openclaw/openclaw.json
# 6. Start: openclaw gateway start
```

Your agent reads BOOTSTRAP.md on first run and guides itself through onboarding.

---

## 📖 The Guide

**[OpenClaw Advanced Operations Guide](docs/advanced-operations.html)** ← Download and open in your browser

The complete 69KB visual guide covering everything from basic architecture to multi-agent orchestration to production security. Five parts, 20 sections:

| Part | Covers |
|------|--------|
| **Part 1: Architecture** | How OpenClaw works, config deep dive, 4-tier memory system, LCM plugin, workspace mastery, context engineering |
| **Part 2: Multi-Agent** | Agent roles, model selection & cost optimization, subagent dispatch patterns, Docker sandbox, agent-to-agent comms |
| **Part 3: Channels & Access** | WhatsApp/Telegram/Discord/Signal setup, Tailscale remote access, mobile node pairing, browser control, Mission Control dashboard |
| **Part 4: Automation** | Cron jobs & scheduling, 137-skill catalog, voice/TTS, NotebookLM integration, custom ops scripts |
| **Part 5: Production** | Security hardening checklist, backup & recovery, monitoring, performance tuning, daily/weekly/monthly operator routines |

---

## 📁 What's Inside

### Workspace Templates (`workspace/`)
Drop-in files for `~/.openclaw/workspace/`. Each has `[BRACKETS]` to fill in.

| File | Purpose |
|------|---------|
| `AGENTS.md` | Operating manual — session startup, memory rules, safety, first-week guide, failure modes |
| `SOUL.md` | Agent personality, communication style, security boundaries |
| `USER.md` | About you — name, timezone, what you do |
| `IDENTITY.md` | Agent name and role |
| `MEMORY.md` | Long-term curated memory (starts empty, grows over time) |
| `HEARTBEAT.md` | Proactive check-in rules |
| `BOOTSTRAP.md` | First-run onboarding (agent deletes after completing) |
| `start.md` | Session startup checklist |
| `TOOLS.md` | Local environment notes |

### Configs (`configs/`)
Example configurations — copy one to `~/.openclaw/openclaw.json`.

| Config | For | Features |
|--------|-----|----------|
| `minimal.json5` | Getting started | 1 agent, memory flush, heartbeat |
| `standard.json5` | Recommended | + Semantic search (free Gemini), context pruning |
| `advanced.json5` | Power users | + Multi-agent, LCM plugin, Docker sandbox, Tailscale |

### Skills (`skills/`)
17 essential skills, pre-scanned with Heimdall.

**Context Management:**
- `context-aware-delegation` — Give cron/subagents main session context
- `context-doctor` — Diagnose context window usage
- `context-slimmer` — Reduce always-loaded context
- `arc-memory-pruner` — Auto-prune memory files

**Security:**
- `heimdall` — Scan skills before installing (65+ detection patterns)
- `eridian-carapace` — Agent security hardening
- `credence` — Check MCP server trustworthiness

**Agent Discipline:**
- `deterministic-controller` — Structured agent workflows
- `systematic-debugging` — Root cause analysis framework
- `verification-before-completion` — Don't report done until verified
- `root-cause-tracing` — Trace failures to origin
- `writing-plans` — Plan before executing

**Development Workflow:**
- `git-workflows` — Advanced git operations
- `using-git-worktrees` — Parallel development branches
- `finishing-a-development-branch` — Merge/PR decision framework
- `openclaw-backup` — Backup workspace and config

### Guides (`guides/`)

| Guide | What It Covers |
|-------|----------------|
| [Advanced Operations (HTML)](guides/advanced-operations.html) | The complete 5-part visual guide |
| [Operator Playbook](guides/operator-playbook.md) | Daily patterns for running a persistent agent |
| [Memory System](guides/memory-system.md) | 4-tier memory architecture + LCM deep dive |
| [Customization](guides/customization.md) | SOUL.md personalities, USER.md tips, AGENTS.md patterns |
| [Troubleshooting](guides/troubleshooting.md) | Common issues and fixes |

---

## 🧠 The Memory System (Why This Kit Exists)

Without proper configuration, your AI agent forgets everything between sessions. Three settings fix this:

```json5
// In openclaw.json → agents.defaults
compaction: {
  mode: "safeguard",
  memoryFlush: { enabled: true },          // ← Saves before compaction
  postCompactionSections: ["Every Session", "Memory", "Safety"]  // ← Re-injects after
},
heartbeat: { every: "30m" }                // ← Periodic check-ins
```

**For lossless compaction** (nothing permanently lost), add the LCM plugin:
```bash
openclaw plugin install @martian-engineering/lossless-claw
```

This uses AI-powered summarization during compaction. Compacted messages become searchable summaries that expand back to full detail on demand.

---

## 🔒 Security

- **Always run `heimdall`** before installing any new skill
- **Never put secrets** in workspace files — use `~/.openclaw/secrets/`
- **Use top-tier models** for agents with tool access
- **Sandbox subagents** that handle untrusted input

---

## 📚 Related Resources

- [OpenClaw Docs](https://docs.openclaw.ai) — Official documentation
- [OpenClaw GitHub](https://github.com/openclaw/openclaw) — Source code
- [ClawHub](https://clawhub.com) — Skill marketplace
- [Community Discord](https://discord.com/invite/clawd) — Get help
- [Awesome Agent Cortex](https://github.com/0xNyk/awesome-agent-cortex) — Curated agent ecosystem resources

---

## License

MIT
