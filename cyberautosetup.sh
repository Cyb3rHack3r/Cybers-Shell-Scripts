#! /bin/sh

<<lic
   
    #Copyright (C) 2023  Ross Thomas

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

lic

#global script variables
    
    #colored text variables
        REDBKGSTART='\e[1;41m' #variable "REDBKGSTART" equals echo text modifier red background, used at start of echo text to give it a red background
        MAGBKGSTART='\e[1;45m' #same as above but a magenta background
        BLUETXTSTART='\e[1;34m' #similar to above but blue text with no background
        BKGEND='\e[0m' #variable "BKGEND" is used at the end of echo text to close of the text effect

#script info
    echo -e "$REDBKGSTART ~~CYBERS AUTO SETUP SCRIPT~~ $BKGEND" #echos the message ~~CYBERS AUTO SETUP SCRIPT~~ with red background
    echo -e "$BLUETXTSTART Copyright (C) 2023  Ross Thomas. This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions. $BKGEND"
    sleep 3 #makes the script pause 3 seconds before moving on to next command to allow the user time to read the copyright declaration

#user setup

    echo -e "$REDBKGSTART ~~USER SETUP~~ $BKGEND"
    
    read -p "WHAT IS YOUR USERNAME? " USERNAME #displays the text asking for username, the user is then given the opertunity to enter their username which is stored as variable USERNAME
    read -p "You have entered | $USERNAME | Continue (y/n)?" NAMECHECK #similar to above but this time it stores the y/n response as variable NAMECHECK
        if [ "$NAMECHECK" = "y" ]; then #is vairable NAMECHECK equals y then do the following action
        echo -e "$BLUETXTSTART COOL USERNAME $BKGEND";
        echo -e "$MAGBKGSTART FINISHED USER SETUP $BKGEND";
        sleep 2
        else #if variable NAMECHECK does not equal y do the following action
        echo -e "$BLUETXTSTART RERUN SCRIPT TO TRY AGAIN $BKGEND";
        exit #terminate the script so the user can run it again
        fi #finishes the if else program, required at the end of if else strings

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

                    TARGETFSTAB="/etc/fstab" #defines the path to fstab, can be changed to define a practice fstab file if you dont want to test on your live fstab (a VERY good idea)
                    HOMEEXISTCHECK=/home
                    HOMEPARTLINE="$HOMEPARTDEV                                   /home                            $HOMEPARTFS                defaults                               0 0"
                    sed -i '\| /home |d' $TARGETFSTAB #read the file defined in TARGETFSTAB variable and see if it contains a line with the string "/home", if it does then it deletes that line, this stops the script from writing duplicate home mountpoints
                    echo "$HOMEPARTLINE" | sudo tee -a $TARGETFSTAB > /dev/null; #echos the text defined in variable HOMEPARTLINE, pipes this text into tee which adds the text into the file defined in TARGETFSTAB variable, must be sudo becuase fstab is a root ownd file
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
            read -p "YOU HAVE ENTERED | $FIRSTPARTDEV $FIRSTPARTFS $FIRSTPARTLAB | AND | $SECONDPARTDEV $SECONDPARTFS $SECONDPARTLAB | AS ADDITIONAL PARTITIONS Are these correct (y/n)?" ADDMARTNAMECHECK
            if [ "$ADDMARTNAMECHECK" = "y" ]; then

                #write new home location to fstab

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
        yay -S --noconfirm steam brave-bin kvantum code virtualbox virtualbox-guest-utils partitionmanager screenfetch plex-media-server htop libotf deluge #gets yay to install the first result found (-S) for each package listed and doesn't ask for y/n confirms (--noconfirm)
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
            grep -q "screenfetch" ~/.bashrc || echo "screenfetch" | sudo tee -a ~./bahsrc > /dev/null #grep searches quietly (-q) for the line "screenfetch" in the file .bashrc contained in home directory (~), if it does not detect (||) this line it will echo the string "screenfetch" and pipe it into tee to write it into .bashrc and send any prompts generated to /dev/null 
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
            sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/ #changes ownership recursively (-R) of /home/USERNAME to user user:group
            sudo chmod -R a+rwx /home/$USERNAME #modifies permissions for user home directory to add read write and execute permissions to the owner
            echo -e "$BLUETXTSTART HOME PERMS SET $BKGEND";
            sudo chown -R $USERNAME:$USERNAME /run/media/$USERNAME/
            sudo chmod -R a+rwx /run/media/$USERNAME/
            echo -e "$BLUETXTSTART DEVICE PERMS SET $BKGEND";
            
        #optional plex permissions
            read -p "DID YOU CHOOSE TO INSTALL plex-media-server (y/n)?" PLEXCONFIRM
            if [ "$PLEXCONFIRM" = "y" ]; then
            sudo usermod -a -G $USERNAME plex #adds user called "plex" to the USERNAME group (gives user plex the same permissions as the user to access your files)
            echo -e "$BLUETXTSTART plex USER ADDED TO $USERNAME GROUP $BKGEND";
            else
            echo -e "$BLUETXTSTART OK, PLEX WONT BE ADDED TO ANY GROUPS $BKGEND";
            fi

    echo -e "$MAGBKGSTART ~~FINISHED PERMISSIONS SETUP~~ $BKGEND"
    sleep 2

#enable services

    echo -e "$REDBKGSTART ~~SERVICES SETUP~~ $BKGEND"

        if [ "$PLEXCONFIRM" = "y" ]; then
        sudo systemctl enable plexmediaserver.service #enters a command in terminal as sudo to enable (turns the service on whenever user logs in) the service called plexmediaserver.service
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
                    mkdir /home/$USERNAME/GitRepos #makes a directory called GitRepos
                    cd /home/$USERNAME/GitRepos #changes the prompts location into this GitRepo directory
                    git clone https://github.com/vinceliuice/Orchis-kde.git #clones a git repo into the current directory
                    git clone https://github.com/vinceliuice/Layan-kde.git
                    git clone https://github.com/yeyushengfan258/Reversal-icon-theme.git
                    echo -e "$BLUETXTSTART REPOS CLONED $BKGEND";

                #install theme related stuff
                    cd /home/$USERNAME/GitRepos/Orchis-kde/
                    ./install.sh #runs the install script contained within the repo directory
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
