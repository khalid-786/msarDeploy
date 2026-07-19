smoke_api(){

curl --fail \
http://localhost:5080/api/version

log_success "API Smoke Test Passed."

}
smoke_frontend(){

curl --fail \
http://localhost

log_success "Frontend Smoke Test Passed."

}