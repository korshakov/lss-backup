#!/bin/bash

createbackup () {
./backup-wizard.sh
}

managebackup () {
./manage-backup.sh
}

listbackups () {
./backup-list.sh
}

importbackup () {
./import-wizard.sh
}

clear
figlet LSS BACKUP
echo "Copyright - Ladislav Stojanik - LS Solutions - https://lssolutions.ie"
echo "#####################################################################"
echo ""
select commanderselect in "Create Backup Job" "Import Previous Backup" "Manage Existing Backup" "List Backup Jobs" "Do Nothing"; do
case $commanderselect in

        "Create Backup Job" ) createbackup ; break;;

	      "Import Previous Backup" ) importbackup ; break;;

        "Manage Existing Backup" ) managebackup ; break;;

	      "List Backup Jobs" ) listbackups ; break;;

        "Do Nothing" ) clear && echo "Good Bye!" ; exit;;

    esac
    done
exit
