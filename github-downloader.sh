wget https://github.com/korshakov/lss-backup/archive/refs/tags/release-candidate.tar.gz
tar -xvzf release-candidate.tar.gz
cd lss-backup-release-candidate/
chmod +x *.sh
chmod +x functions/*.sh
chmod +x prep-dependencies/*.sh
./install-lss-backup.sh
