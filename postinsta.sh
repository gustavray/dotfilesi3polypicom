#!/bin/bash

# ARCH POST INSTALL SCRIPT

# https://
#
# Do NOT run as root
# Change ParallelDownloads from "5" to "10"
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 25/" /etc/pacman.conf

## Yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirmcd

## i3 and other packages
sudo pacman -S --needed --noconfirm git base-devel
sudo pacman -S --noconfirm i3-gaps i3lock i3status i3blocks lightdm lightdm-slick-greeter dmenu rofi nnn j4-dmenu-desktop lxappearance light picom kitty autorandr playerctl feh bat httpie exa the_silver_searcher papirus-icon-theme ffmpeg dkms go wine-staging lutris discord obs-studio packagekit-qt5 deluge flatpak gthumb lollypop steam adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts thunderbird neofetch os-prober polybar zsh lightdm-gtk-greeter

## lightdm
yay -S --noconfirm lightdm-settings
sudo sed -i "s/^#greeter-session=example-gtk-gnome$/greeter-session=lightdm-slick-greeter/" /etc/lightdm/lightdm.conf

## ohmyzsh
yay -S --noconfirm zsh oh-my-zsh-git
chsh -l
chsh -s /usr/bin/zsh
curl -fsSL https://starship.rs/install.sh | zsh
eval “$(starship init zsh)”

sudo systemctl disable gdm.service
sudo systemctl enable lightdm.service

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

cd

## i3/poly/picom config
# Unzip the files
git clone https://github.com/gustavray/dotfilesi3polypicom
cd dotfilesi3polypicom
unzip configs.zip -d ~/.config
unzip Wallpapers.zip -d ~/Pictures

# remove files
cd
rm -r dotfilesi3polypicom

#chaotic aur
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

#sudo echo "[chaotic-aur]" > /etc/pacman.conf
#sudo echo "Include = /etc/pacman.d/chaotic-mirrorlist" > /etc/pacman.conf

echo Now append the needed mirrorlist to chaotic aur on /etc/pacman.conf
