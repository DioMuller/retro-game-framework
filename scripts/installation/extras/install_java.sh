#!/bin/bash

function install_java() {
    ########################################################
    # Includes
    ########################################################
    SCRIPT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../.."

    source "${SCRIPT_ROOT}/util/download_and_extract.sh"
    source "${SCRIPT_ROOT}/util/get_root_direcory.sh"

    ########################################################
    # Constants
    ########################################################
    PROJECT_HOME=$( get_root_directory )

    if [ "${CURRENT_OS}" = "linux-x64" ]; then
        JAVA_URL="https://download.java.net/java/GA/jdk27/55ce5470a6294008af0057ff4626d0e5/35/GPL/openjdk-27_linux-x64_bin.tar.gz"
    elif [ "${CURRENT_OS}" = "linux-arm64" ]; then
        JAVA_URL="https://download.java.net/java/GA/jdk27/55ce5470a6294008af0057ff4626d0e5/35/GPL/openjdk-27_linux-x64_bin.tar.gz"
    elif [ "${CURRENT_OS}" = "macos-arm64" ]; then
        JAVA_URL="https://download.java.net/java/GA/jdk27/55ce5470a6294008af0057ff4626d0e5/35/GPL/openjdk-27_macos-aarch64_bin.tar.gz"
    elif [ "${CURRENT_OS}" = "windows-x64" ]; then
        JAVA_URL="https://download.java.net/java/GA/jdk27/55ce5470a6294008af0057ff4626d0e5/35/GPL/openjdk-27_windows-x64_bin.zip"
    else
        echo "Operating system not supported for Java installation: ${CURRENT_OS}"
        echo "Supported operating systems are: Linux x64 and ARM64, MacOS x64 and ARM64, and Windows x86 and x64."
        return 1
    fi



    ########################################################
    # Download and Install Emulicious
    ########################################################
    download_and_extract "${JAVA_URL}" "${PROJECT_HOME}/tools/extras/"
    return $?
}