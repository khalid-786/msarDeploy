#!/bin/bash

validate_environment() {

    log_info "Validating environment..."

    #############################################
    # Required Commands
    #############################################

    require_command docker
    require_command curl
    require_command jq

    #############################################
    # Docker Compose V2
    #############################################

    if ! docker compose version >/dev/null 2>&1; then
        log_error "Docker Compose Plugin is not installed."
        exit 1
    fi

    #############################################
    # Required Files
    #############################################

    file_exists "$COMPOSE_FILE"

    if [ ! -f ""$ENV_FILE"" ]; then
        log_error ""$ENV_FILE" not found."
        exit 1
    fi

    #############################################
    # Docker Daemon
    #############################################

    if ! docker info >/dev/null 2>&1; then
        log_error "Docker daemon is not running."
        exit 1
    fi

    #############################################
    # Success
    #############################################

    log_success "Environment validated successfully."

}