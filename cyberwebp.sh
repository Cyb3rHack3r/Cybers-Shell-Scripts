#! /bin/sh

#define global script variables
    
    #colored text variables
        REDBKGSTART='\e[1;41m'
        BKGEND='\e[0m'

#echo script info
    echo -e "$REDBKGSTART ~~CYBERS SIMPLE DWEBP SCRIPT~~ $BKGEND"
    sleep 1

#read prompt for the user to enter iso and its desired device to be written to
    read -p "PATH TO WEBP (INCLUDE EXTENSION): " WEBPFILE
    read -p "NAME FOR OUTPUT FILE (DO NOT INCLUDE EXTENSION): " OUTPUTNAME
    echo -e "$REDBKGSTART ~~PARAMS ENTERED, BEGINNING DECODE~~ $BKGEND"

#actual dd command utilising the variables defined in the above read section
    dwebp "$WEBPFILE" -v -o $OUTPUTNAME