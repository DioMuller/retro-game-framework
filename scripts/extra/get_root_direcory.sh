#!/bin/bash

function get_root_directory() {
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"    
    ROOT_DIR="$( cd "${SCRIPT_DIR}/../.." && pwd )"
    
    echo "${ROOT_DIR}"
}