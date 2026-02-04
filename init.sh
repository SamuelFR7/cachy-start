#!/usr/bin/env bash
set -euo pipefail

# Upgrading
sudo pacman -Syu --noconfirm

# Install yay
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  pushd /tmp/yay
  makepkg -si --noconfirm
  popd
fi

# Terminal tools/apps
yay -S --noconfirm \
  btop \
  cargo \
  docker \
  fastfetch \
  ghostty \
  git-crypt \
  lazygit \
  mise \
  neovim \
  1password-cli \
  postgresql \
  starship \
  stow \
  tmux \
  eza \
  bat \
  fzf \
  wl-clipboard \
  ripgrep \
  fd \
  zsh

## Change shell to zsh
chsh -s /bin/zsh

## Tmux TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## Docker enable
sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker $USER
sudo systemctl enable --now docker

# Desktop Apps/Utilities
yay -S --noconfirm \
  1password \
  baobab \
  bruno \
  dbeaver \
  evince \
  libreoffice-still \
  loupe \
  gnome-calculator \
  ttf-jetbrains-mono \
  google-chrome \
  spotify \
  mpv \
  nautilus \
  nerd-fonts-jetbrains-mono \
  hyprland \
  xdg-desktop-portal-hyprland \
  rofi \
  waybar \
  mako \
  hyprpaper \
  hyprlock \
  obs-studio \
  cliphist \
  grim \
  slurp \
  satty \
  pavucontrol

gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot
