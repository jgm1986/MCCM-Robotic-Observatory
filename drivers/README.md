# INDI Driver Develop

## How to build?

There are some examples of INDI drivers in this directory:

```
~/Projects/indi/libindi/examples/
```

You can compile and install one of this driver from its directory using:

```
cd ~/Projects/indi/libindi/examples/
cd tutorial_one/
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug ~/Projects/indi/libindi
sudo make install
cd ..
indiserver -v tutorial_one/simple_driver
######### TODO #########
```


## INDI Server

Launch test drivers for debug:
```
 indiserver -v -p 7624 indi_simulator_ccd indi_simulator_dome indi_simulator_focus indi_simulator_telescope indi_simulator_wheel indi_simulator_gps
```

