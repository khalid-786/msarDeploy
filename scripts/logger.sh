#!/bin/bash

set -euo pipefail

LOG_FILE="logs/deploy.log"

mkdir -p logs

timestamp() {

    date +"%Y-%m-%d %H:%M:%S"

}

log_info() {

    echo "$(timestamp) [INFO ] $1"

    tee -a "$LOG_FILE"

}

log_warn() {

    echo "$(timestamp) [WARN ] $1"

    tee -a "$LOG_FILE"

}

log_error() {

    echo "$(timestamp) [ERROR] $1"

    tee -a "$LOG_FILE"

}

log_success() {

    echo "$(timestamp) [ OK  ] $1"

    tee -a "$LOG_FILE"

}