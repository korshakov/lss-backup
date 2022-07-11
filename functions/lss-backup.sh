#!/bin/bash

# Actual data backup process start here With signaling failures if any!.
if [[ $PROGRAM == 'RESTIC' ]]
then
echo "Starting restic process now!"
restic -r $LSS_REPOSITORY backup $SDIR -v
RESTICCODE="$?"
if [[ $RESTICCODE != '0' ]]
then
    if [[ $RESTICCODE == '1' ]]
    then
    echo "Restic finished with error $RESTICCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/18 -T 10 -t 5 -O /dev/null
    fi

    if [[ $RESTICCODE == '3' ]]
    then
    echo "Restic finished with error $RESTICCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/19 -T 10 -t 5 -O /dev/null
    fi

    if [[ $RESTICCODE != '1' && $RESTICCODE != '3' ]]
    then
    echo "Restic finished with unknown error, investigate!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/39 -T 10 -t 5 -O /dev/null
    fi
else
figlet LSS RESTIC
echo "-----------------------------------"
echo "Restic backup finished succesfully."
##############################################

if [[ $RETENTION == 'YES-FULL' ]]
then
/bin/bash "$WORKDIR"/"$BKID"-lss-reten-full.sh
exit 0
fi
if [[ $RETENTION == 'YES-LAST' ]]
then
/bin/bash "$WORKDIR"/"$BKID"-lss-reten-keep-last-only.sh
exit 0
fi
if [[ $RETENTION == 'NO' ]]
then
/bin/bash "$WORKDIR"/"$BKID"-lss-no-reten.sh
fi
exit 0
fi
fi

###################################################


if [[ $PROGRAM == 'RSYNC' ]]
then
echo "Starting rsync process now!"
rsync -avp $SDIR $LSS_REPOSITORY
RSYNCCODE="$?"
if [[ $RSYNCCODE != '0' ]]
then
    if [[ $RSYNCCODE == '1' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/20 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '2' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/21 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '3' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/22 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '4' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/23 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '5' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/24 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '6' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/25 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '10' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/26 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '11' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/27 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '12' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/28 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '13' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/29 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '14' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/30 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '20' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/31 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '21' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/32 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '22' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/33 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '23' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/34 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '24' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/35 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '25' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/36 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '30' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/37 -T 10 -t 5 -O /dev/null
    fi
    if [[ $RSYNCCODE == '35' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/38 -T 10 -t 5 -O /dev/null
    fi

    if [[ "$RSYNCCODE" -ge 7 && "$RSYNCCODE" -le 9 ]] && [[ "$RSYNCCODE" -ge 15 && "$RSYNCCODE" -le 19 ]] && [[ "$RSYNCCODE" -ge 26 && "$RSYNCCODE" -le 29 ]] && [[ "$RSYNCCODE" -ge 31 && "$RSYNCCODE" -le 34 ]] && [[ "$RSYNCCODE" -ne 35 ]] && [[ "$RSYNCCODE" -gt 36 ]]
    then
    echo "Rsync finished with unknown error, investigate!"
    wget "$CRONDOMAIN"/ping/"$CRONID"/40 -T 10 -t 5 -O /dev/null
    fi
else
# Sending closing ping backup is finished
figlet LSS RSYNC
echo "----------------------------------"
echo "Rsync backup finished succesfully!"
wget "$CRONDOMAIN"/ping/"$CRONID" -T 10 -t 5 -O /dev/null
fi
fi
