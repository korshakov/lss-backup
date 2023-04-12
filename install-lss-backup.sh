apt install figlet
clear
figlet LSS BACKUP
echo "Installing necessary dependencies."
apt-get install restic curl wget rsync cifs-utils nfs-common -y
echo "Updating restic to the latest version manually"
restic self-update
echo "Creating folders"
mkdir -p /mnt/lss-backup
echo "Done"
rm ./database/backup-jobs/readme.txt

SETUPWORKDIR=$(pwd)
cp $SETUPWORKDIR/prep-dependencies/list-config-job-variables.sh.prep $SETUPWORKDIR/prep-dependencies/list-config-job-variables.sh
mv $SETUPWORKDIR/prep-dependencies/list-config-job-variables.sh $SETUPWORKDIR/functions/list-config-job-variables.sh

printf '%s\n' 1a "WORKDIR=$SETUPWORKDIR" . x | ex ./functions/list-config-job-variables.sh
SETUPTIME=$(date)
clear
echo "-----------------------------------------------"
echo "-----------------------------------------------"
echo "Your date and time is: $SETUPTIME, is this correct? (y=Yes,n=No)"
echo "This is important to set correctly for healthchecks to send pings in the right time!"
read TIMECORRECT
if [[ $TIMECORRECT != 'y' ]]
then
echo "Set your correct time zone now. Please refer to man pages on how to setup timezone, example: Europe/Dublin"
read SETUPTIMEZONE
timedatectl set-timezone $SETUPTIMEZONE
echo "Your new date and time is:"
date
fi
service cron restart

# Set the path to the lss-backup.sh script
lss_backup_path="/etc/lss-backup/lss-backup.sh"

# Set the desired alias name
alias_name="lss-backup"

# Check if the alias already exists
if grep -q "alias $alias_name=" ~/.bashrc; then
    echo "Alias already exists"
else
    # Add the alias to the .bashrc file
    echo "alias $alias_name='cd /etc/lss-backup && $lss_backup_path'" >> ~/.bashrc
    echo "Alias created"
fi

# Reload the .bashrc file to apply changes
source ~/.bashrc

# Print a message to confirm the alias has been set
echo "Alias $alias_name set to $lss_backup_path"
echo "You can call this program anytime typing lss-backup."
exec bash
