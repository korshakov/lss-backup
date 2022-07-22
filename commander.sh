#!/bin/bash
### Restic functions

listsnapshots () {

restic -r $LSS_REPOSITORY snapshots

}

removesnapshots () {

restic -r $LSS_REPOSITORY snapshots
echo "Type in snapshot ID to remove."
read SNAPREMOVE
echo "Removing snapshot is not revertable process, are you 100% sure you want to delete this snapshost?"

select snapremoveconfirm in "Yes - Delete snapshot now!" "No - Cancel now!"; do
case $snapremoveconfirm in

        "Yes - Delete snapshot now!" ) restic -r $LSS_REPOSITORY forget "$SNAPREMOVE" ; break;;

        "No - Cancel now!" ) exit;;
esac
done

}

listkeys () {

restic -r $LSS_REPOSITORY key list

}

### End of restic functions
clear
figlet LSS COMMANDER
if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
echo "--------------------------------"
echo "List of backup(s):"
echo "--------------------------------"
column -t ./database/backup-database.txt
echo "--------------------------------"
echo "Choose your backup job first."
read BACKUPJOB

	if [ -d "./database/backup-jobs/$BACKUPJOB" ];
	then
	source ./database/backup-jobs/$BACKUPJOB/$BACKUPJOB-Configuration.env
    if [[ $PROGRAM == 'RESTIC' ]]
    then
    export RESTIC_PASSWORD="$RESTIC_PASSWORD"
    export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" 
    export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
    export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"
    
    select commanderselect in "List Snapshots" "Remove Snapshots" "List Keys" "Exit"; do
    case $commanderselect in

        "List Snapshots" ) listsnapshots ; break;;
        
        "Remove Snapshots" ) removesnapshots ; break;;
        
        "List Keys" ) listkeys ; break;;

        "Exit" ) echo "Nothing to do." ; exit;;

    esac
    done

    else
    echo "Backup job used RSYNC program. There are nothing to do."
    fi
    
	else
	echo "Wrong backup job ID specified! Exitting"
	exit
	fi

else
echo "There are no backups to list!"
fi