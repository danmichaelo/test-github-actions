#!/usr/bin/env bash
set -e

function log {
    echo "[start.sh] $(date -u +'%Y-%m-%d %H:%M:%S.%3N UTC'): $@"
}

log "Starting Apache"
exec apache2-foreground "$@"
