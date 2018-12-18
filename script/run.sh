#!/usr/bin/env bash
echo 'wait database up...'
/app/wait-for-it.sh ${MYSQL_URL}:${MYSQL_PORT} -t 60 -- /app/entrypoint.sh