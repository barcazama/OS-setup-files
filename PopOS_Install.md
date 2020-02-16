# PopOS Install guide

## Install official softwares

### Essential
`sudo apt install snapd telegram-desktop wine winetricks texlive-base texlive-lang-french texmaker neofetch lutris openjdk-14-jre steam qbittorrent browser-plugin-freshplayer-pepperflash gnome-tweaks slack-desktop discord spotify-client`

### Softwares list
- **freecad:** autocad opensource alternative for 3D
- **librecad:** autocad opensource alternative for 2D
- **qgis:** ArcGis opensource alternative, geomatic
- **gimp:** photoshop opensource alternative
- **inkscape:** adobe illustrator opensource alternative
- **alacarte:** allow edit of gnome dashboard
- **pycharm:** python3 IDE
- **atom:** IDE for everthing? Need plugin for everything

### Testing
**Joplin:**
  - install nodejs
  - download using: `wget -O - https://raw.githubusercontent.com/laurent22/joplin/master`
  - run `Joplin_and_update.sh | bash`
  - create shortcuts
    - terminal: `sudo ln -s /home/cooper/.joplin/Joplin.AppImage  /bin/joplin` or with `/usr/bin/joplin`?
    - dash: use software alacarte to edit gnome menu
    
## Snap

### Commands
- Install: `snap install PACKAGE`
- Update snap packages: `snap refresh`
- Search for packages: `snap find`

### Softwares list
- **whatsdesk:** whats'app application
- **pycharm-community --classic:** python IDE


## To download and manually install
- Matlab (install matlab-support post install to automatically create shortcut and resolve dependancies)
- Antidote Druid

## Gnome customisation
*Using the firefox extension*
- AppIndicator Support
- Sound Input and Output Device Chooser
- CPU power manager
- Extension Update Notifier

## Action
Edit `~/.bashrc`
> neofetch
>
> alias cpuP='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
>
> alias cpuS='echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'

## Notes
- Make sure to follow ryzen tutorial: https://forum.manjaro.org/t/amd-ryzen-problems-and-fixes/55533
- Make sure vulkan is installed https://wiki.archlinux.org/index.php/Vulkan
