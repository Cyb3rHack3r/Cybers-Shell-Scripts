#! /bin/sh

#echo script info
    echo "## AUTOMATIC SETUP SCRIPT ##"
    echo "## CREATED ON -- 10 DECEMBER 2023 ##"
    echo "## LAST UPDATED ON -- 11 DECEMBER 2023 ##"
    sleep 4

#install desired packages with yay
    yay -S --noconfirm steam brave-bin kvantum code virtualbox virtualbox-guest-utils partitionmanager screenfetch plex-media-server htop
    echo "### ALL PACKAGES INSTALLED...MOVING ON ###"
    sleep 4

#add items to .bashrc
    echo 'screenfetch' >> ~/.bashrc
    echo "sudo sudo mount /dev/sdc1" >> ~/.bashrc
    echo "### ALL LINES ADDED TO .BASHRC...MOVING ON ###"
    sleep 4

#sets up drive mounts and permissions

    #makes mounting directories"
        sudo mkdir /run/media/cyberhacker/mntsda3
        sudo mkdir /run/media/cyberhacker/mntsdb2
        sudo mkdir /run/media/cyberhacker/mntppd
        echo "### ALL MOUNTING POINTS MADE...MOVING ON ###"
        sleep 4

    #gives permissions to cyberhacker user and group to the above created directories
        sudo chown -R cyberhacker:cyberhacker /run/media/cyberhacker/
        sudo chmod -R a+rwx /run/media/cyberhacker/

            #adds user plex to group cyberhacker
                sudo usermod -a -G cyberhacker plex 

        echo "### ALL PERMISSIONS GIVEN TO MOUNTS...MOVING ON ###"
        sleep 4

    #mounts disks to mount points

        #mounts sda3 "game storage drive"
            echo '/dev/sda3                                   /run/media/cyberhacker/mntsda3   btrfs                defaults                               0 0' >> /etc/fstab

        #mounts sdb2 "redoubt drive"
            echo '/dev/sdb2                                   /run/media/cyberhacker/mntsdb2   btrfs                defaults                               0 0' >> /etc/fstab

        echo "### ALL MOUNTS MOUNTED...MOVING ON ###"
        sleep 4

    echo "### DRIVE MOUNTING AND PERMISSIONS COMPLETE...MOVING ON ###"
    sleep 4

#commands to be run in terminal
    sudo systemctl enable plexmediaserver.service
    sudo sudo mount /dev/sdc1
    echo "### ALL COMMANDS RAN...MOVING ON ###"
    sleep 4
    
#echo the all done message

    sleep 2
    echo "### ALL DONE!!! ###"
