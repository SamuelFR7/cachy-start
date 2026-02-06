#!/usr/bin/env bash
set -euo pipefail

PKGS=(
  kitty
  alacritty
  firefox
)

installed=()

for pkg in "${PKGS[@]}"; do
  if pacman -Qi "$pkg" &>/dev/null; then
    installed+=("$pkg")
  fi
done

if ((${#installed[@]})); then
  yay -Rns --noconfirm "${installed[@]}"
fi
