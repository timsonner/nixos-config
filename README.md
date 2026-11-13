# nixos-config

NixOS 26.05 (Yarara) flake for host `nixos`, an `x86_64-linux` QEMU guest. It records the machine so it can be rebuilt from git: Hyprland (with UWSM and XWayland) on SDDM, GRUB on `/dev/vda`, NetworkManager, and the packages in `configuration.nix`. `hypr/hyprland.lua` is a tracked copy of the user Hyprland config; the flake does not install that file.

## Prerequisites

- NixOS `x86_64-linux` with flakes already enabled (`nix-command` and `flakes`). This configuration turns those features on after it is applied.
- `sudo` for `nixos-rebuild switch`.
- Network access to GitHub. The flake follows `nixpkgs` `nixos-26.05` and `github:herdrdev/herdr-nix`.
- `hardware-configuration.nix` is the generated QEMU guest scan (virtio, GRUB device `/dev/vda`). Replace it before applying this flake on other hardware.

## Install, build, and check

From a clone of this repo:

```bash
nix flake show
nix flake check
nix build .#nixosConfigurations.nixos.config.system.build.toplevel
sudo nixos-rebuild switch --flake .#nixos
```

`nix build` links the system closure at `./result` and does not activate it. `switch` builds the same configuration and activates it on the current machine.

After this repo is on GitHub, from any directory:

```bash
sudo nixos-rebuild switch --flake github:timsonner/nixos-config#nixos
```

## Usage

SDDM offers a Wayland Hyprland session. The normal user is `tim` (`wheel` and `networkmanager`). Extra packages installed by the flake are kitty, opencode, grok-build, git, gh, vim, google-chrome, hyprlauncher, ripgrep, jq, and herdr. Unfree packages are allowed so Chrome can be installed. herdr comes from the `herdr-nix` input.

Hyprland reads `~/.config/hypr/hyprland.lua`. Copy the tracked file into place:

```bash
mkdir -p ~/.config/hypr
cp hypr/hyprland.lua ~/.config/hypr/hyprland.lua
```

In that file Super is the modifier. Super+Q launches kitty, Super+R launches hyprlauncher, Super+C closes the focused window, and the arrow keys move focus. Super+E launches dolphin, which is not in `environment.systemPackages`.

## Layout

- `flake.nix` — `nixosConfigurations.nixos`
- `flake.lock` — locked `nixpkgs` (`nixos-26.05`) and `herdr-nix`
- `configuration.nix` — system configuration, including the `tim` user
- `hardware-configuration.nix` — generated QEMU guest hardware
- `hypr/hyprland.lua` — tracked Hyprland Lua config
