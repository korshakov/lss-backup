##!/bin/bash
figlet LSS RSYNC
echo "Give your backup job an ID, usually numbers would be the best."
echo "Please note that backup ID is taken as a unique identifier! Avoid simple number but rather something more complex. Example CUS01"
read SETUPBKID

# Checking if backup job already exist"
if [ -d "./database/backup-jobs/"$SETUPBKID"" ];
then
echo "Backup ID already taken! Exiting"
exit
else
mkdir -p ./database/backup-jobs/"$SETUPBKID"
touch ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "### BACKUP GENERAL SETTINGS ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
SETUPTIMESTAMP=`date "+%d-%m-%Y--%H:%M"`
echo "BKID=$SETUPBKID" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "PROGRAM=RSYNC" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Would you like to run rsync with --no-perms --no-owner --no-group? This is handy if sync is between mounted folders."
select setrsyncmode in "YES" "NO"; do
    case $setrsyncmode in

        YES ) echo "RSYNCMODE=NOPERMNOOWNNOGP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env" ; break;;

        NO ) echo "RSYNCMODE=NORMAL" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env" ; exit;;

    esac
done

# Setting up work directory
echo "CREATIONTIMESTAMP=$SETUPTIMESTAMP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
SETUPWORKDIR=$(pwd)
echo "WORKDIR=$SETUPWORKDIR/database/backup-jobs/$SETUPBKID" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "Your backup configuration files will be stored at: $SETUPWORKDIR/database/backup-jobs/$SETUPBKID"

#create executable file for cronjob starter file.sh

cp ./functions/source-type-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-source-type-checks.sh
cp ./functions/local-source-folder-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-local-source-folder-checks.sh
cp ./functions/smb-nfs-source-folder-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-source-folder-checks.sh
cp ./functions/destination-type-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-destination-type-checks.sh
cp ./functions/local-destination-folder-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-local-destination-folder-checks.sh
cp ./functions/smb-nfs-destination-folder-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-destination-folder-checks.sh
cp ./functions/s3-destination-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-s3-destination-checks.sh
cp ./functions/backup-config-check.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-backup-config-check.sh
cp ./functions/repository-check.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-repository-check.sh
cp ./functions/destination-type-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-destination-type-checks.sh
cp ./functions/cron-add.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-add.sh
cp ./functions/cron-remove.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-remove.sh
cp ./functions/lss-backup.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-backup.sh

printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-source-type-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-local-source-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-source-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-destination-type-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-local-destination-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-destination-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-s3-destination-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-backup-config-check.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-repository-check.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-destination-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-add.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-remove.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-backup.sh

echo "Name your backup e.g. Sage-Backup-TO-LS-CLOUD Important! Spaces are not allowed!"
read SETUPBKNAME
echo "BKNAME=$SETUPBKNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Set your backup frequency. Use only Daily, Weekly, Monthly"
read SETUPBKFQ
echo "BKFQ=$SETUPBKFQ" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

if [[ $SETUPBKFQ == 'Daily' ]]
then
echo "Which hour of each day should backup start? In 24H format. Example: 19"
read SETUPBKCRONTIMEHH
echo "BKCRONTIMEHH=$SETUPBKCRONTIMEHH" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which minute of the hour $SETUPBKCRONTIMEHH should backup start? Example: 30"
read SETUPBKCRONTIMEMM
echo "BKCRONTIMEMM=$SETUPBKCRONTIMEMM" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Your backup will run daily at $SETUPBKCRONTIMEHH:$SETUPBKCRONTIMEMM"
fi

if [[ $SETUPBKFQ == 'Weekly' ]]
then

