# ANANSI - Weaver of Shadows and Wires

Anansi is a minimalist VPN manager for Linux, wrapping `openvpn` and Mullvad `.conf` files with a touch of flair and stealth.  
Choose your exit node interactively and cloak your traffic with style.

---

## equirements

Before using Anansi, make sure your system has:

- `openvpn`
- `jq`
- `curl`

You can install them using:

```bash
sudo apt install openvpn jq curl

## Setup

Clone the repository:

	git clone https://github.com/yourusername/anansi.git
	cd anansi

Run the setup script:

	./setup.sh

This will:

1. Make all core scripts executable

2. Optionally offer to symlink the main launcher (anansi) into /usr/local/bin

### Important:
Download all Mullvad .conf files, selecting all countries when prompted by Mullvad.
Save them in Anansi/mullvad_config/, along with:

        mullvad_ca.crt

        mullvad_userpass.txt

        update-resolv-conf

## Project Structure

	Anansi/
	├── core/
	│   ├── anansi.sh        # Main launcher
	│   ├── start.sh         # Interactive VPN starter
	│   ├── status.sh        # Checks VPN status and shows current IP/location
	│   ├── stop.sh          # Terminates the active VPN session
	├── mullvad_config/      # All Mullvad `.conf` files and credentials
	│   ├── mullvad_it_all.conf
	│   ├── mullvad_userpass.txt
	│   └── ...
	├── setup.sh             # One-time configuration helper

## Commands

Once installed, you can simply run:

	anansi

From there, you will be prompted to:

1. Check current VPN status

2. Connect to a chosen country

3. Disconnect from a running VPN session

You can also call scripts directly:

	./core/start.sh      # Start new VPN session
	./core/status.sh     # Check VPN status and external IP
	./core/stop.sh       # Kill any active VPN

## Known Limitations / Work in Progress

- mullvad_userpass.txt may have unsafe permissions by default. For now, fix it manually:

	chmod 600 mullvad_config/mullvad_userpass.txt

- ipinfo.io is used to show current IP and geolocation. A more privacy-friendly alternative is being considered.

- GUI or TUI is not planned (by design). Anansi is meant to stay script-based and terminal-friendly.

## Contributions

Pull requests and ideas are welcome — especially if you're good at spinning silken shells around system processes.
