#!/bin/bash

# 🕸 Anansi - Web Presence Checker
# Are you still hidden in the shadows, or have you been caught in the light?

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Dependency check
for cmd in curl jq; do
  command -v $cmd >/dev/null || {
    echo "❌ Missing spell: $cmd — Anansi needs it to see through the veil."
    exit 1
  }
done

echo "==========================="
echo "🕵 Anansi is scanning the threads..."
echo "==========================="

# Find OpenVPN process matching Mullvad config
PID=$(pgrep -f 'openvpn --config mullvad_' | head -n1)

if [[ -z "$PID" ]]; then
  echo "❌ No threads found. You are exposed — prey in the daylight!"
  exit 1
else
  echo "✅ Anansi confirms: the cloak is active. Process ID: $PID"
  echo ""
  echo "🌐 Retrieving your woven disguise..."

  IP_JSON=$(curl -s https://ipinfo.io)
  [[ -z "$IP_JSON" ]] && {
    echo "⚠ The net is silent — couldn’t fetch your disguise details."
    exit 1
  }

  IP=$(echo "$IP_JSON" | jq -r '.ip')
  CITY=$(echo "$IP_JSON" | jq -r '.city')
  REGION=$(echo "$IP_JSON" | jq -r '.region')
  COUNTRY=$(echo "$IP_JSON" | jq -r '.country')
  ORG=$(echo "$IP_JSON" | jq -r '.org')

  echo "🕸 IP Address: $IP"
  echo "📍 Location: $CITY, $REGION ($COUNTRY)"
  echo "🏢 Network Host: $ORG"
fi
