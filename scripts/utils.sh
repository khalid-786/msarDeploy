#!/bin/bash

set -euo pipefail

command_exists() {

    command -v "$1" >/dev/null 2>&1

}

require_command() {

    if ! command_exists "$1"

    then

        echo "$1 is not installed."

        exit 1

    fi

}