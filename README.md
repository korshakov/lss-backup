# lss-backup

More information cocming soon. This is early stage of release candidate.

To Install:
Make sure you are downloading the latest release.
```
cd /etc
wget https://github.com/korshakov/lss-backup/archive/refs/tags/v3.40.tar.gz
```
```
tar -xvf v3.40.tar.gz
rm v3.40.tar.gz
mv lss-backup-v3.40 lss-backup
cd lss-backup
chmod +x *.sh
chmod +x functions/*.sh prep-dependencies/*.sh.prep
bash install-lss-backup.sh
```
