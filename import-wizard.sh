clear
figlet LSS BACKUP
echo "Copyright - Ladislav Stojanik - LS Solutions - https://lssolutions.ie"
echo "#####################################################################"
echo ""
echo "Which program would you like to use? Type RESTIC or RSYNC pres CTRL+C to exit program."
read PROGRAM
if [[ $PROGRAM == 'RESTIC' ]]
then
clear
./restic.sh
exit
fi
if [[ $PROGRAM == 'RSYNC' ]]
then
clear
./rsync.sh
exit
fi
./backup-wizard.sh
