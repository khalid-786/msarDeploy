#!/bin/bash

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
# Monitoring
#############################################

MONITORING_COMPOSE_FILE="compose/docker-compose.monitoring.yml"

#############################################
# Health
#############################################

API_HEALTH_URL="http://localhost:5080/health"
FRONTEND_HEALTH_URL="http://localhost"
HEALTH_RETRIES=30

HEALTH_DELAY=5

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
#############################################
# GitHub Container Registry
#############################################

GHCR_REGISTRY="ghcr.io"