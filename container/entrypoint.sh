#!/usr/bin/env bash
set -e

./container/wait-for-it.sh ${POSTGRES_HOST}:${POSTGRES_PORT} -t 30
sleep 3

exec "$@"
