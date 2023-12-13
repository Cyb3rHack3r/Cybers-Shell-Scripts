# CYBERS SHELL SCRIPTS

###### A collection of useful shell scripts developed by me, mostly to reduce my setup time when I inevitably brick my OS.

### What's Included?

##### Auto Setup

###### The star of the show is an auto-setup script to quickly get a user setup after a fresh install. The script automates the following:

- ###### Partition mounting
- ###### Installs a pre defined list of packages
- ###### Modifies .bashrc
- ###### Permissions setup
- ###### Enables services (if appropriate packages were installed)
- ###### Downloads and installs kvantum themes
- ###### Downloads and installs some fonts

###### The entire script is interactive and presents you with a bunch of options so you can choose what you do and do not want it to do.

##### Simple DD

###### A really simple script to simplify the DD command since I always forget how to use it. It prompts you for the source.iso and the target device as well as pre setting the block size to 1M. 

###### It makes it so you dont have to remember any of the, admitedly very simple, syntax for the DD command.

##### Simple DWEBP

###### Does a very simple thing as the DD script above, prompting you for the input and output so you dont have to remmeber the syntax for DWEBP.

### Really Important Stuff

###### Even though the Auto-Setup script is supposed to be noob friendly there is some really important stuff you should know about using it.

- ###### It is tested on EndeavourOS.
- ###### It is entirely built on the supposition you are using pacman with `yay` installed (Defaults for EndeavourOS).
- ###### The script is exclusively tested with BASH, I don't know enough about other shells to tell you if it will only work in BASH but it's something to be aware of.
- ###### The partition mounting functionality is built to work with FSTAB. If you are not using FSTAB I'd seriously doubt that this function will do anything, It may even cause damage.
- ###### At the time being I haven't configured the ability to add your own packages to the list of packages to be installed. Therefore, If you choose to use this part of the script it will install a predetermined list of packages that I personally find usefull. These packages are `steam` `brave` `kvantum` `vscode` `virtual box` `virtual box guest additions` `kde partition manager` `screenfetch` `plex media server` `htop` and `libotf`

### Modifying the Script

###### You are completely welcome to modify the script or use it as inspiration or a guide for your own efforts, though I don't know if you'd want to consider it a reliable learning aid as im a complete script kiddy.

###### I've done my best to break the entire thing down with the use of comments so my fellow noobs canunderstand what almost every line does and how to apply it to your own scripts.

