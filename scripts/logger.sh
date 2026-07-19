#!/bin/bash

timestamp(){

date +"%Y-%m-%d %H:%M:%S"

}

write_log(){

LEVEL=$1

MESSAGE=$2

echo "$(timestamp) [$LEVEL] $MESSAGE" | tee -a "$LOG_FILE"

}

log_info(){

write_log INFO "$1"

}

log_warn(){

write_log WARN "$1"

}

log_error(){

write_log ERROR "$1"

}

log_success(){

write_log SUCCESS "$1"

}