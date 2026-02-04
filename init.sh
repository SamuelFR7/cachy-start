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
  pavucontrol \
  hyprland \
  xdg-desktop-portal-hyprland \
  sddm \
  polkit-kde-agent \
  xorg-xwayland

# XDG default applications
## Videos
for mime in video/mp4 video/x-matroska video/webm video/x-msvideo video/mpeg video/ogg video/quicktime video/x-flv; do
  xdg-mime default mpv.desktop "$mime"
done

## PDFs
xdg-mime default org.gnome.Evince.desktop application/pdf

## Images
for mime in image/png image/jpeg image/gif image/webp image/svg+xml image/bmp image/tiff image/avif; do
  xdg-mime default org.gnome.Loupe.desktop "$mime"
done

## File manager
xdg-mime default org.gnome.Nautilus.desktop inode/directory

## Web browser
for mime in x-scheme-handler/http x-scheme-handler/https text/html; do
  xdg-mime default google-chrome.desktop "$mime"
done

## Audio
for mime in audio/mpeg audio/ogg audio/flac audio/wav audio/aac audio/mp4 audio/x-vorbis+ogg; do
  xdg-mime default mpv.desktop "$mime"
done

## Archives (nautilus handles these)
for mime in application/zip application/x-tar application/gzip application/x-7z-compressed application/x-rar; do
  xdg-mime default org.gnome.Nautilus.desktop "$mime"
done

## LibreOffice
xdg-mime default libreoffice-writer.desktop application/msword
xdg-mime default libreoffice-writer.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document
xdg-mime default libreoffice-calc.desktop application/vnd.ms-excel
xdg-mime default libreoffice-calc.desktop application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
xdg-mime default libreoffice-impress.desktop application/vnd.ms-powerpoint
xdg-mime default libreoffice-impress.desktop application/vnd.openxmlformats-officedocument.presentationml.presentation

gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot
