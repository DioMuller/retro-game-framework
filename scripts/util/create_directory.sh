#!/bin/bash

# Recursively creates all the directories on a given path
# Returns:
#    Success if directories were created

function create_directory() {
    DIRECTORY=$1
    
    if [ -z "${DIRECTORY}" ]; then
        return 1
    fi

    mkdir -p "${DIRECTORY}"

    return $?
}