clear
figlet LSS BACKUP
echo "Copyright - Ladislav Stojanik - LS Solutions - https://lssolutions.ie"
echo "#####################################################################"
echo ""
echo "Which program would you like to use? Type RESTIC or RSYNC pres CTRL+C to exit program."
select PROGRAM in "RESTIC" "RSYNC" "EXIT"; do
    case $PROGRAM in

        RESTIC ) clear; ./restic.sh ; break;;

        RSYNC ) clear; ./rsync.sh ; break;;

	EXIT ) clear && echo "Good Bye!"; exit;;

    esac
done
exit
