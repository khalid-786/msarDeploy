image_exists(){

docker manifest inspect "$1" >/dev/null 2>&1

}

verify_image(){

IMAGE=$1

if image_exists "$IMAGE"

then

log_success "$IMAGE exists."

else

log_error "$IMAGE not found."

exit 1

fi

}
pull_images(){

verify_image "$BACKEND_IMAGE"

verify_image "$FRONTEND_IMAGE"

log_info "Pulling images..."

$COMPOSE pull

log_success "Images pulled."

}