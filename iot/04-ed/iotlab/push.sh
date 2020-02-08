#!/bin/bash
#
# Script to perform an automated backup of my home directory to an
# rsync server
#
BACKUP_SERVER=djoudi@grenoble.iot-lab.info:

rsync -avz --exclude 'iot-lab/parts/mbed-os' $TOOLSPATH/iot-lab/ $BACKUP_SERVER


