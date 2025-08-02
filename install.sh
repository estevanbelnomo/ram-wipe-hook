#!/usr/bin/env bash
# Simple installer for the RAM-wipe shutdown hook
set -euo pipefail

SCRIPT_SRC="$(dirname "$0")/zz_wipe_ram"
SCRIPT_DST="/usr/lib/systemd/system-shutdown/zzzz_99_wipe_ram"

sudo install -m 755 "$SCRIPT_SRC" "$SCRIPT_DST"
echo "Installed ${SCRIPT_DST}"
echo "Reboot to test: sudo systemctl poweroff"