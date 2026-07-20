#!/bin/bash

validate_compose() {

    log_info "Validating Docker Compose file..."

    docker compose \
        --env-file "$ENV_FILE" \
        -f "$COMPOSE_FILE" \
        config >/dev/null

    if [ $? -ne 0 ]; then
        log_error "Docker Compose configuration is invalid."
        exit 1
    fi

    log_success "Docker Compose configuration is valid."

}