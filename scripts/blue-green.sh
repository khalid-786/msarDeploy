#!/bin/bash

set -Eeuo pipefail

#############################################
# Files
#############################################

STATE_DIRECTORY="./state"

ACTIVE_FILE="$STATE_DIRECTORY/active-color"

#############################################
# Active Color
#############################################

get_active_color() {

    if [ ! -f "$ACTIVE_FILE" ]; then
        echo "blue" > "$ACTIVE_FILE"
    fi

    ACTIVE_COLOR=$(cat "$ACTIVE_FILE")
}

#############################################
# Target Color
#############################################

get_target_color() {

    if [ "$ACTIVE_COLOR" = "blue" ]; then
        TARGET_COLOR="green"
    else
        TARGET_COLOR="blue"
    fi
}

#############################################
# Compose File
#############################################

get_compose_file() {

    COMPOSE_FILE="compose/docker-compose.${TARGET_COLOR}.yml"
}

#############################################
# Start Target
#############################################

start_target() {

    log_info "Starting ${TARGET_COLOR} environment..."

    docker compose \
        -f "$COMPOSE_FILE" \
        up -d

}

#############################################
# Stop Active
#############################################

stop_active() {

    log_info "Stopping ${ACTIVE_COLOR} environment..."

    docker compose \
        -f "compose/docker-compose.${ACTIVE_COLOR}.yml" \
        down

}

#############################################
# Save Active Color
#############################################

save_active_color() {

    echo "$TARGET_COLOR" > "$ACTIVE_FILE"

    log_success "Active environment changed to ${TARGET_COLOR}"

}

#############################################
# Switch Nginx
#############################################

switch_nginx() {

    log_info "Switching Nginx to ${TARGET_COLOR}..."

    ./nginx/switch.sh "$TARGET_COLOR"

}

#############################################
# Initialize
#############################################

switch_environment() {

    get_active_color

    get_target_color

    get_compose_file

    log_info "Current Environment : $ACTIVE_COLOR"

    log_info "Target Environment  : $TARGET_COLOR"

}