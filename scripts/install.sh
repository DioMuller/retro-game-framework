#!/bin/bash

source "emulator/install_emulicious.sh"
source "sdk/install_gbdk.sh"

# Cleanup previous install
if [ -d "../tools" ]; then
    rm -rf ../tools
fi 

# Install Toolchains and Libraries
install_gbdk

# Install Emulators
install_emulicious

rm -rf ../temp