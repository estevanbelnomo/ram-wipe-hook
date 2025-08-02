# RAM-wipe shutdown hook

This single file overwrites all but the last 1 GiB of RAM during power-off /
reboot to mitigate cold-boot attacks.

## Quick install

```bash
git clone https://github.com/estevanbelnomo/ram-wipe-hook.git
cd ram-wipe-hook
sudo ./install.sh
```

## Prerequisites

- A Linux distribution that uses **systemd** (e.g., Debian, Ubuntu, Arch)
- Root privileges to install shutdown hooks
- Testing in a virtual machine is recommended before deploying to a real
  system

## Safe testing

To avoid wiping RAM on a critical machine, test the hook inside a virtual
environment such as QEMU, VirtualBox or a disposable cloud instance.

1. Install the script inside the VM using the commands above.
2. Trigger a shutdown with:

   ```bash
   sudo systemctl poweroff
   ```

### Expected behavior

During shutdown a progress bar appears followed by the message
`RAM wipe complete – powering off…` on the console. After rebooting,
verify execution by inspecting the previous boot's logs:

```bash
journalctl -b -1 | grep 'RAM wipe complete'
```

Seeing this message confirms the script ran successfully.
