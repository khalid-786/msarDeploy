#!/bin/bash

set -e

echo "Removing dangling images..."

docker image prune -f

echo "Removing unused images..."

docker image prune -af

echo "Removing unused containers..."

docker container prune -f

echo "Removing unused volumes..."

docker volume prune -f

echo "Removing unused networks..."

docker network prune -f

echo "Docker cleanup finished."