#!/usr/bin/env bash

# transcode-fansubs
# This script looks for files with the [1080p] tag and attempts to convert them
# to h265.

UNIXTIME=`date +%s`
NEW_FILENAME="${PREFIX}${UNIXTIME}-${RANDOM}.${DOTS_EXTENSION}"

# Convert using CPU / libx265
function convertCPU() {
    INPUT="$1"
    FILENAME=$(basename -- "${INPUT}" | sed 's/\[1080p\]//g')

    # If you need only the "name" and none of the parts after the first dot, use this.
    # Ex: sample.tar.gz = sample and .tar.gz
    DOTS_FILENAME="${FILENAME%%.*}"
    DOTS_EXTENSION="${FILENAME#*.}"

    # If you need the correct filename and extension, use this.
    # Ex: sample.tar.gz = sample.tar and .gz
    PROPER_EXTENSION="${FILENAME##*.}"
    PROPER_FILENAME="${FILENAME%.*}"

    OUTPUT="${DOTS_FILENAME}[h265].mkv"
    echo "Converting: ${INPUT} -> ${OUTPUT}"
    dumb-init time ffmpeg -i "${INPUT}" -c:v libx265 -pix_fmt yuv420p10le -crf 24 \
        -c:a copy "${OUTPUT}" -loglevel warning -hide_banner -stats && \
        sync && \
        rm "${INPUT}" && \
        echo "Conversion complete for: ${OUTPUT}"

    
}

for f in *.mkv; do
    convertCPU "$f"
done
sync
