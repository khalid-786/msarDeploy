#!/bin/bash

set -e

if [ $# -eq 0 ]; then

    echo ""

    echo "Usage:"

    echo "./restore-db.sh backupfile.bak"

    exit 1

fi

FILE=$1

docker exec msar-sql \
/opt/mssql-tools18/bin/sqlcmd \
-S localhost \
-U sa \
-P "$SA_PASSWORD" \
-C \
-Q "RESTORE DATABASE MsarDb FROM DISK='/var/opt/mssql/backup/$FILE' WITH REPLACE"

echo ""

echo "Restore Completed."

echo ""