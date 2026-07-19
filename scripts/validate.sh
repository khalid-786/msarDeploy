#!/bin/bash

set -euo pipefail

source scripts/logger.sh

validate_environment() {

    log_info "Validating Environment"

    require_command docker

    require_command curl

    require_command git

    require_command jq

    log_success "Environment Validated"

}