#!/bin/bash

# Full Retention process

restic -r $LSS_REPOSITORY forget --keep-last $RESTIC_FORGETLAST --keep-within-daily $RESTIC_FORGETDAILY --keep-within-weekly $RESTIC_FORGETWEEKLY --keep-within-monthly $RESTIC_FORGETMONTHLY --keep-within-yearly $RESTIC_FORGETANNUAL

# Moving to pruning
echo "Mooving to pruning"

/bin/bash "$WORKDIR"/"$BKID"-lss-prune.sh