echo "Which day should weekly backup start? Example: 1 That means it will run every Monday."
read SETUPBKCRONWEEKLY
echo "BKCRONWEEKLY=$SETUPBKCRONWEEKLY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "What hour on the day of $SETUPBKCRONWEEKLY should backup start? In 24H format. Example: 19"
read SETUPBKCRONTIMEHH
echo "BKCRONTIMEHH=$SETUPBKCRONTIMEHH" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which minute of the hour specified before should backup start? Example: 30"
read SETUPBKCRONTIMEMM
echo "BKCRONTIMEMM=$SETUPBKCRONTIMEMM" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Your backup will run weekly on the day $SETUPBKCRONWEEKLY at $SETUPBKCRONTIMEHH:$SETUPBKCRONTIMEMM"
fi

if [[ $SETUPBKFQ == 'Monthly' ]]
then

echo "Which day should monthly backup start? Example: 1 That means it will run on first day of every month."
read SETUPBKCRONMONTHLY
echo "BKCRONMONTHLY=$SETUPBKCRONMONTHLY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which hour on the day $SETUPBKCRONWEEKLY of a month  should backup start? In 24H format. Example: 19"
read SETUPBKCRONTIMEHH
echo "BKCRONTIMEHH=$SETUPBKCRONTIMEHH" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which minute of the hour specified before should backup start? Example: 30"
read SETUPBKCRONTIMEMM
echo "BKCRONTIMEMM=$SETUPBKCRONTIMEMM" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Your backup will run monthly on the day $SETUPBKCRONMONTHLY at $SETUPBKCRONTIMEHH:$SETUPBKCRONTIMEMM"
fi

if [[ $SETUPBKFQ != 'Daily' ]] && [[ $SETUPBKFQ != 'Weekly' ]] && [[ $SETUPBKFQ != 'Monthly' ]]
then
echo "Your backup frequency is not matching either Daily, Weekly or Monthly! Exitting."
rm -rf ./database/backup-jobs/$SETUPBKID
exit
fi

echo "### SOURCE VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "What is your backup source type? Either LOCAL, SMB or NFS."
read SETUPBKSOURCETYPE
echo "BKSOURCETYPE=$SETUPBKSOURCETYPE" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	if [[ $SETUPBKSOURCETYPE == 'LOCAL' ]]
	then
	echo "### LOCAL SOURCE VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "What is your LOCAL source directory? Example: /home/user/some-files"
	read SETUPSDIR
	echo "SDIR=$SETUPSDIR" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	fi

	if [[ $SETUPBKSOURCETYPE == 'SMB' ]]
	then
	echo "### SMB SOURCE VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "Source target IP address?"
	read SETUPMPTARGETIP
	echo "MPTARGETIP=$SETUPMPTARGETIP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Share name? Please make sure there are no spaces!"
	read SETUPMPSN
	echo "MPSN=$SETUPMPSN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	#echo "Mountpoint directory where your source should be mounted? Example: /mnt/smb/source"
	#read SETUPMP
	SETUPSDIR="/mnt/lss-backup/$SETUPBKID/source"
	echo "SDIR=$SETUPSDIR" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Credentials"
	echo "Username?"
	read SETUPUSERNAME
	echo "USERNAME=$SETUPUSERNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Password?"
	read SETUPPASSWORD
	echo "PASSWORD=$SETUPPASSWORD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Domain? Leave empty if not joined to domain."
	read SETUPDOMAIN
	echo "DOMAIN=$SETUPDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	fi

	if [[ $SETUPBKSOURCETYPE == 'NFS' ]]
	then
	echo "### NFS SOURCE VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "Source target IP address?"
        read SETUPMPTARGETIP
        echo "MPTARGETIP=$SETUPMPTARGETIP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

        echo "Share name? Please make sure there are no spaces!"
        read SETUPMPSN
        echo "MPSN=$SETUPMPSN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

        #echo "Mountpoint directory where your source should be mounted? Example: /mnt/smb/source"
        #read SETUPMP
        SETUPSDIR="/mnt/lss-backup/$SETUPBKID/source"
	echo "SDIR=$SETUPSDIR" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

        echo "Credentials."
        echo "Username?"
        read SETUPUSERNAME
        echo "SETUPUSERNAME=$SETUPUSERNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

        echo "Password?"
        read SETUPPASSWORD
        echo "PASSWORD=$SETUPPASSWORD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

        echo "Domain? Leave empty if not joined to domain."
        read SETUPDOMAIN
        echo "DOMAIN=$SETUPDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	fi

