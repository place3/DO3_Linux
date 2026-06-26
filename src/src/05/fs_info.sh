#!/bin/bash

collect_fs_info() {
    local dir="$1"

    # --- Папки ---
    TOTAL_FOLDERS=$(find "$dir" -mindepth 1 -type d 2>/dev/null | wc -l)

    # Топ-5 папок по размеру
    TOP5_FOLDERS=$(du -sh "$dir"* "$dir"**/ 2>/dev/null | \
        sort -rh | head -5 | \
        awk '{print $2, $1}' || \
        find "$dir" -mindepth 1 -type d 2>/dev/null -print0 | \
        xargs -0 du -sh 2>/dev/null | \
        sort -rh | head -5)
    # Надёжный вариант через find
    TOP5_FOLDERS=$(find "$dir" -mindepth 1 -type d 2>/dev/null -print0 | \
        xargs -0 du -sb 2>/dev/null | \
        sort -rn | head -5 | \
        awk '{
            size=$1; path=$2
            if (size >= 1073741824)      printf "%s, %.2f GB\n", path, size/1073741824
            else if (size >= 1048576)    printf "%s, %.2f MB\n", path, size/1048576
            else if (size >= 1024)       printf "%s, %.2f KB\n", path, size/1024
            else                         printf "%s, %d B\n",   path, size
        }')

    # --- Файлы ---
    TOTAL_FILES=$(find "$dir" -mindepth 1 -type f 2>/dev/null | wc -l)

    COUNT_CONF=$(find "$dir" -mindepth 1 -type f -name "*.conf" 2>/dev/null | wc -l)
    COUNT_TEXT=$(find "$dir" -mindepth 1 -type f \( -name "*.txt" -o -name "*.md" -o -name "*.csv" \) 2>/dev/null | wc -l)
    COUNT_EXEC=$(find "$dir" -mindepth 1 -type f -executable 2>/dev/null | wc -l)
    COUNT_LOG=$(find "$dir" -mindepth 1 -type f -name "*.log" 2>/dev/null | wc -l)
    COUNT_ARCH=$(find "$dir" -mindepth 1 -type f \
        \( -name "*.tar" -o -name "*.tar.gz" -o -name "*.tgz" -o -name "*.tar.bz2" \
           -o -name "*.tar.xz" -o -name "*.zip" -o -name "*.gz" -o -name "*.bz2" \
           -o -name "*.xz" -o -name "*.rar" -o -name "*.7z" \) 2>/dev/null | wc -l)
    COUNT_SYMLINK=$(find "$dir" -mindepth 1 -type l 2>/dev/null | wc -l)

    # Топ-10 файлов по размеру (путь, размер, расширение)
    TOP10_FILES=$(find "$dir" -mindepth 1 -type f 2>/dev/null -printf '%s %p\n' | \
        sort -rn | head -10 | \
        awk '{
            size=$1; path=$2
            n=split(path, a, ".")
            ext=(n>1) ? a[n] : "unknown"
            if (size >= 1073741824)      printf "%s, %.2f GB, %s\n", path, size/1073741824, ext
            else if (size >= 1048576)    printf "%s, %.2f MB, %s\n", path, size/1048576,    ext
            else if (size >= 1024)       printf "%s, %.2f KB, %s\n", path, size/1024,       ext
            else                         printf "%s, %d B, %s\n",   path, size,             ext
        }')

    # Топ-10 исполняемых файлов по размеру (путь, размер, MD5)
    TOP10_EXEC=$(find "$dir" -mindepth 1 -type f -executable 2>/dev/null -printf '%s %p\n' | \
        sort -rn | head -10 | \
        while IFS=' ' read -r size path; do
            md5=$(md5sum "$path" 2>/dev/null | awk '{print $1}')
            if   [ "$size" -ge 1073741824 ]; then
                printf "%s, %.2f GB, %s\n" "$path" "$(awk "BEGIN{printf \"%.2f\",$size/1073741824}")" "$md5"
            elif [ "$size" -ge 1048576 ]; then
                printf "%s, %.2f MB, %s\n" "$path" "$(awk "BEGIN{printf \"%.2f\",$size/1048576}")"   "$md5"
            elif [ "$size" -ge 1024 ]; then
                printf "%s, %.2f KB, %s\n" "$path" "$(awk "BEGIN{printf \"%.2f\",$size/1024}")"      "$md5"
            else
                printf "%s, %d B, %s\n"    "$path" "$size"                                            "$md5"
            fi
        done)
}
