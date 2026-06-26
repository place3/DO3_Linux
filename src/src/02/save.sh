#!/bin/bash

# Предлагает пользователю сохранить вывод в файл
ask_save() {
    read -rp "Save data to file? (Y/N): " answer
    if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
        local filename
        filename="$(date '+%d_%m_%y_%H_%M_%S').status"
        {
            echo "HOSTNAME = $HOSTNAME"
            echo "TIMEZONE = $TIMEZONE"
            echo "USER = $USER_NAME"
            echo "OS = $OS"
            echo "DATE = $DATE"
            echo "UPTIME = $UPTIME_STR"
            echo "UPTIME_SEC = $UPTIME_SEC_VAL"
            echo "IP = $IP_ADDR"
            echo "MASK = $MASK"
            echo "GATEWAY = $GATEWAY"
            echo "RAM_TOTAL = $RAM_TOTAL_GB GB"
            echo "RAM_USED = $RAM_USED_GB GB"
            echo "RAM_FREE = $RAM_FREE_GB GB"
            echo "SPACE_ROOT = $SPACE_ROOT_MB MB"
            echo "SPACE_ROOT_USED = $SPACE_ROOT_USED_MB MB"
            echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE_MB MB"
        } > "$filename"
        echo "Data saved to: $filename"
    fi
}
