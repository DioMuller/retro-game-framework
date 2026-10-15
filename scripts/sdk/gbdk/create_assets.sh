#!/bin/bash

PLATFORM=$1
    
if [ -z "${PLATFORM}" ]; then
    return 1
fi

PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../../.."
SPRITEDIR="${PROJECT_ROOT}/res/${PLATFORM}/sprites/"
TILEDIR="${PROJECT_ROOT}/res/${PLATFORM}/tiles/"
GENDIR="${PROJECT_ROOT}/gen/${PLATFORM}"
GBDK_HOME="${PROJECT_ROOT}/tools/sdk/gbdk"
PNG2ASSET="${GBDK_HOME}/bin/png2asset"
PATTERN="*.png"

echo "Generating assets for platform: ${PLATFORM}"
echo "Generating Sprites"
mkdir -p ${GENDIR}/sprites/
for asset in "${SPRITEDIR}"/${PATTERN}; do
    if [ -f "$asset" ]; then
        OUTPUT_FILE="${asset%.png}.c"
        NEW_FILENAME=$(basename -- "$OUTPUT_FILE")
        echo "Generating asset: ${GENDIR}/sprites/${NEW_FILENAME}"
        ${PNG2ASSET} "${asset}" -use_metafile -c "${GENDIR}/sprites/${NEW_FILENAME}"
    else
        echo "Invalid sprite file: ${asset}"
    fi
done

echo "Generating Tiles"
mkdir -p ${GENDIR}/tiles/
for asset in "${TILEDIR}"/${PATTERN}; do
    if [ -f "$asset" ]; then
    OUTPUT_FILE="${asset%.png}.c"
        OUTPUT_FILE="${asset%.png}.c"
        NEW_FILENAME=$(basename -- "$OUTPUT_FILE")
        echo "Generating asset: ${GENDIR}/tiles/${NEW_FILENAME}"
        ${PNG2ASSET} "${asset}" -use_metafile -c "${GENDIR}/tiles/${NEW_FILENAME}"
    else
        echo "Invalid tile file: ${asset}"
    fi
done