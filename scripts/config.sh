#!/bin/bash

set -euo pipefail

CONFIG_FILE="config/deployment.conf"

load_configuration() {

    if [ ! -f "$CONFIG_FILE" ]; then

        echo "Configuration file not found."

        exit 1

    fi

    source "$CONFIG_FILE"

}