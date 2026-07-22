# #!/bin/bash

# set -euo pipefail

# create_release(){

# VERSION=$1

# mkdir -p releases/$VERSION

# echo "$VERSION" \
# > releases/$VERSION/version.txt

# echo "$(date)" \
# > releases/$VERSION/date.txt

# echo "$GITHUB_SHA" \
# > releases/$VERSION/commit.txt

# log_success "Release created."

# }
#!/bin/bash

############################################################
# Release Information
############################################################

load_release() {

    if [ -z "${NEW_BACKEND_VERSION:-}" ]; then

        NEW_BACKEND_VERSION="$BACKEND_VERSION"

    fi

    if [ -z "${NEW_FRONTEND_VERSION:-}" ]; then

        NEW_FRONTEND_VERSION="$FRONTEND_VERSION"

    fi

    log_info "Backend Version : $NEW_BACKEND_VERSION"

    log_info "Frontend Version: $NEW_FRONTEND_VERSION"

}