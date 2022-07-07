#!/bin/bash
echo "Woud you like to destroy backup data as well? Please type exactly Yes-I-Do to confirm"
read SUPERDESTROY
if [[ $SUPERDESTROY == 'Yes-I-Do' ]]
then
echo "WARNING THIS PROCESS WILL DESTROY ALL BACKUP DATA AND BACKUP CONFIGURATION!"
echo "Are you 100% sure you want to do this? This is not recoverable process! (y=Yes,n=No)"
read SUPERDESTROYCONFIRM
	if [[ $SUPERDESTROYCONFIRM == 'y' ]]
	then
echo "Please be aware that this script will NEVER delete any source files! If you wish to delete your source files, you must do it manually yourself."
if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
echo "--------------------------------"
echo "WARNING This is DESTRUCTIVE process, be aware of consequences!"
echo "THIS PROCESS WILL DESTROY ALL DESTINATION DATA!"
echo "--------------------------------"
echo "List of backup(s):"
ls database/backup-jobs/
echo "--------------------------------"
echo "Input backup ID you wish to destroy or press CTRL+C to cancel this process without destroying any backups."
read BKDESTROY
# Checking if backup job already exist
	if [ -d "./database/backup-jobs/$BKDESTROY" ];
	then
		# reading out backup job id and based on source and destination variables taking actions.
		source ./database/backup-jobs/$BKDESTROY/$BKDESTROY-Configuration.env
		# Unmounting source shares and deleting mountpoints. Note no source data is deleted.
		if [[ $BKSOURCETYPE == 'SMB' ]] || [[ $BKSOURCETYPE == 'NFS' ]]
		then
		echo "Umounting source share"
		umount /mnt/lss-backup/$BKID/source
		echo "Removing source mount point directory"
		rm -rf /mnt/lss-backup/$BKID/source
                else
                echo "Seems like your source directory is set to local. Not touching that!"
                fi

		# Umounting destination shares and deleting mountpoints. Again backups in destinations are not deleted as of yet in this version of script.
                if [[ $BKDESTTYPE == 'SMB' ]] || [[ $BKDESTTYPE == 'NFS' ]]
                then
		echo "DESTROYING ALL DESTINATION DATA NOW!"
		rm -rf /mnt/lss-backup/$BKID/destination/$BKID-$BKFQ-$BKNAME
		echo "Done"
                echo "Umounting destination share"
                umount /mnt/lss-backup/$BKID/destination
                echo "Removing destination mount point directory"
                rm -rf /mnt/lss-backup/$BKID/destination
                # deleting backup job mount folder.
		else
		echo "Seems like your destination folder is set to local or s3, not touching that!"
		fi
		# Deleting backup job mount point base folder based ib backup job id.
		if [[ $BKSOURCETYPE == 'SMB' ]] || [[ $BKSOURCETYPE == 'NFS' ]] || [[ $BKDESTTYPE == 'SMB' ]] || [[ $BKDESTTYPE == 'NFS' ]]
		then
		echo "Deleting backup job ID: $BKID mountpoint base folder."
		rm -rf /mnt/lss-backup/$BKID
		fi
	echo "Deleting cronjob."
	./database/backup-jobs/$BKDESTROY/$BKDESTROY-cron-remove.sh
	echo "Deleting configuration files."
	rm -rf ./database/backup-jobs/$BKDESTROY
	echo "Backup ID: $BKDESTROY DESTROYED!"
	# Removing backup id from database file
	echo "Cleaning up database file"
	grep -v $BKDESTROY ./database/backup-database.txt > ./database/tmpfile && mv ./database/tmpfile ./database/backup-database.txt
	else
	echo "Backup ID: $BKDESTROY does not exist! Exitting..."
	fi
else
echo "There are no backups to destroy!"
fi
else
echo "EXITING! Nothing will be deleted!"
fi
else
echo "Please be aware that this script will NEVER delete any source files! If you wish to delete your source files, you must do it manually yourself."
if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
echo "--------------------------------"
echo "WARNING This is DESTRUCTIVE process, be aware of consequences!"
echo "This script will not delete backup data, but configuration files, cron jobs and umounts directories only."
echo "You still have to delete destination backup data manually!"
echo "--------------------------------"
echo "List of backup(s):"
ls database/backup-jobs/
echo "--------------------------------"
echo "Input backup ID you wish to destroy or press CTRL+C to cancel this process without destroying any backups."
read BKDESTROY
# Checking if backup job already exist
	if [ -d "./database/backup-jobs/$BKDESTROY" ];
	then
		# reading out backup job id and based on source and destination variables taking actions.
		source ./database/backup-jobs/$BKDESTROY/$BKDESTROY-Configuration.env
		# Unmounting source shares and deleting mountpoints. Note no source data is deleted.
		if [[ $BKSOURCETYPE == 'SMB' ]] || [[ $BKSOURCETYPE == 'NFS' ]]
		then
		echo "Umounting source share"
		umount /mnt/lss-backup/$BKID/source
		echo "Removing source mount point directory"
		rm -rf /mnt/lss-backup/$BKID/source
                else
                echo "Seems like your source directory is set to local. Not touching that!"
                fi

		# Umounting destination shares and deleting mountpoints. Again backups in destinations are not deleted as of yet in this version of script.
                if [[ $BKDESTTYPE == 'SMB' ]] || [[ $BKDESTTYPE == 'NFS' ]]
                then
                echo "Umounting destination share"
                umount /mnt/lss-backup/$BKID/destination
                echo "Removing destination mount point directory"
                rm -rf /mnt/lss-backup/$BKID/destination
                # deleting backup job mount folder.
		else
		echo "Seems like your destination folder is set to local or s3, not touching that!"
		fi
		# Deleting backup job mount point base folder based ib backup job id.
		if [[ $BKSOURCETYPE == 'SMB' ]] || [[ $BKSOURCETYPE == 'NFS' ]] || [[ $BKDESTTYPE == 'SMB' ]] || [[ $BKDESTTYPE == 'NFS' ]]
		then
		echo "Deleting backup job ID: $BKID mountpoint base folder."
		rm -rf /mnt/lss-backup/$BKID
		fi
	echo "Deleting cronjob."
	./database/backup-jobs/$BKDESTROY/$BKDESTROY-cron-remove.sh
	echo "Deleting configuration files."
	rm -rf ./database/backup-jobs/$BKDESTROY
	echo "Backup ID: $BKDESTROY DESTROYED!"
	# Removing backup id from database file
	echo "Cleaning up database file"
	grep -v $BKDESTROY ./database/backup-database.txt > ./database/tmpfile && mv ./database/tmpfile ./database/backup-database.txt
	else
	echo "Backup ID: $BKDESTROY does not exist! Exitting..."
	fi
else
echo "There are no backups to destroy!"
fi
fi
