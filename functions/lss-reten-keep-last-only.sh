#!/bin/bash

# Retention process keep last only.

restic -r $LSS_REPOSITORY forget --keep-last $RESTIC_FORGETLAST

# Moving to pruning
echo "Mooving to pruning"

/bin/bash "$WORKDIR"/"$BKID"-lss-prune.sh
