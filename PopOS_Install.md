# PopOS Install guide

## Install official softwares

### Essential
**Add architecture 32bits:** `sudo dpkg --add-architecture i386 `

**Update and setup backup:** `sudo apt update && sudo apt upgrade && sudo apt install timeshift`

**Setup tlp:** `sudo apt install tlp tlp-rdw --no-install-recommends`

**Remove unused packages:** `sudo apt purge geary`

**Install main packages:** `sudo apt install wine winetricks texlive-base texlive-lang-french texmaker neofetch lutris openjdk-14-jre steam qbittorrent gnome-tweaks discord ubuntu-restricted-extras libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libsqlite3-0:i386 telegram-desktop slack-desktop spotify-client qgis inkscape gimp snapd alacarte virtualbox pdfarranger powertop chromium`

**Install flatpack base packages via PopShop:** Synology Drive,WhatsApp, MiscrosoftTeams, Skype, Tutanota, gtg, anydesk

**Install snap base packages:** sudo snap install joplin

**Install manually:** manually *matlab, antidote, citrix receiver and popcorn* and then create matlab shortcut via PopShop
- https://www.citrix.com/downloads/workspace-app/
- https://www.antidote.info/fr/?utm_source=druide.com&utm_medium=accueil&utm_campaign=vitrines&utm_content=bouton
- https://popcorntime.app/
- https://nl.mathworks.com/products/matlab.html

**Gnome extensions:**
- mouse-battery
- KStatusNotifierItem
- Sound Input & Output Device Chooser 
   
## Snap

### Commands
- Install: `snap install PACKAGE`
- Update snap packages: `snap refresh`
- Search for packages: `snap find`

## Action
Edit `~/.bashrc`
>>>........
# Custom
neofetch

# Alias - Maintenance
alias sudo='sudo '
alias mirror='reflector --verbose --country "Netherlands" --country "Germany" --age 12 --sort rate --save /etc/pacman.d/mirrorlist'
alias update='sudo mirror ; yay -Syu ; sudo snap refresh'
alias maintenance='sudo paccache -r ; sudo pacman -Rns $(pacman -Qtdq) ; npm audit fix ; arch-audit'

# Alias - CPU
alias cpuP='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias cpuS='echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'

# Alias - Game
alias starcitizen='sudo sysctl -w vm.max_map_count=16777216 ; cpuP'

# Alias - Work only under Kali
#alias discover='cd /opt/discover && ./discover.sh'

# Alias - Testing
#alias game='optimus-manager --switch nvidia'
#alias normal='optimus-manager --switch hybrid'
#alias VMwebcam='VBoxManage controlvm Windows webcam attach /dev/video0'
>>>>...............................
