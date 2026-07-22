#!/bin/bash

set -Eeuo pipefail

###########################################################
# Root Directory
###########################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$SCRIPT_DIR"
###########################################################
# Environment
###########################################################

export ENV_FILE="/root/msar/config/.env.production"
###########################################################
# Load Environment
###########################################################

if [ ! -f "$ENV_FILE" ]; then
    echo ""$ENV_FILE" not found."
    exit 1
fi

set -a
source "$ENV_FILE"
set +a

###########################################################
# Load Scripts
###########################################################

source scripts/logger.sh
source scripts/config.sh
source scripts/utils.sh
source scripts/retry.sh
source scripts/version.sh
source scripts/blue-green.sh
source scripts/release.sh
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
    switch_environment

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
    # load_release
    backup_current_version
    save_current_version
    write_history

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

    start_target

    #######################################################
    # Status
    #######################################################

    show_status

    #######################################################
    # Health Checks
    #######################################################

    wait_for_api

    wait_for_frontend
    stop_active
    save_active_color
    save_current_version
    #######################################################
    # Success
    #######################################################

    finish_deployment

}

main "$@"