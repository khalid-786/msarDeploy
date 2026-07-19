#!/bin/bash

set -euo pipefail

source scripts/config.sh

source scripts/logger.sh

source scripts/utils.sh

source scripts/retry.sh

source scripts/validate.sh

log_info "Starting Deployment Framework"

separator

validate_environment

separator

log_success "Framework Ready"

separator