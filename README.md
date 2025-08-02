# RAM-wipe shutdown hook

This single file overwrites all but the last 1 GiB of RAM during power-off /
reboot to mitigate cold-boot attacks.

## Quick install

```bash
git clone https://github.com/estevanbelnomo/ram-wipe-hook.git
cd ram-wipe-hook
sudo ./install.sh
```
