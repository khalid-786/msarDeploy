#!/bin/bash

set -e

if [ $# -ne 2 ]; then
    echo ""
    echo "Usage:"
    echo "./rollback.sh <backend_version> <frontend_version>"
    echo ""
    echo "Example:"
    echo "./rollback.sh v1.0.3 v1.0.3"
    exit 1
fi

BACKEND_VERSION=$1
FRONTEND_VERSION=$2

echo ""
echo "Rolling Back..."
echo ""

sed -i "s/^BACKEND_VERSION=.*/BACKEND_VERSION=${BACKEND_VERSION}/" .env
sed -i "s/^FRONTEND_VERSION=.*/FRONTEND_VERSION=${FRONTEND_VERSION}/" .env

docker compose \
-f docker-compose.yml \
-f docker-compose.prod.yml \
pull

docker compose \
-f docker-compose.yml \
-f docker-compose.prod.yml \
up -d

echo ""
echo "Rollback Completed Successfully."