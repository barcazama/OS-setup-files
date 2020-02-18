# Arch Linux on Oryx5: Installation guide
Be sure to set in nvidia mode before installing.
Make sure by running `lspci -k | grep -A 3 VGA` which should contain Nvidia in the list

# NOTE TEMP
- specify device for root and swap on resume, cf: https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation

## Wipe data
1. Create a temporary encrypted container

    `cryptsetup open --type plain -d dev/urandom /dev/<block-device> to_be_wiped`
    
2. Verify the partition exist with `lsblk`

3. Wipe the container with zeros

    `dd if=/dev/zero of=/dev/mapper/to_be_wiped status=progress`
    
4. Close temporary container

    `cryptsetup close to_be_wiped`
    
## Formating for LVM on LUKS
Needed packages: `lvm2`

1. Encrypt everything but /boot containing /boot/efi where sdXX is the whole disk except /boot

    `cryptsetup -v luksFormat /dev/sdXX` 
    
2. Open container. Will be available under /dev/mapper/cryptlvm

    `cryptsetup open /dev/sdXX cryptlvm`
    
3. Create physical volume on top of the LUKS container

    `pvcreate /dev/mapper/cryptlvm`
    
4. Create volume group

    `vgcreate Main /dev/mapper/cryptlvm`
    
5. Create all logical volume on the volume group
    
    `lvcreate -L 8G Main -n swap`
    
    `lvcreate -L 100%FREE -n root`
    
6. Format file system on each volume
    
    `mkfs.ext4 /dev/Main/root`
    
    `mkswap /etc/Main/swap`
    
    *Don't forget to prepare /boot/efi*
    
7. Mount filesystems
    
    `mount /dev/Main/root /mnt`
    
    `mkdir /mnt/boot/efi`
    
    `mount /dev/sdXX /mnt/boot/efi`
    
    `swapon /dev/Main/swap`

8. Configure mkinitcpio, add hooks to mkinitcpio.conf

    `HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)`

9. Configure the bootloader
    
    `cryptdevice=UUID=device-UUID:cryptlvm root=/dev/MyVolGroup/root`

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
    Follow LUKS guide at the top
    
    fdisk signature:
    - 1 for EFI
    - 19 for swap
    - 20 for root

    `fdisk -l`
    
    `fdisk /dev/sdX`
    > 537M as efi type in CFDISK
    >
    > rest formated as linux file system (default)
    
    `mkfs.ext4 /dev/sdX2`
    
    `mkfs.fat -F32 /dev/sdX1`
    
    `mount /dev/sdX2 as /mnt`
    
    `mkdir /mnt/boot/efi`
    
    `mount /dev/sdX1 /mnt/boot/efi`
    
5. **Install essential packages** (base-devel is optional)

    `pacstrap /mnt base base-devel linux linux-firmware`
    
6. **Generate fstab and check result**

    `genfstab -U /mnt >> /mnt/etc/fstab`
    
    Add the option `noatime,errors=remount-ro` to root mount for nvme (was in System76 base fstab)
    
    `nano /mnt/etc/fstab`
    
7. **Chroot**

    `arch-chroot /mnt`
    
8. **Install needed packages**

    `pacman -Syu sudo nano grub efibootmgr pacman-contrib bash-completion pkgfile linux-lts linux-headers linux-lts-headers xorg iw git flashplugin pepper-flash netctl intel-ucode tlp ttf-liberation pluseaudio alsa dialog wpa_supplicant netctl networkmanager`
    
    `pacman -S xf86-video-intel xf86-video-nouveau mesa mesa-demos acpi acpid`
    
    dektop environement `gnome gnome-extra chrome-gnome-shell arc-gtk-theme arc-icon-theme`
    
    `systemctl enable gdm`
    
    `systemctl enable NetworkManager`
    
    `systemctl enable acpid`
    
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

    `grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB`
    
    `grub-mkconfig -o /boot/grub/grub.cfg`
    
    `nano /etc/default/grub`
    
    `grub-mkconfig -o /boot/grub/grub.cfg`
    
14. **Sorting mirrors**

    `cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak`
    
    `rankmirrors -n 6 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist`
    
15. **Enable multilib repository**

    `nano /etc/pacman.conf`    

16. **End**
    
    `exit`
    
    `umount -R /mnt`
    
    `reboot`
    
00. **Edit bashrc**

    > edit ~/.bashrc
    
    `shopt -s autocd`
    
    `neofetch` *if installed*
    
    `informant check` *if installed and owning permission resolved*
    
    `alias cpuP='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'`
    
    `alias cpuS='echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'`
    
01. **Install System76 drivers**
    All driver are in the Aur
    
    `systemctl enable --now system76-firmware-daemon`
    
    `systemctl enable --now system76-backlight --user`
    
    `systemctl enable --now system76`
    
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
