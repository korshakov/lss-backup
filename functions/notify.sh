#!/bin/bash
#source file will be added here.
if [[ $MONITORING == "NO" ]]; then
echo "Monitoring is disabled"
else
wget "$CRONDOMAIN"/ping/"$CRONID"/"$STATUS" -T 10 -t 5 -O /dev/null
fi

if [[ $EMAILSETUP == "FailOnly" ]]; then

subject="$BKID-$BKFQ-$BKNAME Has Failed with status code: $STATUS"

body="$PROGRAM backup job $BKID-$BKFQ-$BKNAME has failed with exit code: $STATUS. "

to="$EMAILSETUPADDR"

echo -e "Subject:${subject}\n${body}" | sendmail -t "${to}"

fi

