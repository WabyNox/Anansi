#!/bin/bash

# 🕸️ Anansi Setup Script - Spins the Web Before You Vanish

echo "==========================================="
echo "🕷 ANANSI - SETUP"
echo "==========================================="

# --- Dependency Check ---
REQUIRED_CMDS=("openvpn" "curl" "jq")
MISSING_CMDS=()

for cmd in "${REQUIRED_CMDS[@]}"; do
  if ! command -v "$cmd" > /dev/null; then
    MISSING_CMDS+=("$cmd")
  fi
done

if [ ${#MISSING_CMDS[@]} -ne 0 ]; then
  echo "⚠️  The web is incomplete. These essential threads are missing:"
  for m in "${MISSING_CMDS[@]}"; do echo "   🕳️  $m"; done
  echo ""
  echo "🪛 Patch your system with:"
  echo "   sudo apt install ${MISSING_CMDS[*]}"
  echo ""
  echo "🔒 Until then, Anansi sleeps. Try again later."
  exit 1
fi

# --- Paths ---
BASE_DIR="$HOME/Anansi"
CONFIG_DIR="$BASE_DIR/mullvad_config"
CORE_DIR="$BASE_DIR/core"
SYMLINK_PATH="/usr/local/bin/anansi"
MAIN_SCRIPT="$CORE_DIR/anansi.sh"

# --- Config Check ---
echo "🧭 Seeking configuration scrolls in the lair..."
CONFIG_FILES=("$CONFIG_DIR"/*.conf)

if [ -e "${CONFIG_FILES[0]}" ]; then
  echo "✅ Found your .conf tomes. The ritual may proceed."
else
  echo "📭 No configuration files detected in:"
  echo "   $CONFIG_DIR"
  echo ""

  read -p "🕵️  Do you already possess the Mullvad .conf files elsewhere? (y/n): " has_files

  if [[ "$has_files" == "y" ]]; then
    echo ""
    echo "📂 Move them into:"
    echo "   $CONFIG_DIR"
    echo ""
    echo "📌 Reminder: Anansi expects the *ALL LOCATIONS* bundle from Mullvad."
    echo "   If you only chose a few countries, the cloak may tear."
    echo ""
    echo "🕸 Once copied, run this setup again to finish binding the web."
    exit 1
  else
    echo ""
    echo "🧬 Time to weave your VPN fate."
    echo ""
    echo "👉 Head to: https://mullvad.net/en/account/openvpn-config/"
    echo "   - Choose platform"
    echo "   - Country: **Select ALL countries**"
    echo "   - Options: Select Default(UDP) and enable 'Use IP'"
    echo ""
    echo "💾 Download and unzip the archive, then place all the *.conf files into:"
    echo "   $CONFIG_DIR"
    echo ""
    echo "📌 This step is sacred. Without ALL locations, Anansi cannot offer the full web of choice."
    echo "🕸 Once prepared, run this setup script again."
    exit 1
  fi
fi

# --- Make scripts executable ---
echo "🔧 Sharpening Anansi's fangs... granting execution rights."
chmod +x "$CORE_DIR"/*.sh

# --- Symlink creation ---
if [ -L "$SYMLINK_PATH" ] || [ -e "$SYMLINK_PATH" ]; then
  echo "♻️  An old strand already binds to /usr/local/bin/anansi."
  read -p "🧹 Shall we replace it with a fresh thread? (y/n): " overwrite
  if [[ "$overwrite" != "y" ]]; then
    echo "🛑 Link unchanged. The current web remains."
    exit 1
  else
    sudo rm -f "$SYMLINK_PATH"
  fi
fi

echo "🔗 Spinning symbolic link to the command line: anansi"
sudo ln -s "$MAIN_SCRIPT" "$SYMLINK_PATH"

echo ""
echo "🎉 The trap is set. You may now cloak yourself with a whisper:"
echo "   anansi"
echo ""
echo "🕷️  The web is ready. Spin wisely."
