### RESTIC IMPORT FUNCTION

resticimport(){
SETUPWORKDIR=$(pwd)
TIMESTAMP=`date "+%d-%m-%Y--%H:%M"`
# Preparing backup job executable files and folders.

mkdir -p ./database/backup-jobs/"$BKID"/logs
cp ./functions/source-type-checks.sh ./database/backup-jobs/"$BKID"/$BKID-source-type-checks.sh
cp ./functions/local-source-folder-checks.sh ./database/backup-jobs/"$BKID"/$BKID-local-source-folder-checks.sh
cp ./functions/smb-nfs-source-folder-checks.sh ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-source-folder-checks.sh
cp ./functions/destination-type-checks.sh ./database/backup-jobs/"$BKID"/$BKID-destination-type-checks.sh
cp ./functions/local-destination-folder-checks.sh ./database/backup-jobs/"$BKID"/$BKID-local-destination-folder-checks.sh
cp ./functions/smb-nfs-destination-folder-checks.sh ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-destination-folder-checks.sh
cp ./functions/s3-destination-checks.sh ./database/backup-jobs/"$BKID"/$BKID-s3-destination-checks.sh
cp ./functions/backup-config-check.sh ./database/backup-jobs/"$BKID"/$BKID-backup-config-check.sh
cp ./functions/repository-check.sh ./database/backup-jobs/"$BKID"/$BKID-repository-check.sh
cp ./functions/destination-type-checks.sh ./database/backup-jobs/"$BKID"/$BKID-destination-type-checks.sh
cp ./functions/cron-add.sh ./database/backup-jobs/"$BKID"/$BKID-cron-add.sh
cp ./functions/cron-remove.sh ./database/backup-jobs/"$BKID"/$BKID-cron-remove.sh
cp ./functions/lss-backup.sh ./database/backup-jobs/"$BKID"/$BKID-lss-backup.sh
cp ./functions/log-cleanup.sh ./database/backup-jobs/"$BKID"/$BKID-log-cleanup.sh
cp ./functions/notify.sh ./database/backup-jobs/"$BKID"/$BKID-notify.sh

printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-source-type-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-local-source-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-source-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-destination-type-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-local-destination-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-destination-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-s3-destination-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-backup-config-check.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-repository-check.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-destination-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-cron-add.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-cron-remove.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-lss-backup.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-log-cleanup.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-notify.sh

if [[ $RETENTION == 'YES-FULL' ]]
then
cp ./functions/lss-reten-full.sh ./database/backup-jobs/"$BKID"/$BKID-lss-reten-full.sh
cp ./functions/lss-prune.sh ./database/backup-jobs/"$BKID"/$BKID-lss-prune.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-lss-reten-full.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-lss-prune.sh

echo "|$BKID |$TIMESTAMP |$BKNAME |RESTIC |$BKSOURCETYPE-to-$BKDESTTYPE |$BKFQ |Last:$RESTIC_FORGETLAST--KWD:$RESTIC_FORGETDAILY--KWW:$RESTIC_FORGETWEEKLY--KWM:$RESTIC_FORGETMONTHLY--KWY:$RESTIC_FORGETANNUAL |/backup-jobs/$BKID/$BKID-Configuration.env " >> ./database/backup-database.txt

fi
if [[ $RETENTION == 'YES-LAST' ]]
then
cp ./functions/lss-reten-keep-last-only.sh ./database/backup-jobs/"$BKID"/$BKID-lss-reten-keep-last-only.sh
cp ./functions/lss-prune.sh ./database/backup-jobs/"$BKID"/$BKID-lss-prune.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-lss-reten-keep-last-only.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-lss-prune.sh


echo "|$BKID |$TIMESTAMP |$BKNAME |RESTIC |$BKSOURCETYPE-to-$BKDESTTYPE |$BKFQ |Last-only:$RESTIC_FORGETLAST |/backup-jobs/$BKID/$BKID-Configuration.env " >> ./database/backup-database.txt

fi

if [[ $RETENTION == 'NO' ]]
then
cp ./functions/lss-no-reten.sh ./database/backup-jobs/"$BKID"/$BKID-lss-no-reten.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-lss-no-reten.sh
echo "|$BKID |$TIMESTAMP |$BKNAME |RESTIC |$BKSOURCETYPE-to-$BKDESTTYPE |$BKFQ |Not-set |/backup-jobs/$BKID/$BKID-Configuration.env " >> ./database/backup-database.txt

fi

cp ./functions/starter-script.sh ./database/backup-jobs/"$BKID"/"$BKID-$BKFQ-$BKNAME.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/"$BKID-$BKFQ-$BKNAME.sh"

/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-cron-add.sh

echo "Restic repository will initialized in the first backup run."
echo "Import Wizard is now finished. Would you like to run backup now? (y=yes/n=no)"
read RUNBACKUP

if [[ $RUNBACKUP == 'y' ]]
then
/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID-$BKFQ-$BKNAME.sh"
else
echo "It is important to at least re-initialize restic repository otherwise scheduled cron will time out and send failed ping."
echo "Are you 100% sure that you want to even skip restic repository initialization?"
echo "Type n for No and to init restic repository now. Otherwise skip, but know the consequences."
read RUNINITONLY
if [[ $RUNINITONLY == 'n' ]]
then
# Init restic repo only, no backup data transfer.
cp ./functions/restic-repo-init-only.sh ./database/backup-jobs/"$BKID"/"$BKID-restic-repo-init-only.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-restic-repo-init-only.sh
/bin/bash $SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID-restic-repo-init-only.sh
else
cp ./functions/restic-repo-init-only.sh ./database/backup-jobs/"$BKID"/"$BKID-restic-repo-init-only.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-restic-repo-init-only.sh
echo "You must initialize restic repository manually otherwise your scheduled backup will fail!"
echo "To invoke restic repository initialization later copy paste the command below."
echo "/bin/bash $SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID-restic-repo-init-only.sh"
fi
fi

}

