#!/bin/bash

# Форматирование одной строки цветовой схемы
# Если значение дефолтное — выводим "default (color_name)", иначе "N (color_name)"
format_color_val() {
    local value="$1"
    local is_default="$2"
    if [ "$is_default" = true ]; then
        echo "default (${COLOR_NAMES[$value]})"
    else
        echo "$value (${COLOR_NAMES[$value]})"
    fi
}

# Вывод итоговой цветовой схемы
print_scheme() {
    local c1bg=$1 c1fg=$2 c2bg=$3 c2fg=$4

    echo "Column 1 background = $(format_color_val $c1bg $C1BG_DEFAULT)"
    echo "Column 1 font color = $(format_color_val $c1fg $C1FG_DEFAULT)"
    echo "Column 2 background = $(format_color_val $c2bg $C2BG_DEFAULT)"
    echo "Column 2 font color = $(format_color_val $c2fg $C2FG_DEFAULT)"
}
