#!/bin/bash

# colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
reset=`tput sgr0`

# ask for sudo
if [ $EUID != 0 ]; then
  sudo "$0" "$@"
  exit $?
fi

# download package info
apt-get update

# dialog
apt-get install dialog

# dialog menu
HEIGHT=15
WIDTH=80
CHOICE_HEIGHT=6
BACKTITLE="Setup Elementary OS on HP Spectre x360 15t 5KC45AV"
TITLE="Setup"
MENU="Choose one of the following options:"

OPTIONS=(
  1 "Enable WiFi (requires reboot)"
  2 "Install drivers"
  3 "Install apps"
  4 "Install snaps (before installing snaps, logout and log back in)"
  5 "Dark theme"
  6 "Brightness fix"
)

CHOICE=$(dialog --clear \
  --backtitle "$BACKTITLE" \
  --title "$TITLE" \
  --menu "$MENU" \
  $HEIGHT $WIDTH $CHOICE_HEIGHT \
  "${OPTIONS[@]}" \
  2>&1 >/dev/tty)

clear
case $CHOICE in
  1)
    # enable wifi
    apt-get install -y linux-oem-osp1 linux-firmware
    ;;
  2)
    # install drivers
    # nvidia drivers
    ubuntu-drivers autoinstall
    # use integrated graphics by default
    prime-select intel
    ;;
  3)
    # install apps
    # manage the repositories that you install software from
    apt-get install -y software-properties-common
    add-apt-repository -y ppa:andreasbutti/xournalpp-master
    add-apt-repository -y ppa:libreoffice/ppa
    add-apt-repository -y ppa:philip.scott/elementary-tweaks
    add-apt-repository -y ppa:ubuntuhandbook1/audacity
    apt-get update

    # uninstall default apps
    apt-get purge -y \
      epiphany-browser \
      epiphany-browser-data \
      pantheon-mail
    apt-get autoremove

    # install google chrome
    wget -O /tmp/linux_signing_key.pub https://dl.google.com/linux/linux_signing_key.pub
    apt-key add /tmp/linux_signing_key.pub
    apt-get update
    apt-get install -y google-chrome-stable
    rm /tmp/linux_signing_key.pub
    
    # install apps
    apt-get install -y \
      audacity \
      default-jdk \
      elementary-tweaks \
      filezilla \
      firefox \
      git \
      gnome-system-monitor \
      htop \
      kazam \
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
      # notetaking
      xournalpp

    # fix xournalpp icon
    cp ./assets/com.github.xournalpp.xournalpp.svg /usr/share/applications
    sed -i 's/Icon=com.github.xournalpp.xournalpp/Icon=\/usr\/share\/applications\/com.github.xournalpp.xournalpp.svg/' /usr/share/applications/com.github.xournalpp.xournalpp.desktop
    ;;
  4)
    # install snaps
    snap install blender --classic
    # vscode
    snap install code --classic
    snap install discord
    snap install gimp
    snap install intellij-idea-community --classic
    snap install kdenlive
    snap install krita
    # nodejs
    snap install --edge node --classic
    snap install pycharm-community --classic
    snap install slack --classic
    snap install vlc
    ;;
  5)
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
    ;;
  6)
    # brightness fix
    mkdir -p /usr/local/bin
    cp ./assets/bright /usr/local/bin
    cp ./assets/set-bright /usr/local/bin
    chmod +x /usr/local/bin/bright
    chmod +x /usr/local/bin/set-bright
    # brightness fix key bindings
    ./assets/set_customshortcut.py 'bright -' 'bright -' '<Primary>F2'
    ./assets/set_customshortcut.py 'bright +' 'bright +' '<Primary>F3'
esac
