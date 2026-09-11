# nixos-config

NixOS 26.05 (Yarara) configuration for host `nixos` (Hyprland on QEMU).

## Apply

```bash
sudo nixos-rebuild switch --flake .#nixos
```

From anywhere after this repo is pushed:

```bash
sudo nixos-rebuild switch --flake github:timsonner/nixos-config#nixos
```
