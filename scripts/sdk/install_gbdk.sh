#!/bin/bash

# Installs the GBDK toolchain for GB/GBC/GG/SMS/NES/MSX development.
function install_gbdk() {
    ########################################################
    # Includes
    ########################################################
    SCRIPT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

    source "${SCRIPT_ROOT}/util/detect_os.sh"
    source "${SCRIPT_ROOT}/util/download_and_extract.sh"
    source "${SCRIPT_ROOT}/util/get_root_direcory.sh"

    ########################################################
    # Constants
    ########################################################
    CURRENT_OS=$( detect_os )
    PROJECT_HOME=$( get_root_directory )

    if [ "${CURRENT_OS}" = "linux-x64" ]; then
        GBDK_URL="https://github.com/gbdk-2020/gbdk-2020/releases/latest/download/gbdk-linux64.tar.gz"
    elif [ "${CURRENT_OS}" = "linux-arm64" ]; then
        GBDK_URL="https://github.com/gbdk-2020/gbdk-2020/releases/download/4.4.0/gbdk-linux-arm64.tar.gz"
    elif [ "${CURRENT_OS}" = "macos-x64" ]; then
        GBDK_URL="https://github.com/gbdk-2020/gbdk-2020/releases/latest/download/gbdk-macos.tar.gz"
    elif [ "${CURRENT_OS}" = "macos-arm64" ]; then
        GBDK_URL="https://github.com/gbdk-2020/gbdk-2020/releases/latest/download/gbdk-macos-arm64.tar.gz"
    elif [ "${CURRENT_OS}" = "windows-x86" ]; then
        GBDK_URL="https://github.com/gbdk-2020/gbdk-2020/releases/latest/download/gbdk-win32.zip"
    elif [ "${CURRENT_OS}" = "windows-x64" ]; then
        GBDK_URL="https://github.com/gbdk-2020/gbdk-2020/releases/latest/download/gbdk-win64.zip"
    else
        echo "Operating system not supported for GBDK installation: ${CURRENT_OS}"
        echo "Supported operating systems are: Linux x64 and ARM64, MacOS x64 and ARM64, and Windows x86 and x64."
        return 1
    fi

    ########################################################
    # Download and Install GBDK
    ########################################################
    download_and_extract "${GBDK_URL}" "${PROJECT_HOME}/tools/sdk/"
    return $?
}