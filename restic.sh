##!/bin/bash
clear
figlet LSS RESTIC
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
echo "PROGRAM=RESTIC" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

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
echo "Your backup frequency is not matching either Daily, Weekly or Monthly! Exiting."
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

echo "What is your destination source type? Either LOCAL, SMB, NFS or S3."
read SETUPBKDESTTYPE
echo "BKDESTTYPE=$SETUPBKDESTTYPE" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

	if [[ $SETUPBKDESTTYPE == 'LOCAL' ]]
	then
	echo "### LOCAL DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "What is your LOCAL destination directory? Example: /home/user/my-backup-files"
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

	#echo "Mountpoint directory where your destination should be mounted? Example: /mnt/smb/source"
	#read SETUPDMP
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

	if [[ $SETUPBKDESTTYPE == 'S3' ]]
	then
	echo "### S3 DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "Please specify S3 api URL. Example: https://api-lscloud.lssolutions.ie"
	read SETUPRESTICREPO
	echo "S3 Bucket Name? Example sage-backups, please be aware of no upper letters and spaces!"
	read SETUPRESTICBUCKET
	echo "LSS_REPOSITORY=s3:$SETUPRESTICREPO/$SETUPRESTICBUCKET" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "S3 Access key id?"
	read SETUPRESTICS3KEYID
	echo "AWS_ACCESS_KEY_ID=$SETUPRESTICS3KEYID" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "S3 Secret access key?"
	read SETUPRESTICS3KEY
	echo "AWS_SECRET_ACCESS_KEY=$SETUPRESTICS3KEY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	echo "S3 Region? Example: Dublin"
	read SETUPRESTICS3REGION
	echo "AWS_DEFAULT_REGION=$SETUPRESTICS3REGION" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
	fi

echo "### RESTIC VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Would you like to setup retention policy? (y=Yes,n=No)"
echo "As of right now retention policy is invoked right after backup. Custom schedule may be added in future."
echo "As of right now pruning is invoked right after retention. Custom schedule may be added in future."
echo "If you do not setup retention policy all backups will be kept and you will eventually run out of space."
echo "System is setup use within policy for more consistent data trough out the time!"

read SETUPRETENCONFIRM

if [[ $SETUPRETENCONFIRM == 'y' ]]
then
echo "What type of retention? Full or just keep last?"
echo "Type FULL for full retention, type LAST for last only retention."
echo "Full retention is keep last, keep-within-daily, keep-within-weekly, keep-within-monthly, keep-within-yearly"
echo "For long-term persistent data use full retention, for fast snapshots like hourly use last only."
read RETENTYPE

if [[ $RETENTYPE == 'FULL' ]]
then
echo "RETENTION=YES-FULL" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "PRUNE=YES" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
cp ./functions/lss-reten-full.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-reten-full.sh
cp ./functions/lss-prune.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-prune.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-reten-full.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-prune.sh

            echo "How many last (most recent) backups to keep? Enter a numeric number. Example: 7"
	          read SETUPRETENLAST
            echo "RESTIC_FORGETLAST=$SETUPRETENLAST" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

            echo "How many keep within daily backups to keep? Example: 7d means 7 days."
            read  SETUPRETENDAILY
            echo "RESTIC_FORGETDAILY=$SETUPRETENDAILY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

            echo "How many keep within weekly backups to keep? Example: 2m means two months. Please note that it uses months as per restic docs."
            read SETUPRETENWEEKLY
            echo "RESTIC_FORGETWEEKLY=$SETUPRETENWEEKLY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

            echo "How many monthly backups to keep? Example: 15m means 15 months."
            read SETUPRETENMONTHLY
            echo "RESTIC_FORGETMONTHLY=$SETUPRETENMONTHLY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

            echo "How many annual backups to keep? Example: 2y means 2 years."
            read SETUPRETENANNUAL
            echo "RESTIC_FORGETANNUAL=$SETUPRETENANNUAL" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

            echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |$SETUPBKSOURCETYPE-to-$SETUPBKDESTTYPE |$SETUPBKFQ |Last:$SETUPRETENLAST--KWD:$SETUPRETENDAILY--KWW:$SETUPRETENWEEKLY--KWM:$SETUPRETENMONTHLY--KWY:$SETUPRETENANNUAL |$SETUPWORKDIR/database/backup-jobs/$SETUPBKID/$SETUPBKID-Configuration.env " >> ./database/backup-database.txt

else
echo "RETENTION=YES-LAST" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "PRUNE=YES" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
cp ./functions/lss-reten-keep-last-only.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-reten-keep-last-only.sh
cp ./functions/lss-prune.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-prune.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-reten-keep-last-only.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-prune.sh

            echo "How many last (most recent) backups to keep? Enter a numeric number. Example: 7"
	          read SETUPRETENLAST
            echo "RESTIC_FORGETLAST=$SETUPRETENLAST" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
            echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |$SETUPBKSOURCETYPE-to-$SETUPBKDESTTYPE |$SETUPBKFQ |Last-only:$SETUPRETENLAST |$SETUPWORKDIR/database/backup-jobs/$SETUPBKID/$SETUPBKID-Configuration.env " >> ./database/backup-database.txt
fi
else
echo "No retention policy will be specified."
echo "RETENTION=NO" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
cp ./functions/lss-no-reten.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-no-reten.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-no-reten.sh
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |$SETUPBKSOURCETYPE-to-$SETUPBKDESTTYPE |$SETUPBKFQ |Not-set |$SETUPWORKDIR/database/backup-jobs/$SETUPBKID/$SETUPBKID-Configuration.env " >> ./database/backup-database.txt
fi

echo "Input your restic repository password! You MUST store it securely somewhere else! Avoid using special characters which would break Linux!"
read SETUPRESTICREPOPASSWD
echo "RESTIC_PASSWORD=$SETUPRESTICREPOPASSWD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

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

echo "Injecting crontab."
/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-cron-add.sh

echo "Restic repository will initialized in the first backup run."
echo "Wizard is now finished. Would you like to run backup now? (y=yes/n=no)"
read RUNBACKUP

if [[ $RUNBACKUP == 'y' ]]
then
/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME.sh"
else
echo "It is important to at least initialize restic repository otherwise scheduled cron will time out and send failed ping."
echo "Are you 100% sure that you want to even skip restic repository initialization?"
echo "Type n for No and to init restic repository now. Otherwise skip, but know the consequences."
read RUNINITONLY
if [[ $RUNINITONLY == 'n' ]]
then
# Init restic repo only, no backup data transfer.
cp ./functions/restic-repo-init-only.sh ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-restic-repo-init-only.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-restic-repo-init-only.sh
/bin/bash $SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-restic-repo-init-only.sh
else
cp ./functions/restic-repo-init-only.sh ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-restic-repo-init-only.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-restic-repo-init-only.sh
echo "You must initialize restic repository manually otherwise your scheduled backup will fail!"
echo "To invoke restic repository initialization later copy paste the command below."
echo "/bin/bash $SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-restic-repo-init-only.sh"
fi
fi
fi
