## HP Spectre x360 15t 5KC45AV

> Documentation of setting up Elementary OS 5.1 Hera on HP Spectre x360 15t 5KC45AV

### Script

```
./setup.sh
```

### Enable WiFi

Install 5.4.10 kernel from [https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/](https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/)
```
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

Run the `monitor-backlight` script at startup

Source: [AW13 OLED Monitor Brightness](https://gist.github.com/joel-wright/68fc3031cbb3f7cd25db1ed2fe656e60)

### Sources
* [Dark themes for writing](https://robjhyndman.com/hyndsight/dark-themes-for-writing/)
* [Keybindings](https://askubuntu.com/a/597414)

