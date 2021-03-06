#!/bin/bash
set -e

##------------------------------------
## Script Functions
##------------------------------------


##------------------------------------
## INDI Installation Script
##------------------------------------
if [ "`lsb_release -is`" == "Ubuntu" ]
then
        echo "[ INFO ] Adding INDI repository to Ubuntu."
        sudo apt-add-repository ppa:mutlaqja/ppa
	sudo apt-get update
	sudo apt-get install dbus-x11 -y
        echo "[ INFO ] Installing INDI Library including all 3rd party drivers."
        sudo apt-get install indi-full -y
        echo "[ INFO ] Installing latest Ekos."
        sudo apt-get install kstars-bleeding -y
	echo "[ INFO ] Done!"
else
    echo "Unsupported Operating System";
fi

exit 0
