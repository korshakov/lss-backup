#!/bin/bash

echo "Welcome to LS Solutions Backup!"

if [[ $MONITORING == 'NO' ]]
then
echo "Healthchecks monitoring disabled."
else
wget "$CRONDOMAIN"/ping/"$CRONID"/start -T 10 -t 5 -O /dev/null
fi

/bin/bash "$WORKDIR"/"$BKID"-backup-config-check.sh
