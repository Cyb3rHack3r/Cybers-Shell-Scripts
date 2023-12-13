#! /bin/sh

#global script variables
    
    #colored text variables
        REDBKGSTART='\e[1;41m'
        MAGBKGSTART='\e[1;45m'
        BLUETXTSTART='\e[1;34m'
        BKGEND='\e[0m'

#script info
    echo -e "$REDBKGSTART ~~CYBERS AUTO SETUP SCRIPT~~ $BKGEND"
    sleep 3

#user setup

    echo -e "$REDBKGSTART ~~USER SETUP~~ $BKGEND"
    
    read -p "WHAT IS YOUR USERNAME? " USERNAME
    read -p "You have entered | $USERNAME | Continue (y/n)?" NAMECHECK
        if [ "$NAMECHECK" = "y" ]; then
        echo -e "$BLUETXTSTART COOL USERNAME $BKGEND";
        echo -e "$MAGBKGSTART FINISHED USER SETUP $BKGEND";
        sleep 2
        else
        echo -e "$BLUETXTSTART RERUN SCRIPT TO TRY AGAIN $BKGEND";
        exit
        fi

#partition setup

    echo -e "$REDBKGSTART ~~PARTITION SETUP~~ $BKGEND"

    #ask if user wants to change home mount
        
        read -p "WOULD YOU LIKE TO CHANGE WHERE HOME IS MOUNTED (y/n)?" HOMEMOUNTFUNCCHECK
        if [ "$HOMEMOUNTFUNCCHECK" = "y" ]; then
            read -p "WHAT PARTITION WOULD YOU LIKE MOUNTED AS HOME? " HOMEPARTDEV
            read -p "WHAT'S IT'S FILE SYSTEM? " HOMEPARTFS
            read -p "YOU HAVE ENTERED | $HOMEPARTDEV | AS YOUR DESIRED LOCATION FOR YOUR HOME MOUNT, ITS FILESYSTEM IS | $HOMEPARTFS | IS THIS CORRECT (y/n)?" HOMEPARTNAMECHECK
            if [ "$HOMEPARTNAMECHECK" = "y" ]; then

                #write new home location to fstab

                    TARGETFSTAB="practicefstab"
                    HOMEEXISTCHECK=/home
                    HOMEPARTLINE="$HOMEPARTDEV                                   /home                            $HOMEPARTFS                defaults                               0 0"
                    sed -i '\| /home |d' $TARGETFSTAB
                    echo "$HOMEPARTLINE" | sudo tee -a $TARGETFSTAB > /dev/null;
                    echo -e "$BLUETXTSTART FINISHED WRITING HOME TO FSTAB $BKGEND";

            else
            echo -e "$BLUETXTSTART RE RUN SCRIPT TO START AGAIN $BKGEND";
            exit
            fi
        else
        echo -e "$BLUETXTSTART KEEPING HOME MOUNTED WHERE IT IS $BKGEND";
        fi
        
    
    #ask if the user wants to mount other partitions

        read -p "WOULD YOU LIKE TO MOUNT ADDITIONAL PARTITIONS (y/n)?" ADDMOUNTFUNCCHECK
        if [ "$ADDMOUNTFUNCCHECK" = "y" ]; then
            read -p "ENTER UP TO TWO OTHER PARTITIONS THAT NEED TO BE MOUNTED, SEPERATE THEM WITH SPACES " FIRSTPARTDEV SECONDPARTDEV
            read -p "WHAT ARE THEIR FILE SYSTEMS? SEPERATE THEM WITH SPACES AND WRITE THEM RESPECTIVELY " FIRSTPARTFS SECONDPARTFS
            read -p "GIVE THESE PARTITIONS A LABEL, SEPERATE THEM SPACES AND WRITE THEM RESPECTIVELY " FIRSTPARTLAB SECONDPARTLAB
            read -p "YOU HAVE ENTERED | $FIRSTPARTDEV $FIRSTPARTFS $FIRSTPARTLAB | AND | $SECONDPARTDEV $SECONDPARTFS $SECONDPARTLAB | AS ADDITIONAL PARTITIONS | Are these correct (y/n)?" ADDMARTNAMECHECK
            if [ "$ADDMARTNAMECHECK" = "y" ]; then

                #write new home location to fstab

                    TARGETFSTAB="practicefstab"
                    FIRSTPARTLINE="$FIRSTPARTDEV                                   /run/media/$USERNAME/$FIRSTPARTLAB                            $FIRSTPARTFS               defaults                               0 0"
                    SECONDTPARTLINE="$SECONDPARTDEV                                   /run/media/$USERNAME/$SECONDPARTLAB                            $SECONDPARTFS               defaults                               0 0"
                    echo "$FIRSTPARTLINE" | sudo tee -a $TARGETFSTAB > /dev/null
                    echo "$SECONDTPARTLINE" | sudo tee -a $TARGETFSTAB > /dev/null
                    echo -e "$BLUETXTSTART FINISHED WRITING MOUNTS TO FSTAB $BKGEND";

            else
            echo -e "$BLUETXTSTART RE RUN SCRIPT TO START AGAIN $BKGEND";
            exit
            fi
        else
        echo -e "$BLUETXTSTART OK, NO ADDITIONAL MOUNTS $BKGEND";
        fi

    echo -e "$MAGBKGSTART FINISHED PARTITION SETUP $BKGEND";

