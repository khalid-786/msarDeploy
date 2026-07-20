#!/bin/bash

check_image() {

    IMAGE_NAME=$1

    log_info "Checking image: $IMAGE_NAME"

    docker manifest inspect "$IMAGE_NAME" >/dev/null 2>&1

    if [ $? -ne 0 ]; then

        log_error "Image not found: $IMAGE_NAME"

        exit 1

    fi

    log_success "Image exists."

}

check_images() {

    check_image "$BACKEND_IMAGE"

    check_image "$FRONTEND_IMAGE"

}