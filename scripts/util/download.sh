#!/bin/bash

# Downloads from link passed to parameter, on the specified directory.
# Returns: 
#    0 if successful, 
#    1 if curl or wget is not installed
#    2 if no download URL was provided 
#    3 if no download directory was provided
#    4 if the download directory could not be created.

function download() {
    DOWNLOAD_URL=$1
    DOWNLOAD_DIR=$2

    if [ -z "${DOWNLOAD_URL}" ]; then
        return 2
    fi

    if [ -z "${DOWNLOAD_DIR}" ]; then
        return 3
    fi

    # Create the download directory if it doesn't exist
    if [ ! -d "${DOWNLOAD_DIR}" ]; then
        if [ ! mkdir -p "${DOWNLOAD_DIR}" ]; then
            return 4
        fi
    fi

    # Download the file using curl or wget
    if command -v curl >/dev/null 2>&1; then
        curl -fL --retry 10 "${DOWNLOAD_URL}" -o "${DOWNLOAD_DIR}/$(basename ${DOWNLOAD_URL})"
    elif command -v wget >/dev/null 2>&1; then
        wget "${DOWNLOAD_URL}" -O "${DOWNLOAD_DIR}/$(basename ${DOWNLOAD_URL})"
    else
        return 1
    fi

    return $?
}