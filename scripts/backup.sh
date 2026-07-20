# #!/bin/bash

# set -euo pipefail

# source scripts/logger.sh
# source scripts/config.sh

# TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# ###############################################
# # Backup .env
# ###############################################

# backup_environment() {

#     mkdir -p backup/env

#     cp "$ENV_FILE" \
#        backup/"$ENV_FILE".$TIMESTAMP

#     log_success ".env backed up."

# }

# ###############################################
# # Backup compose files
# ###############################################

# backup_compose() {

#     mkdir -p backup/compose

#     cp compose/docker-compose.yml \
#        backup/compose/docker-compose.yml.$TIMESTAMP

#     cp compose/docker-compose.prod.yml \
#        backup/compose/docker-compose.prod.yml.$TIMESTAMP

#     log_success "Compose files backed up."

# }

# ###############################################
# # Backup SQL Server Database
# ###############################################

# backup_database() {

#     mkdir -p backup/sql

#     BACKUP_NAME="MsarDb_${TIMESTAMP}.bak"

#     log_info "Creating SQL Server backup..."

#     docker exec msar-sql /opt/mssql-tools18/bin/sqlcmd \
#         -S localhost \
#         -U sa \
#         -P "$SA_PASSWORD" \
#         -C \
#         -Q "BACKUP DATABASE [MsarDb]
#             TO DISK='/var/opt/mssql/${BACKUP_NAME}'
#             WITH INIT"

#     docker cp \
#         msar-sql:/var/opt/mssql/${BACKUP_NAME} \
#         backup/sql/${BACKUP_NAME}

#     log_success "Database backup completed."

# }

# ###############################################
# # Master Backup
# ###############################################

# create_backup() {

#     backup_environment

#     backup_compose

#     backup_database

# }
#!/bin/bash

backup_current_state(){

log_info "Creating deployment backup..."

mkdir -p backups

DATE=$(date +%Y%m%d_%H%M%S)

BACKUP_FOLDER="backups/$DATE"

mkdir -p "$BACKUP_FOLDER"

docker compose \
--env-file "$ENV_FILE" \
-f "$COMPOSE_FILE" \
config > "$BACKUP_FOLDER/docker-compose.yml"

cp "$ENV_FILE" \
"$BACKUP_FOLDER/.env.production"

log_success "Backup created."

}