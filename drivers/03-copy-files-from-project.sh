#!/bin/bash
set -e

MAINDIR=$(pwd)
cp ~/projects/indi/3rdparty/indi-plcdome/CMakeLists.txt ~/MCCM-Robotic-Observatory/drivers/indi-plcdome/.
cp ~/projects/indi/3rdparty/indi-plcdome/indi_plcdome.xml.cmake ~/MCCM-Robotic-Observatory/drivers/indi-plcdome/.
cp ~/projects/indi/3rdparty/indi-plcdome/plcdomedriver.c ~/MCCM-Robotic-Observatory/drivers/indi-plcdome/.
cp ~/projects/indi/3rdparty/indi-plcdome/plcdome.h ~/MCCM-Robotic-Observatory/drivers/indi-plcdome/.
cp ~/projects/indi/3rdparty/indi-plcdome/config.h.cmake ~/MCCM-Robotic-Observatory/drivers/indi-plcdome/.
cp ~/projects/indi/3rdparty/indi-plcdome/plcdome.cpp ~/MCCM-Robotic-Observatory/drivers/indi-plcdome/.
cp ~/projects/indi/3rdparty/indi-plcdome/plcdomedriver.h ~/MCCM-Robotic-Observatory/drivers/indi-plcdome/.
echo "[ OK ] INDI PLC Driver copied from project directory to repository directory."
cd $MAINDIR
