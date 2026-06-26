#!/bin/bash

# Сбор всех системных показателей в глобальные переменные
collect_info() {
    HOSTNAME=$(hostname)

    # Временная зона: имя + смещение UTC
    TZ_NAME=$(timedatectl show --property=Timezone --value 2>/dev/null || \
              cat /etc/timezone 2>/dev/null || echo "Unknown")
    TZ_OFFSET=$(date +%z)
    # Преобразуем +0300 → UTC +3
    TZ_SIGN="${TZ_OFFSET:0:1}"
    TZ_HOURS=$((10#${TZ_OFFSET:1:2}))
    TZ_MINS=$((10#${TZ_OFFSET:3:2}))
    if [ "$TZ_SIGN" = "+" ]; then
        UTC_STR="UTC +${TZ_HOURS}"
    else
        UTC_STR="UTC -${TZ_HOURS}"
    fi
    [ "$TZ_MINS" -ne 0 ] && UTC_STR="${UTC_STR}:${TZ_MINS}"
    TIMEZONE="$TZ_NAME $UTC_STR"

    USER_NAME=$(whoami)
    OS=$(. /etc/os-release 2>/dev/null && echo "$NAME $VERSION" || uname -o)
    DATE=$(date "+%d %B %Y %H:%M:%S")

    # Uptime
    UPTIME_SEC_VAL=$(awk '{printf "%d", $1}' /proc/uptime)
    UP_DAYS=$(( UPTIME_SEC_VAL / 86400 ))
    UP_HRS=$(( (UPTIME_SEC_VAL % 86400) / 3600 ))
    UP_MIN=$(( (UPTIME_SEC_VAL % 3600) / 60 ))
    UP_SEC=$(( UPTIME_SEC_VAL % 60 ))
    UPTIME_STR="${UP_DAYS} days, ${UP_HRS}:$(printf '%02d' $UP_MIN):$(printf '%02d' $UP_SEC)"

    # IP и маска: берём первый не-loopback интерфейс
    IFACE=$(ip -o -4 addr show | awk '$2 != "lo" {print $2; exit}')
    IP_ADDR=$(ip -o -4 addr show "$IFACE" 2>/dev/null | awk '{print $4}' | cut -d/ -f1)
    PREFIX=$(ip -o -4 addr show "$IFACE" 2>/dev/null | awk '{print $4}' | cut -d/ -f2)
    MASK=$(python3 -c "
import ipaddress, sys
net = ipaddress.IPv4Network('0.0.0.0/'+sys.argv[1], strict=False)
print(str(net.netmask))
" "$PREFIX" 2>/dev/null || echo "N/A")

    GATEWAY=$(ip route | awk '/default/{print $3; exit}')

    # RAM (в ГБ, 3 знака после запятой)
    RAM_TOTAL_KB=$(awk '/MemTotal/{print $2}' /proc/meminfo)
    RAM_FREE_KB=$(awk '/MemAvailable/{print $2}' /proc/meminfo)
    RAM_USED_KB=$(( RAM_TOTAL_KB - RAM_FREE_KB ))
    RAM_TOTAL_GB=$(awk "BEGIN{printf \"%.3f\", $RAM_TOTAL_KB/1048576}")
    RAM_USED_GB=$(awk "BEGIN{printf \"%.3f\", $RAM_USED_KB/1048576}")
    RAM_FREE_GB=$(awk "BEGIN{printf \"%.3f\", $RAM_FREE_KB/1048576}")

    # Дисковое пространство раздела / (в МБ, 2 знака)
    DF_LINE=$(df --block-size=1 / | tail -1)
    SPACE_TOTAL_B=$(echo "$DF_LINE" | awk '{print $2}')
    SPACE_USED_B=$(echo "$DF_LINE" | awk '{print $3}')
    SPACE_FREE_B=$(echo "$DF_LINE" | awk '{print $4}')
    SPACE_ROOT_MB=$(awk "BEGIN{printf \"%.2f\", $SPACE_TOTAL_B/1048576}")
    SPACE_ROOT_USED_MB=$(awk "BEGIN{printf \"%.2f\", $SPACE_USED_B/1048576}")
    SPACE_ROOT_FREE_MB=$(awk "BEGIN{printf \"%.2f\", $SPACE_FREE_B/1048576}")
}

# Печать всех собранных значений
print_info() {
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
}
