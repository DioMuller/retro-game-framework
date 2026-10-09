#!/bin/bash

# Detect the operating system
# Returns:
#    os-arch string, where os is one of:
#    linux
#    macos
#    windows
#    unknown
#    and arch is one of:
#    x64
#    arm64
#    x86
#    unknown
#    For example: linux-x64, macos-arm64, windows-x86, unknown-unknown

function detect_os() {
    case $( uname | tr '[:upper:]' '[:lower:]') in
    linux*)
        OS_TYPE="linux" ;;
    darwin*)
        OS_TYPE="macos" ;;
    msys*|cygwin*|mingw*|nt|win*)
        OS_TYPE="windows" ;;
    *)
        OS_TYPE="unknown"
    esac

    case $( uname -m | tr '[:upper:]' '[:lower:]') in
    x86_64)
        ARCH_TYPE="x64" ;;
    aarch64)
        ARCH_TYPE="arm64" ;;
    i386|i686)
        ARCH_TYPE="x86" ;;
    *)
        ARCH_TYPE="unknown"
    esac

    echo "${OS_TYPE}-${ARCH_TYPE}"
}