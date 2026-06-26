#!/bin/bash

# Part 4: Цветной вывод с настройками из конфигурационного файла.
# Запуск: ./main.sh  (без параметров)
# Настройки читаются из файла config.conf, лежащего рядом со скриптом.

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/../02/sysinfo.sh"
source "$SCRIPT_DIR/../03/colors.sh"
source "$SCRIPT_DIR/../03/print_colored.sh"
source "$SCRIPT_DIR/read_config.sh"
source "$SCRIPT_DIR/print_scheme.sh"

if [ "$#" -ne 0 ]; then
    echo "Error: this script takes no parameters. Settings are read from config.conf." >&2
    exit 1
fi

load_config "$SCRIPT_DIR/config.conf"
collect_info
print_colored_info "$C1BG" "$C1FG" "$C2BG" "$C2FG"
echo ""
print_scheme "$C1BG" "$C1FG" "$C2BG" "$C2FG"
