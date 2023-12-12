#! /bin/sh

#define global script variables
    
    #colored text variables
        REDBKGSTART='\e[1;41m'
        BKGEND='\e[0m'

    #user variables

#echo script info
    echo -e "$REDBKGSTART ~~CYBERS AUTO SETUP SCRIPT~~ $BKGEND"
    sleep 3

#prompt for username
    read -p "WHAT IS YOUR USERNAME? " USERNAME
    read -p "You have entered | $USERNAME | Continue (y/n)?" NAMECHECK
        if [ "$NAMECHECK" = "y" ]; then
        echo "OK, SCRIPT WILL START NOW";
        else
        echo "RERUN SCRIPT TO TRY AGAIN";
        exit
        fi

#install desired packages with yay
    yay -S --noconfirm steam brave-bin kvantum code virtualbox virtualbox-guest-utils partitionmanager screenfetch plex-media-server htop libotf
    echo -e "$REDBKGSTART ~~PACKAGES INSTALLED~~ $BKGEND"
    sleep 3

#add items to .bashrc
    grep -q "screenfetch" ~/.bashrc || echo "screenfetch" | sudo tee -a ~./bahsrc > /dev/null
    echo -e "$REDBKGSTART ~~BASHRC FINISHED~~ $BKGEND"
    sleep 3

#sets up drive mounts and permissions

    #makes mounting directories"
        sudo mkdir /run/media/$USERNAME/mntsda3
        sudo mkdir /run/media/$USERNAME/mntsdb2
        echo -e "$REDBKGSTART ~~MOUNT POINTS MADE~~ $BKGEND"
        sleep 3

    #gives permissions to $USERNAME user and group to the above created directories
        sudo chown -R $USERNAME:$USERNAME /run/media/$USERNAME/
        sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/
        sudo chmod -R a+rwx /run/media/$USERNAME/
        sudo chmod -R a+rwx /home/$USERNAME


            #adds user plex to group $USERNAME
                sudo usermod -a -G $USERNAME plex 

        echo -e "$REDBKGSTART ~~PERMISSIONS SET~~ $BKGEND"
        sleep 3

    #mounts disks to mount points

        #define variables for the mount process

            #terms to check for in fstab, works to make sure if there is any mention of these devices in fstab the write will not be made
            CHECKTEXTSDA3="/dev/sda3"
            CHECKTEXTSDB1="/dev/sdb1"
            CHECKTEXTSDB2="/dev/sdb2"

            #fstab variable
            TARGETFSTAB="/etc/fstab"

            #terms to enter if grep is non 0 for the check terms
            ENTERTEXTSDA3="/dev/sda3                                   /run/media/$USERNAME/mntsda3   btrfs                defaults                               0 0"
            ENTERTEXTSDB1="/dev/sdb1                                   /home                            btrfs                defaults                               0 0"
            ENTERTEXTSDB2="/dev/sdb2                                   /run/media/$USERNAME/mntsdb2   btrfs                defaults                               0 0"

        #write sda3 mount in fstab
            grep -q "$CHECKTEXTSDA3" $TARGETFSTAB || echo "$ENTERTEXTSDA3" | sudo tee -a $TARGETFSTAB > /dev/null

        #write sdb1 mount in fstab
            grep -q "$CHECKTEXTSDB1" $TARGETFSTAB || echo "$ENTERTEXTSDB1" | sudo tee -a $TARGETFSTAB > /dev/null

        #write sdb2 mount in fstab
            grep -q "$CHECKTEXTSDB2" $TARGETFSTAB || echo "$ENTERTEXTSDB2" | sudo tee -a $TARGETFSTAB > /dev/null

        echo -e "$REDBKGSTART ~~MOUNTS WRITTEN TO FSTAB~~ $BKGEND"
        sleep 3

#enable services
    sudo systemctl enable plexmediaserver.service
    
    echo -e "$REDBKGSTART ~~SERVICES STARTED AND ENABLED~~ $BKGEND"
    sleep 3

#setup theming and customization stuff

    #clone theming repos
        mkdir /home/$USERNAME/GitRepos
        cd /home/$USERNAME/GitRepos
        git clone https://github.com/vinceliuice/Orchis-kde.git
        git clone https://github.com/vinceliuice/Layan-kde.git
        git clone https://github.com/yeyushengfan258/Reversal-icon-theme.git

    #install theme related stuff
        cd /home/$USERNAME/GitRepos/Orchis-kde/
        ./install.sh
        cd /home/$USERNAME/GitRepos/Layan-kde/
        ./install.sh
        cd /home/$USERNAME/GitRepos/Reversal-icon-theme/
        ./install.sh

    #download OTF fonts
        sudo mkdir /usr/share/fonts/opentype
        cd /usr/share/fonts/opentype
        sudo git clone https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts.git

echo -e "$REDBKGSTART ~~CUSTOMIZATIONS INSTALLED~~ $BKGEND"

#echo the all done message
     echo -e "$REDBKGSTART ~~AUTO SETUP COMPLETE~~ $BKGEND"
