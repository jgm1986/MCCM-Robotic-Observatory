#!/bin/bash
set -e

MAINDIR=$(pwd)
rm -rf ~/projects/indi/3rdparty/indi-plcdome/
cp -r indi-plcdome/ ~/projects/indi/3rdparty/
cd ~/projects/indi/3rdparty/indi-plcdome/
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug .
make
sudo make install
echo "[ OK ] INDI PLC Driver copied and build in project directory."
cd $MAINDIR
