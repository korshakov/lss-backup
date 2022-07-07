wget https://github.com/korshakov/lss-backup/archive/refs/tags/release-candidate.tar.gz
SETUPWORKDIR=$(pwd)

tar -xvzf $SETUPWORKDIR/release-candidate.tar.gz $SETUPWORKDIR/lss-backup
cd $SETUPWORKDIR/lss-backup
chmod +x *.sh
chmod +x ./functions/*.sh
chmod +x ./prep-dependencies/*.sh
./install-lss-backup.sh


# curl command
# curl -o github-downloader.sh https://lssolutions.ie/lss-backup/github-downloader.sh
# bash ./github-downloader.sh