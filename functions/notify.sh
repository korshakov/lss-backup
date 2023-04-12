#!/bin/bash

#source file will be added here.
TIME=`date "+%d-%m-%Y"`
LOG_FILE=$WORKDIR/logs/$TIME-$BKID.log

if [[ $MONITORING == "NO" ]]; then
echo "Healthchecks monitoring is disabled."
else
wget "$CRONDOMAIN"/ping/"$CRONID"/"$STATUS" -T 10 -t 5 -O /dev/null
fi

if [[ $EMAILSETUP == "Yes" ]] ; then

if [[ $STATUS != "0" ]] ; then

subject="$PROGRAM backup job $BKID-$BKFQ-$BKNAME Has Failed with status code: $STATUS"

body=$(cat $LOG_FILE)

to="$EMAILSETUPADDR"

echo -e "Subject:${subject}\n${body}" | sendmail -t "${to}"

else

subject="$PROGRAM backup job $BKID-$BKFQ-$BKNAME Has finished sucessfully."

body=$(cat $LOG_FILE)

to="$EMAILSETUPADDR"

echo -e "Subject:${subject}\n${body}" | sendmail -t "${to}"


fi
fi

if [[ $EMAILSETUP == "FailOnly" ]] ; then

if [[ $STATUS != "0" ]] ; then

subject="$PROGRAM backup job $BKID-$BKFQ-$BKNAME Has failed with status code: $STATUS"

body=$(cat $LOG_FILE)

to="$EMAILSETUPADDR"

echo -e "Subject:${subject}\n${body}" | sendmail -t "${to}"

else

echo "Email finished succesfully. Email notifications are to failure only. Not sending any emails."


fi
fi

if [[ $EMAILSETUP == "No" ]] ; then

echo "Email notifications are disabled."

fi

