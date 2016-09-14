#!/bin/bash

if [[ "$RESTORE" == "true" ]]; then
  ./restore.sh
else
  if [ -n "$CRON_TIME" ]; then
    env | grep -v 'affinity:container' | sed -e 's/^\([^=]*\)=\(.*\)/export \1="\2"/' > /env.conf # Save current environment
    echo "${CRON_TIME} . /env.conf && /backup.sh 2>&1 | logger -t dockup-cron-${BACKUP_NAME}" > /crontab.conf
    echo "=> Running dockup backups as a cronjob for ${CRON_TIME}"
    exec devcron.py /crontab.conf
  else
    ./backup.sh
  fi
fi
