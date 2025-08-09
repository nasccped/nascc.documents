#!/bin/sh

# This script is used for typst fast reload. It'll place the generated pdf at
# temp directory. Should be ran from the root directory

RED="\e[91m"
GREEN="\e[92m"
RESET="\e[0m"

ENGL_PATH="en"

WATCH_DEST=./temp/temp.pdf

SH_PATH=$(dirname $0)
ROOT_PATH="."

LAST_CHECKSUM="..."

abort() {
    echo "Aborting..."
    exit 1
}

get_template_file() {
    local temp=$(<./tools/template.typ)
    echo "$temp"
}

watch_pdf() {
    if [ ! -d "$(dirname $WATCH_DEST)" ]; then
        mkdir "temp"
    fi
    while true; do
        CURRENT_CHECKSUM=$(md5sum "./tools/template.typ" | awk '{print $1}')
        if [ "$CURRENT_CHECKSUM" != "$LAST_CHECKSUM" ]; then
            echo "$(get_template_file)" \
                | sed "s/<LANGUAGE>/$ENGL_PATH/g" \
                | typst compile - $WATCH_DEST
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Successfully compiled$RESET ($(date +"%H:%M:%S"))"
            else
                echo -e "${RED}Compilation failed$RESET ($(date +"%H:%M:%S")). Fix the errors..."
            fi
            LAST_CHECKSUM="$CURRENT_CHECKSUM"
        fi
        sleep 1
    done
}

main() {
    if [ "$SH_PATH" == "$ROOT_PATH" ]; then
        echo -e "The script should be ran from ${RED}the root${RESET} path!"
        abort
    fi
    watch_pdf
}

main
