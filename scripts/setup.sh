#!/bin/sh

sudo pacman -Syy
sudo pacman -S --needed --noconfirm reflector

# Updating mirrors
echo "Updating mirror list by download rate"
reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy

# Install xorg goodies
echo "Installing nvidia driver and xorg..."
sudo pacman -S --needed --noconfirm \
	xorg-server \
	dkms \
	libva-nvidia-driver \
	nvidia-open-dkms \
	nvidia-utils \
	lib32-nvidia-utils \
	nvidia-settings \
	opencl-nvidia \
	vulkan-icd-loader \
	lib32-vulkan-icd-loader \
	xorg-xinit \
	xorg-xrandr \
	xorg-xkill \
	linux-headers \
	linux-zen-headers \

# Install essential tools and services
echo "Installing essential tools and services..."
sudo pacman -S --needed --noconfirm \
	alacritty \
	redshift \
	polkit-gnome \
	gnome-disk-utility \
	xdg-desktop-portal \
	xdg-desktop-portal-gtk \
	picom \
	starship \
	fastfetch \
	feh \
	flameshot \
	eza \
	ntfs-3g \
	playerctl \
	ranger \
	mpv \
	ffmpeg \
	mangohud \
	gamemode \
	steam \
	lutris \
	rofi \
	dunst \
	code \
	firefox \
	exfatprogs \
	flatpak


# Audio - pipewire
echo "Installing audio - pipewire"
sudo pacman -Rns jack2
sudo pacman -S --needed --noconfirm \
	pipewire \
	pipewire-pulse \
	pipewire-alsa \
	wireplumber \
	pipewire-jack \
	wireplumber \
	wiremix \
	pamixer
systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire-pulse.service
systemctl --user enable --now wireplumber.service

# Bluetooth
echo "Installing bluetooth"
sudo pacman -S --needed --noconfirm \
	bluez \
	bluez-utils
sudo systemctl enable --now bluetooth.service

# Install fonts
echo "Installing fonts"
sudo pacman -S --needed --noconfirm $(pacman -Sgq nerd-fonts)

# Install yay
echo "Installing yay for aur support"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay


# Installing MTP support
yay -S jmtpfs
#use jmtpfs ~/phone (or whatever dir you want) to mount your phone there


echo "Installation complete. Reboot..."

