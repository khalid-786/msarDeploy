#!/bin/bash

login_registry() {

    log_info "Logging in to GitHub Container Registry..."

    #############################################
    # Validate credentials
    #############################################

    if [ -z "$GHCR_USERNAME" ]; then
        log_error "GHCR_USERNAME is empty."
        exit 1
    fi

    if [ -z "$GHCR_TOKEN" ]; then
        log_error "GHCR_TOKEN is empty."
        exit 1
    fi

    #############################################
    # Login
    #############################################

    echo "$GHCR_TOKEN" | docker login "$GHCR_REGISTRY" \
        --username "$GHCR_USERNAME" \
        --password-stdin

    if [ $? -ne 0 ]; then
        log_error "Failed to login to GHCR."
        exit 1
    fi

    log_success "Successfully logged into GHCR."

}