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

# nvidia drivers
ubuntu-drivers autoinstall
# use integrated graphics by default
prime-select intel

# manage the repositories that you install software from (common)
apt-get install -y software-properties-common
apt-get update

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
  default-jdk \
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

# nodejs
snap install --edge node --classic
# vscode
snap install code --classic
snap install discord
snap install slack --classic
snap install intellij-idea-community --classic
snap install pycharm-community --classic
# notetaking
snap install xournalpp

# dark theme
mkdir -p "$HOME/.config/gtk-3.0/"
touch "$HOME/.config/gtk-3.0/settings.ini"
cat > "$HOME/.config/gtk-3.0/settings.ini" <<EOL
[Settings]
gtk-application-prefer-dark-theme=1
EOL

# texstudio dark theme
cp ./assets/.dark.txsprofile ~/.dark.txsprofile

# desktop background
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Morskie%20Oko.jpg'

# brightness fix
mkdir -p /usr/local/bin
cp ./assets/bright /usr/local/bin
cp ./assets/set-bright /usr/local/bin
chmod +x /usr/local/bin/bright
chmod +x /usr/local/bin/set-bright

# brightness fix keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'bright -'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'bright -'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary>F2'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'bright +'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'bright +'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Primary>F3'
