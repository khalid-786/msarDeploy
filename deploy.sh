#!/bin/bash

set -euo pipefail

source scripts/config.sh

source scripts/logger.sh

source scripts/utils.sh

source scripts/retry.sh

source scripts/validate.sh
source scripts/registry.sh
source scripts/images.sh

log_info "Starting Deployment Framework"

separator

validate_environment
login_registry

check_images

separator

log_success "Framework Ready"

separator