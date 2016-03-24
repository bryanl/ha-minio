#!/bin/bash

if [[ -f /mnt/minio1/config/config.json ]]; then
  cat /mnt/minio1/config/config.json \
    | jq '.credentials.accessKeyId + "," + .credentials.secretAccessKey' \
    | sed s/\"//g \
    | awk '{split($0,creds,","); print "\n\n\tMinio Credentials\n\n\tAccess Key ID: " creds[1] "\n\tSecret Access Key: " creds[2] "\n\n"}' > /etc/motd
fi