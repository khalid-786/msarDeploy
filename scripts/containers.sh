#!/bin/bash

set -euo pipefail
start_services(){

log_info "Starting Containers..."

$COMPOSE up -d

log_success "Containers started."

}
stop_services(){

log_info "Stopping Containers..."

$COMPOSE down

log_success "Containers stopped."

}
restart_service(){

SERVICE=$1

log_info "Restarting $SERVICE..."

docker compose restart "$SERVICE"

log_success "$SERVICE restarted."

}