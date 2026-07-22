#!/bin/bash

#############################################
# Resolve Health URLs
#############################################

resolve_health_urls() {

    if [ "$TARGET_COLOR" = "blue" ]; then

        API_HEALTH_URL="http://localhost:5081/health"

        FRONTEND_HEALTH_URL="http://localhost:8081"

    else

        API_HEALTH_URL="http://localhost:5082/health"

        FRONTEND_HEALTH_URL="http://localhost:8082"

    fi

}

#############################################
# API Health
#############################################

wait_for_api() {

    resolve_health_urls

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

#############################################
# Frontend Health
#############################################

wait_for_frontend() {

    resolve_health_urls

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