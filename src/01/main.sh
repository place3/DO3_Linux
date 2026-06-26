#!/bin/bash

# Part 1: Скрипт принимает один параметр и выводит его значение.
# Если параметр является числом — выводит сообщение об ошибке.

source "$(dirname "$0")/check_param.sh"

check_param "$@"
print_param "$1"
