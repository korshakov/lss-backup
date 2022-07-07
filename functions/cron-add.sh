#!/bin/bash

# this is simple cron injection script to do it for you instead.
echo "Hello its cron injector"
if [[ $BKFQ == 'Daily' ]]
then
echo "Injecting command to crontab to the last line."
echo "Here is is for your convinience: $BKCRONTIMEMM $BKCRONTIMEHH * * * /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
line="$BKCRONTIMEMM $BKCRONTIMEHH * * * /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
(crontab -u root -l; echo "$line" ) | crontab -u root -
service cron reload
fi

if [[ $BKFQ == 'Weekly' ]]
then
echo "Injecting command to crontab to the last line."
echo "Here is is for your convinience: $BKCRONTIMEMM $BKCRONTIMEHH * * $BKCRONWEEKLY /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
line="$BKCRONTIMEMM $BKCRONTIMEHH * * $BKCRONWEEKLY /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
(crontab -u root -l; echo "$line" ) | crontab -u root -
service cron reload
fi

if [[ $BKFQ == 'Monthly' ]]
then
echo "Injecting command to crontab to the last line."
echo "Here is is for your convinience: $BKCRONTIMEMM $BKCRONTIMEHH $BKCRONMONTHLY * * /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
line="$BKCRONTIMEMM $BKCRONTIMEHH $BKCRONMONTHLY * * /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
(crontab -u root -l; echo "$line" ) | crontab -u root -
service cron reload
fi

if [[ $BKFQ != 'Daily' ]] && [[ $BKFQ != 'Weekly' ]] && [[ $BKFQ != 'Monthly' ]]
then
echo "Ups! This should not happen here!"
fi
