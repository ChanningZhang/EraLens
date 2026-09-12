#!/usr/bin/env bash
set -euo pipefail

SQL_FILE="${1:?Usage: apply-sql.sh <import.sql>}"

CONTAINER="${ERALENS_PG_CONTAINER:-eralens-postgres}"
PGUSER="${ERALENS_PG_USER:-eralens}"
PGDB="${ERALENS_PG_DB:-eralens}"

if [[ ! -f "$SQL_FILE" ]]; then
  echo "File not found: $SQL_FILE" >&2
  exit 1
fi

if ! docker ps --format '{{.Names}}' | grep -qx "$CONTAINER"; then
  echo "Container $CONTAINER is not running. Run: pnpm db:up" >&2
  exit 1
fi

echo "Applying $SQL_FILE to $CONTAINER/$PGDB ..."
docker exec -i "$CONTAINER" psql -v ON_ERROR_STOP=1 -U "$PGUSER" -d "$PGDB" < "$SQL_FILE"
echo "Done."
