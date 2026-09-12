# nixos-config

NixOS 26.05 (Yarara) configuration for host `nixos`.

Originally written for a QEMU VM; now targeting the Lenovo laptop
(`20W4002HUS`, Intel Tiger Lake, systemd-boot + NVMe).

Hyprland lives in `hypr/hyprland.lua` (copy of `~/.config/hypr/hyprland.lua`).

`herdr` comes from the [herdr-nix](https://github.com/herdrdev/herdr-nix)
flake input (prebuilt release binaries, Cachix cache `herdr`).

## Apply

```bash
sudo nixos-rebuild switch --flake .#nixos
```

From anywhere after this repo is pushed:

```bash
sudo nixos-rebuild switch --flake github:timsonner/nixos-config#nixos
```
