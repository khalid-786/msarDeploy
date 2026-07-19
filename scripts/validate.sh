#!/bin/bash

validate_environment(){

log_info "Validating environment..."

require_command docker

require_command docker-compose

require_command curl

require_command jq

file_exists "$COMPOSE_FILE"

if [ ! -f env/.env.production ]
then

log_error ".env.production not found."

exit 1

fi

log_success "Environment validated."

}