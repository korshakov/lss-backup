#!/bin/bash

echo "Welcome to LS Solutions Backup!"

export STATUS=start
/bin/bash "$WORKDIR"/"$BKID"-notify.sh

/bin/bash "$WORKDIR"/"$BKID"-backup-config-check.sh
