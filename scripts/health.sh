#!/bin/bash

wait_for_api() {

    log_info "Waiting for API..."

    for i in $(seq 1 "$HEALTH_RETRIES")
    do

        if curl -fs "$API_HEALTH_URL" >/dev/null
        then

            log_success "API is healthy."

            return

        fi

        sleep "$HEALTH_DELAY"

    done

    log_error "API Health Check failed."

    exit 1

}

wait_for_frontend() {

    log_info "Waiting for Frontend..."

    for i in $(seq 1 "$HEALTH_RETRIES")
    do

        if curl -fs "$FRONTEND_HEALTH_URL" >/dev/null
        then

            log_success "Frontend is healthy."

            return

        fi

        sleep "$HEALTH_DELAY"

    done

    log_error "Frontend Health Check failed."

    exit 1

}