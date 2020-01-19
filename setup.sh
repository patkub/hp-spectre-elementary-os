#!/bin/bash

# download package info
sudo apt-get update

# dialog
sudo apt-get install dialog

# dialog menu
HEIGHT=15
WIDTH=80
CHOICE_HEIGHT=6
BACKTITLE="Setup Elementary OS on HP Spectre x360 15t 5KC45AV"
TITLE="Setup"
MENU="Choose one of the following options:"

OPTIONS=(
  1 "Install drivers"
  2 "Install apps"
  3 "Install snaps (before installing snaps, logout and log back in)"
  4 "Dark theme"
  5 "Brightness fix"
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
    # install drivers
    # nvidia drivers
    sudo ubuntu-drivers autoinstall
    # use integrated graphics by default
    sudo prime-select intel
    
    # multimedia codecs and dvd playback
    sudo apt-get install -y \
      ubuntu-restricted-extras \
      libavcodec-extra \
      libdvd-pkg
    sudo dpkg-reconfigure libdvd-pkg
    ;;
  2)
    # install apps
    # manage the repositories that you install software from
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:andreasbutti/xournalpp-master
    sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable
    sudo add-apt-repository -y ppa:libreoffice/ppa
    sudo add-apt-repository -y ppa:mc3man/mpv-tests
    sudo add-apt-repository -y ppa:mozillateam/ppa
    sudo add-apt-repository -y ppa:philip.scott/elementary-tweaks
    sudo add-apt-repository -y ppa:ubuntuhandbook1/audacity
    sudo apt-get update

    # uninstall default apps
    sudo apt-get purge -y \
      epiphany-browser \
      epiphany-browser-data \
      pantheon-mail
    sudo apt-get autoremove

    # install google chrome
    wget -O /tmp/linux_signing_key.pub https://dl.google.com/linux/linux_signing_key.pub
    sudo apt-key add /tmp/linux_signing_key.pub
    sudo apt-get update
    sudo apt-get install -y google-chrome-stable
    rm /tmp/linux_signing_key.pub
    
    # install apps
    sudo apt-get install -y \
      audacity \
      default-jdk \
      elementary-tweaks \
      filezilla \
      firefox \
      freecad \
      git \
      gnome-system-monitor \
      htop \
      kazam \
      librecad \
      libreoffice \
      linuxdcpp \
      mpv \
      nload \
      neofetch \
      openscad \
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
    sudo cp ./assets/com.github.xournalpp.xournalpp.svg /usr/share/applications
    sudo sed -i 's/Icon=com.github.xournalpp.xournalpp/Icon=\/usr\/share\/applications\/com.github.xournalpp.xournalpp.svg/' /usr/share/applications/com.github.xournalpp.xournalpp.desktop
    ;;
  3)
    # install snaps
    sudo snap install blender --classic
    # vscode
    sudo snap install code --classic
    sudo snap install discord
    sudo snap install gimp
    sudo snap install intellij-idea-community --classic
    sudo snap install kdenlive
    sudo snap install krita
    # nodejs
    sudo snap install --edge node --classic
    sudo snap install pycharm-community --classic
    sudo snap install slack --classic
    sudo snap install vlc
    ;;
  4)
    # dark theme
    mkdir -p "~/.config/gtk-3.0/"
    touch "~/.config/gtk-3.0/settings.ini"
    cat > "~/.config/gtk-3.0/settings.ini" <<EOL
[Settings]
gtk-application-prefer-dark-theme=1
EOL

    # texstudio dark theme
    cp ./assets/.dark.txsprofile ~/.dark.txsprofile

    # desktop background
    gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Morskie%20Oko.jpg'
    ;;
  5)
    # brightness fix
    sudo mkdir -p /usr/local/bin
    sudo cp ./assets/bright /usr/local/bin
    sudo cp ./assets/set-bright /usr/local/bin
    sudo chmod +x /usr/local/bin/bright
    sudo chmod +x /usr/local/bin/set-bright
    # brightness fix key bindings
    ./assets/set_customshortcut.py 'bright -' 'bright -' '<Primary>F2'
    ./assets/set_customshortcut.py 'bright +' 'bright +' '<Primary>F3'
esac
