#!/bin/bash

CURRENT_LOG_LEVEL=3


function get_log_level_value_for_type() {
    if [ ! $# -eq 1 ]; then return 0; fi
    return $(
    case "$1" in
        ("CRITICAL") return 5 ;;
        ("ERROR") return 4 ;;
        ("INFO") return 3 ;;
        ("DEBUG") return 2 ;;
        ("VERBOSE") return 1 ;;
        (*) return 0 ;;
    esac)
}

function log_level() {
    if [ ! $# -eq 1 ]; then return 1; fi

    get_log_level_value_for_type "$1"
    LOG_LEVEL_VALUE=$?

    if [ "$LOG_LEVEL_VALUE" -gt 0 ]; then 
        CURRENT_LOG_LEVEL=$LOG_LEVEL_VALUE
    fi
}

function log() {
    if [ ! $# -eq 2 ]; then return 1; fi

    LOG_LEVEL=$1
    LOG_MESSAGE=$2
    
    get_log_level_value_for_type "${LOG_LEVEL}"
    LOG_LEVEL_VALUE=$?

    if [ "$LOG_LEVEL_VALUE" -ge "$CURRENT_LOG_LEVEL" ]; then 
        if [ "$LOG_LEVEL_VALUE" -lt 4 ]; then
            echo -e "$(date '+%Y-%m-%d %T') [${LOG_LEVEL}]: ${LOG_MESSAGE}"
        else
            echo 1>&2 -e "$(date '+%Y-%m-%d %T') [${LOG_LEVEL}]: ${LOG_MESSAGE}"
        fi
    fi
}
