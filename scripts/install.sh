#!/bin/bash

source "installation/emulator/install_emulicious.sh"
source "installation/extras/install_java.sh"
source "installation/sdk/install_gbdk.sh"

# Cleanup previous install
if [ -d "../tools" ]; then
    rm -rf ../tools
fi 

# Install Toolchains and Libraries
install_gbdk

# Install Emulators
install_emulicious

# Install Extras
install_java

rm -rf ../temp