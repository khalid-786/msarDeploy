#!/bin/bash

set -e

echo "Login to GitHub Container Registry..."

echo "$GHCR_TOKEN" | docker login ghcr.io \
    -u "$GHCR_USERNAME" \
    --password-stdin

echo "Login Success."