#!/bin/bash

pull_images() {

    log_info "Pulling latest Docker images..."

    docker compose \
        --env-file "$ENV_FILE" \
        -f "$COMPOSE_FILE" \
        pull

    if [ $? -ne 0 ]; then

        log_error "Failed to pull Docker images."

        exit 1

    fi

    log_success "Docker images pulled successfully."

}

start_containers() {

    log_info "Starting containers..."

    docker compose \
        --env-file "$ENV_FILE" \
        -f "$COMPOSE_FILE" \
        up -d

    if [ $? -ne 0 ]; then

        log_error "Failed to start containers."

        exit 1

    fi

    log_success "Containers started."

}

show_status() {

    log_info "Current containers:"

    docker compose \
        --env-file "$ENV_FILE" \
        -f "$COMPOSE_FILE" \
        ps

}