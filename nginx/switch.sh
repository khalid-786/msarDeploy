#!/bin/bash

set -Eeuo pipefail

COLOR="$1"

NGINX_DIR="./nginx"

case "$COLOR" in

blue)

    cp "$NGINX_DIR/upstream-blue.conf" "$NGINX_DIR/upstream.conf"

    ;;

green)

    cp "$NGINX_DIR/upstream-green.conf" "$NGINX_DIR/upstream.conf"

    ;;

*)

    echo "Unknown color: $COLOR"

    exit 1

    ;;

esac

docker exec msar-nginx nginx -t

docker exec msar-nginx nginx -s reload

echo "Nginx switched to $COLOR successfully."