echo "### DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "What is your destination source type? Either LOCAL, SMB or NFS"
read SETUPBKDESTTYPE
echo "BKDESTTYPE=$SETUPBKDESTTYPE" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	if [[ $SETUPBKDESTTYPE == 'LOCAL' ]]
	then
	echo "### LOCAL DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "What is your LOCAL destination directory? Example: /home/user/my-backedup-files"
	read SETUPLSS_REPOSITORY
	echo "LSS_REPOSITORY=$SETUPLSS_REPOSITORY/$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	fi

	if [[ $SETUPBKDESTTYPE == 'SMB' ]]
	then
	echo "### SMB DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "Destination target IP address?"
	read SETUPDMPTARGETIP
	echo "DMPTARGETIP=$SETUPDMPTARGETIP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Share name? Please make sure there are no spaces!"
	read SETUPDMPSN
	echo "DMPSN=$SETUPDMPSN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	SETUPLSS_REPOSITORY="/mnt/lss-backup/$SETUPBKID/destination/$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME"
	echo "LSS_REPOSITORY=$SETUPLSS_REPOSITORY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Credentials"
	echo "Username?"
	read SETUPDUSERNAME
	echo "DUSERNAME=$SETUPDUSERNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Password?"
	read SETUPDPASSWORD
	echo "DPASSWORD=$SETUPDPASSWORD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Domain? Leave empty if not joined to domain."
	read SETUPDDOMAIN
	echo "DDOMAIN=$SETUPDDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

  	fi

	if [[ $SETUPBKDESTTYPE == 'NFS' ]]
	then
	echo "### NFS DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "Destination target IP address?"
	read SETUPDMPTARGETIP
	echo "DMPTARGETIP=$SETUPDMPTARGETIP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Share name? Please make sure there are no spaces!"
	read SETUPDMPSN
	echo "DMPSN=$SETUPDMPSN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	SETUPLSS_REPOSITORY="/mnt/lss-backup/$SETUPBKID/destination/$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME"
	echo "LSS_REPOSITORY=$SETUPLSS_REPOSITORY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Credentials"
	echo "Username?"
	read SETUPDUSERNAME
	echo "DUSERNAME=$SETUPDUSERNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Password?"
	read SETUPDPASSWORD
	echo "DPASSWORD=$SETUPDPASSWORD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	echo "Domain? Leave empty if not joined to domain."
	read SETUPDDOMAIN
	echo "DDOMAIN=$SETUPDDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

  	fi

echo "What is your healthchecks url? Example: https://cron.lssolutions.ie"
read SETUPCRONDOMAIN
echo "### HEALTHCHECKS VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "CRONDOMAIN=$SETUPCRONDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "What is your healthchecks cron id? Example: 8bfc3d73-d49e-427c-8e70-8e40a7d67f1d"
read SETUPCRONID
echo "CRONID=$SETUPCRONID" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"


echo "Preparing starter script."
cp ./functions/starter-script.sh ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME.sh"

echo "Writing to simple database file"
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |$SETUPBKSOURCETYPE-to-$SETUPBKDESTTYPE |$SETUPBKFQ |Not-available |$SETUPWORKDIR/database/backup-jobs/$SETUPBKID/$SETUPBKID-Configuration.env " >> ./database/backup-database.txt
echo "Injecting crontab."
/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-cron-add.sh

echo "Wizard is now finished. Would you like to run backup now? (y=yes/n=no)"
read RUNBACKUP

if [[ $RUNBACKUP == 'y' ]]
then
clear
/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME.sh"
else
echo "Good bye!"
fi
fi
