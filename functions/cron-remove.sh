#!/bin/bash

if [[ $BKFQ != 'Daily' ]] || [[ $BKFQ != 'Weekly' ]] || [[ $BKFQ != 'Monthly' ]]
then
crontab -u root -l | grep -v "$BKID"  | crontab -u root -
service cron reload
else
echo "Backup job was Manual Only, nothing to remove."
fi
