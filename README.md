# RAM-wipe shutdown hook

This single file overwrites all but the last 1 GiB of RAM during power-off /
reboot to mitigate cold-boot attacks.

## Quick install

```bash
git clone https://github.com/estevanbelnomo/ram-wipe-hook.git
cd ram-wipe-hook
sudo ./install.sh

```

## Removing the hook

To uninstall the shutdown hook, delete the installed script from systemd's
shutdown directory:

```bash
sudo rm /usr/lib/systemd/system-shutdown/zzzz_99_wipe_ram
```

**Warning:** These commands require root privileges. Removing the hook will stop
RAM wiping on shutdown, which may leave data in memory and affect security.

