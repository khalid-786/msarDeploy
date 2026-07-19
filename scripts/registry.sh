#!/bin/bash

set -euo pipefail

login_registry(){

log_info "Logging into GitHub Container Registry..."

if echo "$GHCR_TOKEN" | docker login ghcr.io \
-u "$GHCR_USERNAME" \
--password-stdin

then

log_success "Successfully logged into GHCR."

else

log_error "Failed to login into GHCR."

exit 1

fi

}