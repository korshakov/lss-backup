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

if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
echo "--------------------------------"
echo "Restoration process is for restic only."
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
echo "Ask further restic questions." 
else
echo "Restoring data using rsync."
rsync -avp $LSS_REPOSITORY 
fi


else
echo "Incorrect backup ID!"
./restore-backup.sh
fi
else
echo "There are no backup to restore from!"
fi