# The Memory System — How It Works

## The Problem

AI agents forget everything between sessions. Every conversation starts from scratch. This is like hiring a brilliant employee who gets amnesia every morning.

## The Solution: Four-Tier Memory

### Tier 1: Core Memory (`MEMORY.md`)
- **What:** Curated facts — the most important things to remember
- **Size:** ~150 lines max
- **Updated:** Periodically, by the agent during memory reviews
- **Think of it as:** Your agent's long-term memory

### Tier 2: Working Memory (`memory/YYYY-MM-DD.md`)
- **What:** Raw daily logs — everything that happened today
- **Size:** No limit, one file per day
- **Updated:** During conversations, as things happen
- **Think of it as:** Your agent's daily journal

### Tier 3: Session Memory (automatic)
- **What:** The current conversation
- **Size:** Limited by the model's context window
- **Updated:** Automatically, every message
- **Think of it as:** Your agent's short-term / working memory

### Tier 4: Lossless Context (LCM plugin — optional but powerful)
- **What:** Compressed summaries of every conversation, expandable back to full detail
- **Size:** Grows automatically, stored in a local database
- **Updated:** Automatically during compaction
- **Think of it as:** Your agent's subconscious — it can recall anything if asked

## The Flow

```
Conversation → Daily Log → Core Memory
  (live)        (raw)       (curated)
       ↘
    LCM Database (compressed, searchable, expandable)
```

1. You talk to your agent. Important things come up.
2. The agent writes raw notes to today's daily log (`memory/2026-03-13.md`).
3. Periodically, the agent reviews daily logs and promotes key items to `MEMORY.md`.
4. `MEMORY.md` stays focused by archiving old or less-relevant items.
5. Next session: the agent reads `MEMORY.md` and knows what matters.

## Compaction: What Happens When Conversations Get Long

Every AI model has a "context window" — a limit on how much text it can process at once. When your conversation approaches that limit, OpenClaw "compacts" it: older messages get summarized to free up space.

**Without memory flush:** Everything in those older messages is lost forever.

**With memory flush enabled:** Before compaction, your agent is asked to save anything important to the daily log. This is the safety net.

**With LCM plugin:** Compacted messages are stored as searchable summaries in a local database. Your agent can expand them back to full detail when needed. Nothing is truly lost.

### Memory Flush Configuration

This is configured in your OpenClaw settings:

```json5
// In agents.defaults:
compaction: {
  mode: "safeguard",
  memoryFlush: {
    enabled: true,  // ← THIS IS THE KEY SETTING
    prompt: "Write any lasting notes to memory/YYYY-MM-DD.md; reply with NO_REPLY if nothing to store.",
    systemPrompt: "Session nearing compaction. Store durable memories now."
  },
  // These sections from AGENTS.md get re-injected after compaction
  // so your agent still knows how to behave after a context reset
  postCompactionSections: ["Every Session", "Memory", "Safety"]
}
```

**`postCompactionSections` is critical.** After compaction, your agent's context is mostly wiped. These sections from AGENTS.md are automatically re-injected so the agent still knows:
- How to start a session (read memory files)
- How memory works (write to daily logs)
- Safety rules (don't leak data, ask before acting)

Without this, your agent wakes up confused after every compaction — it won't know to check its memory files.

## Semantic Memory Search

Without memory search, your agent can only read files it already knows about. With it, your agent can ask "What did we decide about the database?" and instantly find the answer from a daily log written 3 months ago.

### Free Setup (Google AI — 5 minutes)

1. Go to [Google AI Studio](https://aistudio.google.com/apikey) and create a free API key
2. Add to your OpenClaw config under `agents.defaults`:

```json5
memorySearch: {
  remote: {
    provider: "gemini",
    model: "gemini-embedding-2-preview",
    apiKey: "YOUR_GOOGLE_AI_API_KEY_HERE",
    fallback: "local"
  }
}
```

The free tier gives 1,500 requests/day — more than enough. The `fallback: "local"` means if you hit the limit, it seamlessly uses built-in search instead.

### Without an API Key

OpenClaw has built-in local search that works offline. It's keyword-based instead of semantic, but it still works:

```json5
memorySearch: {
  provider: "local"
}
```

## LCM Plugin (Lossless Context Management)

LCM is an optional plugin that makes compaction lossless — instead of permanently losing old messages, they're stored as searchable summaries that can be expanded back to full detail.

### What It Does
- Stores compressed versions of every compacted conversation
- Your agent can search across all past conversations by keyword or meaning
- Summaries can be "expanded" back to full detail on demand
- Nothing is permanently lost — even months-old conversations are recoverable

### How to Install

```bash
openclaw plugin install @martian-engineering/lossless-claw
```

Then add to your config:

```json5
plugins: {
  entries: {
    "lossless-claw": {
      enabled: true
    }
  }
}
```

Restart the gateway and LCM will start capturing everything automatically.

### Is LCM Required?

No. The basic memory system (MEMORY.md + daily logs + memory flush) works great without it. LCM is a nice-to-have that prevents information loss during compaction. If you're just starting out, skip it and add it later when you want it.

## Tips

1. **Say "remember this"** — your agent will immediately log it
2. **Review MEMORY.md weekly** — correct anything wrong, remove what's outdated
3. **Don't worry about daily logs** — they're automatic. Let them accumulate.
4. **Start small** — you don't need to pre-fill everything. Your agent builds memory naturally.
5. **After compaction feels weird** — that's normal. Your agent just lost short-term context. Give it a moment to re-read its memory files and it'll be back up to speed.
