#!/bin/bash

#############################################
# Load Environment
#############################################

ENV_FILE="env/.env.production"

if [ ! -f "$ENV_FILE" ]; then
    echo "Environment file not found: $ENV_FILE"
    exit 1
fi

set -a
source "$ENV_FILE"
set +a

#############################################
# Images
#############################################

BACKEND_IMAGE="ghcr.io/${GHCR_USERNAME}/msar-api:${BACKEND_VERSION}"

FRONTEND_IMAGE="ghcr.io/${GHCR_USERNAME}/msar-frontend:${FRONTEND_VERSION}"

#############################################
# Containers
#############################################

BACKEND_CONTAINER="msar-api"
FRONTEND_CONTAINER="msar-frontend"

SQL_CONTAINER="msar-sql"
RABBIT_CONTAINER="msar-rabbit"

#############################################
# Compose
#############################################

COMPOSE_FILE="compose/docker-compose.yml"

#############################################
# Health
#############################################

API_HEALTH_URL="http://localhost:5080/health"
FRONTEND_HEALTH_URL="http://localhost"

#############################################
# Logs
#############################################

LOG_DIRECTORY="./logs"
mkdir -p "$LOG_DIRECTORY"

LOG_FILE="$LOG_DIRECTORY/deploy.log"

#############################################
# Retry
#############################################

MAX_RETRIES=5
RETRY_DELAY=2