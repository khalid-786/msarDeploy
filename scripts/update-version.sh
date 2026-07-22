#!/bin/bash

set -Eeuo pipefail

STATE_DIRECTORY="./state"

CURRENT_STATE="$STATE_DIRECTORY/current.env"

source "$CURRENT_STATE"

EVENT_TYPE="$1"

VERSION="$2"

case "$EVENT_TYPE" in

deploy-backend)

    BACKEND_VERSION="$VERSION"
    ;;

deploy-frontend)

    FRONTEND_VERSION="$VERSION"
    ;;

*)

    echo "Unknown Event: $EVENT_TYPE"

    exit 1

    ;;

esac

cat > "$CURRENT_STATE" <<EOF
BACKEND_VERSION=$BACKEND_VERSION
FRONTEND_VERSION=$FRONTEND_VERSION
EOF

echo "====================================="
echo "Current Versions"
echo "====================================="

cat "$CURRENT_STATE"