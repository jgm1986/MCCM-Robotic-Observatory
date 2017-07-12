#!/bin/bash
set -e

sudo apt-get install git -y

##------------------------------------
## Packages required by INDI
## http://indilib.org/develop/developer-manual/163-setting-development-environment.html
##------------------------------------
sudo apt-get install qtcreator -y
sudo apt-get install libnova-dev libcfitsio3-dev libusb-1.0-0-dev zlib1g-dev libgsl0-dev build-essential cmake git libjpeg-dev libcurl4-gnutls-dev kdesudo -y
sudo apt-get install libftdi-dev libgps-dev dcraw libgphoto2-dev libboost-dev libboost-regex-dev -y

# Projects directory
mkdir ~/projects
cd ~/projects
git clone https://github.com/indilib/indi.git
cd indi
git checkout tags/v1.4.1

# Console Build
MAINDIR=$(pwd)
mkdir -p build/libindi
cd build/libindi
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug ../../libindi
make
sudo make install

cd $MAINDIR
cd build
mkdir indi-eqmod
cd indi-eqmod
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug ../../3rdparty/indi-eqmod
make
sudo make install
echo "[ OK ] INDI installed."
cd $MAINDIR
