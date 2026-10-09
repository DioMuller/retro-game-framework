#!/bin/bash

########################################################
# Includes
########################################################

SCRIPT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${SCRIPT_ROOT}/../../util/create_directory.sh"
source "${SCRIPT_ROOT}/../../util/detect_os.sh"
source "${SCRIPT_ROOT}/../../util/download.sh"
source "${SCRIPT_ROOT}/../../util/extract.sh"
source "${SCRIPT_ROOT}/../../util/get_root_direcory.sh"

function install_gbdk() {
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
    # Setup Directories
    ########################################################

    echo ${PROJECT_HOME}
    # Create Temp directory if it doesn't exist
    if [ ! -d "${PROJECT_HOME}/temp" ]; then
        echo "Creating Temp directory..."
        create_directory "${PROJECT_HOME}/temp"
    fi 

    if [ ! -d "${PROJECT_HOME}/tools/sdk" ]; then
        echo "Creating SDK directory..."
        create_directory "${PROJECT_HOME}/tools/sdk"
    fi

    ########################################################
    # Download and Install GBDK
    ########################################################

    download "${GBDK_URL}" "${PROJECT_HOME}/temp"
    if [ $? -eq 0 ]; then
        echo "GBDK downloaded successfully. Extracting..."

        extract "${PROJECT_HOME}/temp/$(basename ${GBDK_URL})" "${PROJECT_HOME}/tools/sdk/"
        if [ $? -eq 0 ]; then
            echo "GBDK extracted successfully."
        else
            echo "Error extracting GBDK."
            return 1
        fi

    else
        echo "Error downloading GBDK from ${GBDK_URL}"
        return 1
    fi

    ########################################################
    # Cleanup
    ########################################################

    rm -rf "${PROJECT_HOME}/temp"

    return 0
}