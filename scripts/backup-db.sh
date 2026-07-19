#!/bin/bash

set -e

BACKUP_DIR=/opt/msar/backups

mkdir -p $BACKUP_DIR

DATE=$(date +%F_%H-%M-%S)

docker exec msar-sql \
/opt/mssql-tools18/bin/sqlcmd \
-S localhost \
-U sa \
-P "$SA_PASSWORD" \
-C \
-Q "BACKUP DATABASE MsarDb TO DISK='/var/opt/mssql/backup/MsarDb_$DATE.bak'"

echo ""

echo "Database Backup Completed"

echo ""