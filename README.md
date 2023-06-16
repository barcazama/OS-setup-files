# New Install - Cheatsheet
Various files used to configure linux and the different distributions

## Important save before formating
- make sure cloud save is good
- backup .bashrc and .bash_aliases to github (.bash.d/aliases and .bash.d/config for fedora)
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
    - Key Promoter X
    - Visual Studio Keymap
    - ?IdeaVim
    - ?Julia
    - ?Matlab Support
    - ?R Langauge for Intellij

### Packages
- backup
    - Timeshift (if local, just set to automatic) or btrfs snapshot system?
    - Vorta backup (+borg)
        - Repository: /home/cooper/Storage/borgbackup
        - SSH Key: Automatic
        - Compression LZ4
    - Megacloud (replacing InSync)
        - Document -> Document
        - Pictures -> Pictures
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
    - todoist
- games
    - wine64 (and wine32?)
    - steam/steam proton / vulkan
    - protonup
    - winetricks / protontricks
    - lutris -> FFXIV, BattleNet, LoL
- Office
    - GIMP
    - Inkscape
    - Marktext (replacing Joplin)
    - libreoffice
    - LaTeX / TexMaker
    - Vim
    - Zotero (+Better BibTex)
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
- steam launch option for FSR: gamescope -h 720p -H 2560 -U -f -r 30 -- %command%
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
    - add: "max_parallel_downloads=10"
    - add: "fastestmirror=True"
    - add: "deltarpm=True"
- Change hostname: "sudo hostnamectl set-hostname "oryxp-fedora"
- Enable additional repository
    - RPM Fusion for Fedora XX
- Graphics (dual gpu):
    - install system76 drivers (cf System76 website)
    - use envycontrol to manage gpu (if system76 fail)
    
### Arch
- Run archinstall`
