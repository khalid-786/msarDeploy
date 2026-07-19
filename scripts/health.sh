#!/bin/bash
docker_running(){

docker info >/dev/null 2>&1

}
verify_docker(){

if docker_running

then

log_success "Docker daemon running."

else

log_error "Docker daemon is not running."

exit 1

fi

}
verify_compose(){

docker compose version >/dev/null

log_success "Docker Compose available."
}
