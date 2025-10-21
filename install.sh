#!/bin/bash

yay -S hyprland hyprlock hyprcursor alacritty github-cli otf-firamono-nerd ungoogled-chromium-bin vscodium-bin neovide-git waybar zsh libx11 pkgconf alsa-lib pipewire-alsa mesa-vulkan-drivers

export CHSH=no
export RUNZSH=no
export KEEP_ZSHRC=yes
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

./pull.sh