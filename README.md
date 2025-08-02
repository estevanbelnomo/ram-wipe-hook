# RAM Wipe Hook

A small systemd shutdown hook that overwrites most of RAM with zeros before poweroff to help reduce data remanence.

## Installation

```bash
sudo ./install.sh
```

This copies the hook to `/usr/lib/systemd/system-shutdown/zzzz_99_wipe_ram`. Reboot or power off to trigger the wipe:

```bash
sudo systemctl poweroff
```

## Uninstallation

To remove the hook and revert to normal shutdown behavior:

```bash
sudo rm /usr/lib/systemd/system-shutdown/zzzz_99_wipe_ram
```

You will need root privileges. Reboot after removing the file to ensure the hook is no longer active.

## Testing

- **Use a virtual machine or non-critical system** to avoid risking data on a production machine.
- After installation, run `sudo systemctl poweroff` and watch the console for a progress bar indicating the wipe is underway.
- The script depends on `systemd` and common GNU utilities (`dd`, `nproc`, etc.); ensure they are available on your distribution.

## Notes

- The wipe is a best-effort process; it cannot guarantee erasure of data in hardware buffers or devices.
- Running the hook will lengthen shutdown time proportionally to available RAM.

## License

MIT License – see [`LICENSE`](LICENSE).
