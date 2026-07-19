#!/bin/bash

set -euo pipefail

source scripts/logger.sh
source scripts/config.sh
source scripts/utils.sh
source scripts/validate.sh

source scripts/docker.sh
source scripts/registry.sh
source scripts/images.sh
source scripts/containers.sh
source scripts/network.sh
source scripts/health.sh

source scripts/backup.sh
source scripts/release.sh
source scripts/migration.sh
source scripts/smoke.sh
source scripts/rollback.sh
source scripts/lock.sh

main(){

acquire_lock

trap release_lock EXIT

load_configuration

validate_environment

create_backup

login_registry

verify_image "$BACKEND_IMAGE"

verify_image "$FRONTEND_IMAGE"

pull_images

start_services

run_migrations

run_health_checks

smoke_api

smoke_frontend

create_release "$BACKEND_VERSION"

cleanup

log_success "Deployment Completed Successfully."

}

main