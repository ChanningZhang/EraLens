#!/usr/bin/env bash
# EraLens Cloud Agent environment — start (runs on every boot; idempotent).
# Brings up the Docker daemon, then PostgreSQL + migrations + real data import.
# The dev servers (web + api) run separately as a tmux terminal (see terminals).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" >/dev/null 2>&1 || true
corepack enable >/dev/null 2>&1 || true

echo "==> [start] Ensuring Docker daemon is running"
if ! sudo docker info >/dev/null 2>&1; then
  sudo dockerd >/tmp/dockerd.log 2>&1 &
  for _ in $(seq 1 60); do
    sudo docker info >/dev/null 2>&1 && break
    sleep 1
  done
fi
if ! sudo docker info >/dev/null 2>&1; then
  echo "!! [start] Docker daemon failed to start; see /tmp/dockerd.log" >&2
  tail -n 40 /tmp/dockerd.log >&2 || true
  exit 1
fi
# Allow the agent user to use docker without sudo in this session.
sudo chmod 666 /var/run/docker.sock || true

echo "==> [start] Starting PostgreSQL, applying migrations, importing data"
pnpm db:setup

echo "==> [start] Ready — Postgres up, schema migrated, imports loaded"
