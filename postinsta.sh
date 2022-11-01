#!/bin/bash

# ARCH POST INSTALL SCRIPT

# https://
#
# Do NOT run as root

# Change ParallelDownloads from "5" to "10"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 25/" /etc/pacman.conf

## Yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

## i3 and other packages
sudo pacman -S --needed --no-confirm git base-devel
sudo pacman -S i3-gaps i3lock i3status i3blocks lightdm lightdm-slick-greeter dmenu rofi nnn j4-dmenu-desktop lxappearance light picom kitty autorandr playerctl feh bat httpie exa the_silver_searcher papirus-icon-theme ffmpeg dkms go wine-staging lutris discord obs-studio packagekit-qt5 deluge flatpak gthumb lollypop steam adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts thunderbird neofetch os-prober starship

## back to home

cd

## Dot files
cd ~/.config
git clone https://github.com/Kerwood/i3-dot-files.git
cd ./i3-dot-files
./create-symlinks.sh

## Nerd fonts
# Download the fonts
http -d https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
http -d https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

# Unzip the files
mkdir Nerd\ Fonts
unzip FiraCode.zip -d Nerd\ Fonts
unzip Hack.zip -d Nerd\ Fonts

# Move the fonts
sudo mv Nerd\ Fonts /usr/share/fonts

# Remove
rm FiraCode.zip
rm Hack.zip

## i3 config
git clone >>

## polybar config
git clone >>

## picom config
git clone >>
