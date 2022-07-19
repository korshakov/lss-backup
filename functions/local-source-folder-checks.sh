#!/bin/bash

echo "LOCAL source folder should contain some files..."
if find "$SDIR" -mindepth 1 -maxdepth 1 | read; then
   echo "Directory contains folders/files."
   # daisy to destination-type-checks.sh
   /bin/bash "$WORKDIR"/"$BKID"-destination-type-checks.sh
   exit
else
   echo "Warning LOCAL source is either empty or does not exist! There is nothing to backup! Aborting backup!"
    if [[ $MONITORING == 'NO' ]]
   then
   echo "Healthchecks monitoring disabled."
   else
   wget "$CRONDOMAIN"/ping/"$CRONID"/7 -T 10 -t 5 -O /dev/null
   fi
fi
