#!/bin/sh

get_sh_files() {
    local fls=$(find . -type f -name "*.sh")
    echo "$fls"
}

format_shs() {
    local fls="$@"
    for f in $fls; do
        sed -i "s/\t/    /g" $f
    done
}

main() {
    local fls=$(get_sh_files)
    format_shs "$fls"
}

main
