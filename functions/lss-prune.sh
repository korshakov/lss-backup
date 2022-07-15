#!/bin/bash

restic -r $LSS_REPOSITORY unlock
restic -r $LSS_REPOSITORY prune
restic -r $LSS_REPOSITORY unlock

/bin/bash "$WORKDIR"/"$BKID"-log-cleanup.sh