#!/bin/bash

# Отображение номера цвета → ANSI escape-код фона / шрифта
declare -A BG_CODES=(
    [1]="\e[47m"   # white bg
    [2]="\e[41m"   # red bg
    [3]="\e[42m"   # green bg
    [4]="\e[44m"   # blue bg
    [5]="\e[45m"   # purple bg
    [6]="\e[40m"   # black bg
)

declare -A FG_CODES=(
    [1]="\e[97m"   # white fg
    [2]="\e[31m"   # red fg
    [3]="\e[32m"   # green fg
    [4]="\e[34m"   # blue fg
    [5]="\e[35m"   # purple fg
    [6]="\e[30m"   # black fg
)

declare -A COLOR_NAMES=(
    [1]="white"
    [2]="red"
    [3]="green"
    [4]="blue"
    [5]="purple"
    [6]="black"
)

RESET="\e[0m"

# Проверка аргументов скрипта
validate_args() {
    if [ "$#" -ne 4 ]; then
        echo "Error: exactly 4 numeric parameters required (1-6)." >&2
        echo "Usage: $0 <col1_bg> <col1_fg> <col2_bg> <col2_fg>" >&2
        exit 1
    fi

    local errors=()
    local params=("$@")
    local names=("Column 1 background" "Column 1 font color" "Column 2 background" "Column 2 font color")

    for i in 0 1 2 3; do
        local val="${params[$i]}"
        if ! [[ "$val" =~ ^[1-6]$ ]]; then
            errors+=("Error: ${names[$i]} value '$val' is invalid. Must be 1-6.")
        fi
    done

    if [ "${#errors[@]}" -gt 0 ]; then
        for err in "${errors[@]}"; do echo "$err" >&2; done
        exit 1
    fi

    # Проверка совпадения фона и шрифта в одном столбце
    if [ "$1" -eq "$2" ]; then
        echo "Error: Column 1 background and font color must not be the same (both are $1 — ${COLOR_NAMES[$1]})." >&2
        echo "Please re-run the script with different values." >&2
        exit 1
    fi

    if [ "$3" -eq "$4" ]; then
        echo "Error: Column 2 background and font color must not be the same (both are $3 — ${COLOR_NAMES[$3]})." >&2
        echo "Please re-run the script with different values." >&2
        exit 1
    fi
}
