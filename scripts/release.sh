#!/bin/bash

set -euo pipefail

create_release(){

VERSION=$1

mkdir -p releases/$VERSION

echo "$VERSION" \
> releases/$VERSION/version.txt

echo "$(date)" \
> releases/$VERSION/date.txt

echo "$GITHUB_SHA" \
> releases/$VERSION/commit.txt

log_success "Release created."

}