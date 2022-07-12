### RESTIC IMPORT FUNCTION

resticimport(){
echo "Hello this is restic import."
}

### END OF RESTIC IMPORT FUNCTION

### RSYNC IMPORT FUNCTION

resticimport(){
echo "Hello this is rsync import."
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

        YES ) echo "./import-override.sh" ; break;;

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
