#!/bin/bash

# Значения по умолчанию:
# Column 1 background = 6 (black)
# Column 1 font color = 1 (white)
# Column 2 background = 2 (red)
# Column 2 font color = 4 (blue)
DEFAULT_C1BG=6
DEFAULT_C1FG=1
DEFAULT_C2BG=2
DEFAULT_C2FG=4

# Глобальные флаги: была ли использована дефолтная схема
C1BG_DEFAULT=false
C1FG_DEFAULT=false
C2BG_DEFAULT=false
C2FG_DEFAULT=false

# Проверка, является ли значение допустимым (1-6)
is_valid_color() {
    [[ "$1" =~ ^[1-6]$ ]]
}

# Загрузка конфигурационного файла
load_config() {
    local config_file="$1"

    # Читаем значения из конфига, если файл существует
    if [ -f "$config_file" ]; then
        local raw_c1bg raw_c1fg raw_c2bg raw_c2fg
        raw_c1bg=$(grep -E '^column1_background=' "$config_file" | cut -d= -f2 | tr -d '[:space:]')
        raw_c1fg=$(grep -E '^column1_font_color='  "$config_file" | cut -d= -f2 | tr -d '[:space:]')
        raw_c2bg=$(grep -E '^column2_background='  "$config_file" | cut -d= -f2 | tr -d '[:space:]')
        raw_c2fg=$(grep -E '^column2_font_color='  "$config_file" | cut -d= -f2 | tr -d '[:space:]')

        if is_valid_color "$raw_c1bg"; then C1BG=$raw_c1bg; else C1BG=$DEFAULT_C1BG; C1BG_DEFAULT=true; fi
        if is_valid_color "$raw_c1fg"; then C1FG=$raw_c1fg; else C1FG=$DEFAULT_C1FG; C1FG_DEFAULT=true; fi
        if is_valid_color "$raw_c2bg"; then C2BG=$raw_c2bg; else C2BG=$DEFAULT_C2BG; C2BG_DEFAULT=true; fi
        if is_valid_color "$raw_c2fg"; then C2FG=$raw_c2fg; else C2FG=$DEFAULT_C2FG; C2FG_DEFAULT=true; fi
    else
        # Конфиг не найден — всё по умолчанию
        C1BG=$DEFAULT_C1BG; C1BG_DEFAULT=true
        C1FG=$DEFAULT_C1FG; C1FG_DEFAULT=true
        C2BG=$DEFAULT_C2BG; C2BG_DEFAULT=true
        C2FG=$DEFAULT_C2FG; C2FG_DEFAULT=true
    fi

    # Проверка коллизий (фон = шрифт в одном столбце)
    if [ "$C1BG" -eq "$C1FG" ]; then
        echo "Error: Column 1 background and font color are the same (${COLOR_NAMES[$C1BG]}). Fix config.conf." >&2
        exit 1
    fi
    if [ "$C2BG" -eq "$C2FG" ]; then
        echo "Error: Column 2 background and font color are the same (${COLOR_NAMES[$C2BG]}). Fix config.conf." >&2
        exit 1
    fi
}