#package setup

    echo -e "$REDBKGSTART ~~PACKAGE SETUP~~ $BKGEND"

    read -p "WOULD YOU LIKE TO INSTALL THE PREDETERMINED LIST OF PACKAGES (y/n)?" PACKAGECONFIRM
        if [ "$PACKAGECONFIRM" = "y" ]; then
        yay -S --noconfirm steam brave-bin kvantum code virtualbox virtualbox-guest-utils partitionmanager screenfetch plex-media-server htop libotf
        else
        echo -e "$BLUETXTSTART NO PACKAGES, NO PROBLEMS $BKGEND";
        fi
    
    echo -e "$MAGBKGSTART FINISHED PACKAGE SETUP $BKGEND";
    sleep 2

#abashrc modifier
    echo -e "$REDBKGSTART ~~BASHRC MODIFIER~~ $BKGEND"

    #optionally write screenfetch into bashrc

        read -p "DID YOU CHOOSE TO INSTALL screenfetch (y/n)?" SCREENFETCHCONFIRM
            if [ "$SCREENFETCHCONFIRM" = "y" ]; then
            grep -q "screenfetch" ~/.bashrc || echo "screenfetch" | sudo tee -a ~./bahsrc > /dev/null
            echo -e "$BLUETXTSTART OK, ADDING SCREENFETCH TO BASHRC $BKGEND";
            sleep 1
            else
            echo -e "$BLUETXTSTART OK, NOT MODIFYING BASHRC $BKGEND";
            fi

    echo -e "$MAGBKGSTART ~~FINISHED WITH BASHRC~~ $BKGEND"
    sleep 2

#permissions setup

    echo -e "$REDBKGSTART ~~PERMISSIONS SETUP~~ $BKGEND"

        #gives permissions to $USERNAME user and group to the above created directories
            sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/
            sudo chmod -R a+rwx /home/$USERNAME
            echo -e "$BLUETXTSTART HOME PERMS SET $BKGEND";
            sudo chown -R $USERNAME:$USERNAME /run/media/$USERNAME/
            sudo chmod -R a+rwx /run/media/$USERNAME/
            echo -e "$BLUETXTSTART DEVICE PERMS SET $BKGEND";
            
        #optional plex permissions
            read -p "DID YOU CHOOSE TO INSTALL plex-media-server (y/n)?" PLEXCONFIRM
            if [ "$PLEXCONFIRM" = "y" ]; then
            sudo usermod -a -G $USERNAME plex
            echo -e "$BLUETXTSTART plex USER ADDED TO $USERNAME GROUP $BKGEND";
            else
            echo -e "$BLUETXTSTART OK, PLEX WONT BE ADDED TO ANY GROUPS $BKGEND";
            fi

    echo -e "$MAGBKGSTART ~~FINISHED PERMISSIONS SETUP~~ $BKGEND"
    sleep 2

#enable services

    echo -e "$REDBKGSTART ~~SERVICES SETUP~~ $BKGEND"

        if [ "$PLEXCONFIRM" = "y" ]; then
        sudo systemctl enable plexmediaserver.service
        echo -e "$BLUETXTSTART plexmediaservice enabled $BKGEND";
        else
        echo -e "$BLUETXTSTART NO ADDITIONAL SERVICES TO ENABLE $BKGEND";
        fi

    echo -e "$MAGBKGSTART ~~FINISHED SERVICES SETUP~~ $BKGEND"
    sleep 2

#gui customization

    echo -e "$REDBKGSTART ~~GUI CUSTOMIZATION~~ $BKGEND"

    #optional customization
            read -p "DO YOU WANT TO INSTALL GUI CUSTOMIZATIONS (y/n)?" GUICONFIRM
            if [ "$GUICONFIRM" = "y" ]; then

                #clone theming repos
                    mkdir /home/$USERNAME/GitRepos
                    cd /home/$USERNAME/GitRepos
                    git clone https://github.com/vinceliuice/Orchis-kde.git
                    git clone https://github.com/vinceliuice/Layan-kde.git
                    git clone https://github.com/yeyushengfan258/Reversal-icon-theme.git
                    echo -e "$BLUETXTSTART REPOS CLONED $BKGEND";

                #install theme related stuff
                    cd /home/$USERNAME/GitRepos/Orchis-kde/
                    ./install.sh
                    cd /home/$USERNAME/GitRepos/Layan-kde/
                    ./install.sh
                    cd /home/$USERNAME/GitRepos/Reversal-icon-theme/
                    ./install.sh
                    echo -e "$BLUETXTSTART THEMES AND ICONS INSTALLED $BKGEND";

                #download OTF fonts
                    sudo mkdir /usr/share/fonts/opentype
                    cd /usr/share/fonts/opentype
                    sudo git clone https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts.git
                    echo -e "$BLUETXTSTART FONTS INSTALLED $BKGEND";

            else
            echo -e "$BLUETXTSTART OK, NO CUSTOMIZATIONS $BKGEND";
            fi

    echo -e "$MAGBKGSTART ~~FINISHED GUI CUSTOMIZATION~~ $BKGEND"
    sleep 2

#echo the all done message

    echo -e "$BLUETXTSTART THANKS FOR USING MY SCRIPT $BKGEND";
    echo -e "$REDBKGSTART ~~AUTO SETUP COMPLETE~~ $BKGEND"
