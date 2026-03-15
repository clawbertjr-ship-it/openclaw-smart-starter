# Troubleshooting

## Common Issues

### "My agent doesn't remember anything between sessions"

**Cause:** Memory flush is not enabled, or postCompactionSections is missing.

**Fix:** Make sure BOTH of these are in your OpenClaw config under `agents.defaults`:
```json5
compaction: {
  mode: "safeguard",
  memoryFlush: {
    enabled: true,
    prompt: "Write any lasting notes to memory/YYYY-MM-DD.md; reply with NO_REPLY if nothing to store.",
    systemPrompt: "Session nearing compaction. Store durable memories now."
  },
  postCompactionSections: ["Every Session", "Memory", "Safety"]
}
```

**Why both matter:**
- `memoryFlush` tells your agent to save notes before compaction happens
- `postCompactionSections` re-injects key instructions after compaction so your agent knows to read those saved notes

Without `postCompactionSections`, your agent saves its notes but then forgets it has notes to read.

Then restart the gateway: `openclaw gateway restart`

### "My agent acts confused after long conversations"

**Cause:** Compaction wiped its context and it didn't recover properly.

**Fix:** Make sure `postCompactionSections` includes the section headers from your AGENTS.md that contain startup and memory instructions. The default starter kit uses `["Every Session", "Memory", "Safety"]`.

These must match the `##` headers in your AGENTS.md exactly. Case-sensitive.

### "My agent's personality is wrong / too generic"

**Cause:** SOUL.md isn't being read, or it's too vague.

**Fix:**
1. Make sure `SOUL.md` is in your workspace directory
2. Make it specific — don't just say "be helpful", say HOW you want it to communicate
3. Start a new session after editing (old sessions cache the old personality)

### "Daily logs aren't being created"

**Cause:** The `memory/` directory doesn't exist.

**Fix:** Create the directory:
```bash
# Mac/Linux
mkdir -p ~/.openclaw/workspace/memory

# Windows (Command Prompt)
mkdir "%USERPROFILE%\.openclaw\workspace\memory"

# Windows (PowerShell)
New-Item -ItemType Directory -Path "$HOME\.openclaw\workspace\memory" -Force
```

### "I can't find my config file"

**Cause:** The config file path uses `~` which means different things on different systems.

**Fix:** Your config file is at:
- **Windows:** `C:\Users\YOUR_USERNAME\.openclaw\openclaw.json`
- **Mac:** `/Users/YOUR_USERNAME/.openclaw/openclaw.json`
- **Linux:** `/home/YOUR_USERNAME/.openclaw/openclaw.json`

To find it for sure, run:
```bash
openclaw config get
```
This will print the parsed config, confirming the file was found.

If the file doesn't exist yet, run `openclaw configure` to create it with the setup wizard.

**Note:** The file is `openclaw.json` (JSON5 format — supports comments and trailing commas), NOT `config.json` or `config.yaml`. There is only one config file.

### "Heartbeats aren't firing"

**Cause:** Heartbeat interval not configured.

**Fix:** Add to your config under `agents.defaults`:
```json5
heartbeat: {
  every: "30m"  // Check in every 30 minutes
}
```

### "My agent is too chatty during heartbeats"

**Cause:** HEARTBEAT.md is too complex or the agent is reporting on stale work.

**Fix:** Make sure HEARTBEAT.md includes the rule:
```markdown
If nothing needs attention, reply with ONLY: HEARTBEAT_OK
```

### "Agent says it can't find files"

**Cause:** Files are in the wrong directory.

**Fix:** All workspace files must be in:
- **Windows:** `C:\Users\YOUR_USERNAME\.openclaw\workspace\`
- **Mac/Linux:** `~/.openclaw/workspace/`

Check that you didn't accidentally put them in a subfolder.

### "MEMORY.md is getting too long"

**Cause:** Your agent is adding too much without pruning.

**Fix:** 
1. Open MEMORY.md and delete anything outdated or unimportant
2. The agent should keep it under ~150 lines automatically
3. If it doesn't, add a reminder to AGENTS.md: "Keep MEMORY.md under 150 lines. Archive old items."

### "Agent keeps asking who I am"

**Cause:** USER.md is empty or missing.

**Fix:** Fill in USER.md with at least your name, timezone, and a sentence about what you do.

## Finding Your Config File (Windows)

The most common issue on Windows: people can't find `~/.openclaw/openclaw.json`.

On Windows, `~` means your user folder. So the full path is:
```
C:\Users\YOUR_USERNAME\.openclaw\openclaw.json
```

**To open it:**
1. Press `Win + R`
2. Type: `%USERPROFILE%\.openclaw`
3. Press Enter
4. Look for `openclaw.json`

**To edit it:**
- Right-click → Open with → Notepad (or VS Code if installed)
- The file is JSON5 format — it supports comments (`//`) and trailing commas

**If the file doesn't exist:**
- Run `openclaw configure` in your terminal to create it
- Or create it manually — start with the example config in this guide

## Quick Diagnostic

Run these to check your setup:
```bash
openclaw status        # Overview of everything
openclaw doctor        # Check for config issues
```

## Getting Help

- **OpenClaw docs:** [docs.openclaw.ai](https://docs.openclaw.ai)
- **Community Discord:** [discord.com/invite/clawd](https://discord.com/invite/clawd)
- **GitHub issues:** [github.com/openclaw/openclaw](https://github.com/openclaw/openclaw)
