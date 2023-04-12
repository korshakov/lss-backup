#!/bin/bash
#source file will be added here.
if [[ $MONITORING == "NO" ]]; then
echo "Monitoring is disabled"
else
wget "$CRONDOMAIN"/ping/"$CRONID"/"$STATUS" -T 10 -t 5 -O /dev/null
fi

echo "Exit code is $STATUS"

if [[ $EMAILSETUP == "Yes" ]] ; then

if [[ $STATUS != "0" ]] ; then

subject="$BKID-$BKFQ-$BKNAME Has Failed with status code: $STATUS"

body="$PROGRAM backup job $BKID-$BKFQ-$BKNAME has failed with exit code: $STATUS. "

to="$EMAILSETUPADDR"

echo -e "Subject:${subject}\n${body}" | sendmail -t "${to}"

else

subject="$BKID-$BKFQ-$BKNAME Has finished sucessfully."

body="$PROGRAM backup job $BKID-$BKFQ-$BKNAME has finished sucessfully. "

to="$EMAILSETUPADDR"

echo -e "Subject:${subject}\n${body}" | sendmail -t "${to}"


fi
fi

if [[ $EMAILSETUP == "FailOnly" ]] ; then

if [[ $STATUS != "0" ]] ; then

subject="$BKID-$BKFQ-$BKNAME Has Failed with status code: $STATUS"

body="$PROGRAM backup job $BKID-$BKFQ-$BKNAME has failed with exit code: $STATUS. "

to="$EMAILSETUPADDR"

echo -e "Subject:${subject}\n${body}" | sendmail -t "${to}"

else

echo "Email finished succesfully. Email notifications are to failure only. Not sending any emails."


fi
fi

if [[ $EMAILSETUP == "No" ]] ; then

echo "Email notifications are disabled."

fi
