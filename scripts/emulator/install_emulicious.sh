#!/bin/bash

# Installs the Emulicious emulator for GB/GBC/GG/SMS/NES/MSX tests.
function install_emulicious() {
    ########################################################
    # Includes
    ########################################################
    SCRIPT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

    source "${SCRIPT_ROOT}/util/download_and_extract.sh"
    source "${SCRIPT_ROOT}/util/get_root_direcory.sh"

    ########################################################
    # Constants
    ########################################################
    PROJECT_HOME=$( get_root_directory )
    EMULICIOUS_URL="https://emulicious.net/Emulicious.zip"

    ########################################################
    # Download and Install Emulicious
    ########################################################
    download_and_extract "${EMULICIOUS_URL}" "${PROJECT_HOME}/tools/emulators/emulicious/"
    return $?
}