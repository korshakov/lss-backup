#!/bin/bash

# Checking if restic repo is initialized or not.
export RESTIC_PASSWORD="$RESTIC_PASSWORD"
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"
restic -r $LSS_REPOSITORY snapshots
EXITCODE="$?"
if [ "$EXITCODE" -eq "0" ]
then
# Repository exist already we can move onto actual data backup.
echo "Repository already exist! There is no need to initialize again!"
exit
else
echo "Initializing restic repository only, first backup will happen on the nearest schedule date and time."
restic -r $LSS_REPOSITORY init
echo "Restic repository initialization complete."
fi
