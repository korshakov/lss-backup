#!/bin/bash
export RESTIC_REPOSITORY=s3:https://api-lscloud.lssolutions.ie/rest
export AWS_ACCESS_KEY_ID=p3zXQzbwf2PL7PXl
export AWS_SECRET_ACCESS_KEY=LxrrVupDwp7a5M2ZaV5w5tD5tt6
export RESTIC_PASSWORD=o8BaMjoN
export AWS_DEFAULT_REGION=Dublin

# restic -r s3:https://api-lscloud.lssolutions.ie/resticbucket init

restic -r s3:https://api-lscloud.lssolutions.ie/resticbucket backup /sage-backups -v
