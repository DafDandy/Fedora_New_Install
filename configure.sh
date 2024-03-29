#!/bin/bash

# Cleaning up the system of bloat
echo "Cleaning up system..."
sleep 3
sudo dnf remove akregator cheese kaddressbook kmail contacts

# Asking to install Brave and set to default browser
printf 'Install Brave Browser? (y/n) '
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if [ "$answer" != "${answer#[Yy]}" ];then
	sudo dnf install dnf-plugins-core

	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

	sudo dnf install brave-browser brave-keyring

 	xdg-settings set default-web-browser brave-browser.desktop
  
else
    break
fi


# Asking to install Nvidia drivers for fedora
printf 'Do you have an Nvidia GPU? (y/n) '
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if [ "$answer" != "${answer#[Yy]}" ];then
	sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda
else
    break
fi


# Installing the all the packages that I use for a gaming computer
echo "Installing gaming dependencies and required packages..."
sleep 3
sudo dnf install wine gamemode steam lutris winetricks vlc gnome-tweaks gnome-extensions-app
yes|flatpak install discord
sudo dnf install alsa-plugins-pulseaudio.i686 glibc-devel.i686 glibc-devel libgcc.i686 libX11-devel.i686 freetype-devel.i686 libXcursor-devel.i686 libXi-devel.i686 libXext-devel.i686 libXxf86vm-devel.i686 libXrandr-devel.i686 libXinerama-devel.i686 mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 libXrender-devel.i686 libpcap-devel.i686 ncurses-devel.i686 libzip-devel.i686 lcms2-devel.i686 zlib-devel.i686 libv4l-devel.i686 libgphoto2-devel.i686 cups-devel.i686 libxml2-devel.i686 openldap-devel.i686 libxslt-devel.i686 gnutls-devel.i686 libpng-devel.i686 flac-libs.i686 json-c.i686 libICE.i686 libSM.i686 libXtst.i686 libasyncns.i686 liberation-narrow-fonts.noarch libieee1284.i686 libogg.i686 libsndfile.i686 libuuid.i686 libva.i686 libvorbis.i686 libwayland-client.i686 libwayland-server.i686 llvm-libs.i686 mesa-dri-drivers.i686 mesa-filesystem.i686 mesa-libEGL.i686 mesa-libgbm.i686 nss-mdns.i686 ocl-icd.i686 pulseaudio-libs.i686 sane-backends-libs.i686 tcp_wrappers-libs.i686 unixODBC.i686 samba-common-tools.x86_64 samba-libs.x86_64 samba-winbind.x86_64 samba-winbind-clients.x86_64 samba-winbind-modules.x86_64 mesa-libGL-devel.i686 fontconfig-devel.i686 libXcomposite-devel.i686 libtiff-devel.i686 openal-soft-devel.i686 mesa-libOpenCL-devel.i686 opencl-utils-devel.i686 alsa-lib-devel.i686 gsm-devel.i686 libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 pulseaudio-libs-devel gtk3-devel.i686 libattr-devel.i686 libva-devel.i686 libexif-devel.i686 libexif.i686 glib2-devel.i686 mpg123-devel.i686 mpg123-devel.x86_64 libcom_err-devel.i686 libcom_err-devel.x86_64 libFAudio-devel.i686 libFAudio-devel.x86_64
sudo dnf groupinstall "C Development Tools and Libraries"
sudo dnf groupinstall "Development Tools"

# Downloading the sound and audio packages to make the experience better
echo "Installing sound and video drivers..."
sleep 3
sudo dnf groupupdate core
sudo dnf groupupdate sound-and-video

# Setting up the rpmfusion repos for free and non-free sources
echo "Installing repos for open source drivers..."
sleep 3
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf makecache

# Updating OS
echo "Updating OS..."
sleep 3
sudo dnf update && sudo dnf upgrade -y

# Rebooting the system to apply all changes
echo "Rebooting sytem to apply changes 5..."
sleep 1
echo "4..."
sleep 1
echo "3..."
sleep 1
echo "2..."
sleep 1
echo "1..."
sleep 1
sudo reboot
