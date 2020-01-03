#!/bin/bash

# download package info
apt-get update

# enable wifi
apt-get install linux-oem-osp1 linux-firmware

# multimedia codecs and dvd playback
apt-get install ubuntu-restricted-extras libavcodec-extra libdvd-pkg

# install google chrome
wget -O /tmp/linux_signing_key.pub https://dl.google.com/linux/linux_signing_key.pub
apt-key add /tmp/linux_signing_key.pub
apt-get update
apt-get install google-chrome-stable
rm /tmp/linux_signing_key.pub

# install apps
apt-get install \
	audacity \
	blender \
	firefox \
	gimp \
	gnome-system-monitor \
	kazam \
	kdenlive \
	krita \
	libreoffice \
	linuxdcpp \
	mpv \
	qbittorrent \
	snapd \
	steam \
	texstudio \
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
touch "$HOME/.config/gtk-3.0/settings.ini"
cat > "$HOME/.config/gtk-3.0/settings.ini" <<EOL
[Settings]
gtk-application-prefer-dark-theme=1
EOL
