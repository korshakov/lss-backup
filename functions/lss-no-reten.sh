#!/bin/bash

# No Retention process no prune.

echo "No snapshots will be cleared as no retention policy specified. There is nothing to prune since everything is kept."
echo "Backup is now finished."
wget "$CRONDOMAIN"/ping/"$CRONID" -T 10 -t 5 -O /dev/null
