## HP Spectre x360 15t 5KC45AV

> Documentation of setting up Elementary OS 5.1 Hera on HP Spectre x360 15t 5KC45AV

### Script

```
./setup.sh
```

### Enable WiFi

Install 5.4.10 kernel https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.10/

Edit `/etc/default/grub`, set
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=vendor acpi_osi='!Windows 2013' acpi_osi='!Windows 2012' snd_hda_intel.dmic_detect=0"
```

```
sudo update-grub
```

Sound and WiFi are working

Source: https://bbs.archlinux.org/viewtopic.php?pid=1876701#p1876701

### Sources
* [Dark themes for writing](https://robjhyndman.com/hyndsight/dark-themes-for-writing/)
* [Keybindings](https://askubuntu.com/a/597414)
