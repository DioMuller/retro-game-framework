#!/bin/bash

########################################################
# Includes
########################################################
source "../extra/detect_os.sh"
source "../extra/download.sh"
source "../extra/extract.sh"
source "../extra/get_root_direcory.sh"

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
    exit 1
fi


########################################################
# Setup Directories
########################################################

# Create Temp directory if it doesn't exist
if [ ! -d "${PROJECT_HOME}/temp" ]; then
    echo "Creating temp directory..."
    mkdir "${PROJECT_HOME}/temp"
fi 

# Create Tools directory if it doesn't exist
if [ ! -d "${PROJECT_HOME}/tools" ]; then
    echo "Creating tools directory..."
    mkdir "${PROJECT_HOME}/tools"
fi 

# Create SDK directory if it doesn't exist
if [ ! -d "${PROJECT_HOME}/tools/sdk" ]; then
    echo "Creating SDK directory..."
    mkdir "${PROJECT_HOME}/tools/sdk"
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
        exit 1
    fi

else
    echo "Error downloading GBDK from ${GBDK_URL}"
    exit 1
fi

########################################################
# Cleanup
########################################################

rm -rf "${PROJECT_HOME}/temp"