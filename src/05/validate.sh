#!/bin/bash

validate_input() {
    if [ "$#" -ne 1 ]; then
        echo "Error: exactly one parameter required — path to a directory." >&2
        echo "Usage: $0 /path/to/dir/" >&2
        exit 1
    fi

    local path="$1"

    # Параметр должен заканчиваться на '/'
    if [[ "$path" != */ ]]; then
        echo "Error: path must end with '/'. Example: $0 /var/log/" >&2
        exit 1
    fi

    # Директория должна существовать
    if [ ! -d "$path" ]; then
        echo "Error: directory '$path' does not exist." >&2
        exit 1
    fi
}
