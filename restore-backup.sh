#!/bin/bash

######################### Functions start here

### SMB MOUNT FUNCTION

smbrestoremountfunction ()
{
echo "IP Address?"
read smbipaddr
echo "Share name?"
read smbrestoredir
echo "Username?"
read smbrestoreusername
echo "Password?"
read smbrestoreuserpasswd
echo "Domain?"
read smbrestoredomain
echo "Where to mountpoint?"
read restoretargetdir

echo "Checking if source SMB is mounted by something else."
if mount | grep "$restoretargetdir" > /dev/null; then
echo "Smb source mountpoint is mounted! Choose a diffrent path!"
exit
else
# Mountpoint is clear we can mount smb. Checking if domain was specified.
# Checking if mountpoint directory exists first.
echo "Checking if $restoretargetdir exists"
if [ -d "$restoretargetdir" ];
then
echo "Directory exists."
else
mkdir -p "$restoretargetdir"
fi
if [[ -z "$smbrestoredomain" ]]
then
echo "Mounting smb without domain"
mount -t cifs //"$smbipaddr"/"$restoretargetdir" "$smbrestoredir" -o username="$smbrestoreusername",password="$smbrestoreuserpasswd"
echo "Checking if mount was succesfull"
if mount | grep "$smbrestoredir" > /dev/null; then
echo "SMB restore directory mounted successfully."
else
echo "SMB mount failed! Something went wrong."
exit
fi
else
echo "Mounting smb with domain."
mount -t cifs //"$smbipaddr"/"$smbrestoredir" "$restoretargetdir" -o username="$smbrestoreusername",password="$smbrestoreuserpasswd",domain="$smbrestoredomain"
echo "Checking if mount was succesfull"
if mount | grep "$smbrestoredir" > /dev/null; then
echo "SMB restore directory mounted successfully."
else
echo "SMB mount failed! Something went wrong."
exit
fi
fi
fi
}

### END OF SMB MOUNT FUNCTION

### NFS MOUNT FUNCTION

nfsrestoremountfunction ()
{
echo "IP Address?"
read nfsipaddr
echo "Share path?"
read nfsrestoredir
echo "Username?"
read nfsrestoreusername
echo "Password?"
read nfsrestoreuserpasswd
echo "Domain?"
read nfsrestoredomain
echo "Where to mountpoint?"
read restoretargetdir

echo "Checking if source NFS is mounted by something else."
if mount | grep "$restoretargetdir" > /dev/null; then
echo "NFS source mountpoint is mounted! Choose a diffrent path!"
exit
else
# Mountpoint is clear we can mount nfs. Checking if domain was specified.
# Checking if mountpoint directory exists first.
echo "Checking if $restoretargetdir exists"
if [ -d "$restoretargetdir" ];
then
echo "Directory exists."
else
mkdir -p "$restoretargetdir"
fi
if [[ -z "$nfsrestoredomain" ]]
then
echo "Mounting nfs without domain"
mount -t nfs -O user="$nfsrestoreusername",pass="$nfsrestoreuserpasswd" "$nfsipaddr":/"$nfsrestoredir" "$restoretargetdir"
echo "Checking if mount was succesfull"
if mount | grep "$nfsrestoredir" > /dev/null; then
echo "NFS restore directory mounted successfully."
else
echo "NFS mount failed! Something went wrong."
exit
fi
else
echo "Mounting nfs with domain."
mount -t nfs -O user="$nfsrestoreusername",pass="$nfsrestoreuserpasswd",domain="$nfsrestoredomain" "$nfsipaddr":/"$nfsrestoredir" "$restoretargetdir"
echo "Checking if mount was succesfull"
if mount | grep "$nfsrestoredir" > /dev/null; then
echo "NFS restore directory mounted successfully."
else
echo "NFS mount failed! Something went wrong."
exit
fi
fi
fi
}

### END OF NFS MOUNT FUNCTION

### LOCAL MOUNT FUNCTION

localrestoremountfunction ()
{
echo "Local directory path?"
read restoretargetdir
    if [ -d "$restoretargetdir" ];
    then
    if find "$restoretargetdir" -mindepth 1 -maxdepth 1 | read; then
    echo "Directory contains folders/files. Use empty folder instead!"
    exit
    else
    echo "All good here."
    fi
    else
    mkdir -p "$restoretargetdir"
    fi  
}

### END OF LOCAL MOUNT FUNCTION
clear
figlet LSS RESTORE
if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
echo "--------------------------------"
echo "List of backup(s):"
echo "--------------------------------"
column -t ./database/backup-database.txt
echo "--------------------------------"

echo "Which backup would you like to restore?"
read BACKUPRESTOREID

# Checking if user has inputted the right backup id.
if [ -d "./database/backup-jobs/$BACKUPRESTOREID" ];
then
# load backup job config file
source ./database/backup-jobs/$BACKUPRESTOREID/$BACKUPRESTOREID-Configuration.env
echo "Where would you like to restore files?"
select restoreloctype in "LOCAL" "SMB" "NFS"; do
    case $restoreloctype in

        LOCAL ) localrestoremountfunction ; break;;

        SMB ) smbrestoremountfunction ; break;;

	NFS ) nfsrestoremountfunction ; exit;;
    esac
done

if [[ $PROGRAM == 'RESTIC' ]]
then

export RESTIC_PASSWORD="$RESTIC_PASSWORD"
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" 
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"

echo "Listing snapshots."
echo "------------------"
restic -r $LSS_REPOSITORY snapshots
echo "-------------------------------"
echo "Would you like to restore latest or specify snapshot id?"

select snapshotchoice in "LATEST" "SPECIFY-ID"; do
    case $snapshotchoice in
    LATEST ) echo "Restoring data."; restic -r $LSS_REPOSITORY restore latest --target "$restoretargetdir"  ; break;;
    SPECIFY-ID ) echo "Input your restic snapshot ID."; read resticsnapshotid; echo "Restoring data."; restic -r $LSS_REPOSITORY restore "$resticsnapshotid" --target "$restoretargetdir" ; exit;;
    esac
done

else
echo "Restoring data using rsync. This may take some time depending how much data you are about to restore."
rsync -avp $LSS_REPOSITORY $restoretargetdir
fi


else
echo "Incorrect backup ID!"
./restore-backup.sh
fi
else
echo "There are no backup to restore from!"
fi