#!/bin/bash

# 🕸 Anansi - Thread Severer
# Time to drop from the web and vanish once more...

echo "======================================"
echo "✂ Anansi is severing the connection..."
echo "======================================"

# Ensure 'sudo' is available
if ! command -v sudo >/dev/null; then
  echo "❌ The blade is dull — 'sudo' is missing. Anansi cannot cut the thread."
  exit 1
fi

# Check for an active Mullvad OpenVPN process
VPN_PID=$(pgrep -f 'openvpn --config mullvad_' | head -n1)

if [[ -z "$VPN_PID" ]]; then
  echo "❌ No thread found to sever. You were already dangling in the wind."
  exit 1
fi

# Attempt to kill the process
sudo pkill -f 'openvpn --config mullvad_'

# Verify if the process was killed
sleep 1
if pgrep -f 'openvpn --config mullvad_' > /dev/null; then
  echo "⚠️ The thread resisted — Anansi’s blade slipped."
else
  echo "✅ The thread is cut. You’re back in the wild — traceable, but free."
fi
