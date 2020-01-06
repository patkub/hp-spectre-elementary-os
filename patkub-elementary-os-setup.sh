#!/bin/bash

# ask for sudo
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# download package info
apt-get update

# enable wifi
apt-get install -y linux-oem-osp1 linux-firmware

# drivers
ubuntu-drivers autoinstall

# manage the repositories that you install software from (common)
apt-get install -y software-properties-common
apt-get update

# multimedia codecs and dvd playback
apt-get install -y \
	ubuntu-restricted-extras \
	libavcodec-extra \
	libdvd-pkg

# uninstall default apps
apt-get purge -y \
	epiphany-browser \
	epiphany-browser-data \
	pantheon-mail

# install google chrome
wget -O /tmp/linux_signing_key.pub https://dl.google.com/linux/linux_signing_key.pub
apt-key add /tmp/linux_signing_key.pub
apt-get update
apt-get install -y google-chrome-stable
rm /tmp/linux_signing_key.pub

# install apps
apt-get install -y \
	audacity \
	blender \
	filezilla \
	firefox \
	gimp \
	git \
	gnome-system-monitor \
	htop \
	kazam \
	kdenlive \
	krita \
	libreoffice \
	linuxdcpp \
	mpv \
	nload \
	neofetch \
	p7zip \
	psensor \
	qbittorrent \
	screen \
	snapd \
	speedtest-cli \
	steam \
	texstudio \
	tlp \
	thunderbird \
	vlc

# install snaps
snap install slack --classic

# vscode
snap install code --classic

snap install discord

# nodejs
snap install node --classic

# notetaking
snap install xournalpp

# dark theme
mkdir -p "$HOME/.config/gtk-3.0/"
touch "$HOME/.config/gtk-3.0/settings.ini"
cat > "$HOME/.config/gtk-3.0/settings.ini" <<EOL
[Settings]
gtk-application-prefer-dark-theme=1
EOL

# desktop background
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Morskie%20Oko.jpg'

# brightness fix
mkdir -p /usr/local/bin
cp ./assets/bright /usr/local/bin
chmod +x /usr/local/bin/bright
