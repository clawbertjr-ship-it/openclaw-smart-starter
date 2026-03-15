#!/bin/bash
set -e

echo ""
echo "  ============================================"
echo "   OpenClaw Smart Agent Starter - Setup"
echo "  ============================================"
echo ""

OC_DIR="$HOME/.openclaw"
WS_DIR="$OC_DIR/workspace"

if [ ! -d "$OC_DIR" ]; then
    echo "  [!] OpenClaw not found at $OC_DIR"
    echo "      Install first: npm install -g openclaw && openclaw configure"
    exit 1
fi

[ -d "$WS_DIR" ] || mkdir -p "$WS_DIR"

KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "  [1/4] Copying workspace files..."
for f in AGENTS.md SOUL.md USER.md IDENTITY.md TOOLS.md HEARTBEAT.md MEMORY.md start.md; do
    if [ ! -f "$WS_DIR/$f" ]; then
        cp "$KIT_DIR/workspace/$f" "$WS_DIR/$f"
        echo "         + $f"
    else
        echo "         ~ $f (already exists, skipping)"
    fi
done

[ -d "$WS_DIR/memory" ] || { mkdir -p "$WS_DIR/memory"; echo "         + memory/ (created)"; }

echo ""
echo "  [2/4] Installing bundled skills (17 skills)..."
[ -d "$WS_DIR/skills" ] || mkdir -p "$WS_DIR/skills"

for s in "$KIT_DIR"/skills/*/; do
    name="$(basename "$s")"
    if [ ! -d "$WS_DIR/skills/$name" ]; then
        cp -r "$s" "$WS_DIR/skills/$name"
        echo "         + $name"
    else
        echo "         ~ $name (already exists, skipping)"
    fi
done
echo "         Done."

echo ""
echo "  [3/4] Copying docs..."
[ -d "$WS_DIR/docs" ] || mkdir -p "$WS_DIR/docs"
[ -f "$KIT_DIR/docs/smart-agent-guide.html" ] && cp "$KIT_DIR/docs/smart-agent-guide.html" "$WS_DIR/docs/smart-agent-guide.html" && echo "         + docs/smart-agent-guide.html"
[ -f "$KIT_DIR/docs/example-config.json5" ] && cp "$KIT_DIR/docs/example-config.json5" "$WS_DIR/docs/smart-starter-config.json5" && echo "         + docs/smart-starter-config.json5"

echo ""
echo "  [4/4] Quick config check..."
if [ -f "$OC_DIR/openclaw.json" ]; then
    echo "         Config found at $OC_DIR/openclaw.json"
    if ! grep -q "memoryFlush" "$OC_DIR/openclaw.json" 2>/dev/null; then
        echo ""
        echo "  [!!] IMPORTANT: memoryFlush not found in your config!"
        echo "       Your agent WILL forget things without it."
        echo "       See docs/smart-starter-config.json5 for what to add."
    else
        echo "         memoryFlush: found (good!)"
    fi
else
    echo "         [!] No config found. Run: openclaw configure"
fi

echo ""
echo "  ============================================"
echo "   Setup complete!"
echo "  ============================================"
echo ""
echo "  Next steps:"
echo "    1. Edit with YOUR info: USER.md, SOUL.md, IDENTITY.md"
echo "    2. Add memoryFlush + postCompactionSections to openclaw.json"
echo "       (see docs/smart-starter-config.json5)"
echo "    3. Restart: openclaw gateway restart"
echo "    4. Open: docs/smart-agent-guide.html"
echo ""