### END OF RESTIC IMPORT FUNCTION

### RSYNC IMPORT FUNCTION

rsyncimport(){

SETUPWORKDIR=$(pwd)
TIMESTAMP=`date "+%d-%m-%Y--%H:%M"`

# Preparing backup job executable files and folders.

mkdir -p ./database/backup-jobs/"$BKID"/logs
cp ./functions/source-type-checks.sh ./database/backup-jobs/"$BKID"/$BKID-source-type-checks.sh
cp ./functions/local-source-folder-checks.sh ./database/backup-jobs/"$BKID"/$BKID-local-source-folder-checks.sh
cp ./functions/smb-nfs-source-folder-checks.sh ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-source-folder-checks.sh
cp ./functions/destination-type-checks.sh ./database/backup-jobs/"$BKID"/$BKID-destination-type-checks.sh
cp ./functions/local-destination-folder-checks.sh ./database/backup-jobs/"$BKID"/$BKID-local-destination-folder-checks.sh
cp ./functions/smb-nfs-destination-folder-checks.sh ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-destination-folder-checks.sh
cp ./functions/s3-destination-checks.sh ./database/backup-jobs/"$BKID"/$BKID-s3-destination-checks.sh
cp ./functions/backup-config-check.sh ./database/backup-jobs/"$BKID"/$BKID-backup-config-check.sh
cp ./functions/repository-check.sh ./database/backup-jobs/"$BKID"/$BKID-repository-check.sh
cp ./functions/destination-type-checks.sh ./database/backup-jobs/"$BKID"/$BKID-destination-type-checks.sh
cp ./functions/cron-add.sh ./database/backup-jobs/"$BKID"/$BKID-cron-add.sh
cp ./functions/cron-remove.sh ./database/backup-jobs/"$BKID"/$BKID-cron-remove.sh
cp ./functions/lss-backup.sh ./database/backup-jobs/"$BKID"/$BKID-lss-backup.sh
cp ./functions/log-cleanup.sh ./database/backup-jobs/"$BKID"/$BKID-log-cleanup.sh
cp ./functions/notify.sh ./database/backup-jobs/"$BKID"/$BKID-notify.sh

printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-source-type-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-local-source-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-source-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-destination-type-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-local-destination-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-destination-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-s3-destination-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-backup-config-check.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-repository-check.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-smb-nfs-destination-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-cron-add.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-cron-remove.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-lss-backup.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-log-cleanup.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/$BKID-notify.sh

cp ./functions/starter-script.sh ./database/backup-jobs/"$BKID"/"$BKID-$BKFQ-$BKNAME.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-Configuration.env" . x | ex ./database/backup-jobs/"$BKID"/"$BKID-$BKFQ-$BKNAME.sh"

echo "Writing to simple database file"
echo "|$BKID |$TIMESTAMP |$BKNAME |RSYNC |$BKSOURCETYPE-to-$BKDESTTYPE |$BKFQ |Not-available |/backup-jobs/$BKID/$BKID-Configuration.env " >> ./database/backup-database.txt

/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID"-cron-add.sh

echo "Import Wizard is now finished. Would you like to run backup now? (y=yes/n=no)"
read RUNBACKUP

if [[ $RUNBACKUP == 'y' ]]
then
clear
/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$BKID"/"$BKID-$BKFQ-$BKNAME.sh"
else
echo "Good bye!"
fi

}

### END OF RSYNC IMPORT FUNCTION



clear
figlet LSS IMPORT
echo "Copyright - Ladislav Stojanik - LS Solutions - https://lssolutions.ie"
echo "#####################################################################"
echo ""
echo "Where is your .env file located. Make sure its an absolute path. Example: /etc/backups/myfile.env"
read importfile



if [ -f "$importfile" ]; then
    echo "$importfile exists. Reading file now."
    source "$importfile"

    echo "Checking if the backup job exists already."
    # Checking if backup job already exist"
    if [ -d "./database/backup-jobs/"$BKID"" ];
    then
    echo "Backup ID already taken! Would you like to override existing backup job?"
    echo "Warning this can cause catastrophyc data loss if your import file contains incorrect values!"
    select importoverride in "YES" "NO"; do
    case $importoverride in

        YES ) echo "./import-override.sh This is still in development." ; break;;

	    NO ) echo "Nothing to do, good bye." ; exit;;
    esac
    done
    exit
    else
        mkdir -p ./database/backup-jobs/"$BKID"
        cp "$importfile" ./database/backup-jobs/"$BKID"/"$BKID-Configuration.env"
        if [[ $PROGRAM == 'RESTIC' ]]
	    then
        resticimport;
        else
        rsyncimport;
        fi
    fi
else
    echo "$importfile does not exist. Try again!"
    echo "Import wizard will start over in 5 seconds. Quit by pressing CTRL+C"
    sleep 5s
    ./import-wizard.sh
fi
