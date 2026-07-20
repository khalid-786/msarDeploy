# #!/bin/bash

# set -euo pipefail

# source scripts/logger.sh
# source scripts/config.sh

# ###############################################
# # Restore .env
# ###############################################

# restore_environment() {

# LATEST_ENV=$(ls -t backup/env/.env.production.* | head -1)

# cp "$LATEST_ENV" env/.env.production

# log_success ".env restored."

# }

# ###############################################
# # Restore compose
# ###############################################

# restore_compose() {

# LATEST_COMPOSE=$(ls -t backup/compose/docker-compose.yml.* | head -1)

# LATEST_PROD=$(ls -t backup/compose/docker-compose.prod.yml.* | head -1)

# cp "$LATEST_COMPOSE" compose/docker-compose.yml

# cp "$LATEST_PROD" compose/docker-compose.prod.yml

# log_success "Compose restored."

# }
# restore_database() {

# BACKUP=$(ls -t backup/sql/*.bak | head -1)

# FILE=$(basename "$BACKUP")

# docker cp \
# "$BACKUP" \
# msar-sql:/var/opt/mssql/$FILE

# docker exec msar-sql /opt/mssql-tools18/bin/sqlcmd \
# -S localhost \
# -U sa \
# -P "$SA_PASSWORD" \
# -C \
# -Q "
# ALTER DATABASE MsarDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

# RESTORE DATABASE MsarDb
# FROM DISK='/var/opt/mssql/$FILE'
# WITH REPLACE;

# ALTER DATABASE MsarDb SET MULTI_USER;
# "

# log_success "Database restored."

# }
# restore_previous_version() {

# PREVIOUS=$(ls releases | sort -V | tail -2 | head -1)

# source releases/$PREVIOUS/version.env

# export BACKEND_VERSION

# export FRONTEND_VERSION

# docker compose pull

# docker compose up -d

# log_success "Previous release restored."

# }
# rollback() {

# log_warn "Deployment failed."

# restore_environment

# restore_compose

# restore_previous_version

# run_health_checks

# log_success "Rollback completed."

# }
#!/bin/bash

rollback(){

log_error "Rollback started..."

restore_previous_version

log_error "Rollback finished."

}