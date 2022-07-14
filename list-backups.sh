#!/bin/bash

if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
echo "--------------------------------"
echo "List of backup(s):"
echo "--------------------------------"
column -t ./database/backup-database.txt
echo "--------------------------------"
echo "Would you like to view backup .env file?"
select OPENENVFILE in "Yes" "No" ; do
    case $OPENENVFILE in

        "Yes" ) ./functions/list-config-job-variables.sh ; break;;

        "No" ) exit ; break;;

    esac
done
else
echo "There are no backups to list!"
fi


