#!/bin/bash

set -euo pipefail

source scripts/logger.sh
source scripts/config.sh
source scripts/registry.sh
source scripts/images.sh
source scripts/containers.sh
source scripts/network.sh
source scripts/health.sh
compose(){

$COMPOSE "$@"

}