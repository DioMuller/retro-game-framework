#!/bin/bash

# Downloads from link passed to parameter, and extracts on given directory.
# Returns: 
#    0 if successful, 
#    1 if download or extraction tool is not installed
#    2 if no download URL was provided or the download URL is invalid 
#    3 if no extraction directory was provided
#    4 if the temporary or extraction directory could not be created.

function download_and_extract() {
    SCRIPT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source "${SCRIPT_ROOT}/create_directory.sh"
    source "${SCRIPT_ROOT}/download.sh"
    source "${SCRIPT_ROOT}/extract.sh"
    source "${SCRIPT_ROOT}/get_root_direcory.sh"


    DOWNLOAD_URL=$1
    EXTRACT_DIR=$2
    PROJECT_HOME=$( get_root_directory )

    # Check for the parameters
    if [ -z "${DOWNLOAD_URL}" ]; then
        return 2
    fi

    if [ -z "${EXTRACT_DIR}" ]; then
        return 3
    fi

    # Create the temporary and extraction directories if they don't exist
    if [ ! -d "${PROJECT_HOME}/temp" ]; then
        create_directory "${PROJECT_HOME}/temp"
        if [ $? -ne 0 ]; then
            return 4
        fi
    fi

    if [ ! -d "${EXTRACT_DIR}" ]; then
        create_directory "${EXTRACT_DIR}"
        if [ $? -ne 0 ]; then
            return 4
        fi
    fi

    # Dowload and extract the archive
    download "${DOWNLOAD_URL}" "${PROJECT_HOME}/temp"
    ret=$?
    if [ $? -eq 0 ]; then
        extract "${PROJECT_HOME}/temp/$(basename ${DOWNLOAD_URL})" "${EXTRACT_DIR}"
        return $?
    else
        return $ret
    fi

    return $?
}