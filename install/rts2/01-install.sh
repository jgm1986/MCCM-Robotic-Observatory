#!/bin/bash
set -e

##------------------------------------
## Script Functions
##------------------------------------

# This function install all packages needed for the RTS2 installation.
function ubuntu_dependencies(){
	sudo apt-get update
	sudo apt-get install libtool -y
	sudo apt-get install git postgresql postgresql-server-dev-9.5 libecpg-dev automake libtool libcfitsio3-dev libnova-dev libecpg-dev gcc g++ libncurses5-dev libgraphicsmagick++1-dev libx11-dev docbook-xsl xsltproc libxml2-dev libarchive-dev libjson-glib-dev libsoup2.4-dev pkg-config -y
}


# This function creates a new download directory used during the
# installation process.
function check_downloads_dir(){
	pwd_dir=$(pwd)
	echo $pwd_dir
	if [ -d downloads ] ; then
		echo "[ INFO ] Deleting previous downloads folder..."
		sudo rm -r downloads
		echo "[ OK ]"
	fi
	mkdir downloads
	cd downloads
}

# Steps used for WCSTools installation.
function install_wcstools(){
	wget http://tdc-www.harvard.edu/software/wcstools/wcstools-3.9.4.tar.gz
	tar xzf wcstools-3.9.4.tar.gz
	cd wcstools-3.9.4/
	# Check if the current machine runs in 64bits architecture.
	MACHINE_TYPE=`uname -m`
	if [ ${MACHINE_TYPE} == 'x86_64' ]; then
		# 64-bit
		echo "[ INFO ] This machine runs over 64bits architecture. Setting flags..."
		sed -i '/CFLAGS= -g -D_FILE_OFFSET_BITS=64/c\CFLAGS= -g -fPIC -D_FILE_OFFSET_BITS=64 ' libwcs/Makefile
		echo "[ OK ]"
	else
		# 32-bit
		echo "[ INFO ] This machine runs over 32bits architecture. No changes needed."
	fi
	make
	cd libwcs
	if [ -d /usr/local/include/wcstools ] ; then
                echo "[ INFO ] Deleting previous WCSTools folder..."
                sudo rm -r /usr/local/include/wcstools
                echo "[ OK ]"
        fi
	sudo mkdir /usr/local/include/wcstools
	sudo cp *.h /usr/local/include/wcstools/
	sudo cp libwcs.a /usr/local/lib/libwcstools.a
	cd ..
	cd ..
	echo "[ OK ] WCSTools installation completed."
}


# Commands used for RTS2 installation.
function install_rts2(){
	git clone https://github.com/RTS2/rts2.git
	cd rts2
	./autogen.sh
	./configure
	aclocal
	automake --add-missing
	autoconf
	autoheader
	./configure
	make
	sudo make install
	echo "[ OK ] RTS2 installation completed."
}



##------------------------------------
## RTS2 Installation Script
##------------------------------------
if [ "`lsb_release -is`" == "Ubuntu" ]
then
        echo "[ INFO ] Installing Ubuntu dependencies."
        ubuntu_dependencies
        echo "[ INFO ] Creating a new directory for downloads."
        check_downloads_dir
        echo "[ INFO ] Installing WCSTools."
        install_wcstools
        echo "[ INFO ] Installing RTS2."
        install_rts2
	echo "[ INFO ] Please continue with configuration process..."
else
	echo "[ ERROR ] Unsupported Operating System. This script only runs over Ubuntu 16.04."
fi

exit 0
