#!/bin/bash

############################################################
# State
############################################################

STATE_DIRECTORY="./state"

CURRENT_STATE="$STATE_DIRECTORY/current.env"

PREVIOUS_STATE="$STATE_DIRECTORY/previous.env"

DEPLOYMENT_HISTORY="$STATE_DIRECTORY/deployment.history"

mkdir -p "$STATE_DIRECTORY"

############################################################
# Helpers
############################################################

build_images() {

    BACKEND_IMAGE="ghcr.io/${GHCR_USERNAME}/msar-api:${BACKEND_VERSION}"

    FRONTEND_IMAGE="ghcr.io/${GHCR_USERNAME}/msar-frontend:${FRONTEND_VERSION}"

}

############################################################
# Load Versions
############################################################

load_versions() {

    if [ ! -f "$CURRENT_STATE" ]; then

        log_error "Current state file not found."

        exit 1

    fi

    source "$CURRENT_STATE"

    build_images

    log_success "Current versions loaded."

}

############################################################
# Backup Current Version
############################################################

backup_current_version() {

    cp "$CURRENT_STATE" "$PREVIOUS_STATE"

    log_success "Current version backed up."

}

############################################################
# Save Current Version
############################################################

save_current_version() {

cat > "$CURRENT_STATE" <<EOF
BACKEND_VERSION=$NEW_BACKEND_VERSION
FRONTEND_VERSION=$NEW_FRONTEND_VERSION
EOF

    BACKEND_VERSION="$NEW_BACKEND_VERSION"

    FRONTEND_VERSION="$NEW_FRONTEND_VERSION"

    build_images

    log_success "Current version updated."

}

############################################################
# Restore Previous Version
############################################################

restore_previous_version() {

    if [ ! -f "$PREVIOUS_STATE" ]; then

        log_error "Previous version not found."

        exit 1

    fi

    cp "$PREVIOUS_STATE" "$CURRENT_STATE"

    source "$CURRENT_STATE"

    build_images

    log_success "Previous version restored."

}

############################################################
# History
############################################################

write_history() {

cat >> "$DEPLOYMENT_HISTORY" <<EOF

=========================================
Date      : $(date '+%Y-%m-%d %H:%M:%S')
Backend   : $BACKEND_VERSION
Frontend  : $FRONTEND_VERSION
Status    : SUCCESS
=========================================

EOF

}