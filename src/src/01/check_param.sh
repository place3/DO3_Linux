#!/bin/bash

# Проверка корректности параметра
check_param() {
    if [ "$#" -ne 1 ]; then
        echo "Error: script requires exactly one parameter." >&2
        exit 1
    fi
}

# Вывод параметра; числовой ввод считается некорректным
print_param() {
    local param="$1"
    # Проверяем, является ли параметр числом (целым или дробным)
    if [[ "$param" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
        echo "Error: parameter must not be a number." >&2
        exit 1
    fi
    echo "$param"
}
