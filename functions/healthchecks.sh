#!/bin/bash
#source file will be added here.
if [[ $MONITORING == "NO" ]]; then
echo "Monitoring is disabled"
else
wget "$CRONDOMAIN"/ping/"CRONID"/"$STATUS" -T 10 -t 5 -O /dev/null
fi
