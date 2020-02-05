## HP Spectre x360 15t 5KC45AV

> Documentation of setting up Elementary OS 5.1 Hera on HP Spectre x360 15t 5KC45AV

## Table of Contents
* [Script](#script)
* [Enable WiFi](#enable-wifi)
* [Brightness Fix for OLED](#brightness-fix-for-oled)
* [Disable suspend](#disable-suspend)
* [Qt apps dark theme](#qt-apps-dark-theme)
* [Sources](#sources)


### Script

A menu to install apps and configure settings

```bash
./setup.sh
```

### Enable WiFi

Install 5.4.10 kernel from [https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/](https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/)
```bash
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/linux-headers-5.4.10-050410_5.4.10-050410.202001091038_all.deb
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/linux-headers-5.4.10-050410-generic_5.4.10-050410.202001091038_amd64.deb
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/linux-image-unsigned-5.4.10-050410-generic_5.4.10-050410.202001091038_amd64.deb
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/linux-modules-5.4.10-050410-generic_5.4.10-050410.202001091038_amd64.deb
sudo dpkg -i linux-headers-*.deb linux-image-*.deb linux-modules-*.deb
```


Edit `/etc/default/grub`, set
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=vendor acpi_osi='!Windows 2013' acpi_osi='!Windows 2012' snd_hda_intel.dmic_detect=0"
```
Run `sudo update-grub` to regenerate GRUB config

Sound and WiFi are working

Source: [https://bbs.archlinux.org/viewtopic.php?pid=1876701#p1876701](https://bbs.archlinux.org/viewtopic.php?pid=1876701#p1876701)

### Brightness Fix for OLED

The `monitor-backlight` script listens to display changes and the `set-bright` script sets the initial display brightness as a percentage from `0` to `1.0`.

Settings > Applications > Startup > Add Startup App... > Type in a custom command  
`/usr/local/bin/monitor-backlight`  
and  
`/usr/local/bin/set-bright 0.45`

Source: [AW13 OLED Monitor Brightness](https://gist.github.com/joel-wright/68fc3031cbb3f7cd25db1ed2fe656e60)

### Disable suspend

Laptop won't wake from suspend, and requires power cycling. To disable suspend, create the following file as root:

`/etc/polkit-1/localauthority/50-local.d/com.ubuntu.disable-suspend.pkla`

```
[Disable suspend (upower)]
Identity=unix-user:*
Action=org.freedesktop.upower.suspend
ResultActive=no
ResultInactive=no
ResultAny=no

[Disable suspend (logind)]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend
ResultActive=no
ResultInactive=no
ResultAny=no

[Disable suspend when others are logged in (logind)]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend-multiple-sessions
ResultActive=no
ResultInactive=no
ResultAny=no
```

Source: [How to disable suspend in 14.04?](https://askubuntu.com/a/488300)

### Qt apps dark theme

```bash
sudo apt-get install qt5ct
```

Open Qt5 Settings app and select `gtk2` from the style dropdown

Append the following lines to `~/.profile`

```bash
unset QT_STYLE_OVERRIDE
export QT_QPA_PLATFORMTHEME="qt5ct"
```

Source: [r/elementaryos Qt apps not conforming to dark theme](https://www.reddit.com/r/elementaryos/comments/cz11uc/qt_apps_not_conforming_to_dark_theme/)

### Sources
* [Dark themes for writing](https://robjhyndman.com/hyndsight/dark-themes-for-writing/)
* [Keybindings](https://askubuntu.com/a/597414)

