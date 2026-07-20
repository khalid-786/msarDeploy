#!/bin/bash

set -Eeuo pipefail

###########################################################
# Root Directory
###########################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$SCRIPT_DIR"

###########################################################
# Load Environment
###########################################################

if [ ! -f env/.env.production ]; then
    echo "env/.env.production not found."
    exit 1
fi

set -a
source env/.env.production
set +a

###########################################################
# Load Scripts
###########################################################

source scripts/logger.sh
source scripts/config.sh
source scripts/utils.sh
source scripts/retry.sh

source scripts/deployment.sh

source scripts/validate.sh

source scripts/registry.sh

source scripts/images.sh

source scripts/compose.sh

source scripts/docker.sh

source scripts/health.sh

source scripts/backup.sh

source scripts/rollback.sh

###########################################################
# Error Handler
###########################################################

on_error() {

    log_error "Deployment failed."

    rollback

    exit 1

}

trap on_error ERR

###########################################################
# Main
###########################################################

main() {

    start_deployment

    #######################################################
    # Validation
    #######################################################

    validate_environment

    #######################################################
    # Registry
    #######################################################

    login_registry

    #######################################################
    # Images
    #######################################################

    check_images

    #######################################################
    # Backup
    #######################################################
    load_versions

    backup_current_version
    backup_current_state

    #######################################################
    # Compose
    #######################################################

    validate_compose

    #######################################################
    # Pull Images
    #######################################################

    pull_images

    #######################################################
    # Start Containers
    #######################################################

    start_containers

    #######################################################
    # Status
    #######################################################

    show_status

    #######################################################
    # Health Checks
    #######################################################

    wait_for_api

    wait_for_frontend
    save_current_version
    #######################################################
    # Success
    #######################################################

    finish_deployment

}

main "$@"