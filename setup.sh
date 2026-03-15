#!/usr/bin/env bash
set -euo pipefail

echo ""
echo "  ============================================"
echo "   OpenClaw Operations Kit - Setup"
echo "  ============================================"
echo ""

OC_DIR="$HOME/.openclaw"
WS_DIR="$OC_DIR/workspace"
KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$OC_DIR" ]; then
    echo "  [!] OpenClaw not found at $OC_DIR"
    echo "      Install first: npm install -g openclaw && openclaw configure"
    exit 1
fi

[ -d "$WS_DIR" ] || mkdir -p "$WS_DIR"

echo "  [1/5] Copying workspace files..."
for f in AGENTS.md SOUL.md USER.md IDENTITY.md TOOLS.md HEARTBEAT.md MEMORY.md BOOTSTRAP.md start.md; do
    if [ ! -f "$WS_DIR/$f" ]; then
        cp "$KIT_DIR/workspace/$f" "$WS_DIR/$f"
        echo "        + $f"
    else
        echo "        ~ $f (already exists, skipping)"
    fi
done

[ -d "$WS_DIR/memory" ] || { mkdir -p "$WS_DIR/memory"; echo "        + memory/ (created)"; }

echo ""
echo "  [2/5] Installing bundled skills (17 skills)..."
[ -d "$WS_DIR/skills" ] || mkdir -p "$WS_DIR/skills"

for skill_dir in "$KIT_DIR"/skills/*/; do
    skill_name="$(basename "$skill_dir")"
    if [ ! -d "$WS_DIR/skills/$skill_name" ]; then
        cp -r "$skill_dir" "$WS_DIR/skills/$skill_name"
        echo "        + $skill_name"
    else
        echo "        ~ $skill_name (already exists, skipping)"
    fi
done
echo "        Done."

echo ""
echo "  [3/5] Copying guides and configs..."
[ -d "$WS_DIR/docs" ] || mkdir -p "$WS_DIR/docs"

[ -f "$KIT_DIR/guides/advanced-operations.html" ] && {
    cp "$KIT_DIR/guides/advanced-operations.html" "$WS_DIR/docs/advanced-operations.html"
    echo "        + docs/advanced-operations.html"
}
[ -f "$KIT_DIR/guides/operator-playbook.md" ] && {
    cp "$KIT_DIR/guides/operator-playbook.md" "$WS_DIR/docs/operator-playbook.md"
    echo "        + docs/operator-playbook.md"
}
[ -f "$KIT_DIR/configs/standard.json5" ] && {
    cp "$KIT_DIR/configs/standard.json5" "$WS_DIR/docs/example-config.json5"
    echo "        + docs/example-config.json5"
}

echo ""
echo "  [4/5] Quick config check..."
if [ -f "$OC_DIR/openclaw.json" ]; then
    echo "        Config found at $OC_DIR/openclaw.json"
    if grep -q "memoryFlush" "$OC_DIR/openclaw.json" 2>/dev/null; then
        echo "        memoryFlush: found (good!)"
    else
        echo ""
        echo "  [!!] IMPORTANT: memoryFlush not found in your config!"
        echo "       Your agent WILL forget things without it."
        echo "       See configs/standard.json5 for what to add."
    fi
else
    echo "        [!] No config found. Run: openclaw configure"
fi

echo ""
echo "  [5/5] Verifying installation..."
OK=1
[ -f "$WS_DIR/AGENTS.md" ] || { echo "        [!] Missing AGENTS.md"; OK=0; }
[ -f "$WS_DIR/SOUL.md" ] || { echo "        [!] Missing SOUL.md"; OK=0; }
[ -f "$WS_DIR/USER.md" ] || { echo "        [!] Missing USER.md"; OK=0; }
[ -f "$WS_DIR/BOOTSTRAP.md" ] || { echo "        [!] Missing BOOTSTRAP.md"; OK=0; }
[ "$OK" = "1" ] && echo "        All workspace files present."

echo ""
echo "  ============================================"
echo "   Setup complete!"
echo "  ============================================"
echo ""
echo "  Next steps:"
echo "    1. Edit these files with YOUR info:"
echo "       $WS_DIR/USER.md     (your name, timezone)"
echo "       $WS_DIR/SOUL.md     (agent personality)"
echo "       $WS_DIR/IDENTITY.md (agent name)"
echo ""
echo "    2. Pick a config and copy it:"
echo "       Beginner:  configs/minimal.json5"
echo "       Standard:  configs/standard.json5"
echo "       Advanced:  configs/advanced.json5"
echo "       Copy to: $OC_DIR/openclaw.json"
echo ""
echo "    3. Restart gateway: openclaw gateway restart"
echo ""
echo "    4. Open the operations guide:"
echo "       guides/advanced-operations.html"
echo ""
