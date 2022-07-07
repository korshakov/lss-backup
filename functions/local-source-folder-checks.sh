#!/bin/bash

echo "LOCAL source folder should contain some files..."
if find "$SDIR" -mindepth 1 -maxdepth 1 | read; then
   echo "Directory contains folders/files."
   # daisy to destination-type-checks.sh
   /bin/bash "$WORKDIR"/"$BKID"-destination-type-checks.sh
   exit
else
   echo "Warning LOCAL source is either empty or does not exist! There is nothing to backup! Sending failed ping and exitting backup process."
   wget "$CRONDOMAIN"/ping/"$CRONID"/7 -T 10 -t 5 -O /dev/null
   exit
fi
