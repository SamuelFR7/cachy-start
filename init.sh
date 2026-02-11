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
yay -S --needed --noconfirm \
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
  xdg-user-dirs \
  jdk17-openjdk \
  watchman-bin \
  zsh \
  qemu-full \
  libvirt \
  virt-manager \
  dnsmasq \
  edk2-ovmf

## XDG user directories
xdg-user-dirs-update

## Change shell to zsh
chsh -s /bin/zsh

## Claude Code
if ! command -v claude &>/dev/null; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

## Tmux TPM
[[ -d ~/.tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## Docker enable
sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker $USER
sudo systemctl enable --now docker

## KVM / libvirt
sudo usermod -aG kvm,libvirt $USER
sudo systemctl enable --now libvirtd

# Mise Config
mise settings add idiomatic_version_file_enable_tools node
mise use -g node@lts

# Desktop Apps/Utilities
yay -S --needed --noconfirm \
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
  ttf-jetbrains-mono-nerd \
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
  xorg-xwayland \
  kitty \
  android-studio

## SDDM enable
sudo systemctl enable sddm

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

# Dark theme
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

read -rp "Ready to reboot for all settings to take effect? [y/N] " ans
[[ "$ans" =~ ^[Yy]$ ]] && sudo reboot
