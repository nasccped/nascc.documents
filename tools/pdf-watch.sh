#!/bin/sh

# This script is used for typst fast reload. It'll place the generated pdf at
# temp directory

RESET="\e[0m"
RED="\e[91m"

ENGL_PATH="en"

WATCH_DEST=./temp/temp.pdf

SH_PATH=$(dirname $0)
ROOT_PATH="."

abort() {
    echo "Aborting..."
    exit 1
}

get_template_file() {
    local temp=$(<./tools/template.typ)
    echo "$temp"
}

watch_pdf() {
    local input="$@"
    if [ ! -d "$(dirname $WATCH_DEST)" ]; then
        mkdir "temp"
    fi
    echo "$input" | typst watch - $WATCH_DEST
}

main() {
    if [ "$SH_PATH" == "$ROOT_PATH" ]; then
        echo -e "The script should be ran from ${RED}the root${RESET} path!"
        abort
    fi
    watch_pdf "$(get_template_file | sed "s/<LANGUAGE>/$ENGL_PATH/g")"
}

main
