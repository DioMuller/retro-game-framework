#!/bin/bash

source "sdk/install_gbdk.sh"

# Cleanup previous install
if [ -d "../tools" ]; then
    rm -rf ../tools
fi 

# Install Toolchains and Libraries
install_gbdk

# Install Emulators