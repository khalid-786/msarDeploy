#!/bin/bash

#############################################
# Images
#############################################

BACKEND_IMAGE=${BACKEND_IMAGE}
FRONTEND_IMAGE=${FRONTEND_IMAGE}

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
# Health URLs
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