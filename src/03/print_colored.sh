#!/bin/bash

# Вывод одной строки: цветное имя = цветное значение
print_line() {
    local key="$1"
    local value="$2"
    local col1_bg="$3"
    local col1_fg="$4"
    local col2_bg="$5"
    local col2_fg="$6"

    printf "${BG_CODES[$col1_bg]}${FG_CODES[$col1_fg]}%s${RESET}" "$key"
    printf " = "
    printf "${BG_CODES[$col2_bg]}${FG_CODES[$col2_fg]}%s${RESET}\n" "$value"
}

# Печать всей информации о системе в цвете
print_colored_info() {
    local c1bg=$1 c1fg=$2 c2bg=$3 c2fg=$4

    print_line "HOSTNAME"       "$HOSTNAME"               $c1bg $c1fg $c2bg $c2fg
    print_line "TIMEZONE"       "$TIMEZONE"               $c1bg $c1fg $c2bg $c2fg
    print_line "USER"           "$USER_NAME"              $c1bg $c1fg $c2bg $c2fg
    print_line "OS"             "$OS"                     $c1bg $c1fg $c2bg $c2fg
    print_line "DATE"           "$DATE"                   $c1bg $c1fg $c2bg $c2fg
    print_line "UPTIME"         "$UPTIME_STR"             $c1bg $c1fg $c2bg $c2fg
    print_line "UPTIME_SEC"     "$UPTIME_SEC_VAL"         $c1bg $c1fg $c2bg $c2fg
    print_line "IP"             "$IP_ADDR"                $c1bg $c1fg $c2bg $c2fg
    print_line "MASK"           "$MASK"                   $c1bg $c1fg $c2bg $c2fg
    print_line "GATEWAY"        "$GATEWAY"                $c1bg $c1fg $c2bg $c2fg
    print_line "RAM_TOTAL"      "$RAM_TOTAL_GB GB"        $c1bg $c1fg $c2bg $c2fg
    print_line "RAM_USED"       "$RAM_USED_GB GB"         $c1bg $c1fg $c2bg $c2fg
    print_line "RAM_FREE"       "$RAM_FREE_GB GB"         $c1bg $c1fg $c2bg $c2fg
    print_line "SPACE_ROOT"     "$SPACE_ROOT_MB MB"       $c1bg $c1fg $c2bg $c2fg
    print_line "SPACE_ROOT_USED" "$SPACE_ROOT_USED_MB MB" $c1bg $c1fg $c2bg $c2fg
    print_line "SPACE_ROOT_FREE" "$SPACE_ROOT_FREE_MB MB" $c1bg $c1fg $c2bg $c2fg
}
