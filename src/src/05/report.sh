#!/bin/bash

print_report() {
    local dir="$1"
    local elapsed="$2"
    local idx

    echo "Total number of folders (including all nested ones) = $TOTAL_FOLDERS"

    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    idx=1
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        echo "$idx - $line"
        (( idx++ ))
    done <<< "$TOP5_FOLDERS"

    echo "Total number of files = $TOTAL_FILES"

    echo "Number of:"
    echo "  Configuration files (with the .conf extension) = $COUNT_CONF"
    echo "  Text files = $COUNT_TEXT"
    echo "  Executable files = $COUNT_EXEC"
    echo "  Log files (with the extension .log) = $COUNT_LOG"
    echo "  Archive files = $COUNT_ARCH"
    echo "  Symbolic links = $COUNT_SYMLINK"

    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    idx=1
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        echo "$idx - $line"
        (( idx++ ))
    done <<< "$TOP10_FILES"

    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    idx=1
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        echo "$idx - $line"
        (( idx++ ))
    done <<< "$TOP10_EXEC"

    echo "Script execution time (in seconds) = $elapsed"
}
