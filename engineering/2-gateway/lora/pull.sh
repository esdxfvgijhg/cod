#!/bin/bash
#
# Script to perform an automated backup of my home directory to an
# rsync server
#
BACKUP_SERVER=pi@192.168.200.1:

rsync -avz $BACKUP_SERVER $PROGRAMPATH/engineering/2-gateway/lora/lora_gateway
