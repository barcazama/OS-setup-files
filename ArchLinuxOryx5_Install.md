# Arch Linux on Oryx5: Installation guide
Be sure to set in nvidia mode before installing.
Make sure by running `lspci -k | grep -A 3 VGA` which should contain Nvidia in the list

# NOTE TEMP
- specify device for root and swap on resume, cf: https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation

## Wipe data
1. Create a temporary encrypted container

    `cryptsetup open --type plain -d dev/urandom /dev/<block-device> to_be_wiped
    
2. Verify the partition exist with `lsblk`

3. Wipe the container with zeros

    `dd if=/dev/zero of=/dev/mapper/to_be_wiped status=progress`
    
4. Close temporary container

    `cryptsetup close to_be_wiped`

## Base setup
1. **Verify the boot mode, if exist then UEFI mode is enable**

    `ls /sys/firmware/efi/efivars`
  
2. **Wifi set-up**
    - Manual

        `dmesg | grep firmware` command to control if firmware install is needed

        `iw dev` command to list wifi device name

        `ip link set INTERFACE up` e.g INTERFACE = wlan0

        `systemctl enable dhcpcd`

        `iw dev INTERFACE scan | less` command to search available SSID

        `wpa_passphrase SSID PASSWPA2 > /etc/wpa_supplicant/example.conf`

        `wpa_supplicant -B -i INTERFACE -c /etc/wpa_supplicant/example.conf`
        
    - Wifi-Menu
    
        `wifi-menu`
    
    `dhcpcd INTERFACE`
    
3. **Update the system clock**

    `timedatectl set-ntp true`
    
4. **Partition the disks**

    `fdisk -l`
    
    `fdisk /dev/sdX`
    > 537M as efi type in CFDISK
    >
    > rest formated as linux file system (default)
    
    `mkfs.ext4 /dev/sdX2`
    
    `mkfs.fat -F32 /dev/sdX1`
    
    `mount /dev/sdX2 as /mnt`
    
    `mkdir /mnt/efi`
    
    `mount /dev/sdX1 /mnt/efi`
    
5. **Install essential packages** (base-devel is optional)

    `pacstrap /mnt base base-devel linux linux-firmware`
    
6. **Generate fstab and check result**

    `genfstab -U /mnt >> /mnt/etc/fstab`
    
    `nano /mnt/etc/fstab`
    
7. **Chroot**

    `arch-chroot /mnt`
    
8. **Install needed packages**

    `pacman -S nano sudo grub efibootmgr pacman-contrib iw xorg git flashplugin pepper-flash bash-completion pkgfile linux-lts linux-headers linux-lts-headers ttf-liberation`
    
    microcode`amd-ucode` or `intel-ucode`
    
    laptop `tlp`
    
    network `dhcpcd wpa_supplicant dialog netctl networkmanager` *networkmanager is already included in gnome*
    
    dektop environement `gnome gnome-extra chrome-gnome-shell arc-gtk-theme arc-icon-theme`
    
    `systemctl enable gdm`
    
    `systemctl enable networkmanager` or `systemctl enable dhcpcd`
    
    `pkgfile -u`
    
8. **Time zone**

    `ln -sf /usr/share/zoneinfo/Canada/Eastern /etc/localtime`
    
    `hwclock --systohc`
    
10. **Localization**
    
    `nano /etc/locale.gen`
    
    `locale-gen`
    
    `nano /etc/locale.conf`
    > LANG=en_CA.UTF-8
    >
    > LC_Messages=en_CA.UTF-8
        
    `nano /etc/vconsole.conf`
    > KEYMAP=us-acentos
        
11. **Network configuration**
    
    `nano /etc/hostname`
    > HOSTNAME
        
    `nano /etc/hosts`
    > 127.0.0.1   localhost
    >
    > ::1         localhost
    >
    > 127.0.1.1   HOSTNAME.localdomain HOSTNAME

12. **Set root password and add user**

    `passwd`
    
    `useradd -m -G wheel USERNAME`
    
    `passwd USERNAME`
    
    `EDITOR=nano visudo`
    > allow wheel group access

13. **Boot loader**

    `grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB`
    
    `grub-mkconfig -o /boot/grub/grub.cfg`
    
    `nano /etc/default/grub`
    
    `grub-mkconfig -o /boot/grub/grub.cfg`
    
14. **Sorting mirrors**

    `cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak`
    
    `rankmirrors -n 6 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist`

15. **Graphic driver and desktop environement**

    `lspci | grep -e VGA -e 3D` command to check which component then install with pacman
    > intel = `xf86-video-intel vulkan-intel`
    >
    > nvidia = `xf86-video-nouveau` or for proprietary or vulkan `nvidia`
    >
    > amd = `xf86-video-amdgpu vulkan-radeon`
    >
    > *look for specific laptop when using intel+nvidia*
    
    `ls /usr/share/vulkan/icd.d/` *check if vulkan is installed correctly*
    
16. **Enable multilib repository**

    `nano /etc/pacman.conf`    
    
17. **Edit bashrc**

    > edit ~/.bashrc
    
    `shopt -s autocd`
    
    `neofetch` *if installed*
    
    `informant check` *if installed and owning permission resolved*
    
    `alias cpuP='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'`
    
    `alias cpuS='echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'`

18. **End**
    
    `exit`
    
    `umount -R /mnt`
    
    `reboot`
    
## Install main softwares

- neofetch
- firefox
- alacarte: allow edit of gnome dashboard
- jre-openjdk
- telegram-desktop: communcation
- discord
- libreoffice-fresh
- texlive-most texmaker
- inkscape
- gimp
- pycharm: IDE python mainly
- atom: IDE
- librecad
- qgis
- wine
- winetricks
- steam: gaming
- lutris


## Install AUR PKG

1. Initinal setup
    git config --global user.name "USERNAME"
    git config --global user.email "EMAIL"
2. Install AUR packages

    download snap from Aur
    
    `tar -xvf PACKAGE.tar.gz`
    
    `cd PACKAGE`
    
    `nano PKGBUILD`
    
    `makepkg -sia`
    
    `gpg --recv-keys #############` *if needed for key and trusted*
    
3. List
    - yay: package helper for AURupdate if package is related to a fresh Arch News 
    - informant: prevent 
    - spotify
    - joplin
    - synology-cloud-station-drive: cloud manager
    - whatsapp-nativefier-dark: what's app
    - slack-desktop
    
    
## Maintenance

1. rank mirrorlist and optimized pacman
2. sudo pacman -Syu
3. Remove orphans

    `sudo pacman -Rns $(pacman -Qtdq)`
    
4. Check for errors

    `sudo systemctl --failed`
    
    `sudo journalctl -p 3 -xb`

## Gnome customisation
The following list of extensions might be installed:
- Alt Tab: Raise First Window
- Always Show Workspaces
- Desktop Icons
- Do Not Disturb
- KStatusNotifierItem/AppIndicator Support
- Pop Battery Icon Fix
- Pop Shop Details
- Sound Input & Output Device Chooser
- Suspend Button
- System76 Power

The following packages might be installed:
- archlinux-wallpaper
  
    
## Notes

1. make grub boot faster
2. install key package
3. setup firewall using ufw?
4. encrypt home directory?
5.
    - ADD codec (e.g. pepperflash)
    - ADD torrent software
    - ADD Matlab software
    - ADD Antidote Druid software
6. Remove games from gnome-extra: pacman -Rs five-or-more four-in-a-row gnome-builder gnome-chess gnome-klotski gnome-mahjongg gnome-mines gnome-nidbbles gnome-robots gnome-sudoku
