#!/bin/bash

restic -r $LSS_REPOSITORY prune

wget "$CRONDOMAIN"/ping/"$CRONID" -T 10 -t 5 -O /dev/null