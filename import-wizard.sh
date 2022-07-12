clear
figlet LSS IMPORT
echo "Copyright - Ladislav Stojanik - LS Solutions - https://lssolutions.ie"
echo "#####################################################################"
echo ""
echo "Where is your .env file located. Make sure its an absolute path. Example: /etc/backups/myfile.env"
read importfile



if [ -f "$importfile" ]; then
    echo "$importfile exists. Reading file now."
else 
    echo "$importfile does not exist. Try again!"
    echo "Import wizard will start over in 5 seconds. Quit by pressing CTRL+C"
    sleep 5s
    ./import-wizard.sh
fi
