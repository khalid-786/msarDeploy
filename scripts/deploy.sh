#!/bin/bash

set -e

echo ""

echo "Starting Deployment"

echo ""

./scripts/login-ghcr.sh

docker compose \
-f docker-compose.yml \
-f docker-compose.prod.yml \
pull

docker compose \
-f docker-compose.yml \
-f docker-compose.prod.yml \
up -d

./scripts/healthcheck.sh

./scripts/cleanup.sh

echo ""

echo "Deployment Finished Successfully"