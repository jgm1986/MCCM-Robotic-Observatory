#!/bin/bash
set -e

##------------------------------------
## Packages required by INDI
## http://indilib.org/develop/developer-manual/163-setting-development-environment.html
##------------------------------------
sudo apt-get install qtcreator -y
sudo apt-get install libnova-dev libcfitsio3-dev libusb-1.0-0-dev zlib1g-dev libgsl0-dev build-essential cmake git libjpeg-dev libcurl4-gnutls-dev -y

# Projects directory
mkdir ~/Projects
cd ~/Projects
git clone https://github.com/indilib/indi.git

# Console Build
mkdir -p ~/Projects/build/libindi
cd ~/Projects/build/libindi
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug ~/Projects/indi/libindi
sudo make install

echo "[ OK ] INDI development environment installed."
