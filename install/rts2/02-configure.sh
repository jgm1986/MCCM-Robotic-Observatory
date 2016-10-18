#!/bin/bash
set -e

##------------------------------------
## Script Functions
##------------------------------------

# This function checks if downloads directory exists before continue.
function check_downloads_dir(){
	if [ ! -d downloads ] ; then
		echo "[ WARNING ] Execute the following script before: 01-install.sh"
		echo "[ ERROR ] The 'downloads' directory doesn't exists."
		exit 0
	fi
	cd downloads
	echo "[ OK ]"
}

# Check if the rts2 repository directory exists inside downloads directory.
function move_inside_rts2(){
	if [ ! -d rts2 ] ; then
                echo "[ ERROR ] A problem has been found during 'rts2' directory detection."
		echo "[ INFO ] Please execute the following script for fix it: 01-install.sh"
                exit 0
        fi
        cd rts2
	echo "[ OK ]"
}

# Creating and populating /etc/rts2 directory for rts2 configuration files.
function create_rts2_dir(){
	if [ -d /etc/rts2 ] ; then
                echo "[ WARNING ] Your system contains an /etc/rts2 directory. This script will be remove it automatically."
		sudo rm -rf /etc/rts2
		echo "[ DONE ]"
        fi
	sudo ./rts2-init
	echo "[ OK ]"
}

# Configure the configuration file with the custom user values.
function rts2_config_values(){
	sudo cp /etc/rts2/rts2.ini /etc/rts2/rts2.ini.original  # Backup original configuration file.
        sudo sed -i '/altitude = xxxx/c\altitude = 900' /etc/rts2/rts2.ini
	sudo sed -i '/longitude = xxxx/c\longitude = -2' /etc/rts2/rts2.ini
	sudo sed -i '/latitude = xxxx/c\latitude = 40' /etc/rts2/rts2.ini
	sudo sed -i '/origin = "XXXXX"/c\origin = "Science Museum of Castilla-La Mancha"' /etc/rts2/rts2.ini
	echo "[ OK ]"
}

# Prepare database for RTS2 user.
function prepare_db(){
	sudo -H -u postgres bash -c 'createuser --interactive $USER'
	echo "[ OK ]"
}

# This function creates a stars database.
function create_db_stars(){
	createdb stars # you must be user which have granted database access
	cd rts2/src/sql
	./rts2-builddb stars
	cd ../../
	echo "[ OK ]"
}

# This function is used for RTS2 configuration with dummy devices.
function dummy_devices_conf(){
	cd src/sql/data
	psql stars < dummy.sql
	echo "[ OK ]"
}


##------------------------------------
## RTS2 Configuration Script
##------------------------------------
if [ "`lsb_release -is`" == "Ubuntu" ]
then
        echo "[ INFO ] Checking downloads directory."
        check_downloads_dir
        echo "[ INFO ] Moving inside RTS2 repository."
        move_inside_rts2
        echo "[ INFO ] Creating RTS2 system directory."
        create_rts2_dir
	echo "[ INFO ] Setting configuration fields using user values."
	rts2_config_values
	echo "[ INFO ] Preparing database."
	prepare_db
	echo "[ INFO ] Creating Stars database."
	create_db_stars
	echo "[ INFO ] If you want to roun RTS2 with dummy devices."
	dummy_devices_conf
	echo "[ INFO ] Test RTS2."
	rts2-targetinfo 1
else
	echo "[ ERROR ] Unsupported Operating System. This script only runs over Ubuntu 16.04."
fi

exit 0
