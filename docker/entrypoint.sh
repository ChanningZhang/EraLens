#!/bin/sh
set -e

if [ -n "$DATABASE_URL" ]; then
  echo "Waiting for PostgreSQL..."
  until pg_isready -h "${DB_HOST:-postgres}" -p "${DB_PORT:-5432}" -U "${DB_USER:-eralens}" -d "${DB_NAME:-eralens}" > /dev/null 2>&1; do
    sleep 1
  done

  echo "Applying database migrations..."
  pnpm --filter @eralens/api db:migrate

  if [ "$RUN_SEED" = "true" ]; then
    echo "Seeding database..."
    pnpm --filter @eralens/api db:seed
  fi
fi

exec "$@"
