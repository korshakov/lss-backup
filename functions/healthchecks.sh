#!/bin/bash
echo "HIIIIIII"
source /etc/lss-backup/database/backup-jobs/FLD-01/FLD-01-Configuration.env
#source file will be added here.
if [[ $MONITORING == "NO" ]]; then
echo "Monitoring is disabled"
else
wget https://cron.lssolutions.ie/ping/8bfc3d73-d49e-427c-8e70-8e40a7d67f1d/"$STATUS" -T 10 -t 5 -O /dev/null
fi
