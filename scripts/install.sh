#!/bin/bash

source "installation/emulator/install_emulicious.sh"
source "installation/extras/install_java.sh"
source "installation/sdk/install_gbdk.sh"
source "util/log.sh"

log_level INFO
log INFO "Starting Installation"

log INFO "Cleaning Previous instalation"
# Cleanup previous install
if [ -d "../tools" ]; then
    rm -rf ../tools
fi 

# Install Toolchains and Libraries
log INFO "Installing GBDK"
install_gbdk

# Install Emulators
log INFO "Installing Emulicious"
install_emulicious

# Install Extras
log INFO "Installing OpenJDK"
install_java

log INFO "Cleaning up temporary files"
rm -rf ../temp