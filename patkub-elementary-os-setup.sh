#!/bin/bash

# enable wifi
apt-get install linux-oem-osp1 linux-firmware

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
	mpv \
	qbittorrent \
	snapd \
	steam \
	textstudio \
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
