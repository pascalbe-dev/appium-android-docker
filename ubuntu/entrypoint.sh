#!/usr/bin/env bash

# START VNC SERVER
vncserver :0 &
sleep 1

# START NO VNC SERVER
./noVNC/utils/launch.sh --vnc localhost:5900 &
sleep 1

# RUN GLOBAL APPIUM INSTALLATION
appium