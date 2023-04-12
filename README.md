# lss-backup

More information cocming soon. This is early stage of release candidate.

To Install:
Make sure you are downloading the latest release.
```
cd /etc
wget https://github.com/korshakov/lss-backup/archive/refs/tags/v3.22-dev.tar.gz
```
```
tar -xvf v3.22-dev.tar.gz
rm v3.22-dev.tar.gz
mv lss-backup-v3.22-dev lss-backup
cd lss-backup
chmod +x *.sh
chmod +x functions/*.sh prep-dependencies/*.sh.prep
bash install-lss-backup.sh
```
