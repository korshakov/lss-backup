#!/bin/bash

crontab -u root -l | grep -v "$BKID"  | crontab -u root -
service cron reload
