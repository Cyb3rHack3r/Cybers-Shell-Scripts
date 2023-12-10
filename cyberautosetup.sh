#! /bin/sh

#echo script info
    echo "## AUTOMATIC SETUP SCRIPT ##"
    echo "## CREATED ON -- 10 DECEMBER 2023 ##"
    echo "## LAST UPDATED ON -- 10 DECEMBER 2023 ##"
    sleep 4

#install desired packages with yay
    yay -S --noconfirm steam brave-bin kvantum code virtualbox virtualbox-guest-utils partitionmanager screenfetch
    echo "### ALL PACKAGES INSTALLED...MOVING ON ###"

#add items to .bashrc
    echo 'screenfetch' >> ~/.bashrc