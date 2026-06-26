#!/bin/bash

# Part 3: Цветной вывод системной информации.
# Запуск: ./main.sh <col1_bg> <col1_fg> <col2_bg> <col2_fg>
# Цвета: 1-white 2-red 3-green 4-blue 5-purple 6-black

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/../02/sysinfo.sh"
source "$SCRIPT_DIR/colors.sh"
source "$SCRIPT_DIR/print_colored.sh"

validate_args "$@"
collect_info
print_colored_info "$1" "$2" "$3" "$4"
