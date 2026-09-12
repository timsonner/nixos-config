# nixos-config

NixOS 26.05 (Yarara) configuration for host `nixos`.

Originally written for a QEMU VM; now targeting the Lenovo laptop
(`20W4002HUS`, Intel Tiger Lake, systemd-boot + NVMe).

Hyprland lives in `hypr/hyprland.lua`. On this machine it is the live
config via a symlink:

```bash
ln -sfn ~/nixos-config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua
ln -sfn ~/nixos-config/waybar ~/.config/waybar
```

Waybar is the Omarchy-style top bar (workspaces, clock, network, audio,
battery). Toggle it with Super+Shift+Space.

`herdr` comes from the [herdr-nix](https://github.com/herdrdev/herdr-nix)
flake input, which wraps the GitHub release binaries.

## Apply

```bash
sudo nixos-rebuild switch --flake .#nixos
```

From anywhere after this repo is pushed:

```bash
sudo nixos-rebuild switch --flake github:timsonner/nixos-config#nixos
```
