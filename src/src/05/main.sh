#!/bin/bash

# Part 5: Анализ содержимого директории.
# Запуск: ./main.sh /path/to/dir/

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/validate.sh"
source "$SCRIPT_DIR/fs_info.sh"
source "$SCRIPT_DIR/report.sh"

START_TIME=$(date +%s%N)

validate_input "$@"
TARGET_DIR="$1"

collect_fs_info "$TARGET_DIR"

END_TIME=$(date +%s%N)
ELAPSED=$(awk "BEGIN{printf \"%.1f\", ($END_TIME - $START_TIME)/1000000000}")

print_report "$TARGET_DIR" "$ELAPSED"
