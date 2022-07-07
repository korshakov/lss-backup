

# Actual data backup process start here.
if [[ $PROGRAM == 'RSYNC' ]]
then
echo "Starting rsync process now!"
rsync -avp $SDIR $LSS_REPOSITORY
# Sending closing ping
wget "$CRONDOMAIN"/ping/"$CRONID" -T 10 -t 5 -O /dev/null
fi

if [[ $PROGRAM == 'RESTIC' ]]
then
echo "Starting restic process now!"
restic -r $LSS_REPOSITORY backup $SDIR -v
wget "$CRONDOMAIN"/ping/"$CRONID" -T 10 -t 5 -O /dev/null
fi
