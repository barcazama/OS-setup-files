# New Install - Cheatsheet
Various files used to configure linux and the different distributions

## Important save before formating
- make sure cloud save is good
- backup .bashrc and .bash_aliases to github
- backup .vimrc
- make sure any conda environment have an install file (and test it)
- update list of important package (bellow)
- update list of gnome extension
- update list of pycharm plugin
- update list of firefox extension

## To Install
### Software Extension
- Gnomes
    - Bluetooth Quick Connect
    - Caffeine
    - Desktop Icons NG (DING)
    - Vitals
    - Sounds Output Device Chooser
- Firefox (should sync auto)
    - Auto Tab Discard
    - Firefox Relay
    - Firefox Translations
    - Grammar & Spell Checker - LanguageTool
    - I don't care about cookies
    - Joplin Web Clipper
    - Lean Library (Utrecht University)
    - Simple Tab Groups (backup in github)
    - SpotiShush
    - To Deepl
    - Tranquility Reader
    - UBlock Origin
    - Zotero Connector
- Pycharm
    - AsciiDoc
    - GitToolBox
    - Past Images into Markdown
    - PDF Viewer
    - TeXiFy IDEA
    - YAML / Ansible support
    - Docker
    - Markdown (default?)
    - Git (default?)
    - GitHub (default?)
    - ?IdeaVim
    - ?Julia
    - ?Matlab Support
    - ?R Langauge for Intellij

### Packages
- backup
    - Timeshift (if local, just set to automatic)
    - Vorta backup (+borg)
        - Repository: /home/cooper/Storage/borgbackup
        - SSH Key: Automatic
        - Compression LZ4
    - InSync
        - Document -> Document
        - Pictures -> Pictures
        - Joplin handle it itself via OneDrive
- terminal
    - bash-completion
    - vim (and vundle plugin: https://github.com/VundleVim/Vundle.vim)
    - ghostscripts
    - git
    - powertop
    - codecs?
- main
    - firefox
    - vlc
    - transmission (or any other torrent client, webtorrent?)
    - tutanota
- games
    - wine64 (and wine32?)
    - steam/steam proton / vulkan
    - protonup
    - winetricks / protontricks
    - lutris -> FFXIV, BattleNet, LoL
- Office
    - GIMP
    - Inkscape
    - Joplin
    - libreoffice
    - LaTeX / TexMaker
    - Vim
    - Zotero
- Programming
    - Jetbrains toolbox: pycharm, dataspell
    - python3
    - miniconda
    - paraview?
    - Matlab / Octave?
    - R?
    - Docker?
    - Jupyter
- Social
    - Discord
    - Signal
    - Microsoft teams
    - Telegram
    - WhatsApp Desktop
- System
    - Extension Manager (for gnome)
    - Flatseal
    - htop
    - menu editor
    - System76 Drivers
    - Tweaks (mod gnome)
- Utilties
    - Anydesk
    - Bottles
    - Gnome Boxes (or VirtualBox?)
    - ?Popsicle (writting usb key)

## Setup guide
- test update and cleaning script (for fedora, change for "sudo dnf update && sudo dnf upgrade")
- graphic driver install
- set automatic mount of disks
- automatic backup for timeshift and borg
- proton install 
- softwares install
- gnome plugins
- firefox: 
    - login + add search (@youtube, @yts, @github, @maps (google)
    - import group backup
- setup new nevironment
- pycharm plugins


## Distribution specific
### Fedora
- Improve DNF package manager speed
    - "vim /etc/dnf/dnf.conf"
    - add: "max_parallel_downloads=8"
    - add: "fastestmirror=True"
- Enable additional repository
    - RPM Fusion for Fedora XX - Nonfree - Steam
- ?Install flathub for easier management of flatpak (https://flatpak.org/setup/Fedora)
- ?If default setup is not viable for hybrid graphics, concider: https://copr.fedorainfracloud.org/coprs/szydell/system76/
