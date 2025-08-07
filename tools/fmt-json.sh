#!/bin/sh

INDENT_VAL=4

report_and_abort() {
  echo "Failed to format '$1' file"
  echo "Aborting..."
  exit 1
}

get_json_files() {
    local fls=$(find . -type f -name "*.json")
    echo $fls
}

format_json_files() {
    local fls="$@"
    for f in $fls; do
        jq . $f > "$f.bak" && mv "$f.bak" "$f"
        if [ $? -ne 0 ]; then
            report_and_abort $f
        fi
    done
}

main() {
    local fls=$(get_json_files)
    format_json_files "$fls"
}

main
