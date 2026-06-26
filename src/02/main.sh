#!/bin/bash

# Part 2: Вывод информации о системе с предложением сохранить в файл.

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/sysinfo.sh"
source "$SCRIPT_DIR/save.sh"

collect_info
print_info
ask_save
