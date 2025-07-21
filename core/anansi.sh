#!/bin/bash

# 🕸️ Anansi - The Watchful Weaver
# Master controller of cloaking threads and digital deception.

SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
CONFIG_DIR="$SCRIPT_DIR/../mullvad_config"

START_SCRIPT="$SCRIPT_DIR/start.sh"
STATUS_SCRIPT="$SCRIPT_DIR/status.sh"
STOP_SCRIPT="$SCRIPT_DIR/stop.sh"

# Check for required dependencies
for cmd in openvpn curl jq; do
  command -v $cmd >/dev/null || {
    echo "❌ Missing tool: $cmd — install it before summoning Anansi."
    exit 1
  }
done

echo "==========================================="
echo "🕷️ ANANSI - Weaver of Shadows and Wires"
echo "==========================================="

# Step 1: Check if any VPN process is running 
VPN_PROC=$(ps aux | grep '[o]penvpn --config')

if [[ -z "$VPN_PROC" ]]; then
    echo "🧵 No thread is currently woven — you're exposed to the light."
    read -p "🌑 Should Anansi spin a new cloak? (y/n): " start_choice
    if [[ "$start_choice" == "y" ]]; then
        bash "$START_SCRIPT"
    else
        echo "🚪 You walk away from the web... but the hunters are watching."
        exit 0
    fi
else
    echo "🕸️ An active web is detected:"
    
    # Extract VPN binary used (e.g., openvpn, wg-quick, nordvpn-cli, etc.)
    VPN_CMD=$(echo "$VPN_PROC" | awk '{print $11}' | head -n1)
    echo "🔎 Thread spun by: $VPN_CMD"

    CONF_NAME=$(echo "$VPN_PROC" | grep -o 'mullvad_[a-z]*_all.conf' | head -n1)
    COUNTRY_CODE=$(echo "$CONF_NAME" | cut -d'_' -f2)

    if [[ -z "$CONF_NAME" || ! -f "$CONFIG_DIR/$CONF_NAME" ]]; then
        echo "⚠ The weave’s thread is frayed — config file not found or malformed."
        exit 1
    fi

    declare -A COUNTRY_MAP=(
        ["at"]="Austria" ["au"]="Australia" ["be"]="Belgium" ["bg"]="Bulgaria" ["br"]="Brazil" ["ca"]="Canada"
        ["ch"]="Switzerland" ["cz"]="Czech Republic" ["de"]="Germany" ["dk"]="Denmark" ["es"]="Spain"
        ["fi"]="Finland" ["fr"]="France" ["gb"]="United Kingdom" ["gr"]="Greece" ["hk"]="Hong Kong"
        ["hu"]="Hungary" ["ie"]="Ireland" ["it"]="Italy" ["jp"]="Japan" ["nl"]="Netherlands" ["no"]="Norway"
        ["nz"]="New Zealand" ["pl"]="Poland" ["ro"]="Romania" ["rs"]="Serbia" ["se"]="Sweden" ["sg"]="Singapore"
        ["us"]="United States"
    )

    COUNTRY_NAME=${COUNTRY_MAP[$COUNTRY_CODE]}

    echo "$VPN_PROC"
    echo ""

    if echo "$VPN_PROC" | grep -q "mullvad_"; then
        echo "🛡️ Anansi’s cloak is active from [${COUNTRY_NAME:-Unknown}]. Observing from the net’s edge..."
        bash "$STATUS_SCRIPT"
    else
        echo "⚠️ A foreign thread is tangled — this isn’t Anansi’s doing."
        echo "🌐 Trying to trace the origin of this alien weave:"
        IP_JSON=$(curl -s https://ipinfo.io)

        IP=$(echo "$IP_JSON" | jq -r '.ip')
        CITY=$(echo "$IP_JSON" | jq -r '.city')
        REGION=$(echo "$IP_JSON" | jq -r '.region')
        COUNTRY=$(echo "$IP_JSON" | jq -r '.country')
        ORG=$(echo "$IP_JSON" | jq -r '.org')

        echo "🕵️ IP: $IP"
        echo "📍 Location: $CITY, $REGION ($COUNTRY)"
        echo "📡 Network: $ORG"
    fi

    echo ""
    read -p "🧶 Should Anansi unravel this thread? (y/n): " stop_choice
    if [[ "$stop_choice" == "y" ]]; then
        if [[ "$VPN_CMD" != *openvpn* ]]; then
            echo "⚠️ This isn’t Anansi’s weave — unspooling may fail."
        fi
        bash "$STOP_SCRIPT" || echo "⚠️ Something resisted the pull. The thread didn’t break cleanly."
    else
        echo "🫥 The thread stays spun. Anansi watches in silence."
    fi
fi
