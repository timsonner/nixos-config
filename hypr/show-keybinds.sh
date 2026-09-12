#!/usr/bin/env bash
# Searchable Hyprland bind list (Omarchy Super+K).
set -euo pipefail

pretty_key() {
  local key="$1"
  key="${key#SUPER + }"
  key="${key#SHIFT + }"
  key="${key#CTRL + }"
  key="${key#ALT + }"
  case "$key" in
    code:10) echo 1 ;;
    code:11) echo 2 ;;
    code:12) echo 3 ;;
    code:13) echo 4 ;;
    code:14) echo 5 ;;
    code:15) echo 6 ;;
    code:16) echo 7 ;;
    code:17) echo 8 ;;
    code:18) echo 9 ;;
    code:19) echo 0 ;;
    code:20) echo "-" ;;
    code:21) echo "=" ;;
    mouse:272) echo "LMB" ;;
    mouse:273) echo "RMB" ;;
    mouse_down) echo "scroll-down" ;;
    mouse_up) echo "scroll-up" ;;
    *) echo "$key" ;;
  esac
}

mods_from_mask() {
  case "$1" in
    0) echo "" ;;
    1) echo "SHIFT" ;;
    4) echo "CTRL" ;;
    5) echo "SHIFT + CTRL" ;;
    8) echo "ALT" ;;
    9) echo "SHIFT + ALT" ;;
    12) echo "CTRL + ALT" ;;
    13) echo "SHIFT + CTRL + ALT" ;;
    64) echo "SUPER" ;;
    65) echo "SUPER + SHIFT" ;;
    68) echo "SUPER + CTRL" ;;
    69) echo "SUPER + SHIFT + CTRL" ;;
    72) echo "SUPER + ALT" ;;
    73) echo "SUPER + SHIFT + ALT" ;;
    76) echo "SUPER + CTRL + ALT" ;;
    77) echo "SUPER + SHIFT + CTRL + ALT" ;;
    *) echo "$1" ;;
  esac
}

mapfile -t lines < <(
  hyprctl binds -j | jq -r '.[] | [.modmask, .key, .description, .dispatcher, .arg] | @tsv'
)

out=()
for line in "${lines[@]}"; do
  IFS=$'\t' read -r modmask key description dispatcher arg <<<"$line"
  mods="$(mods_from_mask "$modmask")"
  key="$(pretty_key "$key")"
  if [[ -n "$mods" ]]; then
    combo="$mods + $key"
  else
    combo="$key"
  fi
  if [[ -n "${description:-}" ]]; then
    action="$description"
  elif [[ "$dispatcher" == "__lua" ]]; then
    action="lua"
  else
    action="$dispatcher ${arg:-}"
  fi
  out+=("$combo   $action")
done

printf '%s\n' "${out[@]}" | sort -u | hyprlauncher -m >/dev/null
