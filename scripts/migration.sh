run_migrations(){

log_info "Running EF Core Migrations..."

docker exec msar-api \
dotnet WepAPI.dll migrate

log_success "Migration finished."

}