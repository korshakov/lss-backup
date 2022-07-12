#!/bin/bash

restic -r $LSS_REPOSITORY unlock
restic -r $LSS_REPOSITORY prune
restic -r $LSS_REPOSITORY unlock

wget "$CRONDOMAIN"/ping/"$CRONID" -T 10 -t 5 -O /dev/null