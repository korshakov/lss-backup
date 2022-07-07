#!/bin/bash

if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
echo "--------------------------------"
echo "List of backup(s):"
echo "--------------------------------"
column -t ./database/backup-database.txt
echo "--------------------------------"
echo "Would you like to view backup env file? (y=Yes,n=No)"
read OPENENVFILE
	if [[ $OPENENVFILE == 'y' ]]
	then
	./functions/list-config-job-variables.sh
	else
	exit
	fi
else
echo "There are no backups to list!"
fi


