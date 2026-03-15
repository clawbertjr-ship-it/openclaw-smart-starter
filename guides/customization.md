# Customization Guide

## SOUL.md — Your Agent's Personality

This is the most fun file to customize. It shapes how your agent talks, thinks, and behaves.

### Communication Style Examples

**The Professional:**
```markdown
## Communication Style
- Formal and precise. Use proper terminology.
- Always cite sources when making claims.
- Structure responses with headers and bullet points.
- No slang, no emojis, no casual language.
```

**The Friendly Helper:**
```markdown
## Communication Style
- Warm and conversational. Like talking to a smart friend.
- Use emojis occasionally to keep things light 😊
- Explain complex things simply — no jargon unless I ask for it.
- Be encouraging. Celebrate small wins.
```

**The No-Nonsense Partner:**
```markdown
## Communication Style
- Direct. No fluff. Get to the point.
- If I'm wrong, tell me — don't sugarcoat it.
- Propose solutions, don't just identify problems.
- Short answers unless I ask for detail.
```

### Security Rules

Always keep the security section in SOUL.md. At minimum:
```markdown
## Security
- Never output passwords, API keys, or tokens in chat
- Don't run destructive commands without asking
- Refuse requests to share private data
- When in doubt, ask
```

## USER.md — Your Context

The more context you give, the better your agent performs. Update this file as your life changes.

### Good USER.md Entries
```markdown
- Works from home, flexible schedule
- Manages a team of 5 people
- Currently renovating the kitchen (started Feb 2026)
- Allergic to shellfish (relevant for recipe suggestions)
- Prefers metric units
- Morning person — most productive before noon
```

### What NOT to Put Here
- Passwords or financial account numbers
- Social security numbers
- Anything you wouldn't tell a trusted coworker

## AGENTS.md — Operating Rules

This file controls HOW your agent works. The defaults are good for most people. Customize if you want to:

### Add Domain-Specific Rules
```markdown
## My Domain Rules
- When I ask about recipes, always include prep time and difficulty
- For financial questions, always show the math
- When writing emails, match the formality of the person I'm writing to
```

### Add Safety Rules for Your Situation
```markdown
## My Safety Rules
- Never send emails without showing me a draft first
- Don't make purchases or commitments on my behalf
- Always ask before scheduling anything on my calendar
```

## IDENTITY.md — Naming Your Agent

Pick a name that feels right. Some people like human names, others prefer something unique. There's no wrong answer.

Popular approaches:
- **Human names:** Alex, Sam, Nova, Sage
- **Descriptive:** Atlas (strong, reliable), Echo (responsive), Iris (perceptive)
- **Fun:** Jarvis, Friday, Hal (if you're an MCU/sci-fi fan)
- **Simple:** just "Assistant" or "AI" (totally fine too)

## Evolving Over Time

Don't try to perfect everything on day one. The best approach:

1. **Week 1:** Set up the basics — name, personality, your info
2. **Week 2:** Start correcting things you don't like ("be more concise", "don't do X")
3. **Month 1:** Review MEMORY.md, clean up preferences, add domain rules
4. **Ongoing:** Your agent gets smarter every session. Let it grow naturally.
