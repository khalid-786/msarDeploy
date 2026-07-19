network_exists(){

docker network inspect msar-network >/dev/null 2>&1

}
verify_network(){

if network_exists

then

log_success "Docker network found."

else

log_warn "Docker network missing."

fi

}