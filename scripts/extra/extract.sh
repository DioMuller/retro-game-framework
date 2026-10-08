#!/bin/bash

# Extracts files from a compressed archive into a specified directory.
# Returns: 
#    0 if successful
#    1 if the extraction tool is not installed
#    2 if no archive file was provided
#    3 if no extraction directory was provided
#    4 if the extraction directory could not be created.

function extract() {
    ARCHIVE_FILE=$1
    EXTRACT_DIR=$2

    if [ -z "${ARCHIVE_FILE}" ]; then
        return 2
    fi

    if [ -z "${EXTRACT_DIR}" ]; then
        return 3
    fi

    # Create the extraction directory if it doesn't exist
    if [ ! -d "${EXTRACT_DIR}" ]; then
        if [ ! mkdir -p "${EXTRACT_DIR}" ]; then
            return 4
        fi
    fi

    # Extract the archive using the available tool (tar or unzip)
    if command -v unzip >/dev/null 2>&1; then
        unzip -o "${ARCHIVE_FILE}" -d "${EXTRACT_DIR}"
    elif command -v tar >/dev/null 2>&1; then
        tar -xf "${ARCHIVE_FILE}" -C "${EXTRACT_DIR}"
    else
        return 1
    fi

    return $?
}