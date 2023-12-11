#! /bin/sh

#define global script variables
    
    #colored text variables
        REDBKGSTART='\e[1;41m'
        BKGEND='\e[0m'

#echo script info
    echo -e "$REDBKGSTART ~~CYBERS SIMPLE DD SCRIPT~~ $BKGEND"
    sleep 3

#read prompt for the user to enter iso and its desired device to be written to
    read -p "PATH TO ISO: " ISOFILE
    read -p "PATH TO DEVICE: " DEVICE
    echo -e "$REDBKGSTART ~~PARAMS ENTERED, BEGINNING WRITE~~ $BKGEND"

#actual dd command utilising the variables defined in the above read section
    sudo dd if="$ISOFILE" of="$DEVICE" bs=1M