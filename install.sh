#!/bin/bash

# Ensure we have the right permissions
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo or as root.. requesting..." 1>&2
   sudo ./install.sh
   exit 0
fi

MTASC_BINARY="mtasc"
STD_DIRECTORY="std"
STD8_DIRECTORY="std8"

if [ -f "bin/mtasc" ]; then
    MTASC_BINARY="bin/mtasc"
    STD_DIRECTORY="bin/std"
    STD8_DIRECTORY="bin/std8"
fi

# Clean up previous installation
/usr/bin/sudo rm -rf /usr/local/share/mtasc

# Create directory
/usr/bin/sudo mkdir -p /usr/local/share/mtasc

# Copy files
/usr/bin/sudo cp $MTASC_BINARY /usr/local/share/mtasc/mtasc
/usr/bin/sudo cp -r $STD_DIRECTORY /usr/local/share/mtasc/std
/usr/bin/sudo cp -r $STD8_DIRECTORY /usr/local/share/mtasc/std8

# Clean up previous symlink
/usr/bin/sudo rm /usr/local/bin/mtasc

# Create symlink
/usr/bin/sudo ln -s /usr/local/share/mtasc/mtasc /usr/local/bin/mtasc

echo "Installed into /usr/local/share/mtasc, symlinked to /usr/local/bin/mtasc"

mtasc --help