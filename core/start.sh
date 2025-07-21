#!/bin/bash

# 🕸 Anansi - Thread of Shadows
# Select your point of escape. The web stretches far.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../mullvad_config"

declare -A COUNTRY_MAP=(
  ["Australia"]="mullvad_au_all.conf"
  ["Austria"]="mullvad_at_all.conf"
  ["Belgium"]="mullvad_be_all.conf"
  ["Brazil"]="mullvad_br_all.conf"
  ["Bulgaria"]="mullvad_bg_all.conf"
  ["Canada"]="mullvad_ca_all.conf"
  ["Czech Republic"]="mullvad_cz_all.conf"
  ["Denmark"]="mullvad_dk_all.conf"
  ["Finland"]="mullvad_fi_all.conf"
  ["France"]="mullvad_fr_all.conf"
  ["Germany"]="mullvad_de_all.conf"
  ["Greece"]="mullvad_gr_all.conf"
  ["Hong Kong"]="mullvad_hk_all.conf"
  ["Hungary"]="mullvad_hu_all.conf"
  ["Ireland"]="mullvad_ie_all.conf"
  ["Italy"]="mullvad_it_all.conf"
  ["Japan"]="mullvad_jp_all.conf"
  ["Netherlands"]="mullvad_nl_all.conf"
  ["New Zealand"]="mullvad_nz_all.conf"
  ["Norway"]="mullvad_no_all.conf"
  ["Poland"]="mullvad_pl_all.conf"
  ["Romania"]="mullvad_ro_all.conf"
  ["Serbia"]="mullvad_rs_all.conf"
  ["Singapore"]="mullvad_sg_all.conf"
  ["Spain"]="mullvad_es_all.conf"
  ["Sweden"]="mullvad_se_all.conf"
  ["Switzerland"]="mullvad_ch_all.conf"
  ["United Kingdom"]="mullvad_gb_all.conf"
  ["United States"]="mullvad_us_all.conf"
)

echo "=============================="
echo "🕷 Anansi - Cloak Weaving Initiated"
echo "=============================="
echo ""
echo "🌍 Choose your point of exit from the web of reality:"
PS3="🎯 Select your node and press Enter: "

options=("${!COUNTRY_MAP[@]}")
select opt in "${options[@]}"; do
  if [[ -n "${opt}" && -n "${COUNTRY_MAP[$opt]}" ]]; then
    FILE=${COUNTRY_MAP[$opt]}

    if [[ ! -f "$CONFIG_DIR/$FILE" ]]; then
      echo "❌ The silk is torn — config file for $opt not found."
      exit 1
    fi

    echo ""
    echo "🧶 Spinning silk toward $opt..."
    echo "🔐 Whisper the passphrase — Anansi weaves only with permission."
    sudo -v || { echo "❌ No passphrase, no thread."; exit 1; }

    echo "🔧 Launching cloak with: sudo openvpn --config \"$FILE\""
    cd "$CONFIG_DIR"
    sudo openvpn --config "$FILE" > /tmp/mullvad_vpn.log 2>&1 &
    sleep 2

    if pgrep -f "openvpn --config $FILE" > /dev/null; then
      echo "✅ Cloak deployed. You now see the world through $opt... but the world sees only shadows."
    else
      echo "❌ The weaving failed — the thread snapped before forming. Check /tmp/mullvad_vpn.log"
    fi

    break
  else
    echo "🚫 The web trembles — that choice doesn’t exist. Try again, silent weaver."
  fi
done
