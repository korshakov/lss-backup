#!/bin/bash

echo "SMB/NFS source folder should contain some files..."
if find "$SDIR" -mindepth 1 -maxdepth 1 | read; then
   echo "Directory contains folders/files."
   /bin/bash "$WORKDIR"/"$BKID"-destination-type-checks.sh
   exit
else
   echo "Warning SMB/NFS source directory is empty! There is nothing to backup! Aborting backup process."
   if [[ $MONITORING == 'NO' ]]
   then
   echo "Healthchecks monitoring disabled."
   else
   wget "$CRONDOMAIN"/ping/"$CRONID"/13 -T 10 -t 5 -O /dev/null
   fi
   exit
fi
