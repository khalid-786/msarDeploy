#!/bin/bash

set -euo pipefail

LOCK_FILE="/tmp/msar-deploy.lock"

acquire_lock(){

if [ -f "$LOCK_FILE" ]; then

log_error "Another deployment is already running."

exit 1

fi

touch "$LOCK_FILE"

log_success "Deployment lock acquired."

}

release_lock(){

rm -f "$LOCK_FILE"

log_success "Deployment lock released."

